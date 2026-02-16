-- SPDX-License-Identifier: Apache-2.0

--[[
   Copyright 2023 Alejandro "HiPhish" Sanchez

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
local log   = require 'rainbow-delimiters.log'
local util  = require 'rainbow-delimiters.util'
local api   = vim.api
local ts    = vim.treesitter

---Highlight strategy which highlights the sub-tree of the buffer which
---contains the cursor. Re-computes -highlights when the buffer contents change
---or when the cursor is moved.
local M = {}

-- Implementation note: This strategy uses a two-step process: on every change
-- to the document tree we compute the match tree and cache it, then when the
-- cursor moves we use the cached match tree and the current cursor position to
-- decide which matches to highlight.
--
-- The document tree changes rarely, so there is no need to re-compute the
-- match tree every time the cursor moves.


---Cache of match trees, maps a buffer number to its match tree.  We compute
---the match tree on every change, so that when the cursor moves without
---changing the tree we don't need to re-compute it.
---
---Each match tree maps a language and TS Tree to the corresponding match tree.
---We need TS Tree because there might be multiple trees per buffer, such as a
---Markdown buffer which contains multiple code blocks.
local match_trees = {}

---Reusable autogroup for events in this strategy.
---@type integer
local augroup = api.nvim_create_augroup('TSRainbowLocalCursor', {})


---Highlights a single match with the given highlight group
---@param bufnr integer
---@param lang string
---@param match table
---@param hlgroup string
local function highlight_match(bufnr, lang, match, hlgroup)
	for _, delimiter in match.delimiter:iter() do lib.highlight(bufnr, lang, delimiter, hlgroup) end
end

---Highlights all matches and their children on the stack of matches. All
---matches must be on the same level of the match tree.
---
---@param bufnr   integer  Number of the buffer
---@param matches Stack   Stack of matches
---@param level   integer  Level of the matches
local function highlight_matches(bufnr, lang, matches, level)
	local hlgroup = lib.hlgroup_at(level)
	for _, match in matches:iter() do
		highlight_match(bufnr, lang, match, hlgroup)
		highlight_matches(bufnr, lang, match.children, level + 1)
	end
end

---Finds a match (and its level) in the match tree whose container node is the
---given container node.
---@param matches Stack
---@param container TSNode
---@param level integer
---@return table
---@return integer
---If no match is found, return nil.
---@overload fun(matches: Stack, container: TSNode, level: integer)
local function find_container(matches, container, level)
	for _, match in matches:iter() do
		if match.container == container then return match, level end
		local result, final_level = find_container(match.children, container, level + 1)
		if result then return result, final_level end
	end
end

--- Create a new empty match_record with an optionally set container
---@param container TSNode
---@return table
local function new_match_record(container)
	return {
		container = container,
		delimiter = Stack.new(),
		children = Stack.new(),
	}
end

---Assembles the match tree, usually called after the document tree has
---changed.
---@param bufnr   integer  Buffer number
---@param changes table   List of node ranges in which the changes occurred
---@param tree    TSTree  TS tree
---@param lang    string  Language
---@return Stack?
local function build_match_tree(bufnr, changes, tree, lang)
	if not lib.enabled_for(lang) then return end

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
				match_record = new_match_record(node)
			elseif name == 'container' then
				local prev_match_record = match_record
				-- temporarily push the match_record to matches to be retrieved
				-- later, since we haven't closed it yet
				matches:push(match_record)
				match_record = new_match_record(node)
				-- since we didn't close the previous match_record, it must
				-- mean that the current match_record has it as an ancestor
				match_record.ancestor = prev_match_record
			elseif name == 'sentinel' and match_record then
				-- if we see the sentinel, then we are done with the current
				-- container
				if match_record.ancestor then
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
				log.error([[You query got the capture name: %s.
					But it didn't come with a container, which should be impossible!
					Please double check your queries.]], name)
			end -- do nothing with other capture names
		end
	end

	return matches
end

---@param bufnr integer
---@param tree TSTree
---@param lang string
local function update_local(bufnr, tree, lang)
	if not lib.enabled_for(lang) then return end
	local query = lib.get_query(lang, bufnr)
	if not query then return end

	-- Find the lowest container node which contains the cursor
	local cursor_container
	do
		local curpos = api.nvim_win_get_cursor(0)
		-- The order of traversal guarantees that the first match which
		-- contains the cursor is also the lowest one.
		for _, match in query:iter_matches(tree:root(), bufnr, 0, -1) do
			if cursor_container then break end
			for id, node in pairs(match) do
				local name = query.captures[id]
				if name == 'container' and ts.is_in_node_range(node, curpos[1] - 1, curpos[2]) then
					cursor_container = node
					break
				end
			end
		end
	end
	if not cursor_container then return end

	local matches_lang = match_trees[bufnr][lang]
	if not matches_lang then
		log.debug("Did not build any matches Stack for language '%s'", lang)
		return
	end
	local matches = matches_lang[tree]
	if not matches then
		-- Note: vim.inspect(tree:root():range()) errors, so we need
		-- to make it into a table instead of a list of numbers
		log.debug("Did not build any matches Stack for tree '%s'", vim.inspect({tree:root():range()}))
		return
	end

	-- Find the correct container in the match tree
	local cursor_match, level = find_container(matches, cursor_container, 1)
	if not cursor_match then return end

	-- Highlight the container match and everything below
	highlight_matches(bufnr, lang, Stack.new {cursor_match}, level)

	-- Starting with the cursor match travel up and highlight every ancestor as
	-- well
	local ancestor = cursor_match.ancestor
	level = level - 1
	while ancestor do
		highlight_match(bufnr, lang, ancestor, lib.hlgroup_at(level))
		ancestor, level = ancestor.ancestor, level - 1
	end
end

---Callback function to re-highlight the buffer according to the current cursor
---position.
---@param bufnr integer
---@param parser vim.treesitter.LanguageTree
local function local_rainbow(bufnr, parser)
	parser:for_each_tree(function(tree, sub_parser)
		update_local(bufnr, tree, sub_parser:lang())
	end)
end

---Sets up all the callbacks and performs an initial highlighting
---@param bufnr integer # Buffer number
---@param parser vim.treesitter.LanguageTree
local function setup_parser(bufnr, parser)
	log.debug('Setting up parser for buffer %d', bufnr)
	util.for_each_child(nil, parser:lang(), parser, function(p, lang, _parent_lang)
		log.debug("Setting up parser for '%s' in buffer %d", lang, bufnr)
		-- Skip languages which are not supported, otherwise we get a
		-- nil-reference error
		if not lib.get_query(lang, bufnr) then return end
		p:register_cbs {
			---@param _changes table
			---@param tree TSTree
			on_changedtree = function(_changes, tree)
				-- HACK: As of Neovim v0.9.1 there is no way of unregistering a
				-- callback, so we use this check to abort
				if not lib.buffers[bufnr] then return end

				if vim.fn.pumvisible() ~= 0 then return end
				-- Ideally we would only rebuild the parts of the tree that have changed,
				-- but this doesn't work, so we will rebuild the entire tree
				-- instead.
				local fake_changes = {
					{tree:root():range()}
				}
				match_trees[bufnr][lang] = match_trees[bufnr][lang] or {}
				match_trees[bufnr][lang][tree] = build_match_tree(bufnr, fake_changes, tree, lang)
				-- Re-highlight after the change
				local_rainbow(bufnr, p)
			end,
			-- New languages can be added into the text at some later time, e.g.
			-- code snippets in Markdown
			---@param child vim.treesitter.LanguageTree
			on_child_added = function(child)
				setup_parser(bufnr, child)
			end,
		}
		log.trace("Done with setting up parser for '%s' in buffer %d", lang, bufnr)
	end)
end

---on_attach implementation for the local strategy
---@param bufnr integer
---@param settings rainbow_delimiters.buffer_settings
function M.on_attach(bufnr, settings)
	local parser = settings.parser
	setup_parser(bufnr, parser)

	api.nvim_create_autocmd('CursorMoved', {
		group = augroup,
		buffer = bufnr,
		callback = function(args)
			util.for_each_child(nil, parser:lang(), parser, function(_, lang, _)
				lib.clear_namespace(bufnr, lang)
			end)
			local_rainbow(args.buf, parser)
		end
	})

	-- Build up the initial match tree
	match_trees[bufnr] = {}
	parser:for_each_tree(function(tree, sub_parser)
		local sub_lang = sub_parser:lang()
		local changes = {
			{tree:root():range()}
		}
		match_trees[bufnr][sub_lang] = match_trees[bufnr][sub_lang] or {}
		match_trees[bufnr][sub_lang][tree] = build_match_tree(bufnr, changes, tree, sub_lang)
	end)
	local_rainbow(bufnr, parser)
end

---on_detach implementation for the local strategy
---@param bufnr integer
function M.on_detach(bufnr)
	-- Uninstall autocommand and delete cached match tree
	api.nvim_clear_autocmds {
		buffer = bufnr,
		group = augroup,
	}
	match_trees[bufnr] = nil
end

---on_reset implementation for the local strategy
---@param bufnr integer
---@param settings rainbow_delimiters.buffer_settings
function M.on_reset(bufnr, settings)
	local parser = settings.parser
	local_rainbow(bufnr, parser)
end

return M --[[@as rainbow_delimiters.strategy]]

-- vim:tw=79:ts=4:sw=4:noet:
