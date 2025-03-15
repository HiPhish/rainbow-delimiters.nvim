local is_test, keys = pcall(require, 'busted-keys')
if not is_test then return end
local assert = require 'luassert'


---Records a row/column pair as position coordinates
local function at_position(state, args, _level)
	assert(args.n == 2, 'Must provide exactly two coordinates')
	assert(rawget(state, keys.channel) ~= nil, 'No Neovim client set')
	local row, column = args[1], args[2]
	rawset(state, keys.position, {row, column, row = row, column = column})
end


assert:register('modifier', 'at_position', at_position)
