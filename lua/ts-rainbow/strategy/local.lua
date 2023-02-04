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

local rainbow = require 'ts-rainbow'
local api = vim.api
local ts = vim.treesitter

---Highlight strategy which highlights the sub-tree of the buffer which
---contains the cursor. Re-computes -highlights when the buffer contents change
---or when the cursor is moved.
local M = {}

local augroup = api.nvim_create_augroup('TSRainbowLocalCursor', {})

local function update_local(bufnr, tree, lang, query_name)
	if vim.fn.pumvisible() ~= 0 or not lang then return end

	local query = rainbow.get_query(lang)
	if not query then return end

	rainbow.clear_namespace(bufnr)
	local containers = rainbow.containers[lang][query_name]

	local row, col
	do
		local curpos = vim.fn.getpos('.')
		row, col = curpos[2] - 1, curpos[3] - 1
	end

	-- NOTE: We highlight the delimiters, but in order to decide whether to
	-- highlight or not we have to look at the level of the container node
	-- which contains all delimiters.  See HACKING file for details.

	-- Find the lowest container node which contains the cursor
	local cursor_container
	for id, node in query:iter_captures(tree:root(), bufnr) do
		local name = query.captures[id]
		if name == 'container' then
			local lower =
				ts.is_in_node_range(node, row, col) and
				(not cursor_container or ts.is_ancestor(cursor_container, node))
			if lower then
				cursor_container = node
			end
		end
	end
	if not cursor_container then return end

	for _, match, _ in query:iter_matches(tree:root(), bufnr) do
		local container, opening, closing
		for id, node in pairs(match) do
			local name = query.captures[id]
			if name == 'container' then
				container = node
			elseif name == 'opening' then
				opening = node
			elseif name == 'closing' then
				closing = node
			end
		end
		if ts.is_in_node_range(container, row, col) or ts.is_ancestor(cursor_container, container) then
			local hlgroup = rainbow.hlgroup_at(rainbow.node_level(container, containers))
			rainbow.highlight(bufnr, opening, hlgroup)
			rainbow.highlight(bufnr, closing, hlgroup)
		end
	end
end

---Callback function to re-highlight the buffer according to the current cursor
---position.
local function local_rainbow(bufnr, query_name)
	if bufnr == 0 then bufnr = vim.fn.bufnr() end
	local parser = rainbow.buffer_config(bufnr).parser
	if not parser then
		return
	end
	parser:for_each_tree(function(tree, sub_parser)
		update_local(bufnr, tree, sub_parser:lang(), query_name)
	end)
end

function M.on_attach(bufnr, settings)
	api.nvim_create_autocmd('CursorMoved', {
		group = augroup,
		buffer = bufnr,
		callback = function(args)
			local buf = args.buf
			local_rainbow(buf, settings.query_name)
		end
	})
end

function M.on_detach(bufnr)
	-- Uninstall autocommand
	api.nvim_clear_autocmds {
		buffer = bufnr,
		group = augroup,
	}
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
