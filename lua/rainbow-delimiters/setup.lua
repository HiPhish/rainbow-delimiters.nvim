---Apply the given configuration to the rainbow-delimiter settings.  Will
---overwrite existing settings.
---
--- @param config table  Settings, same format as `vim.g.rainbow_delimiters`
return function(config)
	vim.g.rainbow_delimiters = config
end
