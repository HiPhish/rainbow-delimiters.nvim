local yd = require 'yo-dawg'

describe('We can use functions to turn rainbow delimiters off and on again.', function()
	local nvim

	before_each(function()
		nvim = yd.start()
		nvim:exec_lua('the_strategy = require("rainbow-delimiters.strategy.global")', {})
		nvim:exec_lua('EnsureTSParser(...)', {'lua'})
		nvim:buf_set_lines(0, 0, -1, true, {'print((((("Hello, world!")))))'})
		nvim:buf_set_option(0, 'filetype', 'lua')
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	it('Does highlighting initially', function()
		assert.remote(nvim).for_language('lua').at_position(0, 5).has_extmarks()
	end)

	it('Disables rainbow delimiters', function()
		nvim:call_function('rainbow_delimiters#disable', {0})
		assert.remote(nvim).for_language('lua').at_position(0, 5).Not.has_extmarks()
	end)

	it('Remains disabled when disabling twice', function()
		nvim:call_function('rainbow_delimiters#disable', {0})
		nvim:call_function('rainbow_delimiters#disable', {0})

		assert.remote(nvim).for_language('lua').at_position(0, 5).Not.has_extmarks()
	end)

	it('Turns rainbow delimiters back on', function()
		nvim:call_function('rainbow_delimiters#disable', {0})
		nvim:call_function('rainbow_delimiters#enable', {0})

		assert.remote(nvim).for_language('lua').at_position(0, 5).has_extmarks()
	end)

	it('Remains enabled when enabling twice', function()
		nvim:call_function('rainbow_delimiters#disable', {0})
		nvim:call_function('rainbow_delimiters#enable', {0})
		nvim:call_function('rainbow_delimiters#enable', {0})

		assert.remote(nvim).for_language('lua').at_position(0, 5).has_extmarks()
	end)

	it('Can be disabled after being enabled', function()
		nvim:call_function('rainbow_delimiters#disable', {0})
		nvim:call_function('rainbow_delimiters#enable', {0})
		nvim:call_function('rainbow_delimiters#disable', {0})

		assert.remote(nvim).for_language('lua').at_position(0, 5).Not.has_extmarks()
	end)

	it('Can be enabled after being disabled twice', function()
		nvim:call_function('rainbow_delimiters#disable', {0})
		nvim:call_function('rainbow_delimiters#disable', {0})
		nvim:call_function('rainbow_delimiters#enable', {0})

		assert.remote(nvim).for_language('lua').at_position(0, 5).has_extmarks()
	end)
end)
