---Install one or more languages synchronously.
---@param lang string | string[]  One or more languages to install
function EnsureTSParser(lang, timeout)
	local nts = require 'nvim-treesitter'
	timeout = timeout or 2 * 60 * 1000
	local result = nts.install(lang):wait(timeout)
	if not result then
		local msg = string.format('Error installing Tree-sitter parsers: %s', vim.inspect(lang))
		error(msg)
	end
end
