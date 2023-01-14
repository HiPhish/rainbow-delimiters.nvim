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

local lib = require 'ts-rainbow.lib'

---Public API for use in writing strategies or other custom code.
local M = {}

M.get_query = lib.get_query
M.highlight = lib.highlight
M.hlgroup_at = lib.hlgroup_at
M.node_level = lib.node_level
---This might get removed, I hope there is a better solution
M.levels = require 'ts-rainbow.levels'

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
