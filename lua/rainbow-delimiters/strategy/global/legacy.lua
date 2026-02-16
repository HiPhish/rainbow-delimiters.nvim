-- SPDX-License-Identifier: Apache-2.0

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
		result = {change[1], change[2], change[4], change[5]}
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


---Create a new empty match_record
---@return table
local function new_match_record()
	return {
		delimiter = Stack.new(),
		children = Stack.new(),
	}
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
		-- This is the match record, it lists all the relevant nodes from
		-- each match.
		---@type table?
		local match_record
		local root_node = tree:root()
		local start_row, end_row = change[1], change[3] + 1
		lib.clear_namespace(bufnr, lang, start_row, end_row)

		for qid, node, _ in query:iter_captures(root_node, bufnr, start_row, end_row) do
			local name = query.captures[qid]
			-- check for 'delimiter' first, since that should be the most
			-- common name
			if name == 'delimiter' and match_record then
				match_record.delimiter:push(node)
			elseif name == 'container' and not match_record then
				match_record = new_match_record()
			elseif name == 'container' then
				-- temporarily push the match_record to matches to be retrieved
				-- later, since we haven't closed it yet
				matches:push(match_record)
				match_record = new_match_record()
				-- since we didn't close the previous match_record, it must
				-- mean that the current match_record has it as an ancestor
				match_record.has_ancestor = true
			elseif name == 'sentinel' and match_record then
				-- if we see the sentinel, then we are done with the current
				-- container
				if match_record.has_ancestor then
					local prev_match_record = matches:pop()
					if prev_match_record then
						-- since we have an ancestor, it has to be the last
						-- element of the stack
						prev_match_record.children:push(match_record)
						match_record = prev_match_record
					else
						-- since match_record.has_ancestor was true, we shouldn't
						-- be able to get to here unless something went wrong
						-- with the queries or treesitter itself
						log.error([[You are missing a @container,
									which should be impossible!
									Please double check the queries.]])
					end
				else
					-- if match_record doesn't have an ancestor, the sentinel
					-- means that we are done with it
					matches:push(match_record)
					match_record = nil
				end
			elseif (name == 'delimiter' or name == 'sentinel') and not match_record then
				log.error([[You query got the capture name %s.
					But it didn't come with a container, which should be impossible!
						Please double check your queries.]], name)
			end -- do nothing with other capture names
		end
		if match_record then
			-- we might have a dangling match_record, so we push it back into
			-- matches
			-- this should only happen when the query is on a proper subset
			-- of the full tree (usually just one line)
			matches:push(match_record)
		end
	end

	-- when we capture on a row and not the full tree, we get the previous
	-- containers (on earlier rows) included in the above, but not the
	-- delimiters and sentinels from them, so we push them up as long as
	-- we know they have an ancestor
	local last_match = matches:pop()
	while last_match and last_match.has_ancestor do
		local prev_match = matches:pop()

		if prev_match then
			prev_match.children:push(last_match)
		else
			log.error('You are in what should be an unreachable position.')
		end
		last_match = prev_match
	end
	matches:push(last_match)

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
				if not parent_lang then
					-- If we have no parent language, then we use changes, otherwise we use the
					-- whole tree's range.
					-- Normalize the changes object if we have no parent language (the one we
					-- get from on_changedtree)
					changes = vim.tbl_map(normalize_change, changes)
				elseif parent_lang ~= lang and changes[1] then
					-- We have a parent language, so we are in an injected language code
					-- block, thus we update all of the current code block
					changes = {{tree:root():range()}}
				else
					-- some languages (like rust) use injections of the language itself for
					-- certain functionality (e.g., macros in rust).  For these the
					-- highlighting will be updated by the non-injected language part of the
					-- code.
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
