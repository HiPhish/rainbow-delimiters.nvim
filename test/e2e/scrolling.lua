local yd = require 'yo-dawg'


describe('Scrolling a buffer in a window', function()
	local nvim

	before_each(function ()
		-- Intentionally a small window so we don't have to scroll much
		nvim = yd.start {
			width = 40,
			height = 30,
		}
		nvim:set_var('rainbow_delimiters', {
			strategy = {
				[''] = 'rainbow-delimiters.strategy.global'
			}
		})
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	describe('with a language that has macros', function()
		before_each(function ()
			nvim:exec_lua('EnsureTSParser(...)', {'c'})
		end)

		it('preserves highlighting in C', function()
			local text = [[
#define U 10
int main() {
	int u=U;
	// blanks
]] .. string.rep('\n', 40) .. [[
	return 0;
}
]]
			nvim:set_option_value('filetype', 'c', {scope='local'})
			nvim:exec_lua('vim.treesitter.start()', {})
			nvim:buf_set_lines(0, -2, -1, true, vim.fn.split(text, '\n'))
			assert.remote(nvim).for_language('c').at_position(1, 8).has_extmarks()
			-- Scroll down and back up
			nvim:feedkeys('G', 'nt', false)
			nvim:feedkeys('gg', 'nt', false)
			assert.remote(nvim).for_language('c').at_position(1, 8).has_extmarks()
		end)
	end)
end)
