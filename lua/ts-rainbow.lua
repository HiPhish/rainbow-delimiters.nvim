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

local lib = require 'ts-rainbow.lib'

---Public API for use in writing strategies or other custom code.
local M = {
	get_query = lib.get_query,
	highlight = lib.highlight,
	hlgroup_at = lib.hlgroup_at,
	node_level = lib.node_level,
	clear_namespace = lib.clear_namespace,
	---Available default highlight strategies
	strategy = {
		['global'] = require 'ts-rainbow.strategy.global',
		['local'] = require 'ts-rainbow.strategy.local',
	}
}


return M
-- vim:tw=79:ts=4:sw=4:noet:
