-- SPDX-License-Identifier: Apache-2.0

-- Cooperative, incremental highlighting.  Highlighting a whole buffer -- or even
-- just a large visible region -- can involve thousands of extmarks; doing it all
-- in one go blocks the editor.  Instead a highlighting pass is expressed as a
-- `poll` function which performs one small unit of work per call and returns
-- whether any work remains.  Futures are drained one time slice at a time on a
-- libuv timer, yielding back to the editor in between.
--
-- Futures are processed newest-first (the pending futures form a stack).  When
-- the user scrolls or edits, the freshest request -- the region they are looking
-- at right now -- preempts older, now less relevant work, so highlighting feels
-- real-time.  Preemption happens at slice boundaries: a future interrupted this
-- way keeps the progress of its `poll` and resumes once the newer futures are
-- done.

local uv = vim.uv or vim.loop

---Nanoseconds of work to perform before yielding back to the event loop.
local BUDGET_NS = 1000000 -- 1 ms

---How often (in `poll` calls) to consult the clock.  Reading the clock on every
---call would dominate the tiny per-call work, so we only check periodically.
local CHECK_EVERY = 100

---@class rainbow_delimiters.future.Future
---@field poll fun(): boolean One unit of work; returns whether more remains
---@field is_stale fun(): boolean The future is dropped if this returns true
---@field on_stale? fun() Function to run if the future is stale.

---Pending futures, processed from the top (most recently submitted) down.
---@type rainbow_delimiters.future.Future[]
local futures = {}
local timer = assert(uv.new_timer())
local pending = false

---Process pending futures, newest first, until the time budget for this slice is
---used up, then reschedule for the next event loop iteration.  A slice runs to
---completion without yielding, so the stack only ever changes between slices --
---which is what lets a future submitted in the meantime be served first.
local function schedule()
	local deadline = uv.hrtime() + BUDGET_NS
	local n = 0

	while #futures > 0 do
		n = n + 1

		-- Always take the most recent submission.
		local fut = futures[#futures]

		if fut.is_stale() then
			futures[#futures] = nil
			if fut.on_stale ~= nil then
				fut.on_stale()
			end
		else
			while true do
				n = n + 1

				if not fut.poll() then
					futures[#futures] = nil
					break
				end

				if n % CHECK_EVERY == 0 and uv.hrtime() > deadline then
					timer:start(0, 0, vim.schedule_wrap(schedule))
					return
				end
			end
		end

		if n % CHECK_EVERY == 0 and uv.hrtime() > deadline then
			timer:start(0, 0, vim.schedule_wrap(schedule))
			return
		end
	end

	pending = false
end

---Submit a future.  It becomes the new top of the stack and is picked up on the
---next event loop iteration, ahead of any older pending work.
---@param fut rainbow_delimiters.future.Future
return function(fut)
	futures[#futures + 1] = fut
	if not pending then
		pending = true
		schedule()
	end
end
