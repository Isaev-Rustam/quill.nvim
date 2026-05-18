-- lua/vague/groups/syntax.lua

-- Базовая подсветка синтаксиса (Vim highlight groups).
-- Это фундаментальная группа, которая используется большинством языков программирования.

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Типы данных и литералы
    Boolean         = { fg = c.number, bold = conf.bold },
    Number          = { fg = c.number },
    Float           = { fg = c.number },
    String          = { fg = c.string, italic = conf.italic },
    Character       = { fg = c.string },

    -- Ключевые слова и управляющие конструкции
    Keyword         = { fg = c.keyword },
    Conditional     = { fg = c.keyword },     -- if, else, switch
    Repeat          = { fg = c.keyword },     -- for, while, do
    Exception       = { fg = c.keyword },     -- try, catch, throw
    Statement       = { fg = c.keyword },
    Label           = { fg = c.keyword },

    -- Функции и идентификаторы
    Function        = { fg = c.func },
    Identifier      = { fg = c.constant },
    Constant        = { fg = c.constant },
    Macro           = { fg = c.constant },

    -- Типы и структуры
    Type            = { fg = c.type },
    Structure       = { fg = c.constant },
    StorageClass    = { fg = c.constant },    -- static, register, volatile
    Typedef         = { fg = c.constant },

    -- Операторы и пунктуация
    Operator        = { fg = c.operator },
    Delimiter       = { fg = c.fg },

    -- Preprocessor / Компиляторные директивы
    PreProc         = { fg = c.constant },
    Include         = { fg = c.keyword },
    Define          = { fg = c.comment },
    PreCondit       = { fg = c.comment },

    -- Специальные элементы
    Special         = { fg = c.builtin },
    SpecialChar     = { fg = c.keyword },
    Tag             = { fg = c.builtin },     -- HTML/JSX теги и т.п.

    -- Комментарии
    Comment         = { fg = c.comment, italic = conf.italic },
    SpecialComment  = { fg = c.keyword },

    -- Разное
    Title           = { fg = c.property },
    Todo            = { fg = c.func, italic = conf.italic },
    Error           = { bg = c.error, bold = conf.bold },
  }

  return hl
end

return M