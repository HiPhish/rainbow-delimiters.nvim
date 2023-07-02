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

local lib = require 'rainbow-delimiters.lib'

---Public API for use in writing strategies or other custom code.
local M = {
	hlgroup_at = lib.hlgroup_at,
	---Available default highlight strategies
	strategy = {
		['global'] = require 'rainbow-delimiters.strategy.global',
		['local']  = require 'rainbow-delimiters.strategy.local',
		['noop']   = require 'rainbow-delimiters.strategy.no-op',
	}
}


return M
-- vim:tw=79:ts=4:sw=4:noet:
