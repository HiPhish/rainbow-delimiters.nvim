local get_runtime_file = vim.api.nvim_get_runtime_file
local parser_pattern = 'parser/%s.*'

---Wrapper around the `:TSinstall` command which will only install a parser if
---it is not installed yet
---@param lang string  Language to install
function TSEnsure(lang, ...)
	for _, l in ipairs({lang, ...}) do
		local parsers = get_runtime_file(parser_pattern:format(l), true)
		if #parsers == 0 then
			vim.cmd {cmd = 'TSInstallSync', args = {l}}
		end
	end
end
