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

---Iterate through the items of the set in an unspecified order.
local function iter(self)
	return pairs(self.content)
end

---Whether the set contains the given item.
local function contains(self, item)
	return self.content[item] ~= nil
end

---Adds a new item to the set, mutates the set in-place. This method is
---idempontent, adding an already existing item to the set does nothing.
---@param item any  The item to add.
---@return table set  The set itself.
local function add(self, item)
	self.content[item] = true
	return self
end

---Removes an item from the set, mutates the set in-place.
---@param item any  The item to remove.
---@return table set  The set itself.
local function drop(self, item)
	self.content[item] = nil
	return self
end

---Removes all items for which the given predicate is true from the set and
---returns a set of them.
---
---@param predicate function  Test function to apply to items one at a time.
---@return table items  Set of items for which the predicate holds true.
local function remove_if(self, predicate)
	local result = M.new()
	for item in self:iter() do
		if predicate(item) then
			result:add(item)
			self:drop(item)
		end
	end
	return result
end

---Instantiates a new set containing the given items, or the empty set if the
---argument is `nil`.
function M.new(items)
	local result = {
		content = {},
		contains = contains,
		add = add,
		drop = drop,
		remove_if = remove_if,
		iter = iter,
	}
	setmetatable(result, mt)
	for _, item in ipairs(items or {}) do result:add(item) end
	return result
end

---Forms the union of any number of sets, returns a new set table.
function M.union(...)
	local result = M.new()
	local sets = {...}
	for _, set in ipairs(sets) do
		for item in set:iter() do result:add(item) end
	end
	return result
end

function M.tostring(set)
	local items = {}
	for item in set:iter() do
		items[#items+1] = tostring(item)
	end
	return string.format('{%s}', table.concat(items, ', '))
end


---[ Metamethods ]-------------------------------------------------------------
mt.__add = M.union
mt.__tostring = M.tostring

return M

-- vim:tw=79:ts=4:sw=4:noet:
