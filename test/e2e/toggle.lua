local say = require 'say'
local rpcrequest = vim.fn.rpcrequest

local filter = vim.fn.filter

local jobopts = {
	rpc = true,
	width = 80,
	height = 24,
}

local call_function = 'nvim_call_function'
local exec_lua = 'nvim_exec_lua'
local buf_set_lines = 'nvim_buf_set_lines'
local buf_set_option = 'nvim_buf_set_option'

describe('We can use functions to turn rainbow delimiters off and on again.', function()
	local nvim

	local function request(method, ...)
		return rpcrequest(nvim, method, ...)
	end

	---Asserts that there are Rainbow Delimiters extmarks at the given position
	---@param arguments integer[]  Row and column, both zero-based
	local function has_extmarks_at(_state, arguments)
		local row, column = arguments[1], arguments[2]
		local nsid = request(exec_lua, 'return require("rainbow-delimiters.lib").nsids.lua', {})
		local extmarks = request(exec_lua, 'return vim.inspect_pos(...).extmarks', {0, row, column})
		filter(extmarks, function(_, v) return v.ns_id == nsid end)
		return #extmarks > 0
	end

	say:set('assertion.extmarks_at.positive', 'Expected extmarks at (%s, %s)')
	say:set('assertion.extmarks_at.negative', 'Expected no extmarks at (%s, %s)')
	assert:register('assertion', 'extmarks_at', has_extmarks_at, 'assertion.extmarks_at.positive', 'assertion.extmarks_at.negative')

	before_each(function()
		-- Start the remote Neovim process.  The `--embed` flag lets us control
		-- Neovim through RPC, the `--headless` flag tells it not to wait for a
		-- UI to attach and start loading plugins and configuration immediately
		nvim = vim.fn.jobstart({'nvim', '--embed', '--headless'}, jobopts)
		request(exec_lua, 'the_strategy = require("rainbow-delimiters.strategy.global")', {})
		request(exec_lua, 'TSEnsure(...)', {'lua'})
		request(buf_set_lines, 0, 0, -1, true, {'print((((("Hello, world!")))))'})
		request(buf_set_option, 0, 'filetype', 'lua')
	end)

	after_each(function()
		vim.fn.jobstop(nvim)
	end)

	it('Does highlighting initially', function()
		assert.has_extmarks_at(0, 5)
	end)

	it('Disables rainbow delimiters', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		assert.Not.has_extmarks_at(0, 5)
	end)

	it('Remains disabled when disabling twice', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#disable', {0})

		assert.Not.has_extmarks_at(0, 5)
	end)

	it('Turns rainbow delimiters back on', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})

		assert.has_extmarks_at(0, 5)
	end)

	it('Remains enabled when enabling twice', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})

		assert.has_extmarks_at(0, 5)
	end)

	it('Can be disabled after being enabled', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})
		request(call_function, 'rainbow_delimiters#disable', {0})

		assert.Not.has_extmarks_at(0, 5)
	end)

	it('Can be enabled after being disabled twice', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})

		assert.has_extmarks_at(0, 5)
	end)
end)
