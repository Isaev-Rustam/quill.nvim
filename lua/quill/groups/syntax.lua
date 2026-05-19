-- lua/quill/groups/syntax.lua

-- Базовая подсветка синтаксиса (Vim highlight groups).
-- Это фундаментальная группа, которая используется большинством языков программирования.

-- ВАЖНО: Treesitter-группы при несрабатывании падают сюда.

local M = {}

---@param conf QuillColorscheme.InternalConfig
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
    Conditional     = { fg = c.keyword },       -- if, else, switch
    Repeat          = { fg = c.keyword },       -- for, while, do
    Exception       = { fg = c.keyword },       -- try, catch, throw
    Statement       = { fg = c.keyword },
    Label           = { fg = c.keyword },

    -- Функции и идентификаторы
    Function        = { fg = c.func },
    Identifier      = { fg = c.fg },
    Constant        = { fg = c.constant, bold = conf.bold },
    Macro           = { fg = c.string },        -- макросы → лавандовый, отличен от констант

    -- Типы и структуры
    Type            = { fg = c.constant, italic = conf.italic },  -- фиолетовый italic (не сливается с fg)
    Structure       = { fg = c.constant, italic = conf.italic },  -- Map, Array, класс
    StorageClass    = { fg = c.keyword },
    Typedef         = { fg = c.type, italic = conf.italic },

    -- Операторы и пунктуация
    Operator        = { fg = c.operator },
    Delimiter       = { fg = c.fg },

    -- Preprocessor / Компиляторные директивы
    PreProc         = { fg = c.builtin },       -- встроенные директивы → бирюзовый
    Include         = { fg = c.keyword },       -- #include, import
    Define          = { fg = c.comment },       -- #define
    PreCondit       = { fg = c.comment },       -- #ifdef, #endif

    -- Специальные элементы
    Special         = { fg = c.builtin },
    SpecialChar     = { fg = c.keyword },
    Tag             = { fg = c.builtin },       -- HTML/JSX теги

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