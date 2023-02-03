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

---Helper library for set-like tables.
local M = {}

---The set metatable.
local mt = {}

---Set constructor, creates a set table containing all the passed arguments.
function M.Set(...)
	local result = setmetatable({}, mt)
	for _, item in pairs({...}) do result[item] = true end
	return result
end

---Instantiates a new set containing the given items, or the empty set if the
---argument is `nil`.
function M.new(items)
	local result = setmetatable({}, mt)
	for _, item in ipairs(items or {}) do result[item] = true end
	return result
end

---Forms the union of any number of sets, returns a new set table.
function M.union(...)
	local result = M.new()
	local sets = {...}
	for _, set in ipairs(sets) do
		for _, item in ipairs(set) do result[item] = true end
	end
end

function M.tostring(set)
	local items = {}
	for item in pairs(set) do
		items[#items+1] = tostring(item)
	end
	return string.format('{%s}', table.concat(items, ', '))
end


---[ Metamethods ]-------------------------------------------------------------
mt.__add = M.union
mt.__tostring = M.tostring

return M
