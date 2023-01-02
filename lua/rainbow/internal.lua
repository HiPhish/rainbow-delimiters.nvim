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

local queries = require("nvim-treesitter.query")
local parsers = require("nvim-treesitter.parsers")
local configs = require("nvim-treesitter.configs")
local api = vim.api

local add_predicate = vim.treesitter.query.add_predicate
local nsid = vim.api.nvim_create_namespace("rainbow_ns")
local extended_languages = { "latex", "html", "verilog", "jsx" }
local colors = configs.get_module("rainbow").colors
local termcolors = configs.get_module("rainbow").termcolors

--- Maps a buffer ID to the buffer's parser; retaining a reference prevents the
--- parser from getting garbage-collected.
local buffer_parsers = {}

--- Find the nesting level of a node.
--- @param node table # Node to find the level of
--- @param len number # Number of colours
--- @param levels table # Levels for the language
local function color_no(node, len, levels)
	local counter = 0
	local current = node
	local found = false
	while current:parent() ~= nil do
		if levels then
			if levels[current:type()] then
				counter = counter + 1
				found = true
			end
		else
			counter = counter + 1
			found = true
		end
		current = current:parent()
	end
	if not found then
		return 1
	elseif counter % len == 0 then
		return len
	else
		return (counter % len)
	end
end

--- Update highlights for a range. Called every time text is changed.
--- @param bufnr number # Buffer number
--- @param changes table # Range of text changes
--- @param tree table # Syntax tree
--- @param lang string # Language
local function update_range(bufnr, changes, tree, lang)
	if vim.fn.pumvisible() ~= 0 or not lang then
		return
	end

	for _, change in ipairs(changes) do
		local root_node = tree:root()
		local query = queries.get_query(lang, "parens")
		local levels = require("rainbow.levels")[lang]
		if query ~= nil then
			for _, node, _ in query:iter_captures(root_node, bufnr, change[1], change[3] + 1) do
				-- set colour for this nesting level
				if not node:has_error() then
					local color_no_ = color_no(node, #colors, levels)
					local startRow, startCol, endRow, endCol = node:range() -- range of the capture, zero-indexed
					if vim.fn.has("nvim-0.7") == 1 then
						vim.highlight.range(
							bufnr,
							nsid,
							("rainbowcol" .. color_no_),
							{ startRow, startCol },
							{ endRow, endCol - 1 },
							{
								regtype = "b",
								inclusive = true,
								priority = 210,
							}
						)
					else
						vim.highlight.range(
							bufnr,
							nsid,
							("rainbowcol" .. color_no_),
							{ startRow, startCol },
							{ endRow, endCol - 1 },
							"blockwise",
							true,
							210
						)
					end
				end
			end
		end
	end
end

--- Update highlights for every tree in given buffer.
--- @param bufnr number # Buffer number
local function full_update(bufnr)
	local parser = buffer_parsers[bufnr]
	parser:for_each_tree(function(tree, sub_parser)
		update_range(bufnr, { { tree:root():range() } }, tree, sub_parser:lang())
	end)
end

--- Register predicates for extended mode.
--- @param config table # Configuration for the `rainbow` module in nvim-treesitter
local function register_predicates(config)
	local extended_mode

	if type(config.extended_mode) == "table" then
		extended_mode = {}
		for _, lang in pairs(config.extended_mode) do
			extended_mode[lang] = true
		end
	elseif type(config.extended_mode) == "boolean" then
		extended_mode = config.extended_mode
	else
		vim.api.nvim_err_writeln("nvim-ts-rainbow: `extended_mode` can be a boolean or a table")
	end

	for _, lang in ipairs(extended_languages) do
		local enable_extended_mode
		if type(extended_mode) == "table" then
			enable_extended_mode = extended_mode[lang]
		else
			enable_extended_mode = extended_mode
		end
		add_predicate(lang .. "-extended-rainbow-mode?", function()
			return enable_extended_mode
		end, true)
	end
end

local state_table = {}

local M = {}

--- Define highlight groups. This had to be a function to allow an autocmd doing this at colorscheme change.
function M.defhl()
	for i = 1, math.max(#colors, #termcolors) do
		local s = string.format("highlight default rainbowcol%d", i)
		if #colors > 0 then
			s = s .. " guifg=" .. colors[(i % #colors == 0) and #colors or (i % #colors)]
		end
		if #termcolors > 0 then
			s = s
				.. " ctermfg="
				.. termcolors[(i % #termcolors == 0) and #termcolors or (i % #termcolors)]
		end
		vim.cmd(s)
	end
end

M.defhl()

--- Attach module to buffer. Called when new buffer is opened or `:TSBufEnable rainbow`.
--- @param bufnr number # Buffer number
--- @param lang string # Buffer language
function M.attach(bufnr, lang)
	local config = configs.get_module("rainbow")
	local max_file_lines = config.max_file_lines
	if max_file_lines ~= nil and vim.api.nvim_buf_line_count(bufnr) > max_file_lines then
		return
	end
	register_predicates(config)
	local parser = parsers.get_parser(bufnr, lang)
	parser:register_cbs({
		on_changedtree = function(changes, tree)
			if state_table[bufnr] then
				update_range(bufnr, changes, tree, lang)
			else
				return
			end
		end,
	})
	buffer_parsers[bufnr] = parser
	state_table[bufnr] = true
	full_update(bufnr)
end

--- Detach module from buffer. Called when `:TSBufDisable rainbow`.
--- @param bufnr number # Buffer number
function M.detach(bufnr)
	state_table[bufnr] = false
	if vim.treesitter.highlighter.hl_map then
		vim.treesitter.highlighter.hl_map["punctuation.bracket"] = "TSPunctBracket"
	else
		vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "TSPunctBracket" })
	end
	vim.api.nvim_buf_clear_namespace(bufnr, nsid, 0, -1)
	buffer_parsers[bufnr] = nil
end

if vim.fn.has("nvim-0.7") == 1 then
	api.nvim_create_augroup("RainbowParser", {})
	api.nvim_create_autocmd("FileType", {
		group = "RainbowParser",
		pattern = "*",
		callback = function()
			local bufnr = api.nvim_get_current_buf()
			if state_table[bufnr] then
				local lang = parsers.get_buf_lang(bufnr)
				local parser = parsers.get_parser(bufnr, lang)
				buffer_parsers[bufnr] = parser
			end
		end,
	})
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
