--[[
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

local queries = require 'nvim-treesitter.query'
local configs = require 'nvim-treesitter.configs'
local lib = require 'ts-rainbow.lib'

local M = {}

function M.init()
    require('nvim-treesitter').define_modules {
        rainbow = {
            module_path = 'ts-rainbow.internal',
            is_supported = function(lang)
            	local query = configs.get_module('rainbow').query
				if type(query) == 'table' then
					query = query[lang] or query[1] or lib.query
				end
                return queries.get_query(lang, query) ~= nil
            end,
            extended_mode = true,
            strategy = require 'ts-rainbow.strategy.global',
            query = lib.query,
            -- Highlight groups in order of display
            hlgroups = {
            	-- The colours are intentionally not in the usual order to make
            	-- the contrast between them stronger
            	'TSRainbowRed',
            	'TSRainbowYellow',
            	'TSRainbowBlue',
            	'TSRainbowOrange',
            	'TSRainbowGreen',
            	'TSRainbowViolet',
            	'TSRainbowCyan',
            },
        },
    }
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
