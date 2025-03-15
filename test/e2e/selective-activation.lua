local yd = require 'yo-dawg'

describe('We can disable rainbow delimiters for certain languages', function()
	local nvim

	before_each(function()
		nvim = yd.start()
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	describe('For the given language', function()
		before_each(function()
			nvim:buf_set_lines(0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
		end)

		it('Does not run when blacklisted', function()
			nvim:set_var('rainbow_delimiters', {
				blacklist = {'lua'}}
			)
			nvim:command('filetype detect')
			assert.remote(nvim).not_has_rainbow()
		end)

		it('Runs when whitelisted', function()
			nvim:set_var('rainbow_delimiters', {
				whitelist = {'lua'}}
			)
			nvim:command('filetype detect')
			assert.remote(nvim).has_rainbow()
		end)
	end)

	describe('For another language', function()
		before_each(function()
			nvim:buf_set_lines(0, 0, -1, true, {'echo "Hello world"', '" vim:ft=vim'})
		end)

		it('Runs when not blacklisted', function()
			nvim:set_var('rainbow_delimiters', {
				blacklist = {'lua'},
			})
			nvim:command('filetype detect')
			assert.remote(nvim).has_rainbow()
		end)

		it('Does not run when not whitelisted', function()
			nvim:set_var('rainbow_delimiters', {
				whitelist = {'lua'},
			})
			nvim:command('filetype detect')
			assert.remote(nvim).not_has_rainbow()
		end)
	end)

	describe('For dynamic condition', function()
		before_each(function()
			nvim:buf_set_lines(0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
			nvim:exec_lua('always = function() return true end', {})
			nvim:exec_lua('never = function() return false end', {})
		end)

		it('Runs when no condition is set', function()
			nvim:set_var('rainbow_delimiters', {
				condition = nil,
			})
			nvim:command('filetype detect')
			assert.remote(nvim).has_rainbow()
		end)

		it('Runs when condition is met', function()
			nvim:exec_lua('vim.g.rainbow_delimiters = {condition = always}', {})
			nvim:command('filetype detect')
			assert.remote(nvim).has_rainbow()
		end)

		it('Does not run when condition is unmet', function()
			nvim:exec_lua('vim.g.rainbow_delimiters = {condition = never}', {})
			nvim:command('filetype detect')
			assert.remote(nvim).not_has_rainbow()
		end)

		it('Is ignored for blacklisted buffers', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					blacklist = {'lua'},
					condition = always,
				}
			]], {})
			nvim:command('filetype detect')
			assert.remote(nvim).not_has_rainbow()
		end)

		it('Is takes prededence over the whitelist', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					whitelist = {'lua'},
					condition = never,
				}
			]], {})
			nvim:command('filetype detect')
			assert.remote(nvim).not_has_rainbow()
		end)
	end)
end)
