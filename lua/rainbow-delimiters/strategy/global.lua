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
---@param change integer[]
---@return integer[]
local function normalize_change(change)
	local result
	if #change == 4 then
		result = change
	elseif #change == 6 then
		result = { change[1], change[2], change[4], change[5] }
	else
		result = {}
	end
	return result
end

---@param bufnr integer
---@param lang string
---@param matches Stack
---@param level integer
local function highlight_matches(bufnr, lang, matches, level)
	local hlgroup = lib.hlgroup_at(level)
	for _, match in matches:iter() do
		for _, delimiter in match.delimiter:iter() do lib.highlight(bufnr, lang, delimiter, hlgroup) end
		highlight_matches(bufnr, lang, match.children, level + 1)
	end
end

---Update highlights for a range. Called every time text is changed.
---@param bufnr   integer  Buffer number
---@param changes table   List of node ranges in which the changes occurred
---@param tree    TSTree  TS tree
---@param lang    string  Language
local function update_range(bufnr, changes, tree, lang)
	log.debug('Updated range with changes %s', vim.inspect(changes))

	if not lib.enabled_for(lang) then return end
	if vim.fn.pumvisible() ~= 0 or not lang then return end

	local query = lib.get_query(lang, bufnr)
	if not query then return end

	local matches = Stack.new()

	for _, change in ipairs(changes) do
		local root_node = tree:root()
		local start_row, end_row = change[1], change[3] + 1
		lib.clear_namespace(bufnr, lang, start_row, end_row)

		for _pattern, match, _metadata in query:iter_matches(root_node, bufnr, start_row, end_row, { all = true }) do
			-- This is the match record, it lists all the relevant nodes from
			-- each match. We start with the root_node as the container, but
			-- we will update this later.
			local match_record = {
				container = root_node,
				delimiter = Stack.new(),
				children = Stack.new(),
				sentinel = nil, ---@type integer[]?
			}
			for id, nodes in pairs(match) do
				local name = query.captures[id]
				for _, node in ipairs(nodes) do
					-- check for 'delimiter' first, since that should be the most
					-- common name
					if name == 'delimiter' then
						match_record.delimiter:push(node)
					elseif name == 'container' then
						-- we update the container here
						match_record.container = node
					elseif name == 'sentinel' then
						-- if a sentinel is given, we save the position here
						local sentinel_row, sentinel_col, _ = node:end_()
						match_record.sentinel = { sentinel_row, sentinel_col }
					end
				end
			end

			-- if sentinel_row is not nil, then sentinel_col is also
			-- not nil
			for _, other in matches:iter() do
				local sentinel = other.sentinel ---@type integer[]?
				if sentinel then
					local this_row, this_col, _ = match_record.container:start()
					local sentinel_row, sentinel_col = sentinel[1], sentinel[2]
					if this_row > sentinel_row or (this_row == sentinel_row and this_col > sentinel_col) then
						-- if other starts after the sentinel, then it should
						-- not be included with the children of the current
						-- match_record
						break
					end
				else
					if not ts.is_ancestor(match_record.container, other.container) then
						-- if other is not in the match_record container, then it
						-- should not be included with the children of the current
						-- match_record
						break
					end
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
---@param bufnr integer # Buffer number
---@param parser vim.treesitter.LanguageTree
local function full_update(bufnr, parser)
	log.debug('Performing full updated on buffer %d', bufnr)
	local function callback(tree, sub_parser)
		local changes = {{tree:root():range()}}
		update_range(bufnr, changes, tree, sub_parser:lang())
	end

	parser:for_each_tree(callback)
end


