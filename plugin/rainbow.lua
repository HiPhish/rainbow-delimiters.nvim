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

if vim.g.loaded_rainbow then
	return
end

local set_hl = vim.api.nvim_set_hl
local internal = require 'ts-rainbow.internal'
local log = require 'ts-rainbow.log'


--- [ DEFINE HIGHLIGHT GROUPS ]------------------------------------------------
local function define_hlgroups()
	log.trace 'Define highlight groups'

	set_hl(0, 'TSRainbowRed'   , {default = true, fg = '#cc241d', ctermfg= 'Red'    })
	set_hl(0, 'TSRainbowOrange', {default = true, fg = '#d65d0e', ctermfg= 'White'  })
	set_hl(0, 'TSRainbowYellow', {default = true, fg = '#d79921', ctermfg= 'Yellow' })
	set_hl(0, 'TSRainbowGreen' , {default = true, fg = '#689d6a', ctermfg= 'Green'  })
	set_hl(0, 'TSRainbowCyan'  , {default = true, fg = '#a89984', ctermfg= 'Cyan'   })
	set_hl(0, 'TSRainbowBlue'  , {default = true, fg = '#458588', ctermfg= 'Blue'   })
	set_hl(0, 'TSRainbowViolet', {default = true, fg = '#b16286', ctermfg= 'Magenta'})
end

define_hlgroups()


--- [ SET UP AUTOCOMMANDS ]----------------------------------------------------
local hl_augroup = vim.api.nvim_create_augroup('TSRainbowHighlight', {})
local rb_augroup = vim.api.nvim_create_augroup('TSRainbowDelimits', {})

vim.api.nvim_create_autocmd('ColorScheme', {
	desc = 'Re-apply highlight group definitions when the colour scheme changes',
	group = hl_augroup,
	callback = define_hlgroups
})

vim.api.nvim_create_autocmd('FileType', {
	desc = 'Attach to a new buffer',
	group = rb_augroup,
	callback = function(args)
		local bufnr = args.buf
		local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].ft)
		log.trace('Attaching to buffer %d with language %s.', bufnr, lang)

		internal.attach(bufnr, lang)
	end
})

vim.api.nvim_create_autocmd('BufUnload', {
	desc = 'Detach from the current buffer',
	group = rb_augroup,
	callback = function(args)
		local bufnr = args.buf
		log.trace('Detaching from buffer %d.', bufnr)
		internal.detach(bufnr)
	end
})

vim.g.loaded_rainbow = true

-- vim:tw=79:ts=4:sw=4:noet:
