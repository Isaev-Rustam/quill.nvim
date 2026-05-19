-- lua/quill/groups/cmp.lua

-- Подсветка для nvim-cmp — классического плагина автодополнения.

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Устаревшие (deprecated) элементы в списке автодополнения
    CmpItemAbbrDeprecated = { fg = c.error, strikethrough = true },

    -- Подсветка совпадения с введённым текстом (обычное совпадение)
    CmpItemAbbrMatch      = { fg = c.delta, bold = conf.bold },

    -- Подсветка "fuzzy" совпадения (когда есть неточные совпадения)
    CmpItemAbbrMatchFuzzy = { fg = c.delta, bold = conf.bold },

    -- Цвет иконок типов (function, variable, class, snippet и т.д.)
    CmpItemKind           = { fg = c.comment },
  }

  return hl
end

return M