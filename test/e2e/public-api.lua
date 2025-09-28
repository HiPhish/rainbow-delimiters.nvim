local yd = require 'yo-dawg'

describe('The Rainbow Delimiters public API', function()
	local nvim

	before_each(function()
		nvim = yd.start()

		nvim:exec_lua([[EnsureTSParser({'markdown', 'lua', 'vim'})]], {})
		nvim:exec_lua([[rb = require 'rainbow-delimiters' ]], {})
    	nvim:set_var('rainbow_delimiters', {
    		strategy = {
    			[''] = 'rainbow-delimiters.strategy.global',
    		}
    	})
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	describe('Whether RB is enabled for a buffer at startup', function()
		it('Is disabled for a buffer without file type', function()
			assert.remote(nvim).not_has_rainbow()
		end)

		it('Is enabled for a supported language', function()
			nvim:buf_set_option(0, 'filetype', 'lua')
			assert.remote(nvim).has_rainbow()
		end)

		describe('Blacklist', function()
			before_each(function()
				nvim:command('let g:rainbow_delimiters.blacklist = ["markdown"]')
			end)

			it('Is enabled for a not blacklisted language', function()
				nvim:buf_set_option(0, 'filetype', 'lua')
				assert.remote(nvim).has_rainbow()
			end)

			it('Is disabled for a blacklisted language', function()
				nvim:buf_set_option(0, 'filetype', 'markdown')
				assert.remote(nvim).not_has_rainbow()
			end)

			it('Is disabled for a blacklisted language with injected whitelisted language', function()
				nvim:buf_set_lines(0, 0, -1, true, {
					'This is Markdown',
					'',
					'```lua',
					'print(((("This is Lua"))))',
					'```',
					'',
					'More Markdown',
				})
				nvim:buf_set_option(0, 'filetype', 'markdown')
				assert.remote(nvim).not_has_rainbow()
			end)
		end)

		describe('Whitelist', function()
			before_each(function()
				nvim:command('let g:rainbow_delimiters.whitelist = ["lua"]')
			end)

			it('Is disabled for a not whitelisted language', function()
				nvim:buf_set_option(0, 'filetype', 'markdown')
				assert.remote(nvim).not_has_rainbow()
			end)

			it('Is enabled for a whitelisted language', function()
				nvim:buf_set_option(0, 'filetype', 'lua')
				assert.remote(nvim).has_rainbow()
			end)

			it('Is enabled for whitelisted language with other language injected', function()
				nvim:buf_set_lines(0, 0, -1, true, {
					'print "This is Lua"',
					'vim.cmd [[echo "This is Vim"]]',
				})
				nvim:buf_set_option(0, 'filetype', 'lua')
				assert.remote(nvim).has_rainbow()
			end)

			it('Is disabled for not whitelisted language with injected whitelisted language', function()
				nvim:buf_set_lines(0, 0, -1, true, {
					'This is Markdown',
					'',
					'```lua',
					'print(((("This is Lua"))))',
					'```',
					'',
					'More Markdown',
				})
				nvim:buf_set_option(0, 'filetype', 'markdown')
				assert.remote(nvim).not_has_rainbow()
			end)
		end)
	end)

	describe('Manual toggling', function()
		it('Can be disabled for a buffer', function()
			nvim:buf_set_option(0, 'filetype', 'lua')
			nvim:exec_lua('rb.disable(0)', {})
			assert.remote(nvim).not_has_rainbow()
		end)

		it('Can be turned back on', function()
			nvim:buf_set_option(0, 'filetype', 'lua')
			nvim:exec_lua('rb.disable(0)', {})
			nvim:exec_lua('rb.enable(0)', {})
			assert.remote(nvim).has_rainbow()
		end)

		it('Can be toggled off', function()
			nvim:buf_set_option(0, 'filetype', 'lua')
			nvim:exec_lua('rb.toggle(0)', {})
			assert.remote(nvim).not_has_rainbow()
		end)

		it('Can be toggled on', function()
			nvim:buf_set_option(0, 'filetype', 'lua')
			nvim:exec_lua('rb.toggle(0)', {})
			nvim:exec_lua('rb.toggle(0)', {})
			assert.remote(nvim).has_rainbow()
		end)

		it('Gets disabled idempotently', function()
			nvim:buf_set_option(0, 'filetype', 'lua')
			nvim:exec_lua('rb.disable(0)', {})
			nvim:exec_lua('rb.disable(0)', {})
			assert.remote(nvim).not_has_rainbow()
		end)

		it('Gets enabled idempotently', function()
			nvim:buf_set_option(0, 'filetype', 'lua')
			nvim:exec_lua('rb.disable(0)', {})
			nvim:exec_lua('rb.enable(0)', {})
			nvim:exec_lua('rb.enable(0)', {})
			assert.remote(nvim).has_rainbow()
		end)

		describe('Blacklist', function()
			before_each(function()
				nvim:command('let g:rainbow_delimiters.blacklist = ["markdown"]')
			end)

			it('Can be enabled for a blacklisted language', function()
				nvim:buf_set_option(0, 'filetype', 'markdown')
				nvim:exec_lua('rb.enable(0)', {})
				assert.remote(nvim).has_rainbow()
			end)

			it('Can be toggled for a blacklisted language', function()
				nvim:buf_set_option(0, 'filetype', 'markdown')
				nvim:exec_lua('rb.toggle(0)', {})
				assert.remote(nvim).has_rainbow()
			end)
		end)

		describe('Whitelist', function()
			before_each(function()
				nvim:command('let g:rainbow_delimiters.whitelist = ["lua"]')
			end)

			it('Can be disabled for a whitelisted language', function()
				nvim:buf_set_option(0, 'filetype', 'lua')
				nvim:exec_lua('rb.disable(0)', {})
				assert.remote(nvim).not_has_rainbow()
			end)

			it('Can be toggled for a whitelisted language', function()
				nvim:buf_set_option(0, 'filetype', 'lua')
				nvim:exec_lua('rb.toggle(0)', {})
				assert.remote(nvim).not_has_rainbow()
			end)
		end)
	end)
end)
