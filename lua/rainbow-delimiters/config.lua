-- SPDX-License-Identifier: Apache-2.0

--[[
   Copyright 2023 Alejandro "HiPhish" Sanchez

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

	   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--]]

local function get_nested(table, index, key)
	local result

	-- 1. User setting for file type
	if vim.g.rainbow_delimiters and vim.g.rainbow_delimiters[index] then
		result = rawget(vim.g.rainbow_delimiters[index], key)
	end
	if result ~= nil then return result end

	-- 2. User setting for fallback
	if vim.g.rainbow_delimiters and vim.g.rainbow_delimiters[index] then
		result = rawget(vim.g.rainbow_delimiters[index], '')
	end
	if result ~= nil then return result end

	-- 3. Default setting
	result = rawget(table, key)
	if result ~= nil then return result end

	result = require('rainbow-delimiters.default')[index][key]
	return result
end

---Plugin settings lookup table.  This table is only used for looking up
---values.  Set `g:rainbow_delimiters` to change the values.
local M = {
	query = setmetatable({}, {
		__index = function(table, key)
			return get_nested(table, 'query', key)
		end
	}),
	strategy = setmetatable({}, {
		__index = function(table, key)
			local value = get_nested(table, 'strategy', key)
			if type(value) == 'string' then
				return require(value)
			end
			return value
		end
	}),
	priority = setmetatable({}, {
		__index = function(table, key)
			return get_nested(table, 'priority', key)
		end
	}),
	log = setmetatable({}, {
		__index = function(table, key)
			return get_nested(table, 'log', key)
		end
	}),
	enabled_for = function(lang)
		if not lang then return false end
		local conf = vim.g.rainbow_delimiters
		if not conf then return true end

		local whitelist = conf.whitelist
		local blacklist = conf.blacklist

		if whitelist then
			for _, v in ipairs(whitelist) do
				if v == lang then return true end
			end
			return false
		end

		if blacklist then
			for _, v in ipairs(blacklist) do
				if v == lang then return false end
			end
		end

		return true
	end,
	enabled_when = function(bufnr)
		local conf = vim.g.rainbow_delimiters
		if not conf or not conf.condition then
			return true
		end
		return conf.condition(bufnr)
	end
}

setmetatable(M, {
	__index = function(table, key)
		if key == 'highlight' then
			local highlight

			if vim.g.rainbow_delimiters then
				highlight = rawget(vim.g.rainbow_delimiters, 'highlight')
			end
			if highlight and #highlight > 0 then return highlight end

			highlight = require('rainbow-delimiters.default').highlight
			return highlight
		end
		return rawget(table, key)
	end,
})

return M

-- vim:tw=79:ts=4:sw=4:noet:
