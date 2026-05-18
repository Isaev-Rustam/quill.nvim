-- lua/vague/groups/fzf-lua.lua

-- Подсветка для fzf-lua — современного и очень быстрого fuzzy finder.
-- Один из самых популярных плагинов для поиска файлов, grep, buffers и т.д.

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Заголовки и комбинации клавиш в верхней части окна
    FzfLuaHeaderBind = { fg = c.constant },   -- Комбинации клавиш (например <C-x>, <M-a>)
    FzfLuaHeaderText = { fg = c.parameter },  -- Текст заголовка рядом с биндами

    -- Граница окна fzf-lua
    FzfLuaBorder     = { link = "FloatBorder" }, -- Использует общий цвет рамки floating окон

    -- В путях: номер строки и колонка
    FzfLuaPathLineNr = { fg = c.string },     -- Номер строки в результате
    FzfLuaPathColNr  = { fg = c.parameter },  -- Номер колонки в результате

    -- Live grep / динамический поиск
    FzfLuaLivePrompt = { fg = c.constant },   -- Prompt при live_grep (по мере ввода)
    FzfLuaLiveSym    = { fg = c.string },     -- Символ/иконка рядом с live prompt

    -- Буферы
    FzfLuaBufNr      = { fg = c.string },     -- Номер буфера
    FzfLuaBufFlagCur = { fg = c.keyword },    -- Флаг текущего буфера
    FzfLuaBufFlagAlt = { fg = c.keyword },    -- Флаг альтернативного буфера

    -- Вкладки (tabs)
    FzfLuaTabTitle   = { fg = c.type },       -- Название вкладки
    FzfLuaTabMarker  = { fg = c.constant },   -- Маркер активной вкладки
  }

  return hl
end

return M