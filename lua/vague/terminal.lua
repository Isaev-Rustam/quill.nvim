-- lua/vague/terminal.lua

-- Настройка цветов для встроенного терминала Neovim (vim.g.terminal_color_*).
-- Эти цвета используются в :terminal, lazygit, toggleterm, run-кодом и т.д.

local curr_internal_conf = require("vague.config.internal").current

local M = {}

M.set_highlights = function()
  local c = curr_internal_conf.colors

  -- Базовые 16 цветов терминала (ANSI)

  -- Normal colors (0-7)
  vim.g.terminal_color_0  = c.line      -- black   (фон/тёмный)
  vim.g.terminal_color_1  = c.error     -- red
  vim.g.terminal_color_2  = c.plus      -- green
  vim.g.terminal_color_3  = c.warning   -- yellow
  vim.g.terminal_color_4  = c.keyword   -- blue
  vim.g.terminal_color_5  = c.parameter -- purple / magenta
  vim.g.terminal_color_6  = c.constant  -- cyan
  vim.g.terminal_color_7  = c.fg        -- white (светлый)

  -- Bright colors (8-15)
  vim.g.terminal_color_8  = c.comment   -- bright black (gray)

  -- Яркие цвета (bright) — частично захардкожены
  vim.g.terminal_color_9  = "#e08398"   -- bright red
  vim.g.terminal_color_10 = "#99b782"   -- bright green
  vim.g.terminal_color_11 = "#f5cb96"   -- bright yellow
  vim.g.terminal_color_12 = "#8ba9c1"   -- bright blue
  vim.g.terminal_color_13 = "#c9b1ca"   -- bright purple
  vim.g.terminal_color_14 = "#bebeda"   -- bright cyan
  vim.g.terminal_color_15 = "#d7d7d7"   -- bright white
end

return M