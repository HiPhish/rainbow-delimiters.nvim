-- Add the plugin itself to the runtime path so we can use it in our tests.
vim.opt.runtimepath:append(vim.fn.getcwd())

-- Tree-sitter highlighting needs to be running, otherwise rainbow highlighting
-- won't get updated on tree changes.  The following autocommand enables it on
-- every file type change.


local function on_file_type(_args)
	vim.treesitter.start()
end


vim.api.nvim_create_autocmd('FileType', {pattern = '*', callback = on_file_type})
