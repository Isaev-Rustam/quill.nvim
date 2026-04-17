-- ~/lua/catppuccin/lib/mapper.lua
local M = {}

function M.apply(flavour)
	local _O, _C, _U = O, C, U
	O = require("catppuccin").options
	C = require("catppuccin.palettes").get_palette(flavour)
	U = require "catppuccin.utils.colors"

	C.none = "NONE"

	local dim_percentage = O.dim_inactive.percentage
	C.dim = O.dim_inactive.shade == "dark"
		and U.darken(C.base, dim_percentage, C.mantle)
		or U.lighten(C.surface0, dim_percentage, C.base)

	local theme = {}
	theme.editor =
		vim.tbl_deep_extend("force", require("catppuccin.groups.editor").get(), require("catppuccin.groups.lsp").get())

	theme.syntax = {}
	local syntax_modules = { "syntax", "semantic_tokens", "treesitter" }
	for i = 1, #syntax_modules do
		theme.syntax =
			vim.tbl_deep_extend("force", theme.syntax, require("catppuccin.groups." .. syntax_modules[i]).get())
	end
	local final_integrations = {}

	if type(O.integrations.dap) == "table" and O.integrations.dap.enable_ui ~= nil then
		O.integrations.dap_ui = O.integrations.dap.enable_ui
		O.integrations.dap.enable_ui = nil
	end

	for integration in pairs(O.integrations) do
		local cot = false
		if type(O.integrations[integration]) == "table" then
			if O.integrations[integration].enabled == true then cot = true end
		else
			if O.integrations[integration] == true then
				local default = require("catppuccin").default_options.integrations[integration]
				O.integrations[integration] = type(default) == "table" and default or {}
				O.integrations[integration].enabled = true
				cot = true
			end
		end

		local ok, result = pcall(require, "catppuccin.groups.integrations." .. integration)
		if ok and result.get and cot then
			final_integrations = vim.tbl_deep_extend("force", final_integrations, result.get())
		end
	end

	theme.integrations = final_integrations
	theme.terminal = require("catppuccin.groups.terminal").get()

	local user_highlights = O.highlight_overrides
	if type(user_highlights["mocha"]) == "function" then
		user_highlights["mocha"] = user_highlights["mocha"](C)
	end
	theme.custom_highlights = vim.tbl_deep_extend(
		"keep",
		user_highlights["mocha"] or {},
		type(user_highlights.all) == "function" and user_highlights.all(C) or user_highlights.all or {}
	)

	O, C, U = _O, _C, _U

	return theme
end

return M
