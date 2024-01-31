local yd = require 'yo-dawg'

describe('The global strategy', function()
	local nvim

	before_each(function()
		nvim = yd.start()
		nvim:exec_lua('TSEnsure(...)', {'lua', 'vim'})
		nvim:exec_lua([[
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
		yd.stop(nvim)
	end)

	it('Does not reactivate when making changes', function()
		nvim:buf_set_lines(0, 0, -1, true, {'print({{{{{}}}}})', '-- vim:ft=lua'})
		nvim:buf_set_option(0, 'filetype', 'lua')
		assert.nvim(nvim).has_extmarks_at(0, 5, 'lua')

		nvim:call_function('rainbow_delimiters#disable', {0})
		assert.nvim(nvim).Not.has_extmarks_at(0, 5, 'lua')

		-- Add a new pair of curly braces
		-- (jump to first column, find the first closing brace, insert new pair)
		local keys = vim.api.nvim_replace_termcodes('gg0f}i{}<esc>', true, false, true)
		nvim:feedkeys(keys, 'n', false)
		assert.is.same({'print({{{{{{}}}}}})'}, nvim:buf_get_lines(0, 0, 1, true))

		assert.nvim(nvim).Not.has_extmarks_at(0, 5, 'lua')
		assert.is.equal(0, nvim:exec_lua('return the_strategy.attachments[1]', {}))
	end)

	it('Ignores blacklisted injected languages', function()
		nvim:exec_lua('vim.g.rainbow_delimiters.blacklist = {...}', {'vim'})
		nvim:buf_set_lines(0, 0, -1, true, {
			'print {{{{{}}}}}',
			'vim.cmd [[',
			'	echo string(1 + (2 + (3 + 4)))',
			']]',
			'-- vim:ft=lua'
		})
		nvim:buf_set_option(0, 'filetype', 'lua')

		-- The Lua code is highlighted, the Vim code not
		assert.nvim(nvim).has_extmarks_at(0, 6, 'lua')
		assert.nvim(nvim).Not.has_extmarks_at(2, 13, 'vim')
	end)

	it('Ignores non-whitelisted injected languages', function()
		nvim:exec_lua('vim.g.rainbow_delimiters.whitelist = {...}', {'lua'})
		nvim:buf_set_lines(0, 0, -1, true, {
			'print {{{{{}}}}}',
			'vim.cmd [[',
			'	echo string(1 + (2 + (3 + 4)))',
			']]',
			'-- vim:ft=lua'
		})
		nvim:buf_set_option(0, 'filetype', 'lua')

		-- The Lua code is highlighted, the Vim code not
		assert.nvim(nvim).has_extmarks_at(0, 6, 'lua')
		assert.nvim(nvim).Not.has_extmarks_at(2, 13, 'vim')
	end)

	it('Applies highlighting to nested code', function()
		-- See also https://github.com/HiPhish/rainbow-delimiters.nvim/pull/92
		local content = [[local function foo()
	return {
		a = print('a'),
	}
end

return foo]]

		nvim:exec_lua('vim.g.rainbow_delimiters.query.lua = "rainbow-blocks"', {})
		nvim:buf_set_lines(0, 0, -1, true, vim.fn.split(content, '\n'))
		nvim:buf_set_option(0, 'filetype', 'lua')
		-- Insert the line "		b = print('b'),"
		nvim:win_set_cursor(0, {3, 0})
		local keys = vim.api.nvim_replace_termcodes("ob = print('b'),<esc>", true, false, true)
		nvim:feedkeys(keys, '', false)

		assert.nvim(nvim).has_extmarks_at(2, 11, 'lua')
		assert.nvim(nvim).has_extmarks_at(3, 11, 'lua')
	end)
end)
