-- SPDX-License-Identifier: Apache-2.0

--[[
   Copyright 2024 Alejandro "HiPhish" Sanchez

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

---A set-like structure which holds any number of items, but only one of each.
---@generic T
---@class rainbow_delimiters.Set<T>
---
---Add an item to the set; this function is idempotent: adding an item more
---than once produces the same result
---@field public add   fun(self: rainbow_delimiters.Set, item: `T`): nil
---
---Predicate whether the set currently contains a given item
---@field public contains fun(self: rainbow_delimiters.Set, item: `T`): boolean
---
---Returns the current size of the set
---@field public size fun(self: rainbow_delimiters.Set): integer
---@field package content `T`[]
---
---Iterator which returns the contents one at a time in an arbitrary order.
---@field public items fun(self: rainbow_delimiters.Set): ((fun(content: table<`T`, true>, key: `T`): `T`), table<`T`, true>)


local function size(self)
	local result = 0
	for _, _ in pairs(self.content) do
		result = result + 1
	end
	return result
end

local function add(self, item)
	self.content[item] = true
end

local function contains(self, item)
	return self.content[item] == true
end

---Wrapper around the built-in `next`, except that it only returns the key.
local function iter(t, k)
	local result = next(t, k)
	return result
end

local function items(self)
	return iter, self.content
end

local function pick_key(key, _value)
	return key
end

local mt = {
	---A human-readable representation of a set like `'Set{1, 2, "a", "b"}'`
	---@param self rainbow_delimiters.Set
	---@return string
	__tostring = function(self)
		local keys = vim.iter(self.content)
			:map(pick_key)
			:map(tostring)
			:join(', ')
		return string.format('Set{%s}', keys)
	end
}

---@return rainbow_delimiters.Set set  The new set instance
function M.new(...)
	---@type rainbow_delimiters.Set
	local result = {
		content  = {},
		size     = size,
		add      = add,
		contains = contains,
		items    = items,
	}
	for _, item in ipairs({...}) do
		result.content[item] = true
	end
	setmetatable(result, mt)
	return result
end

return M
