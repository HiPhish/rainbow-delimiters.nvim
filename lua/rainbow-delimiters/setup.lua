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
setmetatable(M, {__call = M.setup})
return M

-- vim:tw=79:ts=4:sw=4:noet:
