local is_test, keys = pcall(require, 'busted-keys')
if not is_test then return end
local assert = require 'luassert'
local say = require 'say'


---Asserts that there are Rainbow Delimiters extmarks at the given position.
---
---Arguments:
---  1) hl_group   Optional, expected highlight group of the extmark
---
---@param args integer[]  Row and column, both zero-based
---@return boolean
local function has_extmarks(state, args)
	local nvim = rawget(state, keys.channel)
	local lang = rawget(state, keys.language)
	local buffer = rawget(state, keys.buffer) or 0
	local row, column = unpack(rawget(state, keys.position))
	local hl_group = args[1]

	assert(nvim ~= nil, 'No Neovim channel set, use the `remote` modifier')
	assert(lang ~= nil, 'No language set, use the `for_language` modifier')

	if not row or not column then
		local cursor = nvim:win_get_cursor(0)
		row = row or cursor[1] - 1
		column = column or cursor[2]
	end

	local nsid = nvim:exec_lua('return require("rainbow-delimiters.lib").nsids[...]', {lang})

	local extmarks = nvim:exec_lua('return vim.inspect_pos(...).extmarks', {buffer, row, column})
	extmarks = vim.tbl_filter(function(v) return v.ns_id == nsid end, extmarks)
	if hl_group then
		local function same_hl_group(extmark) return extmark.opts.hl_group == hl_group end
		extmarks = vim.tbl_filter(same_hl_group, extmarks)
	end

	return #extmarks > 0
end


say:set('assertion.extmarks.positive', 'Expected extmarks of highlight group %s')
say:set('assertion.extmarks.negative', 'Expected no extmarks of highlight group %s')


assert:register(
	'assertion', 'has_extmarks', has_extmarks,
	'assertion.has_extmarks.positive', 'assertion.has_extmarks.negative')
