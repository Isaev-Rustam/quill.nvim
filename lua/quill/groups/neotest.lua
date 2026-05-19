-- lua/quill/groups/neotest.lua

-- Подсветка для плагина neotest (тестирование в Neovim).

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- === ФОН ПАНЕЛИ ===
    NeoTreeNormal         = { fg = c.fg, bg = c.inactiveBg },      -- ← Основной фон Neo-tree
    NeoTreeNormalNC       = { fg = c.fg, bg = c.inactiveBg },      -- ← Фон неактивной панели

    -- Разделители и границы
    NeoTreeVertSplit      = { fg = c.comment, bg = c.inactiveBg },
    NeoTreeWinSeparator   = { fg = c.comment, bg = c.inactiveBg },

    -- Корневая директория
    NeoTreeRootName       = { fg = c.hint, bold = conf.bold },

    -- Git-статусы
    NeoTreeGitConflict    = { fg = c.error, bold = conf.bold, italic = conf.italic },
    NeoTreeGitUntracked   = { fg = c.error, italic = conf.italic },
    NeoTreeGitModified    = { fg = c.warning },
    NeoTreeGitUnstaged    = { fg = c.warning },
    NeoTreeGitStaged      = { fg = c.plus },

    -- Вспомогательные элементы
    NeoTreeIndentMarker   = { fg = c.comment },
    NeoTreeSymbolicLinkTarget = { fg = c.hint },

    -- Курсорная строка в панели
    NeoTreeCursorLine     = { bg = c.line },   -- или можно сделать чуть темнее/светлее

    -- Конец буфера (чтобы не было пустого пространства другого цвета)
    NeoTreeEndOfBuffer    = { fg = c.inactiveBg, bg = c.inactiveBg },
  }

  return hl
end

return M