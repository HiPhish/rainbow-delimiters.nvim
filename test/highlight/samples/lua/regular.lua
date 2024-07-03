-- This is a comment

local function f1(a, b)
	local function f2(a2, b2)
		return a2, b2
	end
	return f2(a, b)
end

function GlobalFunction()
	print 'This is a global function'
end

if true then
	print 'True condition'
elseif false then
	print 'Alternative condition'
elseif false then
	print 'Alternative condition'
else
	print 'Alternative'
end

while false do
	print 'A while-loop'
end

repeat
	print 'This will repeat only once'
until true

do
	print 'A block'
end

for i, v in ipairs({'a', 'b', 'c'}) do
	print(string.format("%d = %s", i, v))
end

for i = 1, 5, 1 do
	print(string.format("Number %d", i))
end

print(f1('a', 'b'))
print((((('Hello, world!')))))

print {
	{
		{
			'Hello, world!'
		}
	}
}

local one = {1}

print(one[one[one[1]]])

-- Embedded Vim script
vim.cmd [[
	echo a(b(c(d(e(f())))))
]]

local tbl = {
	["highlight me"] = {}
}
