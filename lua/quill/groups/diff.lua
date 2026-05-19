-- lua/quill/groups/diff.lua

-- Подсветка для diff'ов — изменений кода.
-- Используется в:
--   • git diff
--   • vimdiff / nvimdiff
--   • плагинах (gitsigns, diffview, neo-tree git status и т.д.)

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Основные группы для строк
    Added         = { fg = c.plus },      -- Добавленные строки (+)
    Changed       = { fg = c.delta },     -- Изменённые строки (~)
    Removed       = { fg = c.error },     -- Удалённые строки (-)

    -- Фоновая подсветка в vimdiff и diff-режиме
    DiffAdd       = { bg = "#293125" },   -- Фон добавленных строк
    DiffChange    = { bg = "#41362a" },   -- Фон изменённых строк
    DiffDelete    = { bg = "#3b242a" },   -- Фон удалённых строк
    DiffText      = { bg = "#6D583E" },   -- Фон конкретно изменённого текста внутри строки

    -- Дополнительные элементы
    DiffFile      = { fg = c.keyword },   -- Имя файла в diff'е
    DiffIndexLine = { fg = c.comment },   -- Строка с индексом/хешем (@@ -1,5 +1,7 @@)
  }

  return hl
end

return M