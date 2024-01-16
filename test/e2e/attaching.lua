local rpcrequest = vim.fn.rpcrequest

local jobopts = {
	rpc = true,
	width = 80,
	height = 24,
}

local call_function = 'nvim_call_function'
local exec_lua = 'nvim_exec_lua'
local cmd = 'nvim_cmd'

describe('Attaching a strategy to a buffer', function()
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
		vim.fn.jobstop(nvim)
	end)

	it('Does not attach a second time if the buffer is already attached', function()
		-- Set up a tracking strategy
		request(exec_lua, 'TSEnsure(...)', {'lua'})
		request(exec_lua, [[
			do
				local track = require('rainbow-delimiters.strategy.track')
				local noop  = require('rainbow-delimiters.strategy.no-op')
				the_strategy = track(noop)
			end]], {})
    	request(exec_lua, [[
    		vim.g.rainbow_delimiters = {
    			strategy = {
    				[''] = the_strategy
    			}
    		}]], {})

		-- Write buffer to a file
		local tempfile = request(call_function, 'tempname', {})
		request(call_function, 'writefile', {{'print((((("Hello, world!")))))', '-- vim:ft=lua'}, tempfile})

		-- Edit the buffer multiple times, this will trigger attachment
		for _ = 1, 3 do
			request(cmd, {cmd = 'edit', args = {tempfile}}, {})
			request(cmd, {cmd = 'filetype', args = {'detect'}}, {})
		end

		local count = request(exec_lua, 'return the_strategy.attachments[1]', {})
		assert.is.equal(1, count, 'Buffer attached multiple times')
	end)
end)
