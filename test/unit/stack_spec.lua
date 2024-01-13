local Stack = require 'rainbow-delimiters.stack'

describe('The stack data structure #stack', function()
	describe('The empty stack', function()
		local stack

		before_each(function() stack = Stack.new() end)

		it('Can instantiate an empty stack', function()
			assert.is_not._nil(stack)
		end)

		it('Is empty', function()
			assert.is.equal(0, stack:size())
		end)

		it('Can push items onto the stack', function ()
			stack:push('a')
			stack:push('b')
			assert.is.equal(2, stack:size())
		end)
	end)

	describe('Stack with contents', function()
		local stack, items

		before_each(function()
			items = {'a', 'b', 'c', 'd'}
			stack = Stack.new(items)
		end)

		it('Can instantiate stack with contents', function()
			assert.is_not._nil(stack)
		end)

		it('Holds the correct amount of items', function()
			assert.is.equal(4, stack:size())
		end)

		it('Can inspect the topmost element', function ()
			local top = stack:peek()
			assert.is.equal('d', top)
		end)

		it('Can pop items off the stack in reverse order', function()
			for i = 3, 0, -1 do
				local val = stack:pop()
				assert.is.equal(items[i + 1], val)
				assert.is.equal(i, stack:size())
			end
		end)

		it('Can push an item onto the stack', function()
			local val = 'e'
			stack:push(val)
			assert.is.equal(5, stack:size())
			assert.is.equal(val, stack:pop())
		end)
	end)

	describe('Stack traversal', function()
		it('Traverses the stack from top to bottom', function()
			local counter = 1
			local expected_indices = {4, 3, 2, 1}
			local expected_values  = {'d', 'c', 'b', 'a'}

			local stack = Stack.new {'a', 'b', 'c', 'd'}
			for i, v in stack:iter() do
				local index = expected_indices[counter]
				local value = expected_values[ counter]
				assert.is.equal(index, i)
				assert.is.equal(value, v)
				counter = counter + 1
			end
		end)

		it('Does nothing for an empty stack', function()
			local stack = Stack.new()
			for _i, _v in stack:iter() do
				-- This must never run because the stack is empty
				assert.is_true(false)
			end
		end)
	end)
end)
