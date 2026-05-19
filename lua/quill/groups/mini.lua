-- lua/quill/groups/mini.lua

-- Подсветка для плагина mini.nvim
-- (mini.statusline, mini.diff, mini.pick и другие модули)

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Diff
    MiniDiffOverContext = { bg = c.line },   -- Фон при просмотре изменений в контексте

    -- Statusline режимы (mini.statusline)
    MiniStatuslineModeNormal  = { fg = c.bg, bg = c.operator, bold = conf.bold },
    -- Нормальный режим — использует цвет operator

    MiniStatuslineModeInsert  = { fg = c.bg, bg = c.delta, bold = conf.bold },
    -- Режим вставки — использует цвет delta (голубовато-оранжевый)

    MiniStatuslineModeVisual  = { fg = c.bg, bg = c.builtin, bold = conf.bold },
    -- Визуальный режим — цвет builtin

    MiniStatuslineModeReplace = { fg = c.bg, bg = c.string, bold = conf.bold },
    -- Режим замены — цвет строк

    MiniStatuslineModeCommand = { fg = c.bg, bg = c.string, bold = conf.bold },
    -- Командный режим — тоже цвет строк

    MiniStatuslineModeOther   = { fg = c.bg, bg = c.string, bold = conf.bold },
    -- Остальные режимы (например, terminal mode)
  }

  return hl
end

return M