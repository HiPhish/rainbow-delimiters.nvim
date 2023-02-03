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

local rainbow = require 'ts-rainbow'
local queries = require 'ts-rainbow.queries'


---Strategy which highlights the entire buffer.
local M = {}

---Update highlights for a range. Called every time text is changed.
---@param bufnr   number  Buffer number
---@param changes table   List of node ranges in which the changes occurred
---@param tree    table   TS tree
---@param lang    string  Language
local function update_range(bufnr, changes, tree, lang, query_name)
	if vim.fn.pumvisible() ~= 0 or not lang then return end
	local query = rainbow.get_query(lang)
	if not query then return end
	local containers = queries[lang][query_name]

	for _, change in ipairs(changes) do
		local root_node = tree:root()
		for id, node, _ in query:iter_captures(root_node, bufnr, change[1], change[3] + 1) do
			local name = query.captures[id]
			if name == 'opening' or name == 'closing' then
				-- set colour for this nesting level
				if not node:has_error() then
					local hlgroup = rainbow.hlgroup_at(rainbow.node_level(node, containers))
					rainbow.highlight(bufnr, node, hlgroup)
				end
			end
		end
	end
end

---Update highlights for every tree in given buffer.
---@param bufnr number # Buffer number
---@return nil
local function full_update(bufnr, query_name)
	local function callback(tree, sub_parser)
		local changes = {
			{tree:root():range()}
		}
		update_range(bufnr, changes, tree, sub_parser:lang(), query_name)
	end

	rainbow.buffer_config(bufnr).parser:for_each_tree(callback)
end


function M.on_attach(bufnr, settings)
	local parser = rainbow.buffer_config(bufnr).parser
	local lang = settings.lang
	local query_name = settings.query_name
	parser:register_cbs {
		on_changedtree = function(changes, tree)
			update_range(bufnr, changes, tree, lang, query_name)
		end,
	}
	full_update(bufnr, query_name)
end

function M.on_detach(bufnr)
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
