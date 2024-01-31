local yd = require 'yo-dawg'

describe('We can disable rainbow delimiters for certain languages', function()
	local nvim

	before_each(function()
		nvim = yd.start()
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	it('Does not run for a blacklisted language', function()
		nvim:exec_lua('the_strategy = require("rainbow-delimiters.strategy.track")(require("rainbow-delimiters.strategy.no-op"))', {})
		nvim:exec_lua('vim.g.rainbow_delimiters = {blacklist = {"lua"}, strategy = {[""] = the_strategy}}', {})
		nvim:buf_set_lines(0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
		nvim:command('filetype detect')
		local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
		assert.is.equal(0, attachments)
	end)

	it('Runs for a whitelisted language', function()
		nvim:exec_lua('the_strategy = require("rainbow-delimiters.strategy.track")(require("rainbow-delimiters.strategy.no-op"))', {})
		nvim:exec_lua('vim.g.rainbow_delimiters = {whitelist = {"lua"}, strategy = {[""] = the_strategy}}', {})
		nvim:buf_set_lines(0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
		nvim:command('filetype detect')
		local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
		assert.is.equal(1, attachments)
	end)
end)
