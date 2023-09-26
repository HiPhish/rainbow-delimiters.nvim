--[[
   Copyright 2023 Alejandro "HiPhish" Sanchez
   Copyright 2020-2022 Chinmay Dalal

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--]]

local Stack = require 'rainbow-delimiters.stack'
local lib   = require 'rainbow-delimiters.lib'
local util  = require 'rainbow-delimiters.util'
local log   = require 'rainbow-delimiters.log'
local ts    = vim.treesitter


---Strategy which highlights the entire buffer.
local M = {}

---Changes are range objects and come in two variants: one with four entries and
---one with six entries.  We only want the four-entry variant.  See
---`:h TSNode:range()`
local function normalize_change(change)
	local result
	if #change == 4 then
		result = change
	else
		result = {change[1], change[2], change[4], change[5]}
	end
	return result
end

local function highlight_matches(bufnr, lang, matches, level)
	local hlgroup = lib.hlgroup_at(level)
	for _, match in matches:iter() do
		for _, opening      in match.opening:iter()      do lib.highlight(bufnr, lang, opening,      hlgroup) end
		for _, closing      in match.closing:iter()      do lib.highlight(bufnr, lang, closing,      hlgroup) end
		for _, intermediate in match.intermediate:iter() do lib.highlight(bufnr, lang, intermediate, hlgroup) end
		highlight_matches(bufnr, lang, match.children, level + 1)
	end
end

---Update highlights for a range. Called every time text is changed.
---@param bufnr   number  Buffer number
---@param changes table   List of node ranges in which the changes occurred
---@param tree    table   TS tree
---@param lang    string  Language
local function update_range(bufnr, changes, tree, lang)
	log.debug('Updated range with changes ' .. vim.inspect(changes))
	if not lib.enabled_for(lang) then return end
	if vim.fn.pumvisible() ~= 0 or not lang then return end

	local query = lib.get_query(lang)
	if not query then return end

	local matches = Stack.new()

	for _, change in ipairs(changes) do
		local root_node = tree:root()
		local start_row, end_row = change[1], change[3] + 1
		lib.clear_namespace(bufnr, lang, start_row, end_row)
		for _, match, _ in query:iter_matches(root_node, bufnr, start_row, end_row) do
			-- This is the match record, it lists all the relevant nodes from
			-- the match.
			local match_record = {
				opening = Stack.new(),
				closing = Stack.new(),
				intermediate = Stack.new(),
				children = Stack.new(),
			}
			for id, node in pairs(match) do
				local name = query.captures[id]
				if name == 'container' then
					match_record.container = node
				else
					if match_record[name] then match_record[name]:push(node) end
				end
			end

			for _, other in matches:iter() do
				if not ts.is_ancestor(match_record.container, other.container) then
					break
				end
				match_record.children:push(other)
				matches:pop()
			end
			matches:push(match_record)
		end
	end

	highlight_matches(bufnr, lang, matches, 1)
end

---Update highlights for every tree in given buffer.
---@param bufnr number # Buffer number
---@return nil
local function full_update(bufnr, parser)
	log.debug('Performing full updated on buffer %d', bufnr)
	local function callback(tree, sub_parser)
		local changes = {{tree:root():range()}}
		update_range(bufnr, changes, tree, sub_parser:lang())
	end

	parser:for_each_tree(callback)
end

---Sets up all the callbacks and performs an initial highlighting
local function setup_parser(bufnr, parser)
	log.debug('Setting up parser for buffer %d', bufnr)
	util.for_each_child(parser:lang(), parser, function(p, lang)
		log.debug("Setting up parser for '%s' in buffer %d", lang, bufnr)
		-- Skip languages which are not supported, otherwise we get a
		-- nil-reference error
		if not lib.get_query(lang) then return end

		p:register_cbs {
			on_changedtree = function(changes, tree)
				if #changes == 0 then
					-- Hack: an empty change set results from an undo.  Force a
					-- full update by setting the maximum possible range
					table.insert(changes, {tree:root():range()})
				end
				log.trace('Changed tree in buffer %d with languages %s', bufnr, lang)
				-- HACK: As of Neovim v0.9.1 there is no way of unregistering a
				-- callback, so we use this check to abort
				if not lib.buffers[bufnr] then return end

				-- Normalize the changes objects
				changes = vim.tbl_map(normalize_change, changes)

				-- If a line has been moved from another region it will still
				-- carry with it the extmarks from the old region.  We need to
				-- clear all extmarks which do not belong to the current
				-- language
				for _, change in ipairs(changes) do
					for key, nsid in pairs(lib.nsids) do
						if key ~= lang then
							vim.api.nvim_buf_clear_namespace(bufnr, nsid, change[1], change[3])
						end
					end
				end
				update_range(bufnr, changes, tree, lang)
			end,
			-- New languages can be added into the text at some later time, e.g.
			-- code snippets in Markdown
			on_child_added = function(child)
				setup_parser(bufnr, child)
			end,
		}
		log.trace("Done with setting up parser for '%s' in buffer %d", lang, bufnr)
	end)

	full_update(bufnr, parser)
end


function M.on_attach(bufnr, settings)
	log.trace('global strategy on_attach')
	local parser = settings.parser
	setup_parser(bufnr, parser)
end

function M.on_detach(bufnr)
end

function M.on_reset(bufnr, settings)
	log.trace('global strategy on_reset')
	full_update(bufnr, settings.parser)
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
