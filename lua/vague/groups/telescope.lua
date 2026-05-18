-- lua/vague/groups/telescope.lua

-- Подсветка для Telescope.nvim — классического fuzzy-finder'а.

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Окно и границы
    TelescopeBorder = { fg = c.floatBorder },           -- Граница окна Telescope

    -- Поиск и совпадения
    TelescopeMatching = { fg = c.delta, bold = conf.bold }, -- Выделение найденных совпадений

    -- Выбранный элемент
    TelescopeSelection      = { fg = c.constant, bg = c.line }, -- Выделенная строка
    TelescopeSelectionCaret = { fg = c.constant },              -- Каретка (стрелочка) у выбранной строки
  }

  return hl
end

return M