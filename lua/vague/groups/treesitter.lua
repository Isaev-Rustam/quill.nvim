-- lua/vague/groups/treesitter.lua

-- Подсветка Treesitter (семантический синтаксический анализ).
-- Эти группы используются современными парсерами Treesitter для более точной и детальной подсветки кода.

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Константы и конструкторы
    ["@constant.builtin"] = { fg = c.number, bold = conf.bold },   -- Встроенные константы (nil, true, false и т.д.)
    ["@constructor"]      = { fg = c.constant },                   -- Конструкторы (table.new(), Person.new())
    ["@constructor.lua"]  = { fg = c.type },                       -- Специально для Lua

    -- Функции
    ["@function.builtin"]     = { fg = c.func },      -- Встроенные функции (print, ipairs, require)
    ["@function.call"]        = { fg = c.parameter }, -- Вызов обычной функции
    ["@function.method.call"] = { fg = c.type },      -- Вызов метода
    ["@function.macro"]       = { link = "Macro" },   -- Макросы

    -- Ключевые слова
    ["@keyword.import"] = { link = "PreProc" },                    -- import, require, use
    ["@keyword.return"] = { fg = c.keyword, italic = conf.italic }, -- return

    -- Типы
    ["@type.builtin"]     = { fg = c.builtin, bold = conf.bold }, -- Встроенные типы
    ["@type.declaration"] = { fg = c.constant },                  -- Объявление типа
    ["@type.definition"]  = { link = "Typedef" },

    -- Переменные
    ["@variable"]           = { fg = c.fg },         -- Обычные переменные
    ["@variable.member"]    = { fg = c.builtin },    -- Поля объектов (obj.field)
    ["@variable.parameter"] = { fg = c.parameter },  -- Параметры функций

    -- Свойства
    ["@property"] = { fg = c.property },

    -- Разметка и документация
    ["@markup"]          = { fg = c.fg },
    ["@markup.heading"]  = { fg = c.keyword, bold = conf.bold }, -- Заголовки
    ["@markup.link"]     = {},                                    -- Ссылки
    ["@markup.link.label"] = { fg = c.string, underline = true },
    ["@markup.link.url"]   = { fg = c.func },
    ["@markup.list"]       = { fg = c.func },       -- Маркеры списков
    ["@markup.quote"]      = { fg = c.comment },    -- Цитаты
    ["@markup.raw"]        = { fg = c.constant },   -- Встроенный код / raw текст
    ["@markup.math"]       = { fg = c.string },

    -- Специальные символы и пунктуация
    ["@punctuation.special"]   = { link = "SpecialChar" },
    ["@string.special.symbol"] = { link = "Identifier" },
    ["@string.special.url"]    = { fg = c.func },

    -- Теги (HTML, JSX, XML и т.д.)
    ["@tag.attribute"] = { link = "Identifier" },
    ["@tag.delimiter"] = { fg = c.fg },

    -- Diff (изменения в коде)
    ["@diff.plus"]  = { link = "DiffAdd" },
    ["@diff.delta"] = { link = "DiffChange" },
    ["@diff.minus"] = { link = "DiffDelete" },
  }

  return hl
end

return M