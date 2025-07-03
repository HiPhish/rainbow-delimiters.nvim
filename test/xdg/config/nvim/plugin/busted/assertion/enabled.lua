local is_test, keys = pcall(require, 'busted-keys')
if not is_test then return end
local assert = require 'luassert'
local say = require 'say'


---Whether rainbow delimiters is enabled for the given buffer
local function has_rainbow(state, _arguments)
	local nvim = rawget(state, keys.channel)
	local bufnr = rawget(state, keys.buffer)
	assert(nvim ~= nil, 'No Neovim channel set, use the `nvim` modifier to set the channel')
	return nvim:exec_lua('return require("rainbow-delimiters").is_enabled(...)', {bufnr})
end

say:set('assertion.has_rainbow.positive', 'Expected rainbow delimiters to be enabled')
say:set('assertion.has_rainbow.negative', 'Expected rainbow delimiters to be disabled')

assert:register(
	'assertion', 'has_rainbow', has_rainbow,
	'assertion.has_rainbow.positive', 'assertion.has_rainbow.negative')
