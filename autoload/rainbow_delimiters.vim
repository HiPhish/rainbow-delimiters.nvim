" SPDX-License-Identifier: Apache-2.0

"  Copyright 2023 Alejandro "HiPhish" Sanchez
"
"  Licensed under the Apache License, Version 2.0 (the "License");
"  you may not use this file except in compliance with the License.
"  You may obtain a copy of the License at
"
"      http://www.apache.org/licenses/LICENSE-2.0
"
"  Unless required by applicable law or agreed to in writing, software
"  distributed under the License is distributed on an "AS IS" BASIS,
"  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"  See the License for the specific language governing permissions and
"  limitations under the License.

let g:rainbow_delimiters#strategy = {
	\ 'global': luaeval("require 'rainbow-delimiters.strategy.global'"),
	\ 'local':  luaeval("require 'rainbow-delimiters.strategy.local'"),
	\ 'noop':   luaeval("require 'rainbow-delimiters.strategy.no-op'"),
\ }

" Get the appropriate highlight group for the given level of nesting.
function! rainbow_delimiters#hlgroup_at(i)
	return luaeval("require('rainbow-delimiters').hlgroup_at(_A)", a:i)
endfunction

" Disable highlighting for the given buffer. Buffer number zero means current
" buffer.
function! rainbow_delimiters#disable(bufnr)
	call luaeval("require('rainbow-delimiters').disable(_A)", a:bufnr)
endfunction

" Enable highlighting for the given buffer. Buffer number zero means current
" buffer.
function! rainbow_delimiters#enable(bufnr)
	call luaeval("require('rainbow-delimiters').enable(_A)", a:bufnr)
endfunction

" Toggle highlighting for the given buffer. Buffer number zero means current
" buffer.
function! rainbow_delimiters#toggle(bufnr)
	call luaeval("require('rainbow-delimiters').toggle(_A)", a:bufnr)
endfunction

" Check if highlighting is enabled for the given buffer. Buffer number zero
" means current buffer.
function! rainbow_delimiters#is_enabled(bufnr)
	return luaeval("require('rainbow-delimiters').is_enabled(_A)", a:bufnr)
endfunction

" vim:tw=79:ts=4:sw=4:noet:
