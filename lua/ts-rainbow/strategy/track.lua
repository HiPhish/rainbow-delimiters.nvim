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
	local attachments = {0}  -- Table because want to pass it by reference

	return {
		strategy = strategy,
		buffers = buffers,
		attachments = attachments,
		on_attach = function(bufnr, settings, ...)
			buffers[bufnr] = settings
			attachments[1] = attachments[1] + 1
			print(attachments, vim.inspect(attachments))
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
