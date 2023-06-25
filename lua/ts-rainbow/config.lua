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

---Plugin configuration table.
local M = {}

local rainbow = require 'ts-rainbow'

local default_config = {
	query = {
		'rainbow-parens',
		html  = 'rainbow-tags',
		latex = 'rainbow-blocks',
		tsx   = 'rainbow-tags',
	},
	strategy = {
		rainbow.strategy.global,
	},
	-- Highlight groups in order of display
	highlight = {
		-- The colours are intentionally not in the usual order to make
		-- the contrast between them stronger
		'TSRainbowRed',
		'TSRainbowYellow',
		'TSRainbowBlue',
		'TSRainbowOrange',
		'TSRainbowGreen',
		'TSRainbowViolet',
		'TSRainbowCyan',
	}
}

setmetatable(M, {
	__index = function(config, key)
		local result
		result = rawget(config, key)
		if result ~= nil then return result end

		if vim.g.ts_rainbow_delims then
			result = rawget(vim.g.ts_rainbow_delims, key)
		end
		if result ~= nil then return result end

		return rawget(default_config, key)
	end
})

return M

-- vim:tw=79:ts=4:sw=4:noet:
