-- ~/lua/catppuccin/groups/lsp.lua
local M = {}

function M.get()
	local virtual_text = O.lsp_styles.virtual_text
	local underlines = O.lsp_styles.underlines
	local inlay_hints = O.lsp_styles.inlay_hints

	local error = C.red
	local warning = C.yellow
	local info = C.sky
	local hint = C.teal
	local ok = C.green
	local darkening_percentage = 0.095

	return {
		LspReferenceText = { bg = C.surface1 },
		LspReferenceRead = { bg = C.surface1 },
		LspReferenceWrite = { bg = C.surface1 },

		DiagnosticVirtualTextError = {
			bg = O.transparent_background and C.none or U.darken(error, darkening_percentage, C.base),
			fg = error,
			style = virtual_text.errors,
		},
		DiagnosticVirtualTextWarn = {
			bg = O.transparent_background and C.none or U.darken(warning, darkening_percentage, C.base),
			fg = warning,
			style = virtual_text.warnings,
		},
		DiagnosticVirtualTextInfo = {
			bg = O.transparent_background and C.none or U.darken(info, darkening_percentage, C.base),
			fg = info,
			style = virtual_text.information,
		},
		DiagnosticVirtualTextHint = {
			bg = O.transparent_background and C.none or U.darken(hint, darkening_percentage, C.base),
			fg = hint,
			style = virtual_text.hints,
		},
		DiagnosticVirtualTextOk = {
			bg = O.transparent_background and C.none or U.darken(hint, darkening_percentage, C.base),
			fg = ok,
			style = virtual_text.ok,
		},

		DiagnosticError = { bg = C.none, fg = error, style = virtual_text.errors },
		DiagnosticWarn = { bg = C.none, fg = warning, style = virtual_text.warnings },
		DiagnosticInfo = { bg = C.none, fg = info, style = virtual_text.information },
		DiagnosticHint = { bg = C.none, fg = hint, style = virtual_text.hints },
		DiagnosticOk = { bg = C.none, fg = ok, style = virtual_text.ok },

		DiagnosticUnderlineError = { style = underlines.errors, sp = error },
		DiagnosticUnderlineWarn = { style = underlines.warnings, sp = warning },
		DiagnosticUnderlineInfo = { style = underlines.information, sp = info },
		DiagnosticUnderlineHint = { style = underlines.hints, sp = hint },
		DiagnosticUnderlineOk = { style = underlines.ok, sp = ok },

		DiagnosticFloatingError = { fg = error },
		DiagnosticFloatingWarn = { fg = warning },
		DiagnosticFloatingInfo = { fg = info },
		DiagnosticFloatingHint = { fg = hint },
		DiagnosticFloatingOk = { fg = ok },

		DiagnosticSignError = { fg = error },
		DiagnosticSignWarn = { fg = warning },
		DiagnosticSignInfo = { fg = info },
		DiagnosticSignHint = { fg = hint },
		DiagnosticSignOk = { fg = ok },

		LspDiagnosticsDefaultError = { fg = error },
		LspDiagnosticsDefaultWarning = { fg = warning },
		LspDiagnosticsDefaultInformation = { fg = info },
		LspDiagnosticsDefaultHint = { fg = hint },
		LspSignatureActiveParameter = { bg = C.surface0, style = { "bold" } },

		LspDiagnosticsError = { fg = error },
		LspDiagnosticsWarning = { fg = warning },
		LspDiagnosticsInformation = { fg = info },
		LspDiagnosticsHint = { fg = hint },
		LspDiagnosticsVirtualTextError = { fg = error, style = virtual_text.errors },
		LspDiagnosticsVirtualTextWarning = { fg = warning, style = virtual_text.warnings },
		LspDiagnosticsVirtualTextInformation = { fg = info, style = virtual_text.warnings },
		LspDiagnosticsVirtualTextHint = { fg = hint, style = virtual_text.hints },
		LspDiagnosticsUnderlineError = { style = underlines.errors, sp = error },
		LspDiagnosticsUnderlineWarning = { style = underlines.warnings, sp = warning },
		LspDiagnosticsUnderlineInformation = { style = underlines.information, sp = info },
		LspDiagnosticsUnderlineHint = { style = underlines.hints, sp = hint },
		LspCodeLens = { fg = C.overlay0 },
		LspCodeLensSeparator = { link = "LspCodeLens" },
		LspInlayHint = {
			fg = C.overlay0,
			bg = (O.transparent_background or not inlay_hints.background) and C.none
				or U.darken(C.surface0, 0.64, C.base),
		},
		LspInfoBorder = { link = "FloatBorder" },
	}
end

return M
