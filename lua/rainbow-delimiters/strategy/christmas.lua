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

---Strategy decorator which makes your delimiters change colours like Christmas
---lights.  This module is meant as a joke and will not be loaded by default
---with the rest of the plugin.
local M = {}

local uv = vim.loop
local lib = require 'rainbow-delimiters.lib'
local original_hlgroup_at = lib.hlgroup_at


local counter = 0

---Wrapper around the original function which applies some offset to the index.
---@param i integer
---@return string hlgroup
local function patched_hlgroup_at(i)
	return original_hlgroup_at(counter + i)
end

---Wraps the given strategy with a new strategy that switches colours like a
---chain of Christmas lights.
---@param strategy rainbow_delimiters.strategy?  Original strategy (default global)
---@param delay    integer?  Time between switches in milliseconds (default 500)
---@return rainbow_delimiters.strategy christmas_lights  A new strategy object
function M.lights(strategy, delay)
	strategy = strategy or require 'rainbow-delimiters.strategy.global'
	delay = delay or 500
	local timer = uv.new_timer()

	---@param bufnr integer
	---@param settings rainbow_delimiters.buffer_settings
	local function on_attach(bufnr, settings)
		local function blink()
			counter = counter + 1
			local function callback()
				lib.hlgroup_at = patched_hlgroup_at
				strategy.on_reset(bufnr, lib.buffers[bufnr])
				lib.hlgroup_at = original_hlgroup_at
			end
			vim.schedule(callback)
		end
		timer:start(0, delay, blink)
		strategy.on_attach(bufnr, settings)
	end

	---@param bufnr integer
	local function on_detach(bufnr)
		timer:stop()
		strategy.on_detach(bufnr)
	end

	return {
		strategy  = strategy,
		on_attach = on_attach,
		on_detach = on_detach,
		on_reset  = strategy.on_reset,
	}
end

return M
