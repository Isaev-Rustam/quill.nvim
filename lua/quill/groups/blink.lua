-- lua/quill/config/meta.lua

-- Подсветка для Blink.cmp (современный автодополнялки, замена nvim-cmp)

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Границы окон документации и меню
    BlinkCmpDocBorder            = { fg = c.floatBorder },  -- Граница окна с документацией
    BlinkCmpMenuBorder           = { fg = c.floatBorder },  -- Граница основного меню автодополнения
    BlinkCmpSignatureHelpBorder  = { fg = c.floatBorder },  -- Граница окна сигнатуры функции

    -- Устаревшие элементы
    BlinkCmpLabelDeprecated      = { link = "CmpItemAbbrDeprecated" }, -- Зачёркнутый устаревший метод/поле
  }

  return hl
end

return M