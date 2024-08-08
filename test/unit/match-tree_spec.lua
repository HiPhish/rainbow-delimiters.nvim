local MatchTree = require 'rainbow-delimiters.match-tree'

---Constructor for fake TSNode objects which implement the subset of the read
---node interface which we need.
local function make_node(start_row, start_col, end_row, end_col)
	return {
		range = function(_self)
			return start_row, start_col, end_row, end_col
		end
	}
end

local fake_query = {
	captures = {'delimiter', 'container', 'sentinel'}
}

local function make_matchtree(match)
	return MatchTree.assemble(fake_query, match)
end

describe('The match tree data structure', function()
	describe('Relationship comparison', function()
		it('is is less for an ancestor', function()
			local ancestor = make_matchtree {
				[2] = {make_node(0, 0, 10, 10)}
			}
			local descendant = make_matchtree {
				[2] = {make_node(1, 1, 9, 9)}
			}
			assert.is_true(ancestor < descendant)
		end)

		it('is is not greater for an ancestor', function()
			local ancestor = make_matchtree {
				[2] = {make_node(0, 0, 10, 10)}
			}
			local descendant = make_matchtree {
				[2] = {make_node(1, 1, 9, 9)}
			}
			assert.is_false(ancestor > descendant)
		end)

		it('is is greater for a descendant', function()
			local ancestor = make_matchtree {
				[2] = {make_node(0, 0, 10, 10)}
			}
			local descendant = make_matchtree {
				[2] = {make_node(1, 1, 9, 9)}
			}
			assert.is_true(descendant > ancestor)
		end)

		it('is is not less for a descendant', function()
			local ancestor = make_matchtree {
				[2] = {make_node(0, 0, 10, 10)}
			}
			local descendant = make_matchtree {
				[2] = {make_node(1, 1, 9, 9)}
			}
			assert.is_false(descendant < ancestor)
		end)

		it('is is neither greater nor less for cousins', function()
			local tree1 = make_matchtree {
				[2] = {make_node(0, 0, 10, 10)}
			}
			local tree2 = make_matchtree {
				[2] = {make_node(11, 11, 19, 19)}
			}
			assert.is_false(tree1 < tree2)
			assert.is_false(tree1 > tree2)
		end)
	end)

	describe('Appending trees', function()
		it('appends a child directly', function()
			local parent = make_matchtree {
				[2] = {make_node(0, 0, 10, 10)}
			}
			local child = make_matchtree {
				[2] = {make_node(1, 1, 9, 9)}
			}

			assert.is_true(parent(child))
			assert.is_true(parent.children:contains(child))
		end)

		it('does not append to a cousin', function()
			local tree1 = make_matchtree {
				[2] = {make_node(0, 0, 10, 10)}
			}
			local tree2 = make_matchtree {
				[2] = {make_node(11, 11, 19, 19)}
			}
			assert.is_false(tree1(tree2))
			assert.is_false(tree1.children:contains(tree2))
		end)

		it('appends a grandchild transitively', function()
			local parent = make_matchtree {
				[2] = {make_node(0, 0, 10, 10)}
			}
			local child = make_matchtree {
				[2] = {make_node(1, 1, 9, 9)}
			}
			local grandchild = make_matchtree {
				[2] = {make_node(2, 2, 8, 8)}
			}

			parent(child)
			parent(grandchild)
			assert.is_false(parent.children:contains(grandchild))
			assert.is_true(child.children:contains(grandchild))
		end)

		it('does not attach to transitive cousins', function()
			local parent = make_matchtree {
				[2] = {make_node(0, 0, 10, 10)}
			}
			local child1 = make_matchtree {
				[2] = {make_node(1, 1, 5, 5)}
			}
			local child2 = make_matchtree {
				[2] = {make_node(6, 6, 9, 9)}
			}
			local grandchild = make_matchtree {
				[2] = {make_node(2, 2, 4, 4)}
			}

			parent(child1)
			parent(child2)
			parent(grandchild)
			assert.is_false(child2.children:contains(grandchild))
			assert.is_true(child1.children:contains(grandchild))
		end)
	end)
end)
