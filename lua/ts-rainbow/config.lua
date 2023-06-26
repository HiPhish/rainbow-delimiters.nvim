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

---Plugin settings lookup table.  This table is only used for looking up
---values.  Set `g:rainbow_delims` to change the values.
local M = {}

local function lookup(table, key)
	local result

	if vim.g.rainbow_delims then
		result = rawget(vim.g.rainbow_delims, key)
	end
	if result ~= nil then return result end

	result = rawget(table, key)
	if result ~= nil then return result end

	-- Cache the result in table so we don't need a require lookup the next time
	result = require('ts-rainbow.default')[key]
	table[key] = result
	return result
end

setmetatable(M, {
	__index = lookup,
})

return M

-- vim:tw=79:ts=4:sw=4:noet:
