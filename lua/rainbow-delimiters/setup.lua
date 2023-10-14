local M = {}

---Apply the given configuration to the rainbow-delimiter settings.  Will
---overwrite existing settings.
---
--- @param opts table  Settings, same format as `vim.g.rainbow_delimiters`
function M.setup(opts)
	vim.g.rainbow_delimiters = opts
end

return M
