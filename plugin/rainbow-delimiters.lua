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

local api = vim.api
local set_hl         = api.nvim_set_hl
local create_augroup = api.nvim_create_augroup
local create_autocmd = api.nvim_create_autocmd
local get_parser = vim.treesitter.get_parser
local config     = require 'rainbow-delimiters.config'
local log        = require 'rainbow-delimiters.log'
local lib        = require 'rainbow-delimiters.lib'


--- [ DEFINE HIGHLIGHT GROUPS ]------------------------------------------------
local function define_hlgroups()
	log.trace 'Define highlight groups'

	set_hl(0, 'RainbowDelimiterRed'   , {default = true, fg = '#cc241d', ctermfg= 'Red'    })
	set_hl(0, 'RainbowDelimiterOrange', {default = true, fg = '#d65d0e', ctermfg= 'White'  })
	set_hl(0, 'RainbowDelimiterYellow', {default = true, fg = '#d79921', ctermfg= 'Yellow' })
	set_hl(0, 'RainbowDelimiterGreen' , {default = true, fg = '#689d6a', ctermfg= 'Green'  })
	set_hl(0, 'RainbowDelimiterCyan'  , {default = true, fg = '#a89984', ctermfg= 'Cyan'   })
	set_hl(0, 'RainbowDelimiterBlue'  , {default = true, fg = '#458588', ctermfg= 'Blue'   })
	set_hl(0, 'RainbowDelimiterViolet', {default = true, fg = '#b16286', ctermfg= 'Magenta'})
end

define_hlgroups()


--- [ CALLBACK FUNCTIONS ]-----------------------------------------------------
local attach, detach

function attach(bufnr)
	local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].ft)
	if not lang then
		log.trace('Cannot attach to buffer %d, no parser for %s', bufnr, lang)
		return
	end
	log.trace('Attaching to buffer %d with language %s.', bufnr, lang)

	if lib.buffers[bufnr] then
		if lib.buffers[bufnr].lang == lang then return end
		-- The file type of the buffer has change, so we need to detach first
		-- before we re-attach
		detach(bufnr)
	end

	local parser
	do
		local success
		success, parser = pcall(get_parser, bufnr, lang)
		if not success then return end
	end

	local strategy
	do
		strategy = config.strategy[lang]
		if type(strategy) == 'function' then
			strategy = strategy()
		end
	end

	-- Intentionally abort; the user has explicitly disabled rainbow delimiters
	-- for this buffer, usually by setting a strategy- or query function which
	-- returned nil.
	if not strategy then
		log.warn('No strategy defined for %s', lang)
	end

	parser:register_cbs {
		on_detach = function(bnr)
			if not lib.buffers[bnr] then return end
			detach(bufnr)
		end,
		on_child_removed = function(child)
			lib.clear_namespace(bufnr, child:lang())
		end,
	}

	local settings = {
		strategy = strategy,
		parser   = parser,
		lang     = lang
	}
	lib.buffers[bufnr] = settings

	-- For now we silently discard errors, but in the future we should log
	-- them.
	local success, error = pcall(strategy.on_attach, bufnr, settings)
	if not success then
		log.error('Error attaching strategy to buffer %d: %s', bufnr, error)
		lib.buffers[bufnr] = nil
	end
end

function detach(bufnr)
	log.trace('Detaching from buffer %d.', bufnr)
	if not lib.buffers[bufnr] then
		return
	end

	local strategy = lib.buffers[bufnr].strategy
	local parser = lib.buffers[bufnr].parser

	-- Clear all the namespaces for each language
	parser:for_each_child(function(_, lang)
		lib.clear_namespace(bufnr, lang)
	end, true)
	-- Finally release all resources the parser is holding on to
	parser:destroy()

	-- For now we silently discard errors, but in the future we should log
	-- them.
	local success, error = pcall(strategy.on_detach, bufnr)
	if not success then
		log.error('Error detaching strategy from buffer %d: %s', bufnr, error)
	end
	lib.buffers[bufnr] = nil
end


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
	callback = function(args) attach(args.buf) end,
})

create_autocmd('BufUnload', {
	desc = 'Detach from the current buffer',
	group = rb_augroup,
	callback = function(args) detach(args.buf) end
})

vim.g.loaded_rainbow = true

-- vim:tw=79:ts=4:sw=4:noet:
