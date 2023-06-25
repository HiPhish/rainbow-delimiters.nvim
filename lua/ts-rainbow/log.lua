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

---Logger module for rainbow delimiters.  Logs any message whose log level is
---equal to or greater than the log level of the module.
local M = {}

local levels = vim.log.levels
local stdpath = vim.fn.stdpath
local date = os.date

---Log level of the module, see `:h log_levels`.
M.level = levels.WARN
---File name of the log file
M.log_file = stdpath('log') .. '/rainbow-delimiters'

local function log(level, message, ...)
	if level < M.level then return end

	local file = io.open(M.log_file, 'a+')
	-- Intentional: Silently discard the log if the log file cannot be opened
	if not file then return end

	local msg
	local timestamp = date('%FT%H:%M%z')
	if type(message) == 'function' then
		msg = string.format('%s: ', timestamp, msg(...))
	else
		msg = string.format('%s: ' .. message, timestamp , ...)
	end
	file:write(msg)
	-- TODO: Should I also print the message?
end

---Log an error message
function M.error(message, ...)
	log(vim.log.levels.ERROR, message, ...)
end

---Log a warning message
function M.warn(message, ...)
	log(vim.log.levels.WARN, message, ...)
end

---Log a tracing message
function M.debug(message, ...)
	log(vim.log.levels.DEBUG, message, ...)
end

---Log a tracing message
function M.trace(message, ...)
	log(vim.log.levels.TRACE, message, ...)
end

---Log an info message
function M.info(message, ...)
	log(vim.log.levels.INFO, message, ...)
end

---Temporarily set the log level to the given one and apply the thunk.
function M.with_level(level, thunk)
	local old_level = M.level
	M.level = level
	pcall(thunk)
	M.level = old_level
end

return M
