-- SPDX-License-Identifier: Apache-2.0

-- The visible strategy highlights only the delimiters which are currently
-- visible in the window and refreshes them whenever the cursor moves or the
-- window scrolls.  Re-highlighting every visible line on each of those events
-- is wasteful, so we keep a per-buffer cache of the row ranges which have
-- already been highlighted.  When the visible region changes only the rows
-- which are not yet cached are highlighted; moving the cursor around within
-- lines that have already been rendered therefore does no work at all.
--
-- A text change invalidates the cache from the first changed row downwards --
-- rows above an edit never move, so their highlighting stays valid -- and the
-- affected rows are highlighted again on the next update.

local api = vim.api

local config = require 'rainbow-delimiters.config'
local future_spawn = require 'rainbow-delimiters.strategy.visible.future_spawn'
local hl_epoch = require 'rainbow-delimiters.strategy.visible.hl-epoch'
local hl_node = require 'rainbow-delimiters.strategy.visible.hl-node'
local hl_range = require 'rainbow-delimiters.strategy.visible.hl-range'
local lib = require 'rainbow-delimiters.lib'
local log = require 'rainbow-delimiters.log'
local util = require 'rainbow-delimiters.util'

---Highlight visible rows.
---@param bufnr integer
---@param parser vim.treesitter.LanguageTree
local function hl_visible(bufnr, epoch, parser)
	if vim.fn.pumvisible() ~= 0 then return end

	local winnr = api.nvim_get_current_win()
	local top = vim.fn.line('w0', winnr) - 1
	local bot = vim.fn.line('w$', winnr)

	if #hl_range.gaps(bufnr, top, bot) == 0 then return end

	local function is_stale()
		return
			not api.nvim_buf_is_loaded(bufnr) or
			not lib.buffers[bufnr] or
			hl_epoch.current(bufnr) ~= epoch
	end

	parser:parse({ top, bot }, function(err)
		if is_stale() or err ~= nil then return end

		for _, gap in ipairs(hl_range.gaps(bufnr, top, bot)) do
			local g_top, g_bot = gap[1], gap[2]

			-- Cache up front so concurrent updates do not queue the same work twice.
			local removed = false
			hl_range.insert(bufnr, g_top, g_bot)

			parser:for_each_tree(function(tree, sub_parser)
				local lang = sub_parser:lang()
				if not lib.enabled_for(lang) then return end

				local query = lib.get_query(lang, bufnr)
				if not query then return end

				local nsid = lib.nsids[lang]
				local priority = config.priority[lang]
				if type(priority) == "function" then
					priority = priority(bufnr)
				end

				local root = tree:root()
				future_spawn {
					poll = hl_node(query, root, bufnr, g_top, g_bot, nsid, priority),
					is_stale = is_stale,
					on_stale = function()
						if not removed then
							hl_range.remove(bufnr, g_top, g_bot)
							removed = true
							if
								api.nvim_buf_is_loaded(bufnr) and
								lib.buffers[bufnr] and
								lib.buffers[bufnr].parser == parser
							then
								hl_visible(bufnr, hl_epoch.current(bufnr), parser)
							end
						end
					end
				}
			end)
		end
	end)
end

---Register the change callbacks for the parser and all of its children.  This
---does not highlight anything; the caller triggers highlighting separately so
---that the function is safe to call from within an `on_child_added` callback.
---@param bufnr integer
---@param parser vim.treesitter.LanguageTree
---@param start_parent_lang string?
local function setup_parser(bufnr, parser, start_parent_lang)
	log.debug('Setting up parser for buffer %d', bufnr)

	---Sets up an individual parser for a particular language
	---@param lang_parser vim.treesitter.LanguageTree
	---@param lang string
	local function f(lang_parser, lang)
		log.debug("Setting up parser for '%s' in buffer %d", lang, bufnr)

		-- Skip languages which are not supported, otherwise we get a
		-- nil-reference error
		if not lib.get_query(lang, bufnr) then return end

		local nsid = lib.nsids[lang]
		local pendings = {}

		lang_parser:register_cbs {
			on_bytes = function(_, _, from, _, _, offset_old, _, _, offset_new)
				pendings[#pendings + 1] = { from, offset_old, offset_new }
			end,
			on_changedtree = function(ranges)
				local need_hl = false
				if #ranges == 0 and #pendings > 0 then
					-- Changes does not affect tree levels,
					-- but highlighted ranges needs to be updated.
					for _, pending in ipairs(pendings) do
						need_hl = need_hl or pending[2] ~= pending[3]
						hl_range.changed(bufnr, pending[1], pending[2], pending[3])
					end
				else
					need_hl = #ranges > 0
					for _, range in ipairs(ranges) do
						local from = range[1]
						local to = range[3]
						if #range == 6 then
							to = range[4]
						end
						hl_range.remove(bufnr, from, to)
						vim.api.nvim_buf_clear_namespace(bufnr, nsid, from, to)
					end
				end
				pendings = {}

				if need_hl then
					hl_visible(bufnr, hl_epoch.bump(bufnr), lib.buffers[bufnr].parser)
				end
			end,
			on_child_added = function(child)
				setup_parser(bufnr, child, lang)
			end,
		}

		log.trace("Done with setting up parser for '%s' in buffer %d", lang, bufnr)
	end

	-- A buffer has one primary language and potentially many child languages
	-- which may have child languages of their own.  We need to set up the
	-- parser for each of them.  Highlighting is left to the caller so that this
	-- function is safe to call from within an `on_child_added` callback.
	util.for_each_child(start_parent_lang, parser:lang(), parser, f)
end

---Reusable autogroup for events in this strategy.
---@type integer
local augroup = api.nvim_create_augroup('TSRainbowVisibleStrategy', {})

---@param bufnr integer
---@param settings rainbow_delimiters.buffer_settings
local function on_attach(bufnr, settings)
	log.trace('visible strategy on_attach for buffer %d', bufnr)

	local parser = settings.parser
	setup_parser(bufnr, parser, nil)
	hl_visible(bufnr, hl_epoch.bump(bufnr), parser)

	api.nvim_create_autocmd('WinScrolled', {
		group = augroup,
		buffer = bufnr,
		callback = function()
			hl_visible(bufnr, hl_epoch.current(bufnr), parser)
		end
	})
end

---@param bufnr integer
local function on_detach(bufnr)
	log.trace('visible strategy on_detach for buffer %d', bufnr)

	hl_range.clear(bufnr)
	hl_epoch.clear(bufnr)
	api.nvim_clear_autocmds { buffer = bufnr, group = augroup }
end

---@param bufnr integer
---@param settings rainbow_delimiters.buffer_settings
local function on_reset(bufnr, settings)
	log.trace('visible strategy on_reset for buffer %d', bufnr)

	hl_range.clear(bufnr)
	local parser = settings.parser
	util.for_each_child(nil, parser:lang(), parser, function(_, lang)
		lib.clear_namespace(bufnr, lang)
	end)
	hl_visible(bufnr, hl_epoch.bump(bufnr), parser)
end

---Strategy which highlights the delimiters visible in the current window.
---@type rainbow_delimiters.strategy
return {
	on_attach = on_attach,
	on_detach = on_detach,
	on_reset = on_reset,
}