---Sets up all the callbacks and performs an initial highlighting
---@param bufnr integer # Buffer number
---@param parser vim.treesitter.LanguageTree
---@param start_parent_lang string? # Parent language or nil
local function setup_parser(bufnr, parser, start_parent_lang)
	log.debug('Setting up parser for buffer %d', bufnr)

	util.for_each_child(start_parent_lang, parser:lang(), parser, function(p, lang, parent_lang)
		log.debug("Setting up parser for '%s' in buffer %d", lang, bufnr)
		-- Skip languages which are not supported, otherwise we get a
		-- nil-reference error
		if not lib.get_query(lang, bufnr) then return end

		p:register_cbs {
			---@param changes table
			---@param tree TSTree
			on_changedtree = function(changes, tree)
				log.trace('Changed tree in buffer %d with languages %s', bufnr, lang)
				-- HACK: As of Neovim v0.9.1 there is no way of unregistering a
				-- callback, so we use this check to abort
				if not lib.buffers[bufnr] then return end

				-- HACK: changes can accidentally overwrite highlighting in injected code
				-- blocks.

				-- maybe change self_injecting_languages to { rust = true },
				-- since that seems to be the main different one
				local self_injecting_languages = { c = true, cpp = true, markdown = true, }
				if not parent_lang then
					-- If we have no parent language, then we use changes, otherwise we use the
					-- whole tree's range.
					-- Normalize the changes object if we have no parent language (the one we
					-- get from on_changedtree)
					changes = vim.tbl_map(normalize_change, changes)
				elseif parent_lang ~= lang or self_injecting_languages[parent_lang] then
					-- We have a parent language, so we are in an injected language code
					-- block, thus we update all of the current code block.
					changes = {{tree:root():range()}}
				else
					-- Some languages (like rust) use injections of the language itself for
					-- certain functionality (e.g., macros in rust).  For these the
					-- highlighting will be updated by the non-injected language part of the
					-- code. Note that some self_injecting_languages don't
					-- highlight the injected part this way, so they are
					-- covered above.
					changes = {}
				end

				-- If a line has been moved from another region it will still carry with it
				-- the extmarks from the old region.  We need to clear all extmarks which
				-- do not belong to the current language
				for _, change in ipairs(changes) do
					for key, nsid in pairs(lib.nsids) do
						if key ~= lang then
							-- HACK: changes in the main language sometimes need to overwrite
							-- highlighting on one more line
							local line_end = change[3] + (parent_lang and 0 or 1)
							vim.api.nvim_buf_clear_namespace(bufnr, nsid, change[1], line_end)
						end
					end
				end

				-- only update highlighting if we have changes
				if changes[1] then
					update_range(bufnr, changes, tree, lang)
				end

				-- HACK: Since we update the whole tree when we have a parent
				-- language, we need to make sure to then update all children
				-- too, even if there is no change in them. This shouldn't
				-- affect performance, since it only affects code nested at
				-- least 2 injection languages deep.
				if parent_lang then
					local children = p:children()
					for child_lang, child in pairs(children) do
						if lang == child_lang then return end
						child:for_each_tree(function(child_tree, child_p)
							local child_changes = {{child_tree:root():range()}}

							--  we don't need to remove old extmarks, since
							--  the above code will handle that correctly
							--  already, but we might have accidentally
							--  removed extmarks that we need to set again
							update_range(bufnr, child_changes, child_tree, child_p:lang())
						end)
					end
				end
			end,
			-- New languages can be added into the text at some later time, e.g.
			-- code snippets in Markdown
			---@param child vim.treesitter.LanguageTree
			on_child_added = function(child)
				setup_parser(bufnr, child, lang)
			end,
		}
		log.trace("Done with setting up parser for '%s' in buffer %d", lang, bufnr)
	end)

	full_update(bufnr, parser)
end


---on_attach implementation for the global strategy
---@param bufnr integer
---@param settings rainbow_delimiters.buffer_settings
function M.on_attach(bufnr, settings)
	log.trace('global strategy on_attach')
	local parser = settings.parser
	setup_parser(bufnr, parser, nil)
end

---on_detach implementation for the global strategy
---@param _bufnr integer
function M.on_detach(_bufnr)
end

---on_reset implementation for the global strategy
---@param bufnr integer
---@param settings rainbow_delimiters.buffer_settings
function M.on_reset(bufnr, settings)
	log.trace('global strategy on_reset')
	full_update(bufnr, settings.parser)
end

return M --[[@as rainbow_delimiters.strategy]]

-- vim:tw=79:ts=4:sw=4:noet:
