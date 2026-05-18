-- lua/vague/groups/lsp-plugin.lua

-- Подсветка для LSP-плагинов и диагностики.
-- Здесь находятся группы, которые используются:
--   • nvim-lspconfig
--   • lsp diagnostics (ошибки, предупреждения, подсказки)
--   • code lenses, references, c++ highlighting и т.д.

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- ====================== Diagnostics ======================
    DiagnosticError            = { fg = c.error, bold = conf.bold },      -- Ошибки
    DiagnosticWarn             = { fg = c.warning, bold = conf.bold },    -- Предупреждения
    DiagnosticHint             = { fg = c.hint },                         -- Подсказки
    DiagnosticInfo             = { fg = c.constant, italic = conf.italic }, -- Информационные сообщения
    DiagnosticOk               = { fg = c.plus },                         -- Успешные проверки

    -- Подчёркивание под проблемными участками кода
    DiagnosticUnderlineError   = { sp = c.error,    undercurl = true },
    DiagnosticUnderlineWarn    = { sp = c.delta,    undercurl = true, bold = conf.bold },
    DiagnosticUnderlineHint    = { sp = c.hint,     undercurl = true },
    DiagnosticUnderlineInfo    = { sp = c.constant, undercurl = true },
    DiagnosticUnderlineOk      = { sp = c.plus,     undercurl = true },

    -- Виртуальный текст (inline сообщения рядом с кодом)
    DiagnosticVirtualTextError = { fg = c.error, bold = conf.bold },
    DiagnosticVirtualTextWarn  = { fg = c.warning, bold = conf.bold },
    DiagnosticVirtualTextHint  = { fg = c.hint },
    DiagnosticVirtualTextInfo  = { fg = c.constant, italic = conf.italic },
    DiagnosticVirtualTextOk    = { fg = c.plus },

    -- ====================== Code Lens ======================
    LspCodeLens                = { fg = c.comment, italic = conf.italic }, -- Code Lens (ссылки на реализацию, количество ссылок и т.д.)
    LspCodeLensSeparator       = { fg = c.comment },                       -- Разделитель между code lens

    -- ====================== C++ Specific ======================
    LspCxxHlGroupEnumConstant     = { fg = c.type },      -- Enum-константы в C++
    LspCxxHlGroupMemberVariable   = { fg = c.type },      -- Члены класса/структуры в C++
    LspCxxHlGroupNamespace        = { fg = c.func },      -- Пространства имён в C++
    LspCxxHlSkippedRegion         = { fg = c.comment },   -- Скрытый/пропущенный код (например #if 0)
    LspCxxHlSkippedRegionBeginEnd = { fg = c.operator },  -- #if / #endif

    -- ====================== References ======================
    -- Подсветка при наведении на символ (document highlight)
    LspReferenceRead  = { bg = c.comment },   -- Чтение переменной
    LspReferenceText  = { bg = c.comment },   -- Общее выделение
    LspReferenceWrite = { bg = c.comment },   -- Запись в переменную
  }

  return hl
end

return M