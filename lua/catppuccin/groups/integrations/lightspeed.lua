-- ~/lua/catppuccin/groups/integrations/lightspeed.lua
local M = {}

M.url = "https://github.com/ggandor/lightspeed.nvim"

function M.get()
	return {
		LightspeedLabel = { fg = C.red, style = { "bold", "underline" } },
		LightspeedLabelDistant = {
		    fg = C.sky,
		    style = { "bold", "underline" },
		},
		LightspeedShortcut = {
			fg = "#ffffff",
			bg = bg = U.brighten(C.red, 0.3),
			style = { "bold" },
		},
		LightspeedMaskedChar = {
			fg = U.darken(C.pink, 0.7, C.base),
		},
		LightspeedUnlabeledMatch = { fg = C.text, style = { "bold" } },
		LightspeedGreyWash = { link = "Comment" },
		LightspeedUniqueChar = { link = "LightspeedUnlabeledMatch" },
		LightspeedOneCharMatch = { link = "LightspeedShortcut" },
		LightspeedPendingOpArea = { link = "IncSearch" },
		LightspeedCursor = { link = "Cursor" },
	}
end

return M
