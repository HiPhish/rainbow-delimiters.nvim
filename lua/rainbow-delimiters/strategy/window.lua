local Stack        = require 'rainbow-delimiters.stack'
local config       = require 'rainbow-delimiters.config'
local lib          = require 'rainbow-delimiters.lib'
local log          = require 'rainbow-delimiters.log'
local util         = require 'rainbow-delimiters.util'
local api          = vim.api
local ts           = vim.treesitter
local set_provider = api.nvim_set_decoration_provider
local set_extmark  = api.nvim_buf_set_extmark


---Strategy which highlights the entire buffer.
local M = {}

M.nsid = api.nvim_create_namespace('RainbowDelimiterWindow')


---@param bufnr integer
---@param nsid integer
---@param matches Stack
---@param level integer
---@param hlgroups string[]
local function highlight_matches(bufnr, nsid, priority, matches, level, hlgroups)
	local hlgroup = hlgroups[(level - 1) % #hlgroups + 1]
	for _, match in matches:iter() do
		for _, delimiter in match.delimiter:iter() do
			local start_row, start_col, end_row, end_col = delimiter:range(false)
			set_extmark(bufnr, nsid, start_row, start_col, {
				end_row = end_row,
				end_col = end_col,
				hl_group = hlgroup,
				strict = false,
				ephemeral = true,
			})
		end
		highlight_matches(bufnr, nsid, priority, match.children, level + 1, hlgroups)
	end
end

---@param child table
---@param parent Stack
local function put_child_into_parent(child, parent)
	local child_range = child.container
	local child_start_row, child_start_col = child_range[1], child_range[2]
	local child_sentinel = child.sentinel
	local child_sentinel_row, child_sentinel_col = child_sentinel[1], child_sentinel[2]

	for _, current_child in parent:iter() do
		local cur_child_range = current_child.container
		local cur_start_row, cur_start_col = cur_child_range[1], cur_child_range[2]
		local cur_sentinel = current_child.sentinel
		local cur_sentinel_row, cur_sentinel_col = cur_sentinel[1], cur_sentinel[2]

		if
			(cur_start_row < child_start_row
				or (cur_start_row == child_start_row and cur_start_col <= child_start_col))
			and
			(child_sentinel_row < cur_sentinel_row
				or (child_sentinel_row == cur_sentinel_row and child_sentinel_col <= cur_sentinel_col))
		then
			put_child_into_parent(child, current_child.children)
			return
		elseif
			(child_start_row < cur_start_row
				or (child_start_row == cur_start_row and child_start_col <= cur_start_col))
			and
			(cur_sentinel_row < child_sentinel_row
				or (cur_sentinel_row == child_sentinel_row and cur_sentinel_col <= child_sentinel_col))
		then
			put_child_into_parent(current_child, child.children)
			parent:pop()
		else
			break
		end
	end

	parent:push(child)
end

---Update highlights for a range. Called every time text is changed.
---@param bufnr   integer  Buffer number
---@param toprow  integer Top row of the window
---@param botrow  integer Bottom row of the window
---@param tree    TSTree  TS tree
---@param lang    string  Language
---@param hlgroups string[]
local function update_range(bufnr, toprow, botrow, tree, lang, hlgroups)
	log.debug('Updated range with changes %s', vim.inspect({toprow, botrow}))

	if not lib.enabled_for(lang) then return end
	if vim.fn.pumvisible() ~= 0 or not lang then return end

	local query = lib.get_query(lang, bufnr)
	if not query then return end

	local matches = Stack.new()

	local root_node = tree:root()
	local start_row, end_row = toprow, botrow + 1

	for _pattern, match, _metadata in query:iter_matches(root_node, bufnr, start_row, end_row, { all = true }) do
		-- This is the match record, it lists all the relevant nodes from
		-- each match. We start with the root_node as the container, but
		-- we will update this later.
		local match_record = {
			container = {root_node:range()},
			delimiter = Stack.new(),
			children = Stack.new(),
			sentinel = nil, ---@type integer[]?
		}
		for id, nodes in pairs(match) do
			local name = query.captures[id]
			for _, node in ipairs(nodes) do
				-- check for 'delimiter' first, since that should be the most
				-- common name
				if name == 'delimiter' then
					match_record.delimiter:push(node)
				elseif name == 'container' then
					-- we update the container here
					match_record.container = {node:range()}
				elseif name == 'sentinel' then
					-- if a sentinel is given, we save the position here
					local sentinel_row, sentinel_col, _ = node:end_()
					match_record.sentinel = { sentinel_row, sentinel_col }
				end
			end
		end
		if match_record.sentinel == nil then
			match_record.sentinel  = { match_record.container[3], match_record.container[4] }
		end

		for _, other in matches:iter() do
			local match_range = match_record.container
			local other_range = other.container
			local match_start_row, match_start_col = match_range[1], match_range[2]
			local other_start_row, other_start_col = other_range[1], other_range[2]

			local match_sentinel = match_record.sentinel ---@type integer[]
			local match_sentinel_row, match_sentinel_col = match_sentinel[1], match_sentinel[2]
			local other_sentinel = other.sentinel ---@type integer[]
			local other_sentinel_row, other_sentinel_col = other_sentinel[1], other_sentinel[2]

			if
				(match_start_row < other_start_row
					or (match_start_row == other_start_row and match_start_col <= other_start_col))
				and
				(other_sentinel_row < match_sentinel_row
					or (other_sentinel_row == match_sentinel_row and other_sentinel_col <= match_sentinel_col))
			then
				put_child_into_parent(other, match_record.children)
				matches:pop()
			elseif
				(other_start_row < match_start_row
					or (other_start_row == match_start_row and other_start_col <= match_start_col))
				and
				(match_sentinel_row < other_sentinel_row
					or (match_sentinel_row == other_sentinel_row and match_sentinel_col <= other_sentinel_col))
			then
				local child = match_record
				match_record = other
				put_child_into_parent(child, match_record.children)
				matches:pop()
			else
				break
			end
		end
		matches:push(match_record)
	end

	local priority = config.priority[lang]
	if type(priority) == "function" then
		priority = priority(bufnr)
	end
	local nsid = M.nsid
	highlight_matches(bufnr, nsid, priority, matches, 1, hlgroups)
end

local function on_buf(_, bufnr, _tick)
	if bufnr ~= api.nvim_get_current_buf() or not lib.buffers[bufnr] then return false end
end

local function on_win(_, _winid, bufnr, toprow, botrow)
	local parser_ok, parser = pcall(ts.get_parser, bufnr)
	if not parser_ok or not parser then return false end

	local hlgroups = config.highlight
	local parent_lang = parser:lang()
	local lang
	local tree_start_row, tree_end_row
	parser:for_each_tree(function(tree, sub_parser)
		lang = sub_parser:lang()
		if lang == parent_lang and lang == 'rust' then
			-- for rust only highlight with the root parser
			if sub_parser == parser then
				tree_start_row, _, tree_end_row, _ = tree:root():range(false)
				if tree_start_row <= botrow and tree_end_row >= toprow then
					update_range(bufnr, toprow, botrow, tree, lang, hlgroups)
				end
			end
		else
			tree_start_row, _, tree_end_row, _ = tree:root():range(false)
			if tree_start_row <= botrow and tree_end_row >= toprow then
				update_range(bufnr, toprow, botrow, tree, lang, hlgroups)
			end
		end
	end)
end

---on_attach implementation for the global strategy
---@param _bufnr integer
---@param _settings rainbow_delimiters.buffer_settings
function M.on_attach(_bufnr, _settings)
	log.trace('window strategy on_attach')
	set_provider(M.nsid, { on_buf = on_buf, on_win = on_win })
end

---on_detach implementation for the global strategy
---@param _bufnr integer
function M.on_detach(_bufnr)
end

---on_reset implementation for the global strategy
---@param _bufnr integer
---@param _settings rainbow_delimiters.buffer_settings
function M.on_reset(_bufnr, _settings)
	log.trace('window strategy on_reset')
end

return M --[[@as rainbow_delimiters.strategy]]

-- vim:tw=79:ts=4:sw=4:noet:
