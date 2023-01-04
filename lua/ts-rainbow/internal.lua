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
local lib = require 'ts-rainbow.lib'
local api = vim.api

local M = {}

--- Attach module to buffer. Called when new buffer is opened or `:TSBufEnable rainbow`.
--- @param bufnr number # Buffer number
--- @param lang string # Buffer language
function M.attach(bufnr, lang)
	local config = configs.get_module("rainbow")
	if not config then return end

	local strategy = config.strategy
	local max_file_lines = config.max_file_lines
	if max_file_lines ~= nil and vim.api.nvim_buf_line_count(bufnr) > max_file_lines then
		return
	end

	strategy.on_attach(bufnr, lang)
end

--- Detach module from buffer. Called when `:TSBufDisable rainbow`.
--- @param bufnr number # Buffer number
function M.detach(bufnr)
	local config = configs.get_module("rainbow")
	if not config then return end

	local strategy = config.strategy

	lib.state_table[bufnr] = false
	if vim.treesitter.highlighter.hl_map then
		vim.treesitter.highlighter.hl_map["punctuation.bracket"] = "TSPunctBracket"
	else
		vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "TSPunctBracket" })
	end
	vim.api.nvim_buf_clear_namespace(bufnr, lib.nsid, 0, -1)
	lib.buffer_parsers[bufnr] = nil

	strategy.on_detach(bufnr)
end

api.nvim_create_augroup("RainbowParser", {})
api.nvim_create_autocmd("FileType", {
	group = "RainbowParser",
	pattern = "*",
	callback = function()
		local bufnr = api.nvim_get_current_buf()
		if lib.state_table[bufnr] then
			local lang = parsers.get_buf_lang(bufnr)
			local parser = parsers.get_parser(bufnr, lang)
			lib.buffer_parsers[bufnr] = parser
		end
	end,
})

return M

-- vim:tw=79:ts=4:sw=4:noet:
