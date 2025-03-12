local yd = require 'yo-dawg'

describe('User settings are respected', function()
	local nvim

	before_each(function()
		nvim = yd.start()
	end)

	after_each(function()
		yd.stop(nvim)
	end)

	describe('Strategy settings', function()
		it('Resolves a string to a strategy table', function()
			nvim:set_var('rainbow_delimiters', {strategy = {lua = 'rainbow-delimiters.strategy.local'}})
			assert.nvim(nvim).language('lua').has_strategy('rainbow-delimiters.strategy.local')
		end)

		it('Resolves a string to a strategy in Vim script', function()
			nvim:exec2(
				"let g:rainbow_delimiters = {'strategy': {'lua': 'rainbow-delimiters.strategy.local'}}",
				{}
			)
			assert.nvim(nvim).language('lua').has_strategy('rainbow-delimiters.strategy.local')
		end)

		it('Accepts a strategy object', function()
			nvim:exec_lua(
				[[
					vim.g.rainbow_delimiters = {
						strategy = {
							lua = require('rainbow-delimiters.strategy.local')
						}
					}
				]],
				{}
			)
			assert.nvim(nvim).language('lua').has_strategy('rainbow-delimiters.strategy.local')
		end)

		it('Applies the default strategy to all languages xx', function()
			nvim:set_var('rainbow_delimiters', {strategy = {[''] = 'rainbow-delimiters.strategy.local'}})
			assert.nvim(nvim).language('lua').has_strategy('rainbow-delimiters.strategy.local')
			assert.nvim(nvim).language('vim').has_strategy('rainbow-delimiters.strategy.local')
		end)

		it('Overrides the strategy for individual languages', function()
			nvim:set_var('rainbow_delimiters', {strategy = {lua = 'rainbow-delimiters.strategy.local'}})
			assert.nvim(nvim).language('lua').has_strategy('rainbow-delimiters.strategy.local')
			assert.nvim(nvim).language('vim').has_strategy('rainbow-delimiters.strategy.global')
		end)

		describe('Strategies can be thunks', function()
			before_each(function()
				-- Store strategies in global variables for later reference
				nvim:exec_lua('noop = require("rainbow-delimiters").strategy.noop', {})
				nvim:exec_lua('the_strategy = require("rainbow-delimiters.strategy.track")(noop)', {})
				-- Set a thunk as the strategy
				nvim:exec_lua([[
				vim.g.rainbow_delimiters = {
					strategy = {
						[""] = function() return the_strategy end,
						vim = function() return nil end
					}
				}]], {})
			end)

			it('Uses the strategy returned by the thunk', function()
				nvim:exec_lua('TSEnsure(...)', {'lua'})
				nvim:buf_set_lines(0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
				nvim:command('filetype detect')
				local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
				assert.is.equal(1, attachments, 'The strategy should be attached to the Lua buffer')
			end)

			it('Does nothing if the thunk returns nil', function()
				nvim:exec_lua('TSEnsure(...)', {'vim'})
				nvim:buf_set_lines(0, 0, -1, true, {'echo "Hello world"', '" vim:ft=vim'})
				nvim:command('filetype detect')
				local attachments = nvim:exec_lua('return the_strategy.attachments[1]', {})
				assert.is.equal(0, attachments, 'The strategy should not be attached to the Vim buffer')
			end)
		end)
	end)

	it('Overrides the query for an individual language', function()
		-- Override the query for one language only
		nvim:set_var('rainbow_delimiters', {query = {c = 'other-query'}})

		local   c_query = nvim:exec_lua('return require("rainbow-delimiters.config").query.c', {})
		local lua_query = nvim:exec_lua('return require("rainbow-delimiters.config").query.lua', {})

		assert.is.equal('other-query', c_query)
		assert.is.equal('rainbow-delimiters', lua_query)
	end)

	it('Falls back to default highlighting if the highlight table is empty', function()
		---The expected highlight groups in order
		local hlgroups = {
			'RainbowDelimiterRed',
			'RainbowDelimiterYellow',
			'RainbowDelimiterBlue',
			'RainbowDelimiterOrange',
			'RainbowDelimiterGreen',
			'RainbowDelimiterViolet',
			'RainbowDelimiterCyan',
		}

		-- Set highlight to empty list
		nvim:set_var('rainbow_delimiters', {highlight = {}})

		for i, expected in ipairs(hlgroups) do
			local given = nvim:exec_lua('return require("rainbow-delimiters.config").highlight[...]', {i})
			assert.is.equal(expected, given, string.format('Wrong highlight group at index %d', i))
		end
	end)

	describe('White- and blacklist individual languages', function()
		it('Has all languages enabled without configuration', function()
			nvim:exec_lua('rbc = require("rainbow-delimiters.config")', {})
			local lua_enabled = nvim:exec_lua('return rbc.enabled_for("lua")', {})
			local vim_enabled = nvim:exec_lua('return rbc.enabled_for("vim")', {})

			assert.is_true(lua_enabled, 'Lua should be enabled')
			assert.is_true(vim_enabled, 'Vim script should be enabled')
		end)

		it('Has all languages enabled in blank configuration', function()
			nvim:set_var('rainbow_delimiters', {})
			nvim:exec_lua('rbc = require("rainbow-delimiters.config")', {})
			local lua_enabled = nvim:exec_lua('return rbc.enabled_for("lua")', {})
			local vim_enabled = nvim:exec_lua('return rbc.enabled_for("vim")', {})

			assert.is_true(lua_enabled, 'Lua should be enabled')
			assert.is_true(vim_enabled, 'Vim script should be enabled')
		end)

		it('Can whitelist individual file types by adding them to our configuration', function()
			nvim:set_var('rainbow_delimiters', {whitelist = {'lua'}})
			nvim:exec_lua('rbc = require("rainbow-delimiters.config")', {})
			local lua_enabled = nvim:exec_lua('return rbc.enabled_for("lua")', {})
			local vim_enabled = nvim:exec_lua('return rbc.enabled_for("vim")', {})

			assert.is_true( lua_enabled, 'Lua should be enabled')
			assert.is_false(vim_enabled, 'Vim script should be disabled')
		end)

		it('Can blacklist individual file types by adding them to our configuration', function()
			nvim:set_var('rainbow_delimiters', {blacklist = {'vim'}})
			nvim:exec_lua('rbc = require("rainbow-delimiters.config")', {})
			local lua_enabled = nvim:exec_lua('return rbc.enabled_for("lua")', {})
			local vim_enabled = nvim:exec_lua('return rbc.enabled_for("vim")', {})

			assert.is_true( lua_enabled, 'Lua should be enabled')
			assert.is_false(vim_enabled, 'Vim script should be disabled')
		end)
	 end)

	describe('The setup function sets configuration indirectly', function()
		it('Can call the setup function', function()
			nvim:exec_lua([[
			require('rainbow-delimiters.setup').setup {
				query = {
					lua = 'rainbow-blocks'
				}
			}
			]], {})
			local lua_query = nvim:eval('g:rainbow_delimiters.query.lua')
			assert.is.equal('rainbow-blocks', lua_query)
		end)

		it('Can call the table itset', function()
			nvim:exec_lua([[
			require('rainbow-delimiters.setup') {
				query = {
					lua = 'rainbow-blocks'
				}
			}
			]], {})
			local lua_query = nvim:eval('g:rainbow_delimiters.query.lua')
			assert.is.equal('rainbow-blocks', lua_query)
		end)
	end)
end)
