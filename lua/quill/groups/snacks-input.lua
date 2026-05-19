-- lua/quill/groups/snacks-input.lua

-- Подсветка для Snacks.nvim Input (всплывающее окно ввода, используется в командах поиска, фильтрации и т.д.).

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Основные элементы окна ввода
    SnacksInputBorder = { fg = c.floatBorder },   -- Граница окна
    SnacksInputPrompt  = { fg = c.comment },      -- Текст подсказки (prompt)
    SnacksInputTitle   = { fg = c.constant },     -- Заголовок окна
    SnacksInputIcon    = { fg = c.constant },     -- Иконка слева от ввода
  }

  return hl
end

return M