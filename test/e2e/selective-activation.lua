local rpcrequest = vim.rpcrequest
local test_utils = require 'testing.utils'

local exec_lua = 'nvim_exec_lua'
local buf_set_lines = 'nvim_buf_set_lines'

describe('We can disable rainbow delimiters for certain languages', function()
	local nvim

	local function request(method, ...)
		return rpcrequest(nvim, method, ...)
	end

	before_each(function()
		nvim = test_utils.start_embedded()
	end)

	after_each(function()
		test_utils.stop_embedded(nvim)
	end)

	it('Does not run for a blacklisted language', function()
		request(exec_lua, 'the_strategy = require("rainbow-delimiters.strategy.track")(require("rainbow-delimiters.strategy.no-op"))', {})
		request(exec_lua, 'vim.g.rainbow_delimiters = {blacklist = {"lua"}, strategy = {[""] = the_strategy}}', {})
		request(buf_set_lines, 0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
		request('nvim_command', 'filetype detect')
		local attachments = request(exec_lua, 'return the_strategy.attachments[1]', {})
		assert.is.equal(0, attachments)
	end)

	it('Runs for a whitelisted language', function()
		request(exec_lua, 'the_strategy = require("rainbow-delimiters.strategy.track")(require("rainbow-delimiters.strategy.no-op"))', {})
		request(exec_lua, 'vim.g.rainbow_delimiters = {whitelist = {"lua"}, strategy = {[""] = the_strategy}}', {})
		request(buf_set_lines, 0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
		request('nvim_command', 'filetype detect')
		local attachments = request(exec_lua, 'return the_strategy.attachments[1]', {})
		assert.is.equal(1, attachments)
	end)
end)
