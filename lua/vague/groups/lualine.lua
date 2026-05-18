-- lua/vague/groups/lualine.lua

-- Цветовая схема для lualine.nvim — статусной строки.
-- Здесь определяются цвета для разных режимов редактора.

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  return {
    -- ==================== VISUAL режим ====================
    visual = {
      a = { fg = c.bg, bg = c.builtin, bold = conf.bold }, -- Основная часть (левый блок)
      b = { fg = c.property, bg = c.line },                -- Вторичная часть
    },

    -- ==================== REPLACE режим ====================
    replace = {
      a = { fg = c.bg, bg = c.string, bold = conf.bold },
      b = { fg = c.property, bg = c.line },
    },

    -- ==================== INACTIVE (неактивное окно) ====================
    inactive = {
      a = { fg = c.property, bg = c.inactiveBg, bold = conf.bold },
      b = { fg = c.property, bg = c.inactiveBg },
      c = { fg = c.property, bg = c.inactiveBg },
    },

    -- ==================== NORMAL режим ====================
    normal = {
      a = { fg = c.bg, bg = c.operator, bold = conf.bold }, -- Основная часть
      b = { fg = c.property, bg = c.line },                 -- Средняя часть
      c = { fg = c.property, bg = c.inactiveBg },           -- Правая часть
    },

    -- ==================== INSERT режим ====================
    insert = {
      a = { fg = c.bg, bg = c.delta, bold = conf.bold },
      b = { fg = c.property, bg = c.line },
    },
  }
end

return M