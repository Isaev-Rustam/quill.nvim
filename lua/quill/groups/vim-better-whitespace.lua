-- lua/quill/groups/vim-better-whitespace.lua

-- Подсветка для плагина vim-better-whitespace (подсвечивает лишние пробелы в конце строк).

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Подсветка лишних пробелов в конце строк
    ExtraWhitespace = { fg = c.fg, bg = c.error },  -- Белый текст на красном фоне (очень заметно)
  }

  return hl
end

return M