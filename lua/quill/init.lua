-- lua/quill/init.lua

-- Главный входной модуль colorscheme "quill".
-- Здесь находится публичный API: setup(), get_palette() и внутренняя функция _colorscheme().

local internal_conf = require("quill.config.internal")

local M = {}

---@param user_opts? QuillColorscheme.Config
M.setup = function(user_opts)
  -- Применяем пользовательские настройки (цвета, transparent, bold, italic и т.д.)
  if user_opts then
    internal_conf.set(user_opts)
  end
end

-- SHOULD BE CALLED AFTER SETUP (unless using default colors)
M.get_palette = function()
  -- Возвращает текущую палитру цветов в удобном виде.
  -- Полезно для плагинов, которые хотят использовать цвета из твоей темы.
  local palette = {}
  for name, color in pairs(internal_conf.current.colors) do
    palette[name] = color
  end
  return palette
end

--- Under the hood, |:colorscheme| is just using |:highlight GroupName ...| over every highlight group it knows about.
--- so this function is the equivalent to calling |:colorscheme| so use that instead
M._colorscheme = function()
  -- Основная функция, которая вызывается при `:colorscheme quill`

  -- Очищаем предыдущие highlight'ы
  vim.cmd("highlight clear")
  if vim.fn.has("syntax_on") then
    vim.cmd("syntax reset")
  end

  -- Устанавливаем имя colorscheme
  vim.g.colors_name = "quill"

  -- Применяем все highlight-группы
  require("quill.highlights").set_highlights()

  -- Применяем цвета для встроенного терминала (terminal_color_*)
  require("quill.terminal").set_highlights()
end

return M