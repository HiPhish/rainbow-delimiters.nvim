local M = {}

local jobopts = {
	rpc = true,
	width = 80,
	height = 24,
}

---Start the remote Neovim process.
function M.start_embedded()
	-- The `--embed` flag lets us control Neovim through RPC, the `--headless`
	-- flag tells it not to wait for a UI to attach and start loading plugins
	-- and configuration immediately.
	return vim.fn.jobstart({'nvim', '--embed', '--headless'}, jobopts)
end

function M.stop_embedded(nvim)
	vim.rpcnotify(nvim, 'nvim_cmd', {cmd = 'quitall', bang = true}, {})
	vim.fn.jobwait({nvim})
end

return M
