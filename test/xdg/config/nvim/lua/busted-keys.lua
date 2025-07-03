-- Hack: if we try to launch Neovim outside a test all the automatically
-- sourced assertions and modifiers will throw an error because busted is not
-- available.  Since all those files require this module we can use it to check
-- whether we are running a test.  If the error is thrown those files can catch
-- it and return prematurely.

local is_busted = require 'busted'
if not is_busted then error 'not-busted' end

---Table of globally unique objects which can be used as state keys by busted.
local M = {
	channel = {},
	buffer = {},
	language = {},
	position = {},
}


return M
