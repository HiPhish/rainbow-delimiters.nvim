-- SPDX-License-Identifier: Apache-2.0

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

local get_query  = vim.treesitter.query.get
local get_parser = vim.treesitter.get_parser
local log        = require 'rainbow-delimiters.log'
local config     = require 'rainbow-delimiters.config'
local util       = require 'rainbow-delimiters.util'


---[ Internal ]----------------------------------------------------------------
-- The following symbols should only be used internally. In particular, they
-- should not be used by strategies, or else our strategies are using
-- undocumented APIs.

---Private library of shared internal functions and variables.
local M = {}

M.enabled_for = config.enabled_for

---Per-language namespaces. This table instantiates namespaces on demand, i.e.
---a namespace won't exist until we first try to get it from the table.
M.nsids = setmetatable({}, {
	__index = function(t, k)
		local result = rawget(t, k)
		if result == nil then
			result = vim.api.nvim_create_namespace('')
			rawset(t, k, result)
		end
		return result
	end,
	-- Note: this will only catch new indices, not assignment to an already
	-- existing key
	__newindex = function(_, _, _)
		error('Table is immutable')
	end
})


---Keeps track of attached buffers.  The key is the buffer number and the value
---is a table of information about that buffer (e.g. language, strategy,
---query).  This also makes sure we keep track of all parsers in active use to
---prevent them from being garbage-collected.
---@type table<integer, rainbow_delimiters.buffer_settings | false>
M.buffers = {}


---[ This stuff needs to be re-exported ]--------------------------------------
-- The following entries can be used in the public API as well.

---Fetches the query object for the given language from the settings.  If a
---buffer number is given it will be used as the current buffer, otherwise the
---actual current buffer is used.
---
---@param lang  string   Name of the language to get the query for
---@param bufnr integer  Use this buffer as the current buffer
---@return vim.treesitter.Query? query  The query object
function M.get_query(lang, bufnr)
	local name = config['query'][lang]
	if type(name) == "function" then
		name = name(bufnr)
	end
	local query = get_query(lang, name)

	if not query then
		log.debug('Query %s not found for %s', name, lang)
	else
		log.trace('Query %s found for %s', name, lang)
	end
	return query
end

---Apply highlighting to a single node.
---@param bufnr   integer  Buffer which contains the node
---@param lang    string  Language of the node (to group HL into namespaces)
---@param node    table   Node to highlight
---@param hlgroup string  Name of the highlight group to  apply.
function M.highlight(bufnr, lang, node, hlgroup)
	-- range of the capture, zero-indexed
	local startRow, startCol, endRow, endCol = node:range()

	local start, finish = {startRow, startCol}, {endRow, endCol - 1}
	local priority = config.priority[lang]
	if type(priority) == "function" then
		priority = priority(bufnr)
	end
	local opts = {
		regtype   = 'v',
		inclusive = true,
		priority  = priority,
	}

	local nsid = M.nsids[lang]

	if vim.api.nvim_buf_is_loaded(bufnr) then
		(vim.hl or vim.highlight).range(bufnr, nsid, hlgroup, start, finish, opts)
	end
end


---Get the appropriate highlight group for the given level of nesting.
---@param i integer  One-based index into the highlight groups
---@return string hlgroup  Name of the highlight groups
function M.hlgroup_at(i)
	local hlgroups = config.highlight
	return hlgroups[(i - 1) % #hlgroups + 1]
end


---Clears the reserved Rainbow namespace.
---
---@param bufnr integer  Number of the buffer for which to clear the namespace
---@param lang string
---@param line_start integer?
---@param line_end integer?
function M.clear_namespace(bufnr, lang, line_start, line_end)
	local nsid = M.nsids[lang]
	if vim.api.nvim_buf_is_valid(bufnr) then
		vim.api.nvim_buf_clear_namespace(bufnr, nsid, line_start or 0, line_end or -1)
	end
end

---Start rainbow highlighting for the given buffer
---@param bufnr integer
function M.attach(bufnr)
	-- Rainbow delimiters was explicitly disabled for this buffer
	if M.buffers[bufnr] == false then return end

	local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].ft)
	if not lang then
		log.trace('Cannot attach to buffer %d, no parser for %s', bufnr, lang)
		return
	end
	log.trace('Attaching to buffer %d with language %s.', bufnr, lang)

	local settings = M.buffers[bufnr]
	if settings then
		-- if M.buffers[bufnr].lang == lang then return end
		-- TODO: If the language is the same reload the parser
		if settings.lang == lang then
			local parser = get_parser(bufnr, lang)
			local strategy = settings.strategy
			parser:invalidate(true)
			parser:parse()
			strategy.on_reset(bufnr, settings)
			return
		end
		-- The file type of the buffer has changed, so we need to detach first
		-- before we re-attach
		M.detach(bufnr)
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
			strategy = strategy(bufnr)
		end
		if type(strategy) == 'string' then
			strategy = require(strategy)
		end
	end

	-- Intentionally abort; the user has explicitly disabled rainbow delimiters
	-- for this buffer, usually by setting a strategy- or query function which
	-- returned nil.
	if not strategy then
		log.warn('No strategy defined for %s', lang)
	end
	if not strategy or strategy == vim.NIL then return end

	---@param child vim.treesitter.LanguageTree
	local function f(child)
		if child:lang() ~= lang then
			M.clear_namespace(bufnr, child:lang())
		end
	end

	parser:register_cbs {
		---@param bnr integer
		on_detach = function(bnr)
			if not M.buffers[bnr] then return end
			M.detach(bufnr)
		end,
		on_child_removed = f,
	}

	settings = {
		strategy = strategy,
		parser   = parser,
		lang     = lang
	}
	M.buffers[bufnr] = settings

	-- For now we silently discard errors, but in the future we should log
	-- them.
	local success, error = pcall(strategy.on_attach, bufnr, settings)
	if not success then
		log.error('Error attaching strategy to buffer %d: %s', bufnr, error)
		M.buffers[bufnr] = nil
	end
end

---Start rainbow highlighting for the given buffer
---@param bufnr integer
function M.detach(bufnr)
	log.trace('Detaching from buffer %d.', bufnr)
	if not M.buffers[bufnr] then
		return
	end

	local strategy = M.buffers[bufnr].strategy
	local parser = M.buffers[bufnr].parser

	-- Clear all the namespaces for each language
	util.for_each_child(nil, parser:lang(), parser, function(_, lang)
		M.clear_namespace(bufnr, lang)
	end)
	-- Finally release all resources the parser is holding on to
	parser:destroy()

	-- For now we silently discard errors, but in the future we should log
	-- them.
	local success, error = pcall(strategy.on_detach, bufnr)
	if not success then
		log.error('Error detaching strategy from buffer %d: %s', bufnr, error)
	end
	M.buffers[bufnr] = nil
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
