-- ~/lua/catppuccin/groups/integrations/leap.lua
local M = {}

M.url = "https://github.com/ggandor/leap.nvim"

function M.get()
	return {
		LeapMatch = {
		    fg = O.transparent_background and C.pink or U.brighten(C.green, 0.3),
		    style = { "underline", "nocombine", O.transparent_background and "bold" or nil },
		},
		LeapLabel = {
		    fg = O.transparent_background and C.green or C.base,
		    bg = O.transparent_background and C.none or U.brighten(C.green, 0.3),
		    style = { "nocombine", O.transparent_background and "bold" or nil },
		},
		LeapBackdrop = { fg = O.transparent_background and C.overlay0 or C.none },
	}
end

return M
