local say = require 'say'
local rpcrequest = vim.rpcrequest
local test_utils = require 'testing.utils'

local exec_lua = 'nvim_exec_lua'
local feedkeys = 'nvim_feedkeys'
local call_function = 'nvim_call_function'
local buf_set_lines = 'nvim_buf_set_lines'
local buf_set_option = 'nvim_buf_set_option'

local filter = vim.fn.filter

describe('The global strategy', function()
	local nvim

	local function request(method, ...)
		return rpcrequest(nvim, method, ...)
	end

	---Asserts that there are Rainbow Delimiters extmarks at the given position
	---@param arguments integer[]  Row and column, both zero-based
	local function has_extmarks_at(_state, arguments, lang)
		local row, column = arguments[1], arguments[2]
		local nsid = request(exec_lua, 'return require("rainbow-delimiters.lib").nsids[...]', {lang or 'lua'})
		local extmarks = request(exec_lua, 'return vim.inspect_pos(...).extmarks', {0, row, column})
		filter(extmarks, function(_, v) return v.ns_id == nsid end)
		return #extmarks > 0
	end

	say:set('assertion.extmarks_at.positive', 'Expected extmarks at (%s, %s)')
	say:set('assertion.extmarks_at.negative', 'Expected no extmarks at (%s, %s)')
	assert:register('assertion', 'extmarks_at', has_extmarks_at, 'assertion.extmarks_at.positive', 'assertion.extmarks_at.negative')

	before_each(function()
		nvim = test_utils.start_embedded()
		request(exec_lua, 'TSEnsure(...)', {'lua', 'vim'})
		request(exec_lua, [[
			local rb = require 'rainbow-delimiters'
			local track = require('rainbow-delimiters.strategy.track')
			local global = rb.strategy.global
			assert(nil ~= global)
			the_strategy = track(global)
			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = the_strategy
				}, query = {
				},
			}
		]], {})
	end)

	after_each(function()
		test_utils.stop_embedded(nvim)
	end)

	it('Does not reactivate when making changes', function()
		request(buf_set_lines, 0, 0, -1, true, {'print({{{{{}}}}})', '-- vim:ft=lua'})
		request(buf_set_option, 0, 'filetype', 'lua')
		assert.has_extmarks_at(0, 5)

		request(call_function, 'rainbow_delimiters#disable', {0})
		assert.Not.has_extmarks_at(0, 5)

		-- Add a new pair of curly braces
		-- (jump to first column, find the first closing brace, insert new pair)
		local keys = vim.api.nvim_replace_termcodes('gg0f}i{}<esc>', true, false, true)
		request(feedkeys, keys, 'n', false)
		assert.is.same({'print({{{{{{}}}}}})'}, request('nvim_buf_get_lines', 0, 0, 1, true))

		assert.Not.has_extmarks_at(0, 5)
		assert.is.equal(0, request(exec_lua, 'return the_strategy.attachments[1]', {}))
	end)

	it('Ignores blacklisted injected languages', function()
		request(exec_lua, 'vim.g.rainbow_delimiters.blacklist = {...}', {'vim'})
		request(buf_set_lines, 0, 0, -1, true, {
			'print {{{{{}}}}}',
			'vim.cmd [[',
			'	echo string(1 + (2 + (3 + 4)))',
			']]',
			'-- vim:ft=lua'
		})
		request(buf_set_option, 0, 'filetype', 'lua')

		-- The Lua code is highlighted, the Vim code not
		assert.has_extmarks_at(0, 6, 'lua')
		assert.Not.has_extmarks_at(2, 13, 'vim')
	end)

	it('Ignores non-whitelisted injected languages', function()
		request(exec_lua, 'vim.g.rainbow_delimiters.whitelist = {...}', {'lua'})
		request(buf_set_lines, 0, 0, -1, true, {
			'print {{{{{}}}}}',
			'vim.cmd [[',
			'	echo string(1 + (2 + (3 + 4)))',
			']]',
			'-- vim:ft=lua'
		})
		request(buf_set_option, 0, 'filetype', 'lua')

		-- The Lua code is highlighted, the Vim code not
		assert.has_extmarks_at(0, 6, 'lua')
		assert.Not.has_extmarks_at(2, 13, 'vim')
	end)

	it('Applies highlighting to nested code', function()
		-- See also https://github.com/HiPhish/rainbow-delimiters.nvim/pull/92
		local content = [[local function foo()
	return {
		a = print('a'),
	}
end

return foo]]

		request(exec_lua, 'vim.g.rainbow_delimiters.query.lua = "rainbow-blocks"', {})
		request(buf_set_lines, 0, 0, -1, true, vim.fn.split(content, '\n'))
		request(buf_set_option, 0, 'filetype', 'lua')
		-- Insert the line "		b = print('b'),"
		request('nvim_win_set_cursor', 0, {3, 0})
		local keys = vim.api.nvim_replace_termcodes("ob = print('b'),<esc>", true, false, true)
		vim.fn.rpcrequest(nvim,'nvim_feedkeys', keys, '', false)

		assert.has_extmarks_at(2, 11, 'lua')
		assert.has_extmarks_at(3, 11, 'lua')
	end)
end)
