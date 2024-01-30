local say = require 'say'
local rpcrequest = vim.rpcrequest
local test_utils = require 'testing.utils'

local exec_lua = 'nvim_exec_lua'
local filter = vim.fn.filter

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
		request(exec_lua, 'TSEnsure(...)', {'lua', 'vim', 'markdown'})
		request(exec_lua, [[
			local rb = require 'rainbow-delimiters'
			local global = rb.strategy.global
			assert(nil ~= global)
			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = global
				},
			}
		]], {})
	end)

	after_each(function()
		test_utils.stop_embedded(nvim)
	end)

	it('Clears extmarks when moving line out of injected langauge', function()
		request('nvim_exec_lua', 'TSEnsure(...)', {'lua', 'markdown'})
		request('nvim_buf_set_lines', 0, 0, -2, true, vim.fn.split(markdown_with_injected_lua, '\n'))
		request('nvim_buf_set_option', 0, 'filetype', 'markdown')
		assert.has_extmarks_at(3, 5, 'lua')

		-- Move Lua line out of code block
		request('nvim_cmd', {cmd = 'move', range = {4}, args = {5}}, {})

		local given = vim.fn.join(request('nvim_buf_get_lines', 0, 0, -2, true), '\n')
		assert.is.equal(markdown_without_injected_lua, given)

		-- Skip this test for now; calling `move` via RPC does not trigger the
		-- `on_tree_changed` callback on the parser and the extmarks will
		-- remain uncleared
		if true then return end
		assert.Not.has_extmarks_at(4, 5, 'lua')
	end)

	it('Adds extmarks when moving line into injected langauge', function()
		request('nvim_exec_lua', 'TSEnsure(...)', {'lua', 'markdown'})
		request('nvim_buf_set_lines', 0, 0, -2, true, vim.fn.split(markdown_without_injected_lua, '\n'))
		request('nvim_buf_set_option', 0, 'filetype', 'markdown')
		assert.Not.has_extmarks_at(4, 5, 'lua')

		-- Move Lua line out of code block
		request('nvim_cmd', {cmd = 'move', range = {5}, args = {3}}, {})

		local given = vim.fn.join(request('nvim_buf_get_lines', 0, 0, -2, true), '\n')
		assert.is.equal(markdown_with_injected_lua, given)

		-- Skip this test for now; calling `move` via RPC does not trigger the
		-- `on_tree_changed` callback on the parser and the extmarks will
		-- remain uncleared
		if true then return end
		assert.has_extmarks_at(3, 5, 'lua')
	end)
end)
