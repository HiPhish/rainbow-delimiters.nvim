local is_test, keys = pcall(require, 'busted-keys')
if not is_test then return end
local assert = require 'luassert'


local function channel(state, args, _level)
	assert(args.n > 0, 'No Neovim channel provided to the modifier')
	assert(rawget(state, keys.channel) == nil, 'Neovim already set')
	rawset(state, keys.channel, args[1])
	return state
end


assert:register('modifier', 'remote', channel)
