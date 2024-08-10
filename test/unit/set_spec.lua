local Set = require 'rainbow-delimiters.set'

describe('The set data structure', function()
	describe('The empty set', function()
		---@type rainbow_delimiters.Set
		local set

		before_each(function() set = Set.new() end)

		it('Can instantiate the empty set', function()
			assert.is_not._nil(set)
		end)

		it('Is empty', function()
			assert.is_equal(0, set:size())
		end)

		it('Can add items to the set', function()
			set:add(1)
			set:add(2)
			assert.is_equal(2, set:size())
		end)

		it('Adds items idempotently', function()
			set:add(1)
			set:add(1)
			assert.is_equal(1, set:size())
		end)

		it('Produces nothing when iterated over', function()
			local count = 0
			for _ in set:items() do
				count = count + 1
			end
			assert.are_equal(0, count)
		end)
	end)

	describe('Set with contents', function()
		---@type rainbow_delimiters.Set
		local set

		before_each(function()
			set = Set.new(1, 2, 3, 4)
		end)

		it('Can instantiate set with contents', function()
			assert.is_not._nil(set)
		end)

		it('Holds the correct amount of items', function()
			assert.is_equal(4, set:size())
		end)

		it('Tests positively for existing items', function()
			assert.is_true(set:contains(1))
		end)

		it('Tests negatively for missing items', function()
			assert.is_false(set:contains(0))
		end)
	end)

	describe('Set traversal', function()
		---@type rainbow_delimiters.Set
		local set

		before_each(function()
			set = Set.new(1, 2, 3, 4)
		end)

		it('Returns all contents one at a time', function()
			local items = {}
			for item in set:items() do
				items[item] = 1 + (items[item] or 0)
			end

			assert.are_equal(1, items[1])
			assert.are_equal(1, items[2])
			assert.are_equal(1, items[3])
			assert.are_equal(1, items[4])

			local n_items = 0
			for _, _ in pairs(items) do
				n_items = n_items + 1
			end
			assert.are_equal(4, n_items)
		end)
	end)
end)
