---A strategy decorator; the decorated strategy keeps track of all currently
---attached buffers.  Thew new strategy has the following fields:
---
--- - strategy  The wrapped strategy object
--- - buffers   Table mapping of buffer number to buffer settings
---
---@param strategy table
local function track(strategy)
	local buffers = {}

	return {
		strategy = strategy,
		buffers = buffers,
		on_attach = function(bufnr, settings, ...)
			buffers[bufnr] = settings
			strategy.on_attach(bufnr, settings, ...)
		end,
		on_detach = function(bufnr, ...)
			buffers[bufnr] = nil
			strategy.on_detach(bufnr, ...)
		end
	}
end

return track
-- vim:tw=79:ts=4:sw=4:noet:
