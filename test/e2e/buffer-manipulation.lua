local yd = require 'yo-dawg'

---Markdown document with Lua code inside a code block
local markdown_with_injected_lua = [[This is some Markdown

```lua
print(((('Hello world'))))
```

This is more markdown.]]

---Markdown document with Lua code outside a code block
local markdown_without_injected_lua = [[This is some Markdown

```lua
```
print(((('Hello world'))))

This is more markdown.]]


describe('Buffer Manipulation', function()
	local nvim

	before_each(function()
		nvim = yd.start()
		nvim:exec_lua('EnsureTSParser(...)', {{'lua', 'vim', 'markdown'}})
		nvim:set_var('rainbow_delimiters', {
			strategy = {
				[''] = 'rainbow-delimiters.strategy.global'
			}
		})
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	it('Clears extmarks when moving line out of injected language', function()
		nvim:buf_set_lines(0, 0, -2, true, vim.fn.split(markdown_with_injected_lua, '\n'))
		nvim:buf_set_option(0, 'filetype', 'markdown')
		nvim:exec_lua('vim.treesitter.start()', {})
		assert.remote(nvim).for_language('lua').at_position(3, 5).has_extmarks()

		-- Move Lua line out of code block
		nvim:cmd({cmd = 'move', range = {4}, args = {5}}, {})
		assert.remote(nvim).has_content(markdown_without_injected_lua)

		assert.remote(nvim).for_language('lua').at_position(4, 5).Not.has_extmarks()
	end)

	it('Adds extmarks when moving line into injected langauge', function()
		nvim:buf_set_lines(0, 0, -2, true, vim.fn.split(markdown_without_injected_lua, '\n'))
		nvim:buf_set_option(0, 'filetype', 'markdown')
		nvim:exec_lua('vim.treesitter.start()', {})
		assert.remote(nvim).for_language('lua').at_position(4, 5).Not.has_extmarks()

		-- Move Lua line out of code block
		nvim:cmd({cmd = 'move', range = {5}, args = {3}}, {})
		assert.remote(nvim).has_content(markdown_with_injected_lua)

		assert.remote(nvim).for_language('lua').at_position(3, 5).has_extmarks()
	end)

	it('Preserves extmarks upon multi-line substitution', function()
		-- See also https://github.com/neovim/neovim/issues/31067
		pending('Bug reported: https://github.com/neovim/neovim/issues/31067')
		nvim:buf_set_lines(0, 0, -2, true, {'print {', '\t{', '\t},', '\t{', '\t},', '}'})
		nvim:buf_set_option(0, 'filetype', 'lua')
		nvim:exec_lua('vim.treesitter.start()', {})
		assert.remote(nvim).for_language('lua').at_position(1, 1).has_extmarks('RainbowDelimiterYellow')
		assert.remote(nvim).for_language('lua').at_position(3, 1).has_extmarks('RainbowDelimiterYellow')

		nvim:command [[%s/\v\{\n\s+/{]]  -- Remove line break after opening brace
		assert.remote(nvim).has_content
[[print {{},
	{},
}]]

		assert.remote(nvim).for_language('lua').at_position(0, 7).has_extmarks('RainbowDelimiterYellow')
		assert.remote(nvim).for_language('lua').at_position(3, 1).has_extmarks('RainbowDelimiterYellow')
	end)

	describe('Pasting lines containing delimiters', function()
		local content = [[print {
	{a = 1, b = 2},
}]]
		before_each(function()
			nvim:buf_set_lines(0, 0, -2, true, vim.fn.split(content, '\n'))
			nvim:buf_set_option(0, 'filetype', 'lua')
			nvim:exec_lua('vim.treesitter.start()', {})
			assert.remote(nvim).for_language('lua').at_position(1,  1).has_extmarks('RainbowDelimiterYellow')
			assert.remote(nvim).for_language('lua').at_position(1, 14).has_extmarks('RainbowDelimiterYellow')
		end)

		it('Properly highlights after inserting one line', function()
			nvim:feedkeys('ggjyyp', 'n', false)

			assert.remote(nvim).for_language('lua').at_position(1,  1).has_extmarks('RainbowDelimiterYellow')
			assert.remote(nvim).for_language('lua').at_position(1, 14).has_extmarks('RainbowDelimiterYellow')
		end)

		it('Properly highlights after inserting two lines', function()
			nvim:feedkeys('ggjyy2p', 'n', false)

			assert.remote(nvim).for_language('lua').at_position(1,  1).has_extmarks('RainbowDelimiterYellow')
			assert.remote(nvim).for_language('lua').at_position(1, 14).has_extmarks('RainbowDelimiterYellow')
		end)
	end)
end)
