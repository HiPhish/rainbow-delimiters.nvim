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

---Helper library for stack-like tables.
local M = {}

---@class (exact) Stack
---@field public  size    fun(self: Stack): integer
---@field public  peek    fun(self: Stack): any
---@field public  push    fun(self: Stack, item: any): Stack
---@field public  pop     fun(self: Stack): any
---@field public  iter    fun(self: Stack): ((fun(i: integer, item: any): integer?, any), Stack, integer)
---@field package content any[]

---The stack metatable.
local mt = {}

---The actual iterator implementation, hidden behind the iter-method.
---@param stack Stack
---@param i integer
---@return integer?
---@return any
local function iter_stack(stack, i)
	if i <= 1 then return end
	return i - 1, stack.content[i - 1]
end

---@param stack Stack
---@return string
local function stack_tostring(stack)
	local items = {}
	for _, item in ipairs(stack.content) do
		items[#items + 1] = tostring(item)
	end
	return string.format('[%s]', table.concat(items, ', '))
end


---[ Methods ]-----------------------------------------------------------------

---Returns the current number of items in the stack.
---@param self Stack
---@return integer size  Current size of the stack
local function size(self)
	return #self.content
end

---Iterate through the content of the stack from top to bottom. Each iteration
---returns the current index (one-based, counting from the bottom) and the
---current item.
---@param self Stack  The stack instance
---@return fun(i: integer, stack: Stack): integer?, any
---@return Stack
---@return integer
local function iter(self)
	return iter_stack, self, self:size() + 1
end

---Add a new item to the top of the stack. Modifies the stack in-place.
---@param item any  The item to push onto the stack
---@return Stack stack  The stack.
local function push(self, item)
	self.content[self:size() + 1] = item
	return self
end

---Returns the topmost item of the stack without altering the stack.
---@return any top  The top-most item.
local function peek(self)
	local result = self.content[self:size()]
	return result
end

---Returns the topmost item of the stack and removes it from the stack.
---@return any top  The top-most item.
local function pop(self)
	local n = self:size()
	local result = self.content[n]
	self.content[n] = nil
	return result
end


---[ Public module interface ]-------------------------------------------------

---Instantiates a new stack containing the given items, or the empty stack if
---the argument is `nil`.
---@param items any[]?  Array of items in order from bottom to top
---@return Stack stack  The new stack instance
function M.new(items)
	---@type Stack
	local result = {
		content = {},
		size    = size,
		iter    = iter,
		push    = push,
		pop     = pop,
		peek    = peek,
	}
	setmetatable(result, mt)
	for _, item in ipairs(items or {}) do result:push(item) end
	return result
end

---[ Metamethods ]-------------------------------------------------------------
mt.__tostring = stack_tostring

return M


-- vim:tw=79:ts=4:sw=4:noet:
