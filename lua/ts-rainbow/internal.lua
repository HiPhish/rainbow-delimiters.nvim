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

local config  = require 'ts-rainbow.config'
local lib     = require 'ts-rainbow.lib'

---Internal implementation of the plugin.
local M = {}

---Finds the configured strategy for the given language, falling back on the
---default if there is no language-specific setting.
---@param lang string  The language of the buffer
---@return table strategy  The strategy table to use
local function get_strategy(lang)
	local settings = config.strategy
	local setting = settings[lang] or settings['']
	if type(setting) == 'function' then
		return setting()
	end
	return setting
end

--- Attach module to buffer. Called when new buffer is opened or `:TSBufEnable rainbow`.
--- @param bufnr number # Buffer number
--- @param lang string # Buffer language
function M.attach(bufnr, lang)
	if not lang then return end
	if lib.buffers[bufnr] then
		if lib.buffers[bufnr].lang == lang then return end
		-- The file type of the buffer has change, so we need to detach first
		-- before we re-attach
		M.detach(bufnr)
	end

	local parser
	do
		local success
		success, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
		if not success then return end
	end

	local strat = get_strategy(lang)
	-- Intentionally abort; the user has explicitly disabled rainbow delimiters
	-- for this buffer, usually by setting a strategy- or query function which
	-- returned nil.
	if not strat then return end

	parser:register_cbs {
		on_detach = function(bnr)
			if not lib.buffers[bnr] then return end
			M.detach(bufnr)
		end,
		on_child_removed = function(child)
			lib.clear_namespace(bufnr, child:lang())
		end,
	}

	local settings = {
		strategy = strat,
		parser   = parser,
		lang     = lang
	}
	lib.buffers[bufnr] = settings

	-- For now we silently discard errors, but in the future we should log
	-- them.
	pcall(strat.on_attach, bufnr, settings)
end

--- Detach module from buffer. Called when `:TSBufDisable rainbow`.
--- @param bufnr number # Buffer number
function M.detach(bufnr)
	if not lib.buffers[bufnr] then return end

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
	pcall(strategy.on_detach, bufnr)
	lib.buffers[bufnr] = nil
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
