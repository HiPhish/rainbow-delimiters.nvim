-- SPDX-License-Identifier: Apache-2.0

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

---A dummy strategy which does nothing; can be used in testing.
local M = {}

---on_attach implementation for the noop strategy
---@param _bufnr integer
---@param _settings rainbow_delimiters.buffer_settings
M.on_attach = function(_bufnr, _settings)
end

---on_detach implementation for the noop strategy
---@param _bufnr integer
M.on_detach = function(_bufnr)
end

---on_reset implementation for the noop strategy
---@param _bufnr integer
---@param _settings rainbow_delimiters.buffer_settings
M.on_reset = function(_bufnr, _settings)
end

return M --[[@as rainbow_delimiters.strategy]]

-- vim:tw=79:ts=4:sw=4:noet:
