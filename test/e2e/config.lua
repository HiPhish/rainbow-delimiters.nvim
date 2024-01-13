local rpcrequest = vim.fn.rpcrequest

local jobopts = {
	rpc = true,
	width = 80,
	height = 24,
}

local exec_lua = 'nvim_exec_lua'
local exec_vim = 'nvim_exec2'
local set_var  = 'nvim_set_var'
local buf_set_lines = 'nvim_buf_set_lines'

describe('User settings are respected', function()
	local nvim

	local function request(method, ...)
		return rpcrequest(nvim, method, ...)
	end

	before_each(function()
		-- Start the remote Neovim process.  The `--embed` flag lets us control
		-- Neovim through RPC, the `--headless` flag tells it not to wait for a
		-- UI to attach and start loading plugins and configuration immediately
		nvim = vim.fn.jobstart({'nvim', '--embed', '--headless'}, jobopts)
	end)

	after_each(function()
		vim.fn.jobstop(nvim)
	end)

	describe('Strategy settings', function()
		it('Applies the default strategy to all languages', function()
			local strategy = 'default strategy'
			request(exec_vim, 'let g:rainbow_delimiters = {"strategy": {"": "default strategy"}}', {})
			local lua_strategy = request(exec_lua, 'return require("rainbow-delimiters.config").strategy.lua', {})
			local   c_strategy = request(exec_lua, 'return require("rainbow-delimiters.config").strategy.c', {})
			assert.is.equal(strategy, lua_strategy)
			assert.is.equal(strategy,   c_strategy)
		end)

		it('Overrides the strategy for individual languages', function()
			-- I had to use a trick here because we cannot compare dictionaries or
			-- functions for identity between Vim script and Lua.  Instead I
			-- set a string as the strategy and compare for that equality.
			request( exec_lua, 'require("rainbow-delimiters.default").strategy[""] = "default strategy"', {})

			-- Override the strategy for Vim only
			request(set_var, 'rainbow_delimiters', {strategy = {vim = 'vim strategy'}})

			local lua_strategy = request(exec_lua, 'return require("rainbow-delimiters.config").strategy.lua', {})
			local vim_strategy = request(exec_lua, 'return require("rainbow-delimiters.config").strategy.vim', {})

			assert.is.equal('vim strategy',     vim_strategy, 'Wrong strategy found for Vim')
			assert.is.equal('default strategy', lua_strategy, 'Wrong strategy found for Lua')
		end)

		describe('Strategies can be thunks', function()
			before_each(function()
				-- Store strategies in global variables for later reference
				request(exec_lua, 'noop = require("rainbow-delimiters").strategy.noop', {})
				request(exec_lua, 'the_strategy = require("rainbow-delimiters.strategy.track")(noop)', {})
				-- Set a thunk as the strategy
				request(exec_lua, [[
				vim.g.rainbow_delimiters = {
					strategy = {
						[""] = function() return the_strategy end,
						vim = function() return nil end
					}
				}]], {})
			end)

			it('Uses the strategy returned by the thunk', function()
				request('nvim_command', 'TSInstallSync! lua')
				request(buf_set_lines, 0, 0, -1, true, {'print "Hello world"', '-- vim:ft=lua'})
				request('nvim_command', 'filetype detect')
				local attachments = request(exec_lua, 'return the_strategy.attachments[1]', {})
				assert.is.equal(1, attachments, 'The strategy should be attached to the Lua buffer')
			end)

			it('Does nothing if the thunk returns nil', function()
				request('nvim_command', 'TSInstallSync! vim')
				request(buf_set_lines, 0, 0, -1, true, {'echo "Hello world"', '" vim:ft=vim'})
				request('nvim_command', 'filetype detect')
				local attachments = request(exec_lua, 'return the_strategy.attachments[1]', {})
				assert.is.equal(0, attachments, 'The strategy should not be attached to the Vim buffer')
			end)
		end)
	end)

	it('Overrides the query for an individual language', function()
		-- Override the query for one language only
		request(set_var, 'rainbow_delimiters', {query = {c = 'other-query'}})

		local   c_query = request(exec_lua, 'return require("rainbow-delimiters.config").query.c', {})
		local lua_query = request(exec_lua, 'return require("rainbow-delimiters.config").query.lua', {})

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
		request(set_var, 'rainbow_delimiters', {highlight = {}})

		for i, expected in ipairs(hlgroups) do
			local given = request(exec_lua, 'return require("rainbow-delimiters.config").highlight[...]', {i})
			assert.is.equal(expected, given, string.format('Wrong highlight group at index %d', i))
		end
	end)

	describe('White- and blacklist individual languages', function()
		it('Has all languages enabled without configuration', function()
			request(exec_lua, 'rbc = require("rainbow-delimiters.config")', {})
			local lua_enabled = request(exec_lua, 'return rbc.enabled_for("lua")', {})
			local vim_enabled = request(exec_lua, 'return rbc.enabled_for("vim")', {})

			assert.is_true(lua_enabled, 'Lua should be enabled')
			assert.is_true(vim_enabled, 'Vim script should be enabled')
		end)

		it('Has all languages enabled in blank configuration', function()
			request(set_var, 'rainbow_delimiters', {})
			request(exec_lua, 'rbc = require("rainbow-delimiters.config")', {})
			local lua_enabled = request(exec_lua, 'return rbc.enabled_for("lua")', {})
			local vim_enabled = request(exec_lua, 'return rbc.enabled_for("vim")', {})

			assert.is_true(lua_enabled, 'Lua should be enabled')
			assert.is_true(vim_enabled, 'Vim script should be enabled')
		end)

		it('Can whitelist individual file types by adding them to our configuration', function()
			request(set_var, 'rainbow_delimiters', {whitelist = {'lua'}})
			request(exec_lua, 'rbc = require("rainbow-delimiters.config")', {})
			local lua_enabled = request(exec_lua, 'return rbc.enabled_for("lua")', {})
			local vim_enabled = request(exec_lua, 'return rbc.enabled_for("vim")', {})

			assert.is_true( lua_enabled, 'Lua should be enabled')
			assert.is_false(vim_enabled, 'Vim script should be disabled')
		end)

		it('Can blacklist individual file types by adding them to our configuration', function()
			request(set_var, 'rainbow_delimiters', {blacklist = {'vim'}})
			request(exec_lua, 'rbc = require("rainbow-delimiters.config")', {})
			local lua_enabled = request(exec_lua, 'return rbc.enabled_for("lua")', {})
			local vim_enabled = request(exec_lua, 'return rbc.enabled_for("vim")', {})

			assert.is_true( lua_enabled, 'Lua should be enabled')
			assert.is_false(vim_enabled, 'Vim script should be disabled')
		end)
	 end)

	describe('The setup function sets configuration indirectly', function()
		it('Can call the setup function', function()
			request(exec_lua, [[
			require('rainbow-delimiters.setup').setup {
				query = {
					lua = 'rainbow-blocks'
				}
			}
			]], {})
			local lua_query = request('nvim_eval', 'g:rainbow_delimiters.query.lua')
			assert.is.equal('rainbow-blocks', lua_query)
		end)

		it('Can call the table itset', function()
			request(exec_lua, [[
			require('rainbow-delimiters.setup') {
				query = {
					lua = 'rainbow-blocks'
				}
			}
			]], {})
			local lua_query = request('nvim_eval', 'g:rainbow_delimiters.query.lua')
			assert.is.equal('rainbow-blocks', lua_query)
		end)
	end)
end)
