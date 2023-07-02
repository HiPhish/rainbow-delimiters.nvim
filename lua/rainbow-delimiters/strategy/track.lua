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

---A strategy decorator; the decorated strategy keeps track of all currently
---attached buffers.  Thew new strategy has the following fields:
---
--- - strategy     The wrapped strategy object
--- - buffers      Table mapping of buffer number to buffer settings
--- - attachments  Number of currently active attachments
---
---@param strategy table
local function track(strategy)
	local buffers = {}
	local attachments = {0}  -- Table because I want to pass it by reference

	return {
		strategy = strategy,
		buffers = buffers,
		attachments = attachments,
		on_attach = function(bufnr, settings, ...)
			buffers[bufnr] = settings
			attachments[1] = attachments[1] + 1
			strategy.on_attach(bufnr, settings, ...)
		end,
		on_detach = function(bufnr, ...)
			buffers[bufnr] = nil
			attachments[1] = attachments[1] - 1
			strategy.on_detach(bufnr, ...)
		end
	}
end

return track

-- vim:tw=79:ts=4:sw=4:noet:
