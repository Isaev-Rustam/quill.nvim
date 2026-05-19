-- lua/quill/highlights.lua

-- Главный модуль, отвечающий за применение всех highlight-групп colorscheme.
-- Собирает все группы из папки `groups/` и применяет их через nvim_set_hl().

local curr_internal_conf = require("quill.config.internal").current
local groups = require("quill.groups")

local M = {}

M.set_highlights = function()
  local highlights = {}

  -- Собираем все highlight-группы из разных файлов (syntax, treesitter, telescope, neotree и т.д.)
  for _, group in pairs(groups) do
    for hl, settings in pairs(group) do
      highlights[hl] = settings
    end
  end

  -- Позволяем пользователю дополнять или переопределять любые группы
  -- (через on_highlights в настройках colorscheme)
  curr_internal_conf.on_highlights(highlights, curr_internal_conf.colors)

  -- Применяем все собранные highlight-группы
  for hl, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl, settings)
  end
end

return M