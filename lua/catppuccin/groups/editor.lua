-- ~/lua/catppuccin/groups/editor.lua
local M = {}

function M.get()
	return {
		ColorColumn = { bg = C.surface0 },
		Conceal = { fg = C.overlay1 },
		Cursor = { fg = C.base, bg = C.rosewater },
		lCursor = { fg = C.base, bg = C.rosewater },
		CursorIM = { fg = C.base, bg = C.rosewater },
		CursorColumn = { bg = C.mantle },
		CursorLine = { bg = U.darken(C.surface0, 0.64, C.base) },
		Directory = { fg = C.blue },
		EndOfBuffer = { fg = C.surface1 },
		ErrorMsg = { fg = C.red, style = { "bold", "italic" } },
		VertSplit = { fg = O.transparent_background and C.surface1 or C.crust },
		Folded = { fg = C.blue, bg = O.transparent_background and C.none or C.surface1 },
		FoldColumn = { fg = C.overlay0 },
		SignColumn = { fg = C.surface1 },
		SignColumnSB = { bg = C.crust, fg = C.surface1 },
		Substitute = { bg = C.surface1, fg = C.pink },
		LineNr = { fg = C.surface1 },
		CursorLineNr = { fg = C.lavender },
		MatchParen = { fg = C.peach, bg = U.darken(C.surface1, 0.70, C.base), style = { "bold" } },
		ModeMsg = { fg = C.text, style = { "bold" } },
		MsgSeparator = { link = "WinSeparator" },
		MoreMsg = { fg = C.blue },
		NonText = { fg = C.overlay0 },
		Normal = { fg = C.text, bg = O.transparent_background and C.none or C.base },
		NormalNC = {
			fg = C.text,
			bg = (O.transparent_background and O.dim_inactive.enabled and C.dim)
				or (O.dim_inactive.enabled and C.dim)
				or (O.transparent_background and C.none)
				or C.base,
		},
		NormalSB = { fg = C.text, bg = C.crust },
		NormalFloat = { fg = C.text, bg = (O.float.transparent and vim.o.winblend == 0) and C.none or C.mantle },
		FloatBorder = O.float.solid
				and ((O.float.transparent and vim.o.winblend == 0) and { fg = C.surface2, bg = C.none } or {
					fg = C.mantle,
					bg = C.mantle,
				})
			or { fg = C.blue, bg = (O.float.transparent and vim.o.winblend == 0) and C.none or C.mantle },
		FloatTitle = O.float.solid and {
			fg = C.crust,
			bg = C.lavender,
		} or { fg = C.subtext0, bg = (O.float.transparent and vim.o.winblend == 0) and C.none or C.mantle },
		FloatShadow = { bg = (O.float.transparent and vim.o.winblend == 0) and C.none or C.overlay0, blend = 80 },
		FloatShadowThrough = {
			bg = (O.float.transparent and vim.o.winblend == 0) and C.none or C.overlay0,
			blend = 100,
		},
		Pmenu = {
			bg = (O.transparent_background and vim.o.pumblend == 0) and C.none or C.mantle,
			fg = C.overlay2,
		},
		PmenuSel = { bg = C.surface0, style = { "bold" } },
		PmenuMatch = { fg = C.text, style = { "bold" } },
		PmenuMatchSel = { style = { "bold" } },
		PmenuSbar = { bg = C.surface0 },
		PmenuThumb = { bg = C.overlay0 },
		PmenuExtra = { fg = C.overlay0 },
		PmenuExtraSel = { bg = C.surface0, fg = C.overlay0, style = { "bold" } },
		ComplMatchIns = { link = "PreInsert" },
		PreInsert = { fg = C.overlay2 },
		ComplHint = { fg = C.subtext0 },
		ComplHintMore = { link = "Question" },
		Question = { fg = C.blue },
		QuickFixLine = { bg = U.darken(C.surface1, 0.70, C.base), style = { "bold" } },
		Search = { bg = U.darken(C.sky, 0.30, C.base), fg = C.text },
		IncSearch = { bg = U.darken(C.sky, 0.90, C.base), fg = C.mantle },
		CurSearch = { bg = C.red, fg = C.mantle },
		SpecialKey = { link = "NonText" },
		SpellBad = { sp = C.red, style = { "undercurl" } },
		SpellCap = { sp = C.yellow, style = { "undercurl" } },
		SpellLocal = { sp = C.blue, style = { "undercurl" } },
		SpellRare = { sp = C.green, style = { "undercurl" } },
		StatusLine = { fg = C.text, bg = O.transparent_background and C.none or C.mantle },
		StatusLineNC = { fg = C.surface1, bg = O.transparent_background and C.none or C.mantle },
		TabLine = { bg = C.crust, fg = C.overlay0 },
		TabLineFill = { bg = O.transparent_background and C.none or C.mantle },
		TabLineSel = { link = "Normal" },
		TermCursor = { fg = C.base, bg = C.rosewater },
		TermCursorNC = { fg = C.base, bg = C.overlay2 },
		Title = { fg = C.blue, style = { "bold" } },
		Visual = { bg = C.surface1, style = { "bold" } },
		VisualNOS = { bg = C.surface1, style = { "bold" } },
		WarningMsg = { fg = C.yellow },
		Whitespace = { fg = C.surface1 },
		WildMenu = { bg = C.overlay0 },
		WinBar = { fg = C.rosewater },
		WinBarNC = { link = "WinBar" },
		WinSeparator = { fg = O.transparent_background and C.surface1 or C.crust },
	}
end

return M
