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

local parsers = require("nvim-treesitter.parsers")
local configs = require("nvim-treesitter.configs")
local lib     = require 'ts-rainbow.lib'
local rb      = require 'ts-rainbow'
local api     = vim.api
local ts      = vim.treesitter

---Internal implementation of the plugin.
local M = {}

---Update the parser for a buffer.
local function set_buffer_parser()
	local bufnr = api.nvim_get_current_buf()
	if lib.buffers[bufnr] then
		local lang = parsers.get_buf_lang(bufnr)
		local parser = ts.get_parser(bufnr, lang)
		lib.buffers[bufnr].parser = parser
	end
end

---Finds the configured strategy for the given language, falling back on the
---default if there is no language-specific setting.
---@param lang string  The language of the buffer
---@return table strategy  The strategy table to use
local function get_strategy(lang)
	local settings = configs.get_module('rainbow').strategy
	local setting = settings[lang] or settings[1] or rb.strategy.global
	if type(setting) == 'function' then
		return setting()
	end
	return setting
end

--- Attach module to buffer. Called when new buffer is opened or `:TSBufEnable rainbow`.
--- @param bufnr number # Buffer number
--- @param lang string # Buffer language
function M.attach(bufnr, lang)
	local config = configs.get_module("rainbow")
	if not config then return end

	local strat = get_strategy(lang)
	-- Intentionally abort; the user has explicitly disabled rainbow delimiters
	-- for this buffer, usually by setting a strategy- or query function which
	-- returned nil.
	if not strat then
		return
	end

	local parser = ts.get_parser(bufnr, lang)
	parser:register_cbs {
		on_detach = function(bnr)
			if not lib.buffers[bnr] then return end
			print(string.format('Detaching buffer %d', bnr))
			M.detach(bufnr)
		end
	}

	local settings = {
		strategy = strat,
		parser = parser,
	}
	lib.buffers[bufnr] = settings

	-- For now we silently discard errors, but in the future we should log
	-- them.
	pcall(strat.on_attach, bufnr, settings)
end

--- Detach module from buffer. Called when `:TSBufDisable rainbow`.
--- @param bufnr number # Buffer number
function M.detach(bufnr)
	local config = configs.get_module("rainbow")
	if not config then return end

	local strategy = lib.buffers[bufnr].strategy

	-- Clear all the namespaces for each language
	lib.buffers[bufnr].parser:for_each_child(function(_, lang)
		lib.clear_namespace(bufnr, lang)
	end, true)

	-- For now we silently discard errors, but in the future we should log
	-- them.
	pcall(strategy.on_detach, bufnr)
	lib.buffers[bufnr] = nil
end

-- If the file type of a buffer changes we have to swap out the parser for that
-- buffer.
api.nvim_create_augroup("TSRainbowParser", {})
api.nvim_create_autocmd("FileType", {
	group = "TSRainbowParser",
	pattern = "*",
	callback = set_buffer_parser,
})

return M
-- vim:tw=79:ts=4:sw=4:noet:
