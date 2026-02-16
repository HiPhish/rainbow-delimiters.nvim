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

---Logger module for rainbow delimiters.  Logs any message whose log level is
---equal to or greater than the log level of the module.
local M = {}

local date = os.date
local levels = vim.log.levels
local config = require 'rainbow-delimiters.config'

---Reverse lookup table; maps a log level to its text label
local level_str = {}
for key, value in pairs(levels) do
	level_str[value] = key
end

---Dynamically determines the module from which the log function was called.
---If it was called from somewhere else return the name of the plugin.
---@return string
local function get_module()
	local module = debug.getinfo(4, 'S').source:match('^.+rainbow%-delimiters/(.+).lua$')
	if not module then
		return ''
	end
	return module:gsub('/', '.')
end

---@param file file*
---@param level integer
---@param module string
---@param message any
---@param ... any
local function write_log(file, level, module, message, ...)
	local msg
	local timestamp = date('%FT%H:%M%z')
	if type(message) == 'function' then
		msg = message()
	else
		msg = string.format(message, ...)
	end

	file:write(string.format('%s	%s	%s	%s\n', timestamp, level, module, msg))
end

---@param level integer
---@param message any
---@param ... any
local function log(level, message, ...)
	if level < config.log.level then return end

	local file = io.open(config.log.file, 'a+')
	-- Intentional: Silently discard the log if the log file cannot be opened
	if not file then return end

	-- Wrap inside a pcall to make sure the file gets closed even if an error
	-- occurs
	pcall(write_log, file, level_str[level], get_module(), message, ...)
	file:close()
	-- Should I also print the message?
end

---Log an error message
function M.error(message, ...)
	log(levels.ERROR, message, ...)
end

---Log a warning message
function M.warn(message, ...)
	log(levels.WARN, message, ...)
end

---Log a tracing message
function M.debug(message, ...)
	log(levels.DEBUG, message, ...)
end

---Log a tracing message
function M.trace(message, ...)
	log(levels.TRACE, message, ...)
end

---Log an info message
function M.info(message, ...)
	log(levels.INFO, message, ...)
end

return M

-- vim:tw=79:ts=4:sw=4:noet:
