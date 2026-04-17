-- ~/lua/catppuccin/groups/integrations/grug_far.lua
local M = {}

M.url = "https://github.com/MagicDuck/grug-far.nvim"

function M.get()
	return {
		GrugFarResultsMatch = { link = "IncSearch" },
	}
end

return M
