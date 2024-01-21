local rpcrequest = vim.fn.rpcrequest

local jobopts = {
	rpc = true,
	width = 80,
	height = 24,
}

local call_function = 'nvim_call_function'
local exec_lua = 'nvim_exec_lua'
local buf_set_lines = 'nvim_buf_set_lines'
local buf_set_option = 'nvim_buf_set_option'
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

		-- Set up a tracking strategy
		request(exec_lua, [[
			TSEnsure('lua', 'vim')
			do
				local track = require('rainbow-delimiters.strategy.track')
				local noop  = require('rainbow-delimiters.strategy.no-op')
				the_strategy = track(noop)
			end
    		vim.g.rainbow_delimiters = {
    			strategy = {
    				[''] = the_strategy
    			}
    		}]], {})
	end)

	after_each(function()
		vim.fn.jobstop(nvim)
	end)

	it('Does not attach a second time if the buffer is already attached', function()
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

	it('Performs cleanup after a buffer is deleted', function()
		local is_attached

		request(buf_set_lines, 0, 0, -1, true, {'print((((("Hello, world!")))))', '-- vim:ft=lua'})
		request(cmd, {cmd = 'filetype', args = {'detect'}}, {})

		is_attached = request(exec_lua, 'return the_strategy.buffers[vim.fn.bufnr()] ~= nil', {})
		assert.is_true(is_attached, 'Strategy must be attach to buffer')

		-- Delete the buffer
		request(cmd, {cmd = 'bdelete', bang = true}, {})
		is_attached = request(exec_lua, 'return the_strategy.buffers[vim.fn.bufnr()] ~= nil', {})
		assert.is_false(is_attached, 'Strategy must not be attach to buffer')
	end)

	it('Detaches from the buffer and re-attached with the new language', function()
		-- Switching the file type preserves the number of attachments, but
		-- changes the language
		for _, expected in ipairs({'lua', 'vim'}) do
			request('nvim_buf_set_option', 0, 'filetype', expected)

			local lang = request(exec_lua, 'return the_strategy.buffers[vim.fn.bufnr()].lang', {})
			local attachments = request(exec_lua, 'return the_strategy.attachments[1]', {})

			assert.is.equal(1, attachments)
			assert.is.equal(lang, expected)
		end
	end)

	it('Unloads a buffer without raising errors', function()
		-- Create two windows with different buffers, but with same file type
		request(buf_set_option, 0, 'filetype', 'lua')
		request(buf_set_lines, 0, 0, -1, true, {'print(((("Hello world"))))', '-- vim:ft=lua'})
		request(cmd, {cmd = 'new'}, {})
		request(buf_set_option, 0, 'filetype', 'lua')
		request(buf_set_lines, 0, 0, -1, true, {'print(((("Goodbye world"))))', '-- vim:ft=lua'})

		local secondbuf = request(call_function, 'bufnr', {})
		request(cmd, {cmd = 'bdelete', args = {secondbuf}, bang = true}, {})
		local errmsg = request('nvim_get_vvar', 'errmsg')

		assert.is.equal('', errmsg)
	end)
end)
