-- lua/quill/groups/neotree.lua

-- Подсветка для плагина neo-tree (файловый менеджер).

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Окна и разделители
    NeoTreeVertSplit     = { fg = c.comment, bg = not conf.transparent and c.comment or nil },
    NeoTreeWinSeparator  = { fg = c.comment, bg = not conf.transparent and c.comment or nil },

    -- Корневая директория
    NeoTreeRootName      = { fg = c.hint, bold = conf.bold },

    -- Git-статусы
    NeoTreeGitConflict   = { fg = c.error, bold = conf.bold, italic = conf.italic },
    NeoTreeGitUntracked  = { fg = c.error, italic = conf.italic },

    -- Вспомогательные элементы
    NeoTreeIndentMarker  = { fg = c.comment },           -- Вертикальные линии отступов
    NeoTreeSymbolicLinkTarget = { fg = c.hint },         -- Целевой путь символьных ссылок
  }

  return hl
end

return M