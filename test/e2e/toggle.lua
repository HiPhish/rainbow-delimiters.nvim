local rpcrequest = vim.rpcrequest
local test_utils = require 'testing.utils'

local call_function = 'nvim_call_function'
local exec_lua = 'nvim_exec_lua'
local buf_set_lines = 'nvim_buf_set_lines'
local buf_set_option = 'nvim_buf_set_option'

describe('We can use functions to turn rainbow delimiters off and on again.', function()
	local nvim

	local function request(method, ...)
		return rpcrequest(nvim, method, ...)
	end

	before_each(function()
		nvim = test_utils.start_embedded()
		request(exec_lua, 'the_strategy = require("rainbow-delimiters.strategy.global")', {})
		request(exec_lua, 'TSEnsure(...)', {'lua'})
		request(buf_set_lines, 0, 0, -1, true, {'print((((("Hello, world!")))))'})
		request(buf_set_option, 0, 'filetype', 'lua')
	end)

	after_each(function()
		test_utils.stop_embedded(nvim)
	end)

	it('Does highlighting initially', function()
		assert.nvim(nvim).has_extmarks_at(0, 5, 'lua')
	end)

	it('Disables rainbow delimiters', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		assert.nvim(nvim).Not.has_extmarks_at(0, 5, 'lua')
	end)

	it('Remains disabled when disabling twice', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#disable', {0})

		assert.nvim(nvim).Not.has_extmarks_at(0, 5, 'lua')
	end)

	it('Turns rainbow delimiters back on', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})

		assert.nvim(nvim).has_extmarks_at(0, 5, 'lua')
	end)

	it('Remains enabled when enabling twice', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})

		assert.nvim(nvim).has_extmarks_at(0, 5, 'lua')
	end)

	it('Can be disabled after being enabled', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})
		request(call_function, 'rainbow_delimiters#disable', {0})

		assert.nvim(nvim).Not.has_extmarks_at(0, 5, 'lua')
	end)

	it('Can be enabled after being disabled twice', function()
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#disable', {0})
		request(call_function, 'rainbow_delimiters#enable', {0})

		assert.nvim(nvim).has_extmarks_at(0, 5, 'lua')
	end)
end)
