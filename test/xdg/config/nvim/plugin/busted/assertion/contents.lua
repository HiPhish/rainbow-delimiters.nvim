-- If busted is not available this configuration is not running as part of a
-- test, so there is nothing to do.
local success, say = pcall(require, 'say')
if not success then return end

local assert = require 'luassert'
local keys = require 'busted-keys'


local function has_buffer_content(state, arguments)
	local nvim = rawget(state, keys.channel)
	local buffer = rawget(state, keys.buffer) or 0

	assert(nvim ~= nil, 'No Neovim channel set, use the `nvim` modifier to set the channel')
	assert(arguments.n == 1, 'Provide the expected buffer contents as a string')

	local expected = arguments[1]
	local given = vim.fn.join(nvim:buf_get_lines(buffer, 0, -2, true), '\n')

	return expected == given
end


say:set('assertion.has_content.positive', 'Expected buffer content %s')
say:set('assertion.has_content.negative', 'Expected different buffer content than %s')


assert:register(
	'assertion', 'has_content', has_buffer_content,
	'assertion.has_content.positive', 'assertion.has_content.negative')
