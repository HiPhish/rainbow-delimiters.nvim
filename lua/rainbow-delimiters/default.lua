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

local priorities = (vim.hl or vim.highlight).priorities

---Default plugin configuration.
---@type rainbow_delimiters.config
local M = {
	---Query names by file type
	query = {
		['']  = 'rainbow-delimiters',
		javascript = 'rainbow-delimiters-react'
	},
	---Highlight strategies by file type
	strategy = {
		[''] = require 'rainbow-delimiters.strategy.global',
	},
	priority = {
		-- Halfway between semantic tokens and Tree-sitter
		[''] = math.floor((priorities.semantic_tokens + priorities.treesitter) / 2)

	},
	---Event logging settings
	log = {
		---Log level of the module, see `:h log_levels`.
		level = vim.log.levels.WARN,
		---File name of the log file
		file  = vim.fn.stdpath('log') .. '/rainbow-delimiters.log',
	},
	-- Highlight groups in order of display
	highlight = {
		-- The colours are intentionally not in the usual order to make
		-- the contrast between them stronger
		'RainbowDelimiterRed',
		'RainbowDelimiterYellow',
		'RainbowDelimiterBlue',
		'RainbowDelimiterOrange',
		'RainbowDelimiterGreen',
		'RainbowDelimiterViolet',
		'RainbowDelimiterCyan',
	}
}

---If the key does not exist in the table fall back on the empty string as
---key.
local function get_with_fallback(table, key)
	return rawget(table, key) or rawget(table, '')
end

setmetatable(M.query, {
	__index = get_with_fallback,
})

setmetatable(M.strategy, {
	__index = get_with_fallback,
})

setmetatable(M.priority, {
	__index = get_with_fallback,
})


return M

-- vim:tw=79:ts=4:sw=4:noet:
