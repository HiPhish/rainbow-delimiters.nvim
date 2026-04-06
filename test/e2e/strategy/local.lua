local yd = require 'yo-dawg'

describe('The local strategy', function()
	local nvim

	before_each(function()
		nvim = yd.start()
		nvim:set_var('rainbow_delimiters', {
			strategy = {
				[''] = 'rainbow-delimiters.strategy.local',
			}
		})
		nvim:exec_lua('EnsureTSParser(...)', {{'lua', 'vim'}})
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	describe('with a Lua buffer', function()
		before_each(function ()
			nvim:buf_set_lines(0, 0, -1, true, {'print({{{{{}}}}})', '-- vim:ft=lua'})
			nvim:win_set_cursor(0, {1, 5})
			nvim:set_option_value('filetype', 'lua', {buf = 0})
		end)

		it('does not raise any errors', function()
			-- Some arbitrary action to give the remote time to process an error
			nvim:feedkeys('<CR>', 'n', true)
			assert.are_equal('', nvim:get_vvar('errmsg'))
		end)

		it('does not reactivate when making changes', function()
			assert.remote(nvim).for_language('lua').at_position(0, 5).has_extmarks()

			nvim:call_function('rainbow_delimiters#disable', {0})
			assert.remote(nvim).for_language('lua').at_position(0, 5).Not.has_extmarks()

			-- Add a new pair of curly braces
			-- (jump to first column, find the first closing brace, insert new pair)
			local keys = vim.api.nvim_replace_termcodes('gg0f}i{}<esc>', true, false, true)
			nvim:feedkeys(keys, 'n', false)
			assert.remote(nvim).has_content('print({{{{{{}}}}}})')

			assert.remote(nvim).for_language('lua').at_position(0, 5).Not.has_extmarks()
			assert.remote(nvim).Not.has_rainbow()
		end)
	end)
end)
