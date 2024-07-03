-- Custom configuration for Busted

-- If busted is not available this configuration is not running as part of a
-- test, so there is nothing to do.
local success, say = pcall(require, 'say')
if not success then
	return
end
local assert = require 'luassert'


---Globally unique key to retrieve the current Neovim channel from the test
---state.
local NVIM_STATE_KEY = {}

local function nvim_client(state, args, _level)
	assert(args.n > 0, "No Neovim channel provided to the modifier")
	assert(rawget(state, NVIM_STATE_KEY) == nil, "Neovim already set")
	rawset(state, NVIM_STATE_KEY, args[1])
	return state
end

---Asserts that there are Rainbow Delimiters extmarks at the given position.
---
---Arguments:
---
---  1) row        Zero-indexed row of the character position
---  2) column     Zero-indexed column of the character position
---  3) lang       Expected language of the extmark
---  4) hl_group   Optional, expected highlight group of the extmark
---
---@param arguments integer[]  Row and column, both zero-based
---@return boolean
local function has_extmarks_at(_state, arguments)
	local nvim = rawget(_state, NVIM_STATE_KEY)
	assert(nvim ~= nil, 'No Neovim channel set, use the nvim modifier to set the channel')
	local row, column, lang, hl_group = arguments[1], arguments[2], arguments[3], arguments[4]
	local nsid = nvim:exec_lua('return require("rainbow-delimiters.lib").nsids[...]', {lang})

	local extmarks = nvim:exec_lua('return vim.inspect_pos(...).extmarks', {0, row, column})
	extmarks = vim.tbl_filter(function(v) return v.ns_id == nsid end, extmarks)
	if hl_group then
		local function same_hl_group(extmark) return extmark.opts.hl_group == hl_group end
		extmarks = vim.tbl_filter(same_hl_group, extmarks)
	end

	return #extmarks > 0
end

say:set('assertion.extmarks_at.positive', 'Expected extmarks at (%s, %s)')
say:set('assertion.extmarks_at.negative', 'Expected no extmarks at (%s, %s)')

assert:register(
	'assertion', 'has_extmarks_at', has_extmarks_at,
	'assertion.has_extmarks_at.positive', 'assertion.has_extmarks_at.negative')
assert:register('modifier', 'nvim', nvim_client)
