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

local configs = require 'nvim-treesitter.configs'

---Collection of all included strategies.
local M = {
	global = require 'ts-rainbow.strategy.global',
	['local'] = require 'ts-rainbow.strategy.local',
}

---Default strategy if there is none configured
local default = M.global

---Finds the configured strategy for the given language, falling back on the
---default if there is no language-specific setting.
---@param lang string  The language of the buffer
---@return table strategy  The strategy table to use
function M.get(lang)
	local setting = configs.get_module('rainbow').strategy
	if type(setting) == 'table' then
		setting = setting[lang] or setting[1] or default
	end
	return setting
end

return M
