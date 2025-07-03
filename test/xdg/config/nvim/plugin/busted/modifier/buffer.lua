local is_test, keys = pcall(require, 'busted-keys')
if not is_test then return end
local assert = require 'luassert'


local function buffer(state, args, _level)
	assert(args.n == 1, 'Must provide exactly one buffer')
	assert(rawget(state, keys.channel) ~= nil, 'No Neovim client set')
	assert(rawget(state, keys.buffer) == nil, 'Buffer already set')
	rawset(state, keys.buffer, args[1])
end

assert:register('modifier', 'in_buffer', buffer)
