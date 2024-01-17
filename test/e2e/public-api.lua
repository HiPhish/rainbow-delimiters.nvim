local rpcrequest = vim.fn.rpcrequest

local jobopts = {
	rpc = true,
	width = 80,
	height = 24,
}

local exec_lua = 'nvim_exec_lua'
local buf_set_lines = 'nvim_buf_set_lines'
local buf_set_option = 'nvim_buf_set_option'
local command = 'nvim_command'


describe('The Rainbow Delimiters public API', function()
	local nvim

	local function request(method, ...)
		return rpcrequest(nvim, method, ...)
	end

	before_each(function()
		-- Start the remote Neovim process.  The `--embed` flag lets us control
		-- Neovim through RPC, the `--headless` flag tells it not to wait for a
		-- UI to attach and start loading plugins and configuration immediately
		nvim = vim.fn.jobstart({'nvim', '--embed', '--headless'}, jobopts)

		-- Set up a tracking strategy
		request(exec_lua, [[
			TSEnsure('markdown', 'lua', 'vim')
			rb = require 'rainbow-delimiters'
    		vim.g.rainbow_delimiters = {
    			strategy = {
    				[''] = rb.strategy.global,
    			},
    		}]], {})
	end)

	after_each(function()
		vim.fn.jobstop(nvim)
	end)

	describe('Whether RB is enabled for a buffer at startup', function()
		it('Is disabled for a buffer without file type', function()
			assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
		end)

		it('Is enabled for a supported language', function()
			request(buf_set_option, 0, 'filetype', 'lua')
			assert.is.True(request(exec_lua, 'return rb.is_enabled()', {}))
		end)

		describe('Blacklist', function()
			before_each(function()
				request(command, 'let g:rainbow_delimiters.blacklist = ["markdown"]')
			end)

			it('Is enabled for a not blacklisted language', function()
				request(buf_set_option, 0, 'filetype', 'lua')
				assert.is.True(request(exec_lua, 'return rb.is_enabled()', {}))
			end)

			it('Is disabled for a blacklisted language', function()
				request(buf_set_option, 0, 'filetype', 'markdown')
				assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
			end)

			it('Is disabled for a blacklisted language with injected whitelisted language', function()
				request(buf_set_lines, 0, 0, -1, true, {
					'This is Markdown',
					'',
					'```lua',
					'print(((("This is Lua"))))',
					'```',
					'',
					'More Markdown',
				})
				request(buf_set_option, 0, 'filetype', 'markdown')
				assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
			end)
		end)

		describe('Whitelist', function()
			before_each(function()
				request(command, 'let g:rainbow_delimiters.whitelist = ["lua"]')
			end)

			it('Is disabled for a not whitelisted language', function()
				request(buf_set_option, 0, 'filetype', 'markdown')
				assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
			end)

			it('Is enabled for a whitelisted language', function()
				request(buf_set_option, 0, 'filetype', 'lua')
				assert.is.True(request(exec_lua, 'return rb.is_enabled()', {}))
			end)

			it('Is enabled for whitelisted language with other language injected', function()
				request(buf_set_lines, 0, 0, -1, true, {
					'print "This is Lua"',
					'vim.cmd [[echo "This is Vim"]]',
				})
				request(buf_set_option, 0, 'filetype', 'lua')
				assert.is.True(request(exec_lua, 'return rb.is_enabled()', {}))
			end)

			it('Is disabled for not whitelisted language with injected whitelisted language', function()
				request(buf_set_lines, 0, 0, -1, true, {
					'This is Markdown',
					'',
					'```lua',
					'print(((("This is Lua"))))',
					'```',
					'',
					'More Markdown',
				})
				request(buf_set_option, 0, 'filetype', 'markdown')
				assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
			end)
		end)
	end)

	describe('Manual toggling', function()
		it('Can be disabled for a buffer', function()
			request(buf_set_option, 0, 'filetype', 'lua')
			request(exec_lua, 'rb.disable(0)', {})
			assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
		end)

		it('Can be turned back on', function()
			request(buf_set_option, 0, 'filetype', 'lua')
			request(exec_lua, 'rb.disable(0)', {})
			request(exec_lua, 'rb.enable(0)', {})
			assert.is.True(request(exec_lua, 'return rb.is_enabled()', {}))
		end)

		it('Can be toggled off', function()
			request(buf_set_option, 0, 'filetype', 'lua')
			request(exec_lua, 'rb.toggle(0)', {})
			assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
		end)

		it('Can be toggled on', function()
			request(buf_set_option, 0, 'filetype', 'lua')
			request(exec_lua, 'rb.toggle(0)', {})
			request(exec_lua, 'rb.toggle(0)', {})
			assert.is.True(request(exec_lua, 'return rb.is_enabled()', {}))
		end)

		it('Gets disabled idempotently', function()
			request(buf_set_option, 0, 'filetype', 'lua')
			request(exec_lua, 'rb.disable(0)', {})
			request(exec_lua, 'rb.disable(0)', {})
			assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
		end)

		it('Gets enabled idempotently', function()
			request(buf_set_option, 0, 'filetype', 'lua')
			request(exec_lua, 'rb.disable(0)', {})
			request(exec_lua, 'rb.enable(0)', {})
			request(exec_lua, 'rb.enable(0)', {})
			assert.is.True(request(exec_lua, 'return rb.is_enabled()', {}))
		end)

		describe('Blacklist', function()
			before_each(function()
				request(command, 'let g:rainbow_delimiters.blacklist = ["markdown"]')
			end)

			it('Can be enabled for a blacklisted language', function()
				request(buf_set_option, 0, 'filetype', 'markdown')
				request(exec_lua, 'rb.enable(0)', {})
				assert.is.True(request(exec_lua, 'return rb.is_enabled()', {}))
			end)

			it('Can be toggled for a blacklisted language', function()
				request(buf_set_option, 0, 'filetype', 'markdown')
				request(exec_lua, 'rb.toggle(0)', {})
				assert.is.True(request(exec_lua, 'return rb.is_enabled()', {}))
			end)
		end)

		describe('Whitelist', function()
			before_each(function()
				request(command, 'let g:rainbow_delimiters.whitelist = ["lua"]')
			end)

			it('Can be disabled for a whitelisted language', function()
				request(buf_set_option, 0, 'filetype', 'lua')
				request(exec_lua, 'rb.disable(0)', {})
				assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
			end)

			it('Can be toggled for a whitelisted language', function()
				request(buf_set_option, 0, 'filetype', 'lua')
				request(exec_lua, 'rb.toggle(0)', {})
				assert.is.False(request(exec_lua, 'return rb.is_enabled()', {}))
			end)
		end)
	end)
end)
