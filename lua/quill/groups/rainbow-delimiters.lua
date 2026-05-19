-- lua/quill/groups/rainbow-delimiters.lua

-- Подсветка Rainbow Delimiters — разноцветные скобки для лучшей читаемости вложенного кода.

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Цвета радужных скобок (по уровню вложенности)
    RainbowDelimiterRed    = { fg = c.error },      -- Красный
    RainbowDelimiterOrange = { fg = c.func },       -- Оранжевый
    RainbowDelimiterYellow = { fg = c.warning },    -- Жёлтый
    RainbowDelimiterGreen  = { fg = c.plus },       -- Зелёный
    RainbowDelimiterBlue   = { fg = c.hint },       -- Синий
    RainbowDelimiterViolet = { fg = c.parameter },  -- Фиолетовый
    RainbowDelimiterCyan   = { fg = c.keyword },    -- Голубой / Бирюзовый
  }

  return hl
end

return M