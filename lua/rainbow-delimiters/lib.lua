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

local get_query = vim.treesitter.query.get
local log       = require 'rainbow-delimiters.log'
local config    = require 'rainbow-delimiters.config'


---[ Internal ]----------------------------------------------------------------
-- The following symbols should only be used internally. In particular, they
-- should not be used by strategies, or else our strategies are using
-- undocumented APIs.

---Private library of shared internal functions and variables.
local M = {}

---Per-language namespaces. This table instantiates namespaces on demand, i.e.
---a namespace won't exist until we first try to get it from the table.
M.nsids = setmetatable({}, {
	__index = function(t, k)
		local result = rawget(t, k)
		if result == nil then
			result = vim.api.nvim_create_namespace('')
			rawset(t, k, result)
		end
		return result
	end,
	-- Note: this will only catch new indices, not assignment to an already
	-- existing key
	__newindex = function(_, _, _)
		error('Table is immutable')
	end
})


---Keeps track of attached buffers.  The key is the buffer number and the value
---is a table of information about that buffer (e.g. language, strategy,
---query).  This also makes sure we keep track of all parsers in active use to
---prevent them from being garbage-collected.
M.buffers = {}


---[ This stuff needs to be re-exported ]--------------------------------------
-- The following entries can be used in the public API as well.

---Fetches the query object for the given language from the settings.
---
---@param lang string  Name of the language to get the query for
---@return userdata query  The query object
function M.get_query(lang)
	local name = config['query'][lang]
	local query = get_query(lang, name)

	if not query then
		log.debug('Query %s not found for %s', name, lang)
	else
		log.trace('Query %s found for %s', name, lang)
	end
	return query
end

---Apply highlighting to a single node.
---@param bufnr   number  Buffer which contains the node
---@param lang    string  Language of the node (to group HL into namespaces)
---@param node    table   Node to highlight
---@param hlgroup string  Name of the highlight group to  apply.
---@return nil
function M.highlight(bufnr, lang, node, hlgroup)
	-- range of the capture, zero-indexed
	local startRow, startCol, endRow, endCol = node:range()

	local start, finish = {startRow, startCol}, {endRow, endCol - 1}
	local opts = {
		regtype = 'c',
		inclusive = true,
		priority = 210,
	}

	local nsid = M.nsids[lang]

	if vim.api.nvim_buf_is_loaded(bufnr) then
		vim.highlight.range(bufnr, nsid, hlgroup, start, finish, opts)
	end
end


---Get the appropriate highlight group for the given level of nesting.
---@param i number  One-based index into the highlight groups
---@return string hlgroup  Name of the highlight groups
function M.hlgroup_at(i)
	local hlgroups = config.highlight
	return hlgroups[(i - 1) % #hlgroups + 1]
end


---Clears the reserved Rainbow namespace.
---
---@param bufnr number  Number of the buffer for which to clear the namespace
---@return nil
function M.clear_namespace(bufnr, lang, line_start, line_end)
	local nsid = M.nsids[lang]
	if vim.api.nvim_buf_is_valid(bufnr) then
		vim.api.nvim_buf_clear_namespace(bufnr, nsid, line_start or 0, line_end or -1)
	end
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
