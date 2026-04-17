-- ~/lua/catppuccin/utils/lualine.lua
return function()
	local C = require("catppuccin.palettes").get_palette()
	local O = require("catppuccin").options
	local transparent_bg = O.transparent_background and "NONE" or C.mantle

	local default_colors = {
		normal = {
			a = { bg = C.blue, fg = C.mantle, gui = "bold" },
			b = { bg = C.surface0, fg = C.blue },
			c = { bg = transparent_bg, fg = C.text },
		},
		insert = {
			a = { bg = C.green, fg = C.base, gui = "bold" },
			b = { bg = C.surface0, fg = C.green },
		},
		terminal = {
			a = { bg = C.green, fg = C.base, gui = "bold" },
			b = { bg = C.surface0, fg = C.green },
		},
		command = {
			a = { bg = C.peach, fg = C.base, gui = "bold" },
			b = { bg = C.surface0, fg = C.peach },
		},
		visual = {
			a = { bg = C.mauve, fg = C.base, gui = "bold" },
			b = { bg = C.surface0, fg = C.mauve },
		},
		replace = {
			a = { bg = C.red, fg = C.base, gui = "bold" },
			b = { bg = C.surface0, fg = C.red },
		},
		inactive = {
			a = { bg = transparent_bg, fg = C.blue },
			b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
			c = { bg = transparent_bg, fg = C.overlay0 },
		},
	}

	local overrides = O.integrations.lualine
	if overrides then
		local function get_colors(colors_override)
			if colors_override == nil then return {}
			elseif type(colors_override) == "function" then return colors_override(C)
			else return colors_override end
		end
		return vim.tbl_deep_extend("force", default_colors,
			get_colors(overrides.all),
			get_colors(overrides["mocha"]))
	end
	return default_colors
end
