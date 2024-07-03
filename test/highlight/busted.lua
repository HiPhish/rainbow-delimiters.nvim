---A dynamic test file, meaning it generates many different tests at runtime.

local yd  = require 'yo-dawg'
local lib = require 'rainbow-delimiters._test.highlight'

local function verify(language, sample, query)
	local lazy_spec, err = loadfile(('test/highlight/spec/%s/%s/%s.lua'):format(language, query, sample))
	if not lazy_spec then
		error(err)
	end
	local spec = lazy_spec()
	local nvim = yd.start()
	local success, results = pcall(lib.fetch_delimiters, nvim, language, sample, query)
	yd.stop(nvim)
	if not success then
		error(results)
	end
	for lang, extmarks in pairs(spec) do
		local result = results[lang]
		assert.are_equal(#extmarks, #result, string.format('Discrepancy in %s', lang))
		for i, expected in ipairs(extmarks) do
			local given = result[i]
			for key, value in pairs(expected) do
				local error_msg = ('Discrepancy at position %d, key %s'):format(i, key)
				assert.are_equal(value, given[key], error_msg)
			end
		end
	end
	return true
end

for _, lang in ipairs(lib.list_languages()) do
	describe(('Highlights for language #%s'):format(lang), function()
		local queries = lib.list_queries(lang)
		for _, query in ipairs(queries) do
			describe(('for query #%s'):format(query), function()
				for _, sample in ipairs(lib.list_samples(lang)) do
					it(('for sample file %s'):format(sample), function()
						verify(lang, sample, query)
					end)
				end
			end)
		end
	end)
end
