-- SPDX-FileCopyrightText: © 2026 HiPhish
-- SPDX-License-Identifier: 0BSD


local post_install_actions = {
	['tree-sitter-jinja2'] = function (evt)
		local cmd = {'tree-sitter', 'build', '--output', 'parser/jinja2.so'}
		local opts = {
			cwd = evt.data.path
		}
		vim.system(cmd, opts)
	end
}

vim.api.nvim_create_autocmd('PackChanged', { callback = function (evt)
	for name, action in pairs(post_install_actions) do
		local data = evt.data
		if name == data.spec.name and (data.kind == 'install' or data.kind == 'update') then
			action(evt)
		end
	end
end })

return {
	{
		src = 'https://github.com/nvim-treesitter/nvim-treesitter',
		version = 'main',
	}, {
		src = 'https://gitlab.com/HiPhish/yo-dawg.nvim.git',
		version = 'master',
	}, {
		-- Custom grammar for language 'htmljinja'
		src = 'https://github.com/geigerzaehler/tree-sitter-jinja2',
		version = 'main',
	}
}
