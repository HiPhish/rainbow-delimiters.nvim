local is_test, keys = pcall(require, 'busted-keys')
if not is_test then return end
local assert = require 'luassert'
local say = require 'say'


local function has_strategy(state, arguments)
	local nvim = rawget(state, keys.channel)
	local language = rawget(state, keys.language)
	local module = arguments[1]

	assert(language ~= nil, 'No language set')
	assert(module, 'Provide the expected strategy module as a string')

	return nvim:exec_lua(
		string.format([[
			return vim.deep_equal(
				require('rainbow-delimiters.config').strategy["%s"],
				require('%s')
			)
		]], language, module),
		{}
	)
end


say:set('assertion.has_strategy.positive', 'Expected strategy %s')
say:set('assertion.has_strategy.negative', 'Expected different strategy than %s')


assert:register(
	'assertion', 'has_strategy', has_strategy,
	'assertion.has_strategy.positive', 'assertion.has_strategy.negative')
