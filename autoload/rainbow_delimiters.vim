let g:rainbow_delimiters#strategy = {
	\ 'global': luaeval("require 'rainbow-delimiters.strategy.global'"),
	\ 'local':  luaeval("require 'rainbow-delimiters.strategy.local'"),
	\ 'noop':   luaeval("require 'rainbow-delimiters.strategy.no-op'"),
\ }

" Get the appropriate highlight group for the given level of nesting.
function! rainbow_delimiters#hlgroup_at(i)
	return luaeval("require('rainbow-delimiters').hlgroup_at(_A)", a:i)
endfunction
