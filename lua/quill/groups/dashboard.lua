-- lua/quill/groups/dashboard.lua

-- Подсветка для Dashboard (alpha.nvim / dashboard-nvim и подобных плагинов).
-- Это экран приветствия, который появляется при запуске Neovim без файлов.

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Горячие клавиши / шорткаты (например "SPC f f  → Find files")
    DashboardShortCut = { fg = c.parameter },

    -- Большой заголовок / ASCII-арт вверху дашборда
    DashboardHeader   = { fg = c.constant },

    -- Центральная часть: основные кнопки и команды
    DashboardCenter   = { fg = c.constant },

    -- Нижняя часть (обычно информация о версии, дата, цитата и т.д.)
    DashboardFooter   = { fg = c.delta, italic = conf.italic },
  }

  return hl
end

return M