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
local get_current_buf = vim.api.nvim_get_current_buf

---Disable rainbow delimiters for a given buffer.
---@param bufnr number  Buffer number, zero for current buffer.
local function disable(bufnr)
	if not bufnr or bufnr == 0 then bufnr = get_current_buf() end
	lib.detach(bufnr)
	lib.buffers[bufnr] = false
end

---Enable rainbow delimiters for a given buffer.
---@param bufnr number         Buffer number, zero for current buffer.
---@param what? boolean|table  For which languages to enable
local function enable(bufnr, what)
	if not bufnr or bufnr == 0 then bufnr = get_current_buf() end
	local whitelist
	if what == nil or what == true then
		whitelist = true
	elseif what == false then
		whitelist = nil
	elseif type(what) == 'table' and #what > 0 then
		whitelist = {}
		for _, lang in ipairs(what) do whitelist[lang] = true end
	elseif type(what) == 'table' then
		local pos = vim.fn.getpos('.')
		local x, y = pos[2] - 1, pos[3] - 1
		local cursor_lang = vim.treesitter
			.get_parser()
			:language_for_range({x, y, x, y})
			:lang()
		whitelist = {
			[cursor_lang] = true
		}
	else
		error(string.format("Invalid value '%s' of second parameter", tostring(what)))
	end

	lib.buffers[bufnr] = nil
	lib.attach(bufnr, {whitelist = whitelist})
end

local function toggle(bufnr)
	if not bufnr or bufnr == 0 then bufnr = get_current_buf() end
	if lib.buffers[bufnr] then
		disable(bufnr)
	else
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
