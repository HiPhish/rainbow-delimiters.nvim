---A dummy strategy which can be used for testing
local M = {}

---Keeping track of buffers which have this strategy registered
M.buffers = {}

M.on_attach = function(bufnr, settings)
	M.buffers[bufnr] = settings
end

M.on_detach = function(bufnr)
	M.buffers[bufnr] = nil
end

return M
