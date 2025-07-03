local is_test, keys = pcall(require, 'busted-keys')
if not is_test then return end
local assert = require 'luassert'


local function nvim_language(state, args, _level)
	assert(args.n == 1, 'Must provide exactly one language')
	assert(rawget(state, keys.channel) ~= nil, 'No Neovim client set')
	assert(rawget(state, keys.language) == nil, 'Language already set')
	rawset(state, keys.language, args[1])
end


assert:register('modifier', 'for_language', nvim_language)
