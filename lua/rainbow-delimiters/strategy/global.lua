-- SPDX-License-Identifier: Apache-2.0

--[[
   Copyright 2024 Alejandro "HiPhish" Sanchez

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


local lib   = require 'rainbow-delimiters.lib'
local util  = require 'rainbow-delimiters.util'
local log   = require 'rainbow-delimiters.log'

local Stack = require 'rainbow-delimiters.stack'
local MatchTree = require 'rainbow-delimiters.match-tree'


---Changes are range objects and come in two variants: one with four entries and
---one with six entries.  We only want the four-entry variant.  See
---`:h TSNode:range()`
---@param change integer[]
---@return integer[]
local function normalize_change(change)
	local result
	if #change == 4 then
		result = change
	elseif #change == 6 then
		result = {change[1], change[2], change[4], change[5]}
	else
		result = {}
	end
	return result
end


---Update highlights for a range. Called every time text is changed.
---@param bufnr   integer  Buffer number
---@param changes table   List of node ranges in which the changes occurred
---@param tree    vim.treesitter.TSTree  TS tree
---@param lang    string  Language
local function update_range(bufnr, changes, tree, lang)
	log.debug('Updated range with changes %s', vim.inspect(changes))

	if not lib.enabled_for(lang) or vim.fn.pumvisible() ~= 0 then
		return
	end

	local query = lib.get_query(lang, bufnr)
	if not query then return end

	---Temporary stack of partial match trees; used to build the final match trees
	local root_node = tree:root()

	-- Build the match tree
	for _, change in ipairs(changes) do
		local match_trees = Stack.new()
		local start_row, end_row = change[1], change[3] + 1
		lib.clear_namespace(bufnr, lang, start_row, end_row)

		for _, match in query:iter_matches(root_node, bufnr, start_row, end_row, {all=true}) do
			---@type rainbow_delimiters.MatchTree
			local this = MatchTree.assemble(query, match)
			while match_trees:size() > 0 do
				local other = match_trees:pop()
				if this < other then
					this(other)
				else
					match_trees:push(other)
					break
				end
			end
			match_trees:push(this)
		end
		for _, match_tree in match_trees:iter() do
			MatchTree.highlight(match_tree, bufnr, lang, 1)
		end
	end
end

---Update highlights for every tree in given buffer.
---@param bufnr integer # Buffer number
---@param parser vim.treesitter.LanguageTree
local function full_update(bufnr, parser)
	log.debug('Performing full updated on buffer %d', bufnr)
	local function callback(tree, sub_parser)
		local changes = {{tree:root():range()}}
		update_range(bufnr, changes, tree, sub_parser:lang())
	end

	parser:for_each_tree(callback)
end

---Sets up all the callbacks and performs an initial highlighting
---@param bufnr integer # Buffer number
---@param parser vim.treesitter.LanguageTree
---@param start_parent_lang string? # Parent language or nil
local function setup_parser(bufnr, parser, start_parent_lang)
	log.debug('Setting up parser for buffer %d', bufnr)

	---Sets up an individual parser for a particular language
	---@param p vim.treesitter.LanguageTree   Parser for that language
	---@param lang string  The language
	local function f(p, lang, parent_lang)
		log.debug("Setting up parser for '%s' in buffer %d", lang, bufnr)
		-- Skip languages which are not supported, otherwise we get a
		-- nil-reference error
		if not lib.get_query(lang, bufnr) then return end

		local function on_changedtree(changes, tree)
			log.trace('Changed tree in buffer %d with languages %s', bufnr, lang)
			-- HACK: As of Neovim v0.9.1 there is no way of unregistering a
			-- callback, so we use this check to abort
			if not lib.buffers[bufnr] then return end

			-- Collect changes to pass on to the next step; might have to treat
			-- injected languages differently.
			if not parent_lang then
				-- If we have no parent language, then we use changes, otherwise we use the
				-- whole tree's range.
				-- Normalize the changes object if we have no parent language (the one we
				-- get from on_changedtree)
				changes = vim.tbl_map(normalize_change, changes)
			elseif parent_lang ~= lang and changes[1] then
				-- We have a parent language, so we are in an injected language code
				-- block, thus we update all of the current code block
				changes = {{tree:root():range()}}
			else
				-- some languages (like rust) use injections of the language itself for
				-- certain functionality (e.g., macros in rust).  For these the
				-- highlighting will be updated by the non-injected language part of the
				-- code.
				changes = {}
			end
			-- TODO
			-- Clear extmarks if a line has been moved across languages
			--
			-- TODO
			-- Update the range
			-- only update highlighting if we have changes
			if changes[1] then
				update_range(bufnr, changes, tree, lang)
			end
		end

		---New languages can be added into the text at some later time, e.g.
		---code snippets in Markdown
		---@param child vim.treesitter.LanguageTree
		local function on_child_added(child)
			setup_parser(bufnr, child, lang)
		end

		p:register_cbs {
			on_changedtree = on_changedtree,
			on_child_added = on_child_added,
		}
		log.trace("Done with setting up parser for '%s' in buffer %d", lang, bufnr)
	end

	-- A buffer has one primary language and potentially many child languages
	-- which may have child languages of their own.  We need to set up the
	-- parser for each of them.
	util.for_each_child(start_parent_lang, parser:lang(), parser, f)

	full_update(bufnr, parser)
end


---@param bufnr integer
---@param settings rainbow_delimiters.buffer_settings
local function on_attach(bufnr, settings)
	log.trace('global strategy on_attach for buffer %d', bufnr)
	local parser = settings.parser
	setup_parser(bufnr, parser, nil)
end

---@param bufnr integer
local function on_detach(bufnr)
	log.trace('global strategy on_detach for buffer %d', bufnr)
end

---@param bufnr integer
---@param settings rainbow_delimiters.buffer_settings
local function on_reset(bufnr, settings)
	log.trace('global strategy on_reset for buffer %d', bufnr)
	full_update(bufnr, settings.parser)
end


---Strategy which highlights all delimiters in the current buffer.
---@type rainbow_delimiters.strategy
return {
	on_attach = on_attach,
	on_detach = on_detach,
	on_reset = on_reset,
}
