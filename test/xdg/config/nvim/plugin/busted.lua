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
local BUFFER_STATE_KEY = {}
local LANGUAGE_STATE_KEY = {}

local function nvim_client(state, args, _level)
	assert(args.n > 0, 'No Neovim channel provided to the modifier')
	assert(rawget(state, NVIM_STATE_KEY) == nil, 'Neovim already set')
	rawset(state, NVIM_STATE_KEY, args[1])
	return state
end

local function nvim_buffer(state, args, _level)
	assert(args.n == 1, 'Must provide exactly one buffer')
	assert(rawget(state, NVIM_STATE_KEY) ~= nil, 'No Neovim client set')
	assert(rawget(state, BUFFER_STATE_KEY) == nil, 'Buffer already set')
	rawset(state, BUFFER_STATE_KEY, args[1])
end

local function nvim_language(state, args, _level)
	assert(args.n == 1, 'Must provide exactly one language')
	assert(rawget(state, NVIM_STATE_KEY) ~= nil, 'No Neovim client set')
	assert(rawget(state, LANGUAGE_STATE_KEY) == nil, 'Language already set')
	rawset(state, LANGUAGE_STATE_KEY, args[1])
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

local function has_buffer_content(state, arguments)
	local nvim = rawget(state, NVIM_STATE_KEY)
	local buffer = rawget(state, BUFFER_STATE_KEY) or 0

	assert(nvim ~= nil, 'No Neovim channel set, use the `nvim` modifier to set the channel')
	assert(arguments.n == 1, 'Provide the expected buffer contents as a string')

	local expected = arguments[1]
	local given = vim.fn.join(nvim:buf_get_lines(buffer, 0, -2, true), '\n')

	return expected == given
end

local function has_strategy(state, arguments)
	local nvim = rawget(state, NVIM_STATE_KEY)
	local language = rawget(state, LANGUAGE_STATE_KEY)
	local module = arguments[1]

	assert(language ~= nil, 'No language set')
	assert(module, 'Provide the expected strategy module as a string')

	return nvim:exec_lua(
		string.format([[
			return vim.deep_equal(
				require('rainbow-delimiters.config').strategy["%s"],
				require('%s')
			)
		]], language, module),
		{}
	)
end

---Whether rainbow delimiters is enabled for the given buffer
local function has_rainbow(state, _arguments)
	local nvim = rawget(state, NVIM_STATE_KEY)
	local bufnr = rawget(state, BUFFER_STATE_KEY)
	assert(nvim ~= nil, 'No Neovim channel set, use the `nvim` modifier to set the channel')
	return nvim:exec_lua('return require("rainbow-delimiters").is_enabled(...)', {bufnr})
end

say:set('assertion.extmarks_at.positive', 'Expected extmarks at (%s, %s)')
say:set('assertion.extmarks_at.negative', 'Expected no extmarks at (%s, %s)')

say:set('assertion.has_content.positive', 'Expected buffer content %s')
say:set('assertion.has_content.negative', 'Expected different buffer content than %s')

say:set('assertion.has_strategy.positive', 'Expected strategy %s')
say:set('assertion.has_strategy.negative', 'Expected different strategy than %s')

say:set('assertion.has_rainbow.positive', 'Expected rainbow delimiters to be enabled')
say:set('assertion.has_rainbow.negative', 'Expected rainbow delimiters to be disabled')

assert:register(
	'assertion', 'has_extmarks_at', has_extmarks_at,
	'assertion.has_extmarks_at.positive', 'assertion.has_extmarks_at.negative')
assert:register(
	'assertion', 'has_content', has_buffer_content,
	'assertion.has_content.positive', 'assertion.has_content.negative')
assert:register(
	'assertion', 'has_strategy', has_strategy,
	'assertion.has_strategy.positive', 'assertion.has_strategy.negative')
assert:register(
	'assertion', 'has_rainbow', has_rainbow,
	'assertion.has_rainbow.positive', 'assertion.has_rainbow.negative')

assert:register('modifier', 'nvim', nvim_client)
assert:register('modifier', 'buffer', nvim_buffer)
assert:register('modifier', 'language', nvim_language)
