-- ~/lua/catppuccin/groups/integrations/vim_sneak.lua
local M = {}

M.url = "https://github.com/justinmk/vim-sneak"

function M.get()
	return {
		Sneak = { fg = C.overlay2, bg = C.pink },
		SneakScope = { bg = C.text },
	}
end

return M
