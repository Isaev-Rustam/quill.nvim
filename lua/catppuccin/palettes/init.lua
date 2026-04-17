-- ~/lua/catppuccin/palettes/init.lua
local M = {}

function M.get_palette()
	local _, palette = pcall(require, "catppuccin.palettes.mocha")
	local O = require("catppuccin").options
	local ans = vim.tbl_deep_extend("keep", O.color_overrides.all or {}, O.color_overrides["mocha"] or {}, palette or {})

	if O.kitty then
		for accent, hex in pairs(ans) do
			local red_green_string = hex:sub(1, 5)
			local blue_value = tonumber(hex:sub(6, 7), 16)
			blue_value = blue_value == 255 and blue_value - 1 or blue_value + 1
			ans[accent] = string.format("%s%.2x", red_green_string, blue_value)
		end
	end

	return ans
end

return M
