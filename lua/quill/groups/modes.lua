-- lua/quill/groups/modes.lua

-- Подсветка для плагина modes.nvim
-- Плагин меняет цвет курсора и строки в зависимости от режима редактирования.

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
      -- Основные режимы (цвет фона курсора / строки)
      ModesCopy    = { bg = c.keyword },    -- режим Copy (обычно Visual)
      ModesDelete  = { bg = c.error },      -- режим Delete
      ModesFormat  = { bg = c.func },       -- режим Format
      ModesReplace = { bg = c.plus },       -- режим Replace (R)
      ModesVisual  = { bg = c.number },     -- режим Visual
      ModesInsert  = { bg = c.constant },   -- режим Insert (самый важный)

      -- Специальные группы для Insert режима
      -- Используются, чтобы строка и номер строки не сливались с обычным CursorLine
      ModesInsertCursorLine     = { bg = c.line },
      ModesInsertCursorLineNr   = { bg = c.line },
      ModesInsertCursorLineFold = { bg = c.line },
      ModesInsertCursorLineSign = { bg = c.line },
  }

  return hl
end

return M