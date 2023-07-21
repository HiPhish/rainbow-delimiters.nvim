---Health check module.
local M = {}

local error = vim.health.error or vim.health.report_error
local warn = vim.health.warn or vim.health.report_warn
local info= vim.health.info or vim.health.report_info
local ok = vim.health.ok or vim.health.report_ok
local start = vim.health.start or vim.health.report_start

local STRATEGY_ADVICE = "See :h rb-delimiters-strategy for the strategy protocol"
local    QUERY_ADVICE = "See :h rb-delimiters-query for included standard queries."
local  HLGROUP_ADVICE = "Consecutive highlight groups make delimiter levels indistinguishable, use another highlight group."


---Check whether there is a parser installed for the given language.
local function check_parser_installed(lang)
	local success = pcall(vim.treesitter.language.inspect, lang)
	return success
end

---Check whether the strategy is a valid strategy.
---
---This is not a 100% reliable check; we only test the type of the argument and
---whether the table has the correct fields, but not what the callback
---functions actually do.
local function check_strategy(strategy)
	if type(strategy) == 'function' then
		local info = debug.getinfo(strategy)
		return info.nparams == 0
	end
	if type(strategy) == 'table' then
		if type(strategy.on_attach) ~= 'function' then
			return false
		end
		if type(strategy.on_detach) ~= 'function' then
			return false
		end
		return true
	end
	return false
end

---Check whether the given query is defined for the given language.
local function check_query(lang, name)
	local query = vim.treesitter.query.get(lang, name)
	return query ~= nil
end


function M.check()
	local settings = vim.g.rainbow_delimiters
	if not settings then
		return
		info("No custom configuration; see :h rb-delimiters-setup for information.")
	end

	local whitelist = settings.whitelist
	if whitelist then
		start 'Parsers for whitelisted languages'
		for _, lang in ipairs(whitelist) do
			local success = check_parser_installed(lang)
			if success then
				local msg =string.format("Parser installed for '%s'", lang)
				ok(msg)
			else
				local msg =string.format("No parser installed for '%s'", lang)
				warn(msg)
			end
		end
	end

	local strategies = settings.strategy
	if strategies then
		start 'Custom strategies'
		for lang, strategy in pairs(strategies) do
			local has_strategy = check_strategy(strategy)
			if lang == '' then
				if has_strategy then
					local msg = 'Valid custom default strategy.'
					ok(msg)
				else
					local msg = 'Invalid custom default strategy.'
					error(msg, STRATEGY_ADVICE)
				end
			else
				local has_parser = check_parser_installed(lang)
				if not has_parser then
					local msg = string.format("No parser installed for '%s'", lang)
					error(msg)
				end
				if not has_strategy then
					local msg = string.format("Invalid custom strategy for '%s'", lang)
					error(msg, STRATEGY_ADVICE)
				end
				if has_parser and has_strategy then
					local msg = string.format("Valid custom strategy for '%s'.", lang)
					ok(msg)
				end
			end
		end
	end

	local queries = settings.query
	if queries then
		start 'Custom queries'
		for lang, query in pairs(queries) do
			if lang ~= '' then
				local has_lang = check_parser_installed(lang)
				local has_query = check_query(lang, query)
				if not has_lang then
					local msg = string.format("No parser installed for '%s'.", lang)
					warn(msg)
				end
				if not has_query then
					local msg = string.format("No query named '%s' for '%s' found.", query, lang)
					warn(msg, QUERY_ADVICE)
				end
			end
		end
	end

	local hlgroups = settings.highlight
	if hlgroups then
		start 'Custom highlight groups'
		local previous
		for _, hlgroup in ipairs(hlgroups) do
			local has_hlgroup = vim.fn.hlID(hlgroup) ~= 0
			if has_hlgroup then
				ok(string.format("Highlight group '%s' defined.", hlgroup))
			else
				error(string.format("Highlight group '%s' not defined.", hlgroup))
			end
			if previous and hlgroup == previous then
				local msg = string.format("Consecutive highlight group '%s'", hlgroup)
				warn(msg, HLGROUP_ADVICE)
			end
			previous = hlgroup
		end
	end
end

return M
