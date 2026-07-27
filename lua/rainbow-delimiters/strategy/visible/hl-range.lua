-- SPDX-License-Identifier: Apache-2.0

---Highlighted range cache.
local M = {}

-- For every attached buffer we remember which rows have already been
-- highlighted.  The value is a list of `{start, stop}` pairs (zero-based,
-- end-exclusive) which is kept sorted in ascending order and free of
-- overlapping or touching ranges.
---@type table<integer, integer[][]>
local highlighted = {}

---Return the sub-ranges of `[top, bot)` which are *not* yet highlighted.
---@param bufnr integer
---@param from integer First row, inclusive
---@param to integer Last row, exclusive
---@return integer[][] gaps  List of `{start, stop}` ranges, end-exclusive
function M.gaps(bufnr, from, to)
	local gaps = {}
	if from >= to then return gaps end

	local cursor = from
	for _, range in ipairs(highlighted[bufnr] or {}) do
		if range[1] >= to then
			break
		elseif range[2] > cursor then
			if range[1] > cursor then
				gaps[#gaps + 1] = { cursor, range[1] }
			end
			cursor = range[2]
			if cursor >= to then return gaps end
		end
	end
	if cursor < to then
		gaps[#gaps + 1] = { cursor, to }
	end
	return gaps
end

---Mark `[top, bot)` as highlighted, merging it into the cached ranges.
---@param bufnr integer
---@param from integer First row, inclusive
---@param to integer Last row, exclusive
function M.insert(bufnr, from, to)
	if from >= to then return end

	local merged = {}
	local lo, hi = from, to
	local placed = false
	for _, range in ipairs(highlighted[bufnr] or {}) do
		if range[2] < lo then
			merged[#merged + 1] = range
		elseif range[1] > hi then
			if not placed then
				merged[#merged + 1] = { lo, hi }
				placed = true
			end
			merged[#merged + 1] = range
		else
			lo = math.min(lo, range[1])
			hi = math.max(hi, range[2])
		end
	end
	if not placed then
		merged[#merged + 1] = { lo, hi }
	end
	highlighted[bufnr] = merged
end

---Drop the rows in `[from, to)` from the cache so they will be highlighted
---again.  Ranges which are only partially covered are split.
---@param bufnr integer
---@param from integer First row to drop, inclusive
---@param to integer Last row to drop, exclusive (may be `math.huge`)
function M.remove(bufnr, from, to)
	if from >= to then return end

	local ranges = highlighted[bufnr]
	if ranges == nil then return end

	local kept = {}
	for _, range in ipairs(ranges) do
		if range[2] <= from or range[1] >= to then
			kept[#kept + 1] = range
		else
			if range[1] < from then
				kept[#kept + 1] = { range[1], from }
			end
			if range[2] > to then
				kept[#kept + 1] = { to, range[2] }
			end
		end
	end
	highlighted[bufnr] = kept
end

---Clear the highlight cache in buffer
---@param bufnr integer
function M.clear(bufnr)
	highlighted[bufnr] = nil
end

---Update highlight ranges after text insertion or deletion.
---@param bufnr integer
---@param from integer Start row of the changed text
---@param delta integer Number of lines changed
function M.changed(bufnr, from, offset_old, offset_new)
	if offset_old == offset_new then return end

	local ranges = highlighted[bufnr]
	if ranges == nil then return end

	local kept = {}
	local delta = offset_new - offset_old
	local to = from + offset_old
	for _, range in ipairs(ranges) do
		if range[2] <= from then
			kept[#kept + 1] = range
		elseif range[1] >= to then
			kept[#kept + 1] = { range[1] + delta, range[2] + delta }
		else
			if range[1] < from then
				kept[#kept + 1] = { range[1], from }
			end
			if range[2] > to then
				kept[#kept + 1] = { from + offset_new, range[2] + delta }
			end
		end
	end
	highlighted[bufnr] = kept
end

return M
