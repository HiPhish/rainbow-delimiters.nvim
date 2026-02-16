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

---Lazily loaded reference to the private library
local lib

---Disable rainbow delimiters for a given buffer.
---@param bufnr integer  Buffer number, zero for current buffer.
local function disable(bufnr)
	lib = lib or require 'rainbow-delimiters.lib'
	if not bufnr or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
	lib.detach(bufnr)
	lib.buffers[bufnr] = false
end

---Enable rainbow delimiters for a given buffer.
---@param bufnr integer  Buffer number, zero for current buffer.
local function enable(bufnr)
	lib = lib or require 'rainbow-delimiters.lib'
	if not bufnr or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
	lib.buffers[bufnr] = nil
	lib.attach(bufnr)
end

---Toggle rainbow delimiters for a given buffer.
---@param bufnr integer  Buffer number, zero for current buffer.
local function toggle(bufnr)
	lib = lib or require 'rainbow-delimiters.lib'
	if not bufnr or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
	if lib.buffers[bufnr] then
		disable(bufnr)
	else
		enable(bufnr)
	end
end

---Check if rainbow delimiters are enabled for a given buffer.
---@param bufnr integer  Buffer number, zero for current buffer.
---@return boolean # Whether or not rainbow delimiters is enabled
local function is_enabled(bufnr)
	lib = lib or require 'rainbow-delimiters.lib'
	if not bufnr or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
	return lib.buffers[bufnr] ~= nil and lib.buffers[bufnr] ~= false
end

---Get the appropriate highlight group for the given level of nesting.
---@param i integer  One-based index into the highlight groups
---@return string hlgroup  Name of the highlight groups
local function hlgroup_at(i)
	lib = lib or require 'rainbow-delimiters.lib'
	return lib.hlgroup_at(i)
end

---Public API for use in writing strategies or other custom code.
local M = {
	hlgroup_at = hlgroup_at,
	---Available default highlight strategies
	strategy = {
		---Global highlighting strategy
		['global'] = 'rainbow-delimiters.strategy.global',
		---Local highlighting strategy
		['local']  = 'rainbow-delimiters.strategy.local',
		---Empty highlighting strategy for testing
		['noop']   = 'rainbow-delimiters.strategy.no-op',
	},
	enable  = enable,
	disable = disable,
	toggle  = toggle,
	is_enabled  = is_enabled,
}


return M
-- vim:tw=79:ts=4:sw=4:noet:
