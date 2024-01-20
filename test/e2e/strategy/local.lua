local say = require 'say'
local rpcrequest = vim.fn.rpcrequest

local jobopts = {
	rpc = true,
	width = 80,
	height = 24,
}

local exec_lua = 'nvim_exec_lua'
local feedkeys = 'nvim_feedkeys'
local call_function = 'nvim_call_function'
local buf_set_lines = 'nvim_buf_set_lines'
local buf_set_option = 'nvim_buf_set_option'

local filter = vim.fn.filter

describe('The local strategy', function()
	local nvim

	local function request(method, ...)
		return rpcrequest(nvim, method, ...)
	end

	---Asserts that there are Rainbow Delimiters extmarks at the given position
	---@param arguments integer[]  Row and column, both zero-based
	local function has_extmarks_at(_state, arguments, lang)
		local row, column = arguments[1], arguments[2]
		local nsid = request(exec_lua, 'return require("rainbow-delimiters.lib").nsids[...]', {lang or 'lua'})
		local extmarks = request(exec_lua, 'return vim.inspect_pos(...).extmarks', {0, row, column})
		filter(extmarks, function(_, v) return v.ns_id == nsid end)
		return #extmarks > 0
	end

	say:set('assertion.extmarks_at.positive', 'Expected extmarks at (%s, %s)')
	say:set('assertion.extmarks_at.negative', 'Expected no extmarks at (%s, %s)')
	assert:register('assertion', 'extmarks_at', has_extmarks_at, 'assertion.extmarks_at.positive', 'assertion.extmarks_at.negative')

	before_each(function()
		-- Start the remote Neovim process.  The `--embed` flag lets us control
		-- Neovim through RPC, the `--headless` flag tells it not to wait for a
		-- UI to attach and start loading plugins and configuration immediately
		nvim = vim.fn.jobstart({'nvim', '--embed', '--headless'}, jobopts)
		request(exec_lua, 'TSEnsure(...)', {'lua', 'vim'})
		request(exec_lua, [[
			local rb = require 'rainbow-delimiters'
			local track = require('rainbow-delimiters.strategy.track')
			local strategy = rb.strategy['local']
			assert(nil ~= strategy)
			the_strategy = track(strategy)
			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = the_strategy
				}
			}
		]], {})
	end)

	after_each(function()
		vim.fn.jobstop(nvim)
	end)

	it('Does not reactivate when making changes', function()
		request(buf_set_lines, 0, 0, -1, true, {'print({{{{{}}}}})', '-- vim:ft=lua'})
		request('nvim_win_set_cursor', 0, {1, 5})
		request(buf_set_option, 0, 'filetype', 'lua')
		assert.has_extmarks_at(0, 5)

		request(call_function, 'rainbow_delimiters#disable', {0})
		assert.Not.has_extmarks_at(0, 5)

		-- Add a new pair of curly braces
		-- (jump to first column, find the first closing brace, insert new pair)
		local keys = vim.api.nvim_replace_termcodes('gg0f}i{}<esc>', true, false, true)
		request(feedkeys, keys, 'n', false)
		assert.is.same({'print({{{{{{}}}}}})'}, request('nvim_buf_get_lines', 0, 0, 1, true))

		assert.Not.has_extmarks_at(0, 5)
		assert.is.equal(0, request(exec_lua, 'return the_strategy.attachments[1]', {}))
	end)
end)

