---@type fun(x: (fun(): integer), y: fun(z: fun()))

---@type { key1: { key2: { [string]: table<number, number | integer> }, [integer]: integer } }

---@type table<integer | number, table<string, table<number, boolean>>>

---@class test
---@field a boolean
---@field b (((boolean)))
---@field x number | string | { key: number | string | boolean } | boolean
---@field [string] boolean

---@type string[]
local _str_tbl = { 'a', 'b', 'c' }

---@param f fun(i: integer): (integer, integer)
---@return integer, integer
local function _test_fun(f)
	return f(1)
end

-- Note: The parser nests union types, which can mess
-- with rainbow-delimiters highlighting, so we don't
-- highlight the '|' here:
---@type number | integer[] | string | number[] | string[] | boolean | boolean[]
local _x = 1
---@type boolean[] | integer[]
local _t = { true, false } or { 0, 1 }
---@type (boolean | integer)[]
local _arr = { true, 0 }
