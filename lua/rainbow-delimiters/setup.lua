-- SPDX-License-Identifier: Apache-2.0

local M = {}

---Apply the given configuration to the rainbow-delimiter settings.  Will
---overwrite existing settings.
---
---@param opts rainbow_delimiters.config  Settings, same format as `vim.g.rainbow_delimiters`
function M.setup(opts)
	vim.g.rainbow_delimiters = opts
end


-- Make it possible to call the module directly; for backwards compatibility
-- with a previous version of this module.
setmetatable(M, {__call = function(_t, opts) M.setup(opts) end})
return M

-- vim:tw=79:ts=4:sw=4:noet:
