-- SPDX-License-Identifier: Apache-2.0

---Helper script of functions which are used in highlight tests.  Do not
---require this file at runtime, it is only used for testing.
local M = {}

local yd = require 'yo-dawg'

local EXTMARK_OPTS = {
	type = 'highlight',
	details = true,
}

---Job options for the embedded Neovim process; note the custom environment
---variables.
local JOB_OPTS = {
	rpc = true,
	width = 80,
	height = 40,
	env = {
		XDG_DATA_HOME   = 'test/xdg/local/share/',
		XDG_CONFIG_HOME = 'test/xdg/config/',
		XDG_STATE_HOME  = 'test/xdg/local/state/',
	}
}

---Reduces an extmark to only those fields we care about
---@param extmark table  An extmark as returned by Neovim
---@return table reduced  A reduced extmark
local function reduce_extmark(extmark)
	return {
		start_row = extmark[2],
		start_col = extmark[3],
		end_row   = extmark[4].end_row,
		end_col   = extmark[4].end_col,
		hl_group  = extmark[4].hl_group,
	}
end

---Retrieves the extmarks of a given language from a remote Neovim process.
---@param nvim table   A Yo-Dawg Neovim handle
---@param lang string  Name of the language
---@return table extmarks  The extmarks from the remote instance.
local function fetch_extmarks(nvim, lang)
	local nsid = nvim:exec_lua('return require("rainbow-delimiters.lib").nsids[...]', {lang})
	local extmarks = nvim:buf_get_extmarks(0, nsid, 0, -1, EXTMARK_OPTS)
	return vim.tbl_map(reduce_extmark, extmarks)
end

local function is_directory(_name, type)
	return type == 'directory'
end

local function is_file(_name, type)
	return type == 'file'
end

local function is_query_file(name, type)
	 return type == 'file' and name:match('%.scm$')
end

local function to_name(name, _type)
	return name
end

local function to_query_name(name, _type)
	local result = name:gsub('%.scm$', '')
	return result
end

---List all languages which have sample files.
function M.list_languages()
	return vim.iter(vim.fs.dir('test/highlight/samples'))
	:filter(is_directory)
	:map(to_name)
	:totable()
end

function M.list_queries(lang)
	local query_dir = ('queries/%s'):format(lang)
	return vim.iter(vim.fs.dir(query_dir))
		:filter(is_query_file)
		:map(to_query_name)
		:totable()
end

function M.list_samples(lang)
	local sample_directory = ('test/highlight/samples/%s/'):format(lang)
	return vim.iter(vim.fs.dir(sample_directory))
		:filter(is_file)
		:map(to_name)
		:totable()
end

---Given a Neovim instance, language, sample file and query collect all
---highlight information from the sample file and return it.
---@param nvim   table   A Yo-Dawn Neovim instance
---@param lang   string  Language of the sample file
---@param sample string  Sample file path
---@param query  string  Name of the query to use
---@return table
function M.fetch_delimiters(nvim, lang, sample, query)
	local sample_file = ('test/highlight/samples/%s/%s'):format(lang, sample)

	-- NOTE: We have to parse the buffer first because this is an embedded
	-- Neovim which has no UI.  When there is a UI the buffer will be parsed
	-- automatically, but in an embedded context this is not guaranteed.
	nvim:set_var('rainbow_delimiters', {query = {[''] = query}})
	nvim:exec_lua('EnsureTSParser(...)', {lang})
	nvim:cmd({cmd = 'edit', args = {sample_file}}, {})
	nvim:exec_lua('vim.treesitter.start()', {})
	nvim:exec_lua('parser = vim.treesitter.get_parser()', {})
	nvim:exec_lua('parser:parse(true)', {})

	local children = nvim:exec_lua('return vim.tbl_keys(parser:children())', {})
	local result = {}

	result[lang] = fetch_extmarks(nvim, lang)
	for _, child in ipairs(children) do
		result[child] = fetch_extmarks(nvim, child)
	end
	return result
end

---Record all the rainbow delimiter extmarks for a given language, query and
---sample file for later testing.  The sample file will be located according to
---the language, do no provide the path leading to the sample directory.
---@param language string  The language to record for
---@param sample   string  Name of the sample file without leading path
---@param query    string  Name of the query
function M.record_extmarks(language, sample, query)
	local languages = language and {language} or M.list_languages()
	for _, lang in ipairs(languages) do
		local samples = sample and {sample} or M.list_samples(lang)
		for _, sample in ipairs(samples) do
			local queries = query and {query} or M.list_queries(lang)
			for _, query in ipairs(queries) do
				local nvim = yd.start(JOB_OPTS)
				local success, result = pcall(M.fetch_delimiters, nvim, lang, sample, query)
				yd.stop(nvim)
				if not success then
					error(result)
					return
				end
				local spec_file = ('test/highlight/spec/%s/%s/%s.lua'):format(lang, query, sample)
				vim.fn.mkdir(('test/highlight/spec/%s/%s/'):format(lang, query), 'p')
				local file = io.open(spec_file, 'w')
				if not file then
					error (('Could not open output file %s'):format(spec_file))
				end
				-- License and copyright header are hard-coded
				file:write('-- SPDX-License-Identifier: Unlicense\n')
				file:write('-- SPDX-FileCopyrightText: NONE\n')
				file:write('\n')
				file:write('return ')
				file:write(vim.inspect(result))
				file:close()
				print(string.format('Spec file "%s" written\n', spec_file))
			end
		end
	end
end

return M
