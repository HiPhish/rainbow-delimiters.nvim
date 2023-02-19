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

local Stack = require 'ts-rainbow.stack'
local lib   = require 'ts-rainbow.lib'
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


-- Cache of queries by language. Fetching a query on every cursor movement is
-- expensive, but we can cache them here and retrieve them after the first
-- fetch. If a query does not exist we store the 'false' value to distinguish
-- it from a query which has not yet been fetched.
local queries = {}

-- Cache of match trees. We compute the match tree on every change, so that
-- when the cursor moves without changing the tree we don't need to re-compute
-- it.
local match_trees = {}

-- Reusable autogroup for events in this strategy.
local augroup = api.nvim_create_augroup('TSRainbowLocalCursor', {})


---Highlights a single match with the given highlight group
local function highlight_match(bufnr, match, hlgroup)
	local opening = match.opening
	if opening then lib.highlight(bufnr, opening, hlgroup) end
	local closing = match.closing
	if closing then lib.highlight(bufnr, closing, hlgroup) end
	for _, intermediate in ipairs(match.intermediates) do
		lib.highlight(bufnr, intermediate, hlgroup)
	end
end

---Highlights all matches and their children on the stack of matches. All
---matches must be on the same level of the match tree.
---
---@param bufnr   number  Number of the buffer
---@param matches Stack   Stack of matches
---@param level   number  Level of the matches
local function highlight_matches(bufnr, matches, level)
	local hlgroup = lib.hlgroup_at(level)
	for _, match in matches:iter() do
		highlight_match(bufnr, match, hlgroup)
		highlight_matches(bufnr, match.children, level + 1)
	end
end

---Finds a match (and its level) in the match tree whose container node is the
---given container node.
local function find_container(matches, container, level)
	for _, match in matches:iter() do
		if match.container == container then return match, level end
		local result, final_level = find_container(match.children, container, level + 1)
		if result then return result, final_level end
	end
end

---Assembles the match tree, usually called after the document tree has
---changed.
local function build_match_tree(bufnr, changes, tree, lang)
	if queries[lang] == nil then queries[lang] = lib.get_query(lang) or false end
	local query = queries[lang]
	if not query then return end

	local matches = Stack.new()

	for _, change in ipairs(changes) do
		local root_node = tree:root()
		for _, match, _ in query:iter_matches(root_node, bufnr, change[1], change[3] + 1) do
			-- This is the match record, it lists all the relevant nodes from
			-- the match.
			local match_record = {
				intermediates = {},
				children = Stack.new(),
			}
			for id, node in pairs(match) do
				local name = query.captures[id]
				if name == 'container' then
					match_record.container = node
				elseif name == 'opening' then
					match_record.opening = node
				elseif name == 'closing' then
					match_record.closing = node
				elseif name == 'intermediate' then
					match_record.intermediates[#match_record.intermediates+1] = node
				end
			end

			for _, other in matches:iter() do
				if not ts.is_ancestor(match_record.container, other.container) then
					break
				end
				other.ancestor = match_record
				match_record.children:push(other)
				matches:pop()
			end
			matches:push(match_record)
		end
	end
	return matches
end

local function update_local(bufnr, tree, lang)
	if queries[lang] == nil then queries[lang] = lib.get_query(lang) or false end
	local query = queries[lang]
	if not query then return end

	lib.clear_namespace(bufnr)

	-- Find the lowest container node which contains the cursor
	local cursor_container
	do
		local curpos = api.nvim_win_get_cursor(0)
		-- The order of traversal guarantees that the first match which
		-- contains the cursor is also the lowest one.
		for _, match in query:iter_matches(tree:root(), bufnr) do
			if cursor_container then break end
			for id, node in pairs(match) do
				local name = query.captures[id]
				if name == 'container' and ts.is_in_node_range(node, curpos[1], curpos[2]) then
					cursor_container = node
					break
				end
			end
		end
	end
	if not cursor_container then return end

	local matches = match_trees[bufnr][lang]
	if not matches then return end

	-- Find the correct container in the match tree
	local cursor_match, level = find_container(matches, cursor_container, 1)
	if not cursor_match then return end

	-- Highlight the container match and everything below
	highlight_matches(bufnr, Stack.new {cursor_match}, level)

	-- Starting with the cursor match travel up and highlight every ancestor as
	-- well
	local ancestor, level = cursor_match.ancestor, level - 1
	while ancestor do
		highlight_match(bufnr, ancestor, lib.hlgroup_at(level))
		ancestor, level = ancestor.ancestor, level - 1
	end
end

---Callback function to re-highlight the buffer according to the current cursor
---position.
local function local_rainbow(bufnr, parser)
	parser:for_each_tree(function(tree, sub_parser)
		update_local(bufnr, tree, sub_parser:lang())
	end)
end

function M.on_attach(bufnr, settings)
	local lang = settings.lang
	local parser = settings.parser

	parser:register_cbs {
		on_changedtree = function(changes, tree)
			if vim.fn.pumvisible() ~= 0 or not lang then return end
			-- Ideally we would only rebuild the parts of the tree that have changed,
			-- but this doesn't work, so we will rebuild the entire tree
			-- instead.
			local fake_changes = {
				{tree:root():range()}
			}
			match_trees[bufnr][lang] = build_match_tree(bufnr, fake_changes, tree, lang)
			local_rainbow(bufnr, parser)
		end,
	}

	api.nvim_create_autocmd('CursorMoved', {
		group = augroup,
		buffer = bufnr,
		callback = function(args)
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
		match_trees[bufnr][sub_lang] = build_match_tree(bufnr, changes, tree, sub_lang)
	end)
end

function M.on_detach(bufnr)
	-- Uninstall autocommand and delete cached match tree
	api.nvim_clear_autocmds {
		buffer = bufnr,
		group = augroup,
	}
	match_trees[bufnr] = nil
end

return M

-- vim:tw=79:ts=4:sw=4:noet: