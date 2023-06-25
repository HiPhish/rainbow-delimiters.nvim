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

---Default plugin configuration.
local M = {
	query = {
		['']  = 'rainbow-parens',
		html  = 'rainbow-tags',
		latex = 'rainbow-blocks',
		tsx   = 'rainbow-tags',
	},
	strategy = {
		require 'ts-rainbow.strategy.global'
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

return M

-- vim:tw=79:ts=4:sw=4:noet:
