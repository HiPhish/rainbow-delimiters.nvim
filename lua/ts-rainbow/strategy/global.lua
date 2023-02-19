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

local Stack = require 'ts-rainbow.stack'
local lib   = require 'ts-rainbow.lib'
local ts    = vim.treesitter


---Strategy which highlights the entire buffer.
local M = {}

local function highlight_matches(bufnr, records, level)
	local hlgroup = lib.hlgroup_at(level)
	for _, record in records:iter() do
		local opening = record.opening
		if opening then lib.highlight(bufnr, opening, hlgroup) end
		local closing = record.closing
		if closing then lib.highlight(bufnr, closing, hlgroup) end
		for _, intermediate in ipairs(record.intermediates) do
			lib.highlight(bufnr, intermediate, hlgroup)
		end
		highlight_matches(bufnr, record.children, level + 1)
	end
end

---Update highlights for a range. Called every time text is changed.
---@param bufnr   number  Buffer number
---@param changes table   List of node ranges in which the changes occurred
---@param tree    table   TS tree
---@param lang    string  Language
local function update_range(bufnr, changes, tree, lang, query)
	if vim.fn.pumvisible() ~= 0 or not lang then return end
	if not query then return end

	local matches = Stack.new()

	for _, change in ipairs(changes) do
		local root_node = tree:root()
		for _, match, _ in query:iter_matches(root_node, bufnr, change[1], change[3] + 1) do
			-- This is the match record, it lists all the relevant nodes from
			-- the match.
			local match_record = {
				intermediates = {},
				children = Stack.new(),
			}
			for id, node in pairs(match) do
				local name = query.captures[id]
				if name == 'container' then
					match_record.container = node
				elseif name == 'opening' then
					match_record.opening = node
				elseif name == 'closing' then
					match_record.closing = node
				elseif name == 'intermediate' then
					match_record.intermediates[#match_record.intermediates+1] = node
				end
			end

			for _, other in matches:iter() do
				if not ts.is_ancestor(match_record.container, other.container) then
					break
				end
				match_record.children:push(other)
				matches:pop()
			end
			matches:push(match_record)
		end
	end

	highlight_matches(bufnr, matches, 1)
end

---Update highlights for every tree in given buffer.
---@param bufnr number # Buffer number
---@return nil
local function full_update(bufnr, parser, query)
	local function callback(tree, sub_parser)
		local changes = {
			{tree:root():range()}
		}
		update_range(bufnr, changes, tree, sub_parser:lang(), query)
	end

	parser:for_each_tree(callback)
end


function M.on_attach(bufnr, settings)
	local parser = settings.parser
	local lang = settings.lang
	local query = settings.query
	parser:register_cbs {
		on_changedtree = function(changes, tree)
			update_range(bufnr, changes, tree, lang, query)
		end,
	}
	full_update(bufnr, parser, query)
end

function M.on_detach(bufnr)
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
