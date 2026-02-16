-- SPDX-License-Identifier: Apache-2.0

--  Copyright 2023 Alejandro "HiPhish" Sanchez
--  Copyright 2020-2022 Chinmay Dalal
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.

if vim.g.loaded_rainbow_delimiters then
	return
end

local api = vim.api
local set_hl         = api.nvim_set_hl
local create_augroup = api.nvim_create_augroup
local create_autocmd = api.nvim_create_autocmd
local get_lang   = vim.treesitter.language.get_lang


--- [ DEFINE HIGHLIGHT GROUPS ]------------------------------------------------
local function define_hlgroups()
	set_hl(0, 'RainbowDelimiterRed'   , {default = true, fg = '#cc241d', ctermfg= 'Red'    })
	set_hl(0, 'RainbowDelimiterOrange', {default = true, fg = '#d65d0e', ctermfg= 'White'  })
	set_hl(0, 'RainbowDelimiterYellow', {default = true, fg = '#d79921', ctermfg= 'Yellow' })
	set_hl(0, 'RainbowDelimiterGreen' , {default = true, fg = '#689d6a', ctermfg= 'Green'  })
	set_hl(0, 'RainbowDelimiterCyan'  , {default = true, fg = '#a89984', ctermfg= 'Cyan'   })
	set_hl(0, 'RainbowDelimiterBlue'  , {default = true, fg = '#458588', ctermfg= 'Blue'   })
	set_hl(0, 'RainbowDelimiterViolet', {default = true, fg = '#b16286', ctermfg= 'Magenta'})
end

define_hlgroups()


--- [ SET UP AUTOCOMMANDS ]----------------------------------------------------
local hl_augroup = create_augroup('TSRainbowHighlight', {})
local rb_augroup = create_augroup('TSRainbowDelimits', {})

create_autocmd('ColorScheme', {
	desc = 'Re-apply highlight group definitions when the colour scheme changes',
	group = hl_augroup,
	callback = define_hlgroups
})

create_autocmd('FileType', {
	desc = 'Attach to a new buffer',
	group = rb_augroup,
	callback = function(args)
		local config = require 'rainbow-delimiters.config'
		local lib    = require 'rainbow-delimiters.lib'

		local lang = get_lang(args.match)
		local bufnr = args.buf
		if not config.enabled_for(lang) then return end
		if not config.enabled_when(bufnr) then return end

		lib.attach(bufnr)
	end,
})

create_autocmd('BufUnload', {
	desc = 'Detach from the current buffer',
	group = rb_augroup,
	callback = function(args)
		local lib = require 'rainbow-delimiters.lib'
		lib.detach(args.buf)
	end
})

vim.g.loaded_rainbow_delimiters = true

-- vim:tw=79:ts=4:sw=4:noet:
