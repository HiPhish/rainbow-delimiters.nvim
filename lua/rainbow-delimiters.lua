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

local lib = require 'rainbow-delimiters.lib'

---Disable rainbow delimiters for a given buffer.
---@param bufnr number  Buffer number, zero for current buffer.
local function disable(bufnr)
	bufnr = bufnr > 0 and bufnr or vim.api.nvim_get_current_buf()
	lib.detach(bufnr)
	lib.buffers[bufnr] = false
end

---Enable rainbow delimiters for a given buffer.
---@param bufnr number  Buffer number, zero for current buffer.
local function enable(bufnr)
	bufnr = bufnr > 0 and bufnr or vim.api.nvim_get_current_buf()
	lib.buffers[bufnr] = nil
	lib.attach(bufnr)
end

local function toggle(bufnr)
	bufnr = bufnr > 0 and bufnr or vim.api.nvim_get_current_buf()
	if lib.buffers[bufnr] then
		print 'turn off'
		disable(bufnr)
	else
		print 'turn on'
		enable(bufnr)
	end
end

---Public API for use in writing strategies or other custom code.
local M = {
	hlgroup_at = lib.hlgroup_at,
	---Available default highlight strategies
	strategy = {
		['global'] = require 'rainbow-delimiters.strategy.global',
		['local']  = require 'rainbow-delimiters.strategy.local',
		['noop']   = require 'rainbow-delimiters.strategy.no-op',
	},
	enable  = enable,
	disable = disable,
	toggle  = toggle,
}


return M
-- vim:tw=79:ts=4:sw=4:noet:
