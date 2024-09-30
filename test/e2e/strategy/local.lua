local yd = require 'yo-dawg'

describe('The local strategy', function()
	local nvim

	before_each(function()
		nvim = yd.start()
		nvim:exec_lua('TSEnsure(...)', {'lua', 'vim'})
		nvim:exec_lua([[
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
		yd.stop(nvim)
	end)

	it('Does not reactivate when making changes', function()
		nvim:buf_set_lines(0, 0, -1, true, {'print({{{{{}}}}})', '-- vim:ft=lua'})
		nvim:win_set_cursor(0, {1, 5})
		nvim:buf_set_option(0, 'filetype', 'lua')
		assert.nvim(nvim).has_extmarks_at(0, 5, 'lua')

		nvim:call_function('rainbow_delimiters#disable', {0})
		assert.nvim(nvim).Not.has_extmarks_at(0, 5, 'lua')

		-- Add a new pair of curly braces
		-- (jump to first column, find the first closing brace, insert new pair)
		local keys = vim.api.nvim_replace_termcodes('gg0f}i{}<esc>', true, false, true)
		nvim:feedkeys(keys, 'n', false)
		assert.nvim(nvim).has_content('print({{{{{{}}}}}})')

		assert.nvim(nvim).Not.has_extmarks_at(0, 5, 'lua')
		assert.is.equal(0, nvim:exec_lua('return the_strategy.attachments[1]', {}))
	end)
end)
