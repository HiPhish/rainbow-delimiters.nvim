local yd = require 'yo-dawg'

describe('We can disable rainbow delimiters for certain languages', function()
	local nvim

	before_each(function()
		nvim = yd.start()
		nvim:exec_lua('the_strategy = require("rainbow-delimiters.strategy.track")(require("rainbow-delimiters.strategy.no-op"))', {})
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	describe('For the given language', function()
		before_each(function()
			nvim:buf_set_lines(0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
		end)

		it('Does not run when blacklisted', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {[""] = the_strategy},
					blacklist = {"lua"},
				}
			]], {})
			nvim:command('filetype detect')
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
			assert.is.equal(0, attachments)
		end)

		it('Runs when whitelisted', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {[""] = the_strategy},
					whitelist = {"lua"},
				}
			]], {})
			nvim:command('filetype detect')
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
			assert.is.equal(1, attachments)
		end)
	end)

	describe('For another language', function()
		before_each(function()
			nvim:buf_set_lines(0, 0, -1, true, {'echo "Hello world"', '" vim:ft=vim'})
		end)

		it('Runs when not blacklisted', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {[""] = the_strategy},
					blacklist = {"lua"},
				}
			]], {})
			nvim:command('filetype detect')
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
			assert.is.equal(1, attachments)
		end)

		it('Does not run when not whitelisted', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {[""] = the_strategy},
					whitelist = {"lua"}
				}
			]], {})
			nvim:command('filetype detect')
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
			assert.is.equal(0, attachments)
		end)
	end)

	describe('For dynamic condition', function()
		before_each(function()
			nvim:buf_set_lines(0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
		end)

		it('Runs when no condition is set', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {[""] = the_strategy},
					condition = nil,
				}
			]], {})
			nvim:command('filetype detect')
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
			assert.is.equal(1, attachments)
		end)

		it('Runs when condition is met', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {[""] = the_strategy},
					condition = function(bufnr)
						return true
					end,
				}
			]], {})
			nvim:command('filetype detect')
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
			assert.is.equal(1, attachments)
		end)

		it('Does not run when condition is unmet', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {[""] = the_strategy},
					condition = function(_bufnr)
						return false
					end,
				}
			]], {})
			nvim:command('filetype detect')
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
			assert.is.equal(0, attachments)
		end)

		it('Is ignored for blacklisted buffers', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {[""] = the_strategy},
					blacklist = {'lua'},
					condition = function(_bufnr)
						return true
					end,
				}
			]], {})
			nvim:command('filetype detect')
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
			assert.is.equal(0, attachments)
		end)

		it('Is takes prededence over the whitelist', function()
			nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {[""] = the_strategy},
					whitelist = {'lua'},
					condition = function(_bufnr)
						return false
					end,
				}
			]], {})
			nvim:command('filetype detect')
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
			assert.is.equal(0, attachments)
		end)
	end)
end)
