-- lua/vague/groups/html.lua

-- Подсветка для HTML (и частично для XML, JSX, TSX).
-- Эти группы используются как встроенным Treesitter, так и LSP.

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
      -- HTML теги
      htmlTag            = { fg = c.fg },        -- Обычные теги: <div>, <span>, <p> и т.д.
      htmlEndTag         = { fg = c.fg },        -- Закрывающие теги: </div>, </span>

      -- Имя самого тега
      htmlTagName        = { fg = c.builtin },   -- Название тега (div, header, main, section...)
      htmlSpecialTagName = { fg = c.builtin },   -- Специальные теги (html, head, body, title...)

      -- Атрибуты тегов
      htmlArg            = { fg = c.constant },  -- Атрибуты: class, id, href, src, alt и т.д.
  }

  return hl
end

return M