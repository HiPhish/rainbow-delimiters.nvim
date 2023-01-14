--[[
   Copyright 2023 Alejandro "HiPhish" Sanchez
   Copyright 2020-2022 Chinmay Dalal

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

---Private library of shared internal functions and variables.
local M = {}

---Default query name to use
M.query = 'rainbow-parens'

---Namespace reserved for this plugin
M.nsid = vim.api.nvim_create_namespace("rainbow_ns")

---Keeps track of attached buffers.  The key is the buffer number and the value
---is a table of information about that buffer (e.g. language, strategy,
---query).  This also makes sure we keep track of all parsers in active use to
---prevent them from being garbage-collected.
M.buffers = {}

return M
-- vim:tw=79:ts=4:sw=4:noet:
