---A dynamic test file, meaning it generates many different tests at runtime.

local get_query = vim.treesitter.query.get
local lib = require 'rainbow-delimiters._test.highlight'

for _, lang in ipairs(lib.list_languages()) do
	describe(('For language #%s'):format(lang), function()
		EnsureTSParser(lang)
		local queries = lib.list_queries(lang)
		for _, query in ipairs(queries) do
			describe(('the query #%s'):format(query), function()
				it('is correct', function()
					local success, error = pcall(get_query, lang, query)
					assert.is_true(success, error)
				end)
			end)
		end
	end)
end
