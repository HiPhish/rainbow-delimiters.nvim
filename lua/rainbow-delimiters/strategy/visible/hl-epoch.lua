-- SPDX-License-Identifier: Apache-2.0

---Per-buffer highlighting epochs.
local M = {}

---@type table<integer, integer>
local epochs = {}

---Return the current epoch.
---@param bufnr integer
---@return integer epoch
function M.current(bufnr)
	return epochs[bufnr] or 0
end

---Advance the epoch.
---@param bufnr integer
---@return integer epoch
function M.bump(bufnr)
	local epoch = M.current(bufnr) + 1
	epochs[bufnr] = epoch
	return epoch
end

---Clear the epoch.
---@param bufnr integer
function M.clear(bufnr)
	epochs[bufnr] = nil
end

return M
