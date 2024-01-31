local yd = require 'yo-dawg'

describe('Attaching a strategy to a buffer', function()
	local nvim

	before_each(function()
		nvim = yd.start()

		-- Set up a tracking strategy
		nvim:exec_lua([[
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
		yd.stop(nvim)
	end)

	it('Does not attach a second time if the buffer is already attached', function()
		-- Write buffer to a file
		local tempfile = nvim:call_function('tempname', {})
		nvim:call_function('writefile', {{'print((((("Hello, world!")))))', '-- vim:ft=lua'}, tempfile})

		-- Edit the buffer multiple times, this will trigger attachment
		for _ = 1, 3 do
			nvim:cmd({cmd = 'edit', args = {tempfile}}, {})
			nvim:cmd({cmd = 'filetype', args = {'detect'}}, {})
		end

		local count = nvim:exec_lua('return the_strategy.attachments[1]', {})
		assert.is.equal(1, count, 'Buffer attached multiple times')
	end)

	it('Performs cleanup after a buffer is deleted', function()
		local is_attached

		nvim:buf_set_lines(0, 0, -1, true, {'print((((("Hello, world!")))))', '-- vim:ft=lua'})
		nvim:cmd({cmd = 'filetype', args = {'detect'}}, {})

		is_attached = nvim:exec_lua('return the_strategy.buffers[vim.fn.bufnr()] ~= nil', {})
		assert.is_true(is_attached, 'Strategy must be attach to buffer')

		-- Delete the buffer
		nvim:cmd({cmd = 'bdelete', bang = true}, {})
		is_attached = nvim:exec_lua('return the_strategy.buffers[vim.fn.bufnr()] ~= nil', {})
		assert.is_false(is_attached, 'Strategy must not be attach to buffer')
	end)

	it('Detaches from the buffer and re-attached with the new language', function()
		-- Switching the file type preserves the number of attachments, but
		-- changes the language
		for _, expected in ipairs({'lua', 'vim'}) do
			nvim:buf_set_option(0, 'filetype', expected)

			local lang = nvim:exec_lua('return the_strategy.buffers[vim.fn.bufnr()].lang', {})
			local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})

			assert.is.equal(1, attachments)
			assert.is.equal(lang, expected)
		end
	end)

	it('Unloads a buffer without raising errors', function()
		-- Create two windows with different buffers, but with same file type
		nvim:buf_set_option(0, 'filetype', 'lua')
		nvim:buf_set_lines(0, 0, -1, true, {'print(((("Hello world"))))', '-- vim:ft=lua'})
		nvim:cmd({cmd = 'new'}, {})
		nvim:buf_set_option(0, 'filetype', 'lua')
		nvim:buf_set_lines(0, 0, -1, true, {'print(((("Goodbye world"))))', '-- vim:ft=lua'})

		local secondbuf = nvim:call_function('bufnr', {})
		nvim:cmd({cmd = 'bdelete', args = {secondbuf}, bang = true}, {})
		local errmsg = nvim:get_vvar('errmsg')

		assert.is.equal('', errmsg)
	end)
end)
