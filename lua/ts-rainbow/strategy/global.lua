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
local lib = require 'ts-rainbow.lib'
local levels = require 'ts-rainbow.levels'


---Strategy which highlights the entire buffer.
local M = {}

---Update highlights for a range. Called every time text is changed.
---@param bufnr   number  Buffer number
---@param changes table   List of node ranges in which the changes occurred
---@param tree    table   TS tree
---@param lang    string  Language
local function update_range(bufnr, changes, tree, lang)
	if vim.fn.pumvisible() ~= 0 or not lang then return end
	local query = lib.get_query(lang)
	if not query then return end
	local levels = levels[lang]

	for _, change in ipairs(changes) do
		local root_node = tree:root()
		for id, node, _ in query:iter_captures(root_node, bufnr, change[1], change[3] + 1) do
			local name = query.captures[id]
			if name == 'opening' or name == 'closing' then
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

	lib.buffers[bufnr].parser:for_each_tree(callback)
end


function M.attach(bufnr, lang)
	local parser = parsers.get_parser(bufnr, lang)
	parser:register_cbs {
		on_changedtree = function(changes, tree)
			if lib.buffers[bufnr] then
				update_range(bufnr, changes, tree, lang)
			else
				return
			end
		end,
	}
	full_update(bufnr)
end

function M.detach(bufnr)
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
