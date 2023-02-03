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

local configs = require 'nvim-treesitter.configs'
local queries = require 'nvim-treesitter.query'
local lib     = require 'ts-rainbow.lib'

---Public API for use in writing strategies or other custom code.
local M = {}

---Fetches the query and its name for the given language from the settings.
---
---@param lang string  Name of the language to get the query for
---@return userdata query  The query object
---@return string   name   The name of the query
function M.get_query(lang)
	local settings = configs.get_module('rainbow').query
	local name = type(settings) == 'string' and settings or settings[lang] or settings[1] or lib.query
	local query = queries.get_query(lang, name)
	return query, name
end

---Apply highlighting to a single node.
---@param bufnr   number  Buffer which contains the node
---@param node    table   Node to highlight
---@param hlgroup string  Name of the highlight group to  apply.
---@return nil
function M.highlight(bufnr, node, hlgroup)
	-- range of the capture, zero-indexed
	local startRow, startCol, endRow, endCol = node:range()

	local start, finish = {startRow, startCol}, {endRow, endCol - 1}
	local opts = {
		regtype = "b",
		inclusive = true,
		priority = 210,
	}

	vim.highlight.range(bufnr, lib.nsid, hlgroup, start, finish, opts)
end


---Get the appropriate highlight group for the given level of nesting.
---@param i number  One-based index into the highlight groups
---@return string hlgroup  Name of the highlight groups
function M.hlgroup_at(i)
	local hlgroups = configs.get_module('rainbow').hlgroups
	return hlgroups[(i - 1) % #hlgroups + 1]
end

---Find the nesting level of a node.
---@param node       table  Node to find the level of
---@param containers table  Set-like table of `@container` capture names
---@return number level Level of the node, does not wrap around
function M.node_level(node, containers)
	local result, current, found = 0, node, false

	while current:parent() ~= nil do
		if containers then
			if containers[current:type()] then
				result = result + 1
				found = true
			end
		else
			result = result + 1
			found = true
		end
		current = current:parent()
	end
	if not found then
		return 1
	end
	return result
end

---Table mapping the name of a language to a set-like table of `@container`
---capture names. I am not certain whether this will remain.
M.containers = require 'ts-rainbow.containers'

function M.clear_namespace(bufnr)
	vim.api.nvim_buf_clear_namespace(bufnr, lib.nsid, 0, -1)
end

function M.buffer_config(bufnr)
	-- TODO: make the resulting table read-only. Perhaps this should be done in
	-- the original table?
	return lib.buffers[bufnr]
end

return M
-- vim:tw=79:ts=4:sw=4:noet:
