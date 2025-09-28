-- Test dependencies
vim.pack.add {
	{
		src = 'https://github.com/nvim-treesitter/nvim-treesitter',
		version = 'main',
	}, {
		src = 'https://gitlab.com/HiPhish/yo-dawg.nvim.git',
		version = 'master',
	},
}

-- Add the plugin itself to the runtime path so we can use it in our tests.
vim.opt.runtimepath:append(vim.fn.getcwd())

-- Tree-sitter highlighting needs to be running, otherwise rainbow highlighting
-- won't get updated on tree changes.  The following autocommand enables it on
-- every file type change.


local function on_buf_win_enter(_args)
	if vim.bo.filetype ~= '' then
		vim.treesitter.start()
	end
end


vim.api.nvim_create_autocmd('BufWinEnter', {pattern = '*', callback = on_buf_win_enter})
