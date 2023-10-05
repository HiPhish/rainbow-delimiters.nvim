--[[
   Copyright 2023 Alejandro "HiPhish" Sanchez

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--]]

---Internal helper functions.  This module will probably be removed when I no
---longer need the helpers.
local M = {}


---Similar to the function `LanguageTree:for_each_child` which has been
---deprecated.  Applies the thunk to the language tree and each of its
---descendants recursively.
---
---See also https://github.com/neovim/neovim/pull/25154 for a better
---replacement.
function M.for_each_child(lang, language_tree, thunk)
	thunk(language_tree, lang)
	local children = language_tree:children()
	for child_lang, child in pairs(children) do
		M.for_each_child(child_lang, child, thunk)
	end
end

return M
