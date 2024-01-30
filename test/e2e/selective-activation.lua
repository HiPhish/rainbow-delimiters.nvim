local rpcrequest = vim.rpcrequest

local jobopts = {
	rpc = true,
	width = 80,
	height = 24,
}

local exec_lua = 'nvim_exec_lua'
local buf_set_lines = 'nvim_buf_set_lines'

describe('We can disable rainbow delimiters for certain languages', function()
	local nvim

	local function request(method, ...)
		return rpcrequest(nvim, method, ...)
	end

	before_each(function()
		-- Start the remote Neovim process.  The `--embed` flag lets us control
		-- Neovim through RPC, the `--headless` flag tells it not to wait for a
		-- UI to attach and start loading plugins and configuration immediately
		nvim = vim.fn.jobstart({'nvim', '--embed', '--headless'}, jobopts)
	end)

	after_each(function()
		vim.rpcnotify(nvim, 'nvim_cmd', {cmd = 'quitall', bang = true}, {})
		vim.fn.jobwait({nvim})
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
