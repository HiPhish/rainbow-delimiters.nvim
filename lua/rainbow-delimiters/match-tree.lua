-- SPDX-License-Identifier: Apache-2.0

---Functions for dealing with match trees.  This library is only relevant to
---strategy authors.  A match tree is the tree-like structure we use to
---organize a subset of the buffer's node tree for highlighting.
local M = {}

local lib = require 'rainbow-delimiters.lib'
local Set = require 'rainbow-delimiters.set'

---A single match from the query.  All matches contain the same fields, which
---correspond to the captures from the query.  Matches are hierarchical and can
---be arranged in a tree where the container of a parent match contains all the
---nodes of the descendant matches.
---@class rainbow_delimiters.Match
---The container node.
---@field container vim.treesitter.TSNode
---Sentinel node, marks the last delimiter of the match.
---@field sentinel vim.treesitter.TSNode
---The actual delimiters we want to highlight, there can be any number of them.
---@field delimiters rainbow_delimiters.Set

---A hierarchical structure of nested matches.  Each node of the tree consists
---of exactly one match and a set of any number of child matches.  Terminal
---matches have no children.
---
---Match trees have a strict partial ordering: for two matches `m1` and `m2` we
---say that `m1` < `m2` if and only if the container of `m1` contains the
---container of `m2`, i.e. `m1` is an ancestor of `m2`.  The root node will
---have the lowest value.
---@class rainbow_delimiters.MatchTree
---The match object
---@field public match rainbow_delimiters.Match
---The children of the match
---@field public children rainbow_delimiters.Set

local match_mt = {
	__tostring = function(self)
		return string.format(
			'{container = %s, delimiters = %s}',
			tostring(self.container),
			tostring(self.delimiters)
		)
	end
}

local tree_mt = {
	---@param m1 rainbow_delimiters.MatchTree
	---@param m2 rainbow_delimiters.MatchTree
	---@return boolean
	__lt = function(m1, m2)
		local c1 = m1.match.container
		local r2 = {m2.match.container:range()}
		return vim.treesitter.node_contains(c1, r2)
	end,
	---Appends the given match tree `m2` to this match tree.  Will traverse
	---through the descendants until it finds the most appropriate one.
	---@return boolean success  Whether appending was successfull
	__call = function(self, other)
		if not (self < other) then return false end
		for child in self.children:items() do
			if child < other then
				return child(other)
			end
		end
		self.children:add(other)
		return true
	end,
	__tostring = function(self)
		return string.format(
			'{match = %s, children = %s}',
			tostring(self.match),
			tostring(self.children)
		)
	end
}

---Instantiate a new match tree node without children based on the results of
---the `iter_matches` method of a query.
---@param query vim.treesitter.Query
---@param match Table<integer, vim.treesitter.TSNode[]>
---@return rainbow_delimiters.MatchTree
function M.assemble(query, match)
	local result = {delimiters = Set.new()}
	for id, nodes in pairs(match) do
		local capture = query.captures[id]
		if capture == 'delimiter' then
			-- It is expected for a match to contain any number of delimiters
			for _, node in ipairs(nodes) do
				result.delimiters:add(node)
			end
		else
			-- We assume that there is only ever exactly one node per
			-- non-delimiter capture
			result[capture] = nodes[1]
		end
	end

	---@type rainbow_delimiters.MatchTree
	local matchtree = {
		match = setmetatable(result, match_mt),
		children = Set.new(),
	}
	return setmetatable(matchtree, tree_mt)
end

---Apply highlighting to a given match tree at a given level
---@param bufnr integer
---@param lang  string
---@param tree  rainbow_delimiters.MatchTree
---@param level integer  Highlight level of this tree
---@param pred  (fun(rainbow_delimiters): boolean)?  Predicate function, will abort highlighting if it evaluates to `false` at any point down the tree for that branch only.
function M.highlight(tree, bufnr, lang, level, pred)
	if pred and not pred(tree) then return end
	local hlgroup = lib.hlgroup_at(level)
	for delimiter in tree.match.delimiters:items() do
		lib.highlight(bufnr, lang, delimiter, hlgroup)
	end
	for child in tree.children:items() do
		M.highlight(child, bufnr, lang, level + 1, pred)
	end
end

return M
