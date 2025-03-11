# SPDX-License-Identifier: Unlicense

# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or distribute
# this software, either in source code form or as a compiled binary, for any
# purpose, commercial or non-commercial, and by any means.
#
# In jurisdictions that recognize copyright laws, the author or authors of
# this software dedicate any and all copyright interest in the software to
# the public domain.  We make this dedication for the benefit of the public
# at large and to the detriment of our heirs and successors.  We intend this
# dedication to be an overt act of relinquishment in perpetuity of all
# present and future rights to this software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
# AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <https://unlicense.org/>


.PHONY: check unit-test e2e-test highlight-test record-highlight clean

check: unit-test e2e-test highlight-test query-test

unit-test:
	@./test/bin/busted --run unit

e2e-test:
	@./test/bin/busted --run e2e

highlight-test:
ifdef LANGUAGE
	@./test/bin/busted --run highlight -t $(LANGUAGE)
else
	@./test/bin/busted --run highlight
endif

query-test:
	@./test/bin/busted --run query

# NOTE: default value empty string ensures that by default no language is
# passed because there is no language whose name is the empty string.
record-highlight:
	@# Records the extmarks for the language passed via the LANGUAGE variable.
	@# Use this from the command-line:  make record-highlight LANGUAGE=lua
ifdef LANGUAGE
	@./test/bin/lua -e 'require("rainbow-delimiters._test.highlight").record_extmarks("$(LANGUAGE)")'
else
	@echo 'Must pass a language via `LANGUAGE` variable'
	@exit 1
endif

clean:
	@rm -rf test/xdg/local/state/nvim/*
	@rm -rf test/xdg/local/share/nvim/site/pack/testing/start/nvim-treesitter/parser/*
	@# The symlink might have been left over from a failed test run
	@rm -rf test/xdg/local/share/nvim/site/pack/self-*
