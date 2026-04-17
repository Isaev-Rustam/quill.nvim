-- ~/lua/catppuccin/groups/integrations/copilot_vim.lua
local M = {}

M.url = "https://github.com/github/copilot.vim"

function M.get()
	return {
		CopilotSuggestion = { fg = C.overlay0 },
		CopilotAnnotation = { fg = C.blue },
	}
end

return M
