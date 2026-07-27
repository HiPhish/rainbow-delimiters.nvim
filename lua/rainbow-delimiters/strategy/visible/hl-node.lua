-- SPDX-License-Identifier: Apache-2.0

-- Streaming match iteration and highlighting.  This library is only relevant
-- to strategy authors.  It walks the buffer's syntax tree in nesting order,
-- yielding each query match together with its highlight level, and applies the
-- delimiter highlighting one match at a time.

local nvim_buf_set_extmark = vim.api.nvim_buf_set_extmark

local lib = require 'rainbow-delimiters.lib'
local Set = require 'rainbow-delimiters.set'

--- Streaming, pre-order DFS version of Query:iter_matches().
---
--- Yields each match when its pattern's *root* node is reached in a
--- pre-order walk, so enclosing/earlier matches come first. State is
--- only the DFS stack (O(tree depth)); nothing is buffered up front.
---
--- Trade-off: runs one (root-only) query cursor per visited node, so
--- it does more total work than the single-pass built-in.
---
---@param query vim.treesitter.Query
---@param node vim.treesitter.TSNode
---@param bufnr integer
---@param start_row integer First row to highlight, inclusive
---@param end_row integer Last row to highlight, exclusive
---@return fun(): (integer, table<integer, TSNode[]>) next_match
local function iter_matches(query, node, bufnr, start_row, end_row)
	return coroutine.wrap(function()
		local queue = { { node, 1 } }

		while #queue > 0 do
			local tail = queue[#queue]
			queue[#queue] = nil

			local n = tail[1]
			local level = tail[2]

			-- `max_start_depth = 0` => only patterns whose root is exactly `n`.
			-- Predicates/directives are already applied by iter_matches.
			local matches = query:iter_matches(n, bufnr, start_row, end_row, { max_start_depth = 0 })

			local _, first_match = matches()
			local next_level = level
			if first_match ~= nil then
				-- only increase level if we are in container to
				-- avoid yielding the AST level.
				next_level = next_level + 1
				coroutine.yield(level, first_match)
			end

			for _, match in matches do
				coroutine.yield(level, match)
			end

			for child in n:iter_children() do
				if child:end_() >= start_row and child:start() < end_row then
					queue[#queue + 1] = { child, next_level }
				end
			end
		end
	end)
end

---Create a polling function which highlights the delimiters of all matches
---reachable from `root_node` within `[start_row, end_row)`.  Each call to the
---returned function processes a single match and reports whether there is more
---work left to do, allowing the caller to spread the work across multiple event
---loop iterations.
---
---@param query vim.treesitter.Query
---@param root_node vim.treesitter.TSNode
---@param bufnr integer
---@param start_row integer First row to highlight, inclusive
---@param end_row integer Last row to highlight, exclusive
---@param nsid integer Namespace for the extmarks
---@param priority integer Priority of the extmarks
---@return fun(): boolean poll
return function(query, root_node, bufnr, start_row, end_row, nsid, priority)
	local next_match = iter_matches(query, root_node, bufnr, start_row, end_row)
	local prev_level = 1
	local hlgroup = lib.hlgroup_at(1)

	local function poll()
		local level, match = next_match()
		if level == nil then
			return false
		end

		local delimiters = Set.new()
		for id, nodes in pairs(match) do
			if query.captures[id] == 'delimiter' then
				-- It is expected for a match to contain any number of delimiters
				for _, node in ipairs(nodes) do
					local s_row, _, e_row, _ = node:range()
					if e_row >= start_row and s_row < end_row then
						-- Only delimiters which intersect the view range need to be highlighted.
						delimiters:add(node)
					end
				end
			else
				-- This can only be container.
				-- We assume that there is only ever exactly one node per container capture.
				local s_row, _, e_row, _ = nodes[1]:range()
				if e_row < start_row or s_row >= end_row then
					-- Node range does not overlap with the view range
					return true
				end
			end
		end

		if level ~= prev_level then
			hlgroup = lib.hlgroup_at(level)
			prev_level = level
		end

		for delimiter in delimiters:items() do
			local s_row, s_col, e_row, e_col = delimiter:range()
			nvim_buf_set_extmark(bufnr, nsid, s_row, s_col, {
				end_row = e_row,
				end_col = e_col,
				priority = priority,
				hl_group = hlgroup,
				strict = false
			})
		end

		return true
	end
	return poll
end
