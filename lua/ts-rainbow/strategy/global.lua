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
local queries = require 'nvim-treesitter.query'
local configs = require 'nvim-treesitter.configs'
local add_predicate = vim.treesitter.query.add_predicate
local extended_languages = { "latex", "html", "verilog", "jsx" }
local lib = require 'ts-rainbow.lib'
local levels = require 'ts-rainbow.levels'


---Strategy which highlights the entire buffer.
local M = {}

---Register predicates for extended mode.
---@param config table # Configuration for the `rainbow` module in nvim-treesitter
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

---Update highlights for a range. Called every time text is changed.
---@param bufnr   number  Buffer number
---@param changes table   List of node ranges in which the changes occurred
---@param tree    table   TS tree
---@param lang    string  Language
local function update_range(bufnr, changes, tree, lang)
	if vim.fn.pumvisible() ~= 0 or not lang then return end

	local query = configs.get_module("rainbow").query
	if type(query) == 'table' then
		query = query[lang] or query[1] or lib.query
	end

	for _, change in ipairs(changes) do
		local root_node = tree:root()
		local query = queries.get_query(lang, query)
		local levels = levels[lang]
		if query ~= nil then
			for _, node, _ in query:iter_captures(root_node, bufnr, change[1], change[3] + 1) do
				-- set colour for this nesting level
				if not node:has_error() then
					local hlgroup = lib.hlgroup_at(lib.node_level(node, levels))
					lib.highlight(bufnr, node, hlgroup)
				end
			end
		end
	end
end

---Update highlights for every tree in given buffer.
---@param bufnr number # Buffer number
---@return nil
local function full_update(bufnr)
	local function callback(tree, sub_parser)
		local changes = {
			{tree:root():range()}
		}
		update_range(bufnr, changes, tree, sub_parser:lang())
	end

	lib.buffer_parsers[bufnr]:for_each_tree(callback)
end


function M.on_attach(bufnr, lang)
	local config = configs.get_module("rainbow")
	register_predicates(config)
	local parser = parsers.get_parser(bufnr, lang)
	parser:register_cbs {
		on_changedtree = function(changes, tree)
			if lib.state_table[bufnr] then
				update_range(bufnr, changes, tree, lang)
			else
				return
			end
		end,
	}
	lib.buffer_parsers[bufnr] = parser
	lib.state_table[bufnr] = true
	full_update(bufnr)
end

function M.on_detach(bufnr)
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
