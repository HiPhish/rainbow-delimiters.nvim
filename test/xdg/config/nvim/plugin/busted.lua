-- Custom configuration for Busted

local say = require 'say'
local assert = require 'luassert'
local filter = vim.fn.filter
local rpcrequest = vim.rpcrequest


local NVIM_STATE_KEY = {}

local function nvim(state, args, level)
	assert(args.n > 0, "No Neovim channel provided to the modifier")
	assert(rawget(state, NVIM_STATE_KEY) == nil, "Neovim already set")
	rawset(state, NVIM_STATE_KEY, args[1])
	return state
end

---Asserts that there are Rainbow Delimiters extmarks at the given position
---@param arguments integer[]  Row and column, both zero-based
local function has_extmarks_at(_state, arguments, lang)
	local nvim = rawget(_state, NVIM_STATE_KEY)
	assert(nvim ~= nil, 'No Neovim channel set, use the nvim modifier to set the channel')
	local row, column = arguments[1], arguments[2]
	local nsid = rpcrequest(nvim, 'nvim_exec_lua', 'return require("rainbow-delimiters.lib").nsids[...]', {lang})
	local extmarks = rpcrequest(nvim, 'nvim_exec_lua', 'return vim.inspect_pos(...).extmarks', {0, row, column})
	filter(extmarks, function(_, v) return v.ns_id == nsid end)
	return #extmarks > 0
end

say:set('assertion.extmarks_at.positive', 'Expected extmarks at (%s, %s)')
say:set('assertion.extmarks_at.negative', 'Expected no extmarks at (%s, %s)')

assert:register(
	'assertion', 'has_extmarks_at', has_extmarks_at,
	'assertion.has_extmarks_at.positive', 'assertion.has_extmarks_at.negative')
assert:register('modifier', 'nvim', nvim)
