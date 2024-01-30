local rpcrequest = vim.rpcrequest
local test_utils = require 'testing.utils'

local exec_lua = 'nvim_exec_lua'
local feedkeys = 'nvim_feedkeys'
local call_function = 'nvim_call_function'
local buf_set_lines = 'nvim_buf_set_lines'
local buf_set_option = 'nvim_buf_set_option'

describe('The local strategy', function()
	local nvim

	local function request(method, ...)
		return rpcrequest(nvim, method, ...)
	end

	before_each(function()
		nvim = test_utils.start_embedded()
		request(exec_lua, 'TSEnsure(...)', {'lua', 'vim'})
		request(exec_lua, [[
			local rb = require 'rainbow-delimiters'
			local track = require('rainbow-delimiters.strategy.track')
			local strategy = rb.strategy['local']
			assert(nil ~= strategy)
			the_strategy = track(strategy)
			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = the_strategy
				}
			}
		]], {})
	end)

	after_each(function()
		test_utils.stop_embedded(nvim)
	end)

	it('Does not reactivate when making changes', function()
		request(buf_set_lines, 0, 0, -1, true, {'print({{{{{}}}}})', '-- vim:ft=lua'})
		request('nvim_win_set_cursor', 0, {1, 5})
		request(buf_set_option, 0, 'filetype', 'lua')
		assert.nvim(nvim).has_extmarks_at(0, 5, 'lua')

		request(call_function, 'rainbow_delimiters#disable', {0})
		assert.nvim(nvim).Not.has_extmarks_at(0, 5, 'lua')

		-- Add a new pair of curly braces
		-- (jump to first column, find the first closing brace, insert new pair)
		local keys = vim.api.nvim_replace_termcodes('gg0f}i{}<esc>', true, false, true)
		request(feedkeys, keys, 'n', false)
		assert.is.same({'print({{{{{{}}}}}})'}, request('nvim_buf_get_lines', 0, 0, 1, true))

		assert.nvim(nvim).Not.has_extmarks_at(0, 5, 'lua')
		assert.is.equal(0, request(exec_lua, 'return the_strategy.attachments[1]', {}))
	end)
end)

