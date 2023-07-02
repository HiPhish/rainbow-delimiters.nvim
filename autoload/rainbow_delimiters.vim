let g:rainbow_delimiters#strategy = {
	\ 'global': luaeval("require 'rainbow-delimiters.strategy.global'"),
	\ 'local':  luaeval("require 'rainbow-delimiters.strategy.local'"),
	\ 'noop':   luaeval("require 'rainbow-delimiters.strategy.no-op'"),
\ }
