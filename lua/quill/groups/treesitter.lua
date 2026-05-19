-- lua/quill/groups/treesitter.lua

-- Подсветка Treesitter (семантический синтаксический анализ).
-- Справочник: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
--
-- Палитра (напоминание):
--   fg        = "#d6d3d1"  -- основной текст (серо-белый)
--   builtin   = "#5eead4"  -- бирюзовый  → встроенные ф-ции / типы / self
--   func      = "#f28c61"  -- оранжевый  → функции
--   string    = "#f0abfc"  -- лавандовый → строки
--   number    = "#a78bfa"  -- фиолетовый → числа, константы, keyword
--   property  = "#fdba74"  -- персиковый → свойства, member, method.call
--   constant  = "#a78bfa"  -- фиолетовый → (тот же что keyword, разводим через bold)
--   parameter = "#f8f8f2"  -- почти белый → параметры
--   keyword   = "#a78bfa"  -- фиолетовый → ключевые слова (italic)
--   type      = "#d6d3d1"  -- серый       → типы (как fg, разводим через italic)
--   comment   = "#78716c"  -- тёмно-серый → комментарии
--   error     = "#f28c61"  -- оранжевый   → ошибки
--   plus      = "#cff486"  -- зелёный     → добавления
--   delta     = "#fdba74"  -- персиковый  → изменения

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {

    -- ════════════════════════════════════════════════════════════
    -- ПЕРЕМЕННЫЕ
    -- ════════════════════════════════════════════════════════════

    ["@variable"]           = { fg = c.fg },                                      -- Обычные переменные: x, result
    ["@variable.builtin"]   = { fg = c.builtin },                                 -- self, this, super, _ENV
    ["@variable.parameter"] = { fg = c.parameter },                               -- Параметры в сигнатуре: function foo(A, B)
    ["@variable.member"]    = { fg = c.property },                                -- Поля объекта: foo.BAR, self.name

    -- ════════════════════════════════════════════════════════════
    -- КОНСТАНТЫ
    -- ════════════════════════════════════════════════════════════
    -- Чтобы отличить от keyword (тот же цвет #a78bfa) — используем bold

    ["@constant"]         = { fg = c.constant, bold = conf.bold },                -- Пользовательские константы: MAX_SIZE, PI
    ["@constant.builtin"] = { fg = c.number, bold = conf.bold },                  -- nil, true, false, null, undefined
    ["@constant.macro"]   = { link = "Macro" },                                   -- NULL, EOF в C (из препроцессора)

    -- ════════════════════════════════════════════════════════════
    -- СТРОКИ
    -- ════════════════════════════════════════════════════════════

    ["@string"]                   = { fg = c.string },                            -- "hello", 'world'
    ["@string.documentation"]     = { fg = c.string, italic = conf.italic },      -- Python docstrings """..."""
    ["@string.regexp"]            = { fg = c.builtin },                           -- /regex/, r"pattern"
    ["@string.escape"]            = { fg = c.builtin },                           -- \n, \t, \\, \u0041
    ["@string.special"]           = { link = "Special" },                         -- Особые строки: форматные, даты
    ["@string.special.path"]      = { fg = c.string },                            -- Пути в строках
    ["@string.special.symbol"]    = { fg = c.string },                            -- :symbol в Ruby, :atom в Elixir
    ["@string.special.url"]       = { fg = c.func, underline = true },            -- URL / ссылки

    -- ════════════════════════════════════════════════════════════
    -- ЧИСЛА И СИМВОЛЫ
    -- ════════════════════════════════════════════════════════════

    ["@number"]           = { fg = c.number },                                    -- 42, 0xFF, 0b1010
    ["@number.float"]     = { fg = c.number },                                    -- 3.14, 2.3e10
    ["@boolean"]          = { fg = c.number, bold = conf.bold },                  -- true / false (bold = как константы)
    ["@character"]        = { fg = c.string },                                    -- 'c', '\n' в C/Rust
    ["@character.special"] = { link = "SpecialChar" },                            -- Wildcards, метасимволы

    -- ════════════════════════════════════════════════════════════
    -- ТИПЫ
    -- ════════════════════════════════════════════════════════════

    ["@type"]             = { fg = c.type, italic = conf.italic },                -- MyClass, Result<T>, Vec<i32>
    ["@type.builtin"]     = { fg = c.builtin, bold = conf.bold },                 -- int, string, bool, void, any
    ["@type.definition"]  = { fg = c.constant, bold = conf.bold },                -- typedef, type Alias = ...
    ["@type.qualifier"]   = { fg = c.keyword, italic = conf.italic },             -- const, static, readonly (в позиции типа)
    ["@attribute"]        = { fg = c.property },                                  -- @decorator Python, #[derive] Rust
    ["@attribute.builtin"] = { fg = c.builtin },                                  -- Встроенные аннотации

    -- ════════════════════════════════════════════════════════════
    -- ФУНКЦИИ
    -- ════════════════════════════════════════════════════════════

    ["@function"]               = { fg = c.func },                                -- Объявление: function foo() {}
    ["@function.builtin"]       = { fg = c.builtin },                             -- print(), len(), table.insert()
    ["@function.call"]          = { fg = c.func },                                -- Вызов функции: foo()
    ["@function.macro"]         = { fg = c.string, bold = conf.bold },            -- macro_rules!, #define FOO()
    ["@function.method"]        = { fg = c.func },                                -- Определение метода класса
    ["@function.method.call"]   = { fg = c.property },                            -- Вызов метода: obj.method() — персиковый, отличен от @function.call
    ["@constructor"]            = { fg = c.constant },                            -- new Foo(), __init__()
    ["@constructor.lua"]        = { fg = c.type },                                -- {} в Lua (таблица-конструктор)

    -- ════════════════════════════════════════════════════════════
    -- ОПЕРАТОРЫ И ПУНКТУАЦИЯ
    -- ════════════════════════════════════════════════════════════

    ["@operator"]               = { fg = c.operator },                            -- +, -, *, /, =, ==, ->, ::
    ["@punctuation.delimiter"]  = { fg = c.comment },                             -- ; . , : — приглушённые
    ["@punctuation.bracket"]    = { fg = c.fg },                                  -- ( ) [ ] { }
    ["@punctuation.special"]    = { link = "SpecialChar" },                       -- ${} в интерполяции, * в splat

    -- ════════════════════════════════════════════════════════════
    -- КЛЮЧЕВЫЕ СЛОВА
    -- ════════════════════════════════════════════════════════════

    ["@keyword"]                      = { fg = c.keyword, italic = conf.italic }, -- Всё что не попало в другие группы
    ["@keyword.modifier"]             = { fg = c.keyword, italic = conf.italic }, -- const, static, public, private, async
    ["@keyword.type"]                 = { fg = c.keyword, italic = conf.italic }, -- struct, enum, class, interface, type
    ["@keyword.coroutine"]            = { fg = c.keyword, italic = conf.italic }, -- async, await, go, yield, suspend
    ["@keyword.function"]             = { fg = c.keyword },                       -- function, def, fn, fun, sub
    ["@keyword.operator"]             = { fg = c.keyword },                       -- and, or, not, in, is, instanceof
    ["@keyword.import"]               = { link = "PreProc" },                     -- import, require, use, #include
    ["@keyword.repeat"]               = { fg = c.keyword },                       -- for, while, loop, do, foreach
    ["@keyword.return"]               = { fg = c.keyword, italic = conf.italic }, -- return, yield
    ["@keyword.debug"]                = { link = "Exception" },                   -- debugger, breakpoint
    ["@keyword.exception"]            = { fg = c.keyword, bold = conf.bold },     -- try, catch, throw, raise, rescue
    ["@keyword.conditional"]          = { fg = c.keyword },                       -- if, else, elif, switch, case, when
    ["@keyword.conditional.ternary"]  = { fg = c.operator },                      -- ? и : в тернарном выражении
    ["@keyword.directive"]            = { link = "PreProc" },                     -- #pragma, #!/usr/bin/env
    ["@keyword.directive.define"]     = { link = "Define" },                      -- #define, #undef
    ["@keyword.export"]               = { fg = c.keyword, italic = conf.italic }, -- export, export default

    -- ════════════════════════════════════════════════════════════
    -- МОДУЛИ И МЕТКИ
    -- ════════════════════════════════════════════════════════════

    ["@module"]  = { fg = c.builtin, italic = conf.italic },                      -- namespace, import X from 'y'
    ["@label"]   = { fg = c.string },                                             -- case:, default:, goto label

    -- ════════════════════════════════════════════════════════════
    -- СВОЙСТВА
    -- ════════════════════════════════════════════════════════════

    ["@property"] = { fg = c.property },                                          -- foo.PROPERTY — персиковый

    -- ════════════════════════════════════════════════════════════
    -- КОММЕНТАРИИ
    -- ════════════════════════════════════════════════════════════

    ["@comment"]               = { fg = c.comment, italic = conf.italic },        -- // ..., # ..., /* ... */
    ["@comment.documentation"] = { fg = c.comment },                              -- JSDoc, /** */, ///, ##
    ["@comment.error"]         = { fg = c.bg, bg = c.error },                     -- ERROR:, BUG:, FIXME:
    ["@comment.warning"]       = { fg = c.bg, bg = c.warning },                   -- WARNING:, WARN:, HACK:
    ["@comment.hint"]          = { fg = c.bg, bg = c.hint },                      -- HINT:, NOTE:
    ["@comment.todo"]          = { fg = c.bg, bg = c.property },                  -- TODO:, FIXME: — персиковый фон
    ["@comment.note"]          = { fg = c.bg, bg = c.string },                    -- NOTE:, INFO: — лавандовый фон

    -- ════════════════════════════════════════════════════════════
    -- РАЗМЕТКА (Markdown, RST, AsciiDoc)
    -- ════════════════════════════════════════════════════════════

    ["@markup"]                   = { fg = c.fg },                                -- Обычный текст в файлах разметки
    ["@markup.strong"]            = { fg = c.fg, bold = true },                   -- **Жирный**
    ["@markup.italic"]            = { fg = c.fg, italic = true },                 -- *Курсив*
    ["@markup.strikethrough"]     = { fg = c.comment, strikethrough = true },     -- ~~Зачёркнутый~~
    ["@markup.underline"]         = { underline = true },                         -- Подчёркнутый
    ["@markup.heading"]           = { fg = c.keyword, bold = conf.bold },         -- # Заголовки
    ["@markup.math"]              = { fg = c.string },                            -- $x^2$, $$...$$
    ["@markup.quote"]             = { fg = c.comment, italic = conf.italic },     -- > Цитата
    ["@markup.environment"]       = { fg = c.keyword },                           -- \begin{} в LaTeX
    ["@markup.environment.name"]  = { fg = c.func },                              -- Имя окружения: figure, table
    ["@markup.link"]              = { fg = c.string },                            -- Ссылки и сноски
    ["@markup.link.label"]        = { fg = c.string, underline = true },          -- [ЭТОТ ТЕКСТ](url)
    ["@markup.link.url"]          = { fg = c.func, italic = conf.italic, underline = true }, -- [text](ЭТА ССЫЛКА)
    ["@markup.raw"]               = { fg = c.constant },                          -- `инлайн-код` и блоки кода
    ["@markup.list"]              = { fg = c.func },                              -- - / * / + / 1.
    ["@markup.list.checked"]      = { fg = c.plus },                              -- [x] выполнено — зелёный
    ["@markup.list.unchecked"]    = { fg = c.comment },                           -- [ ] не выполнено — серый

    -- ════════════════════════════════════════════════════════════
    -- DIFF
    -- ════════════════════════════════════════════════════════════

    ["@diff.plus"]  = { link = "DiffAdd" },                                       -- + добавленные строки
    ["@diff.delta"] = { link = "DiffChange" },                                    -- ~ изменённые строки
    ["@diff.minus"] = { link = "DiffDelete" },                                    -- - удалённые строки

    -- ════════════════════════════════════════════════════════════
    -- HTML / JSX / XML ТЕГИ
    -- ════════════════════════════════════════════════════════════

    ["@tag"]            = { fg = c.keyword },                                     -- <DIV>, <span>, <MyComponent>
    ["@tag.builtin"]    = { fg = c.builtin },                                     -- Встроенные JSX теги: <div>
    ["@tag.attribute"]  = { fg = c.property, italic = conf.italic },              -- <div CLASS="foo">
    ["@tag.delimiter"]  = { fg = c.comment },                                     -- < > / в <div> </div>

    -- ════════════════════════════════════════════════════════════
    -- ОШИБКИ
    -- ════════════════════════════════════════════════════════════

    ["@error"] = { link = "Error" },                                              -- Синтаксические ошибки парсера

    -- ════════════════════════════════════════════════════════════
    -- СПЕЦИФИКА ЯЗЫКОВ
    -- ════════════════════════════════════════════════════════════

    -- ════════════════════════════════════════════════════════════
    -- TYPESCRIPT / JAVASCRIPT
    -- ════════════════════════════════════════════════════════════

    -- Объявления переменных
    ["@keyword.modifier.typescript"]        = { fg = c.keyword, italic = conf.italic }, -- const, let, var, readonly
    ["@keyword.modifier.javascript"]        = { fg = c.keyword, italic = conf.italic },
    ["@keyword.modifier.tsx"]               = { fg = c.keyword, italic = conf.italic },

    -- Функции и классы
    ["@keyword.function.typescript"]        = { fg = c.keyword },                  -- function, async function
    ["@keyword.function.javascript"]        = { fg = c.keyword },
    ["@keyword.coroutine.typescript"]       = { fg = c.keyword, italic = conf.italic }, -- async, await
    ["@keyword.coroutine.javascript"]       = { fg = c.keyword, italic = conf.italic },

    -- Типы (TS-специфика)
    ["@type.typescript"]                    = { fg = c.type, italic = conf.italic }, -- MyClass, Result<T>
    ["@type.builtin.typescript"]            = { fg = c.builtin, bold = conf.bold },  -- number, string, boolean, void, any, never
    ["@type.builtin.javascript"]            = { fg = c.builtin, bold = conf.bold },

    -- new Map<K,V>() — конструктор как тип
    ["@constructor.typescript"]             = { fg = c.constant, bold = conf.bold }, -- new Foo()
    ["@constructor.javascript"]             = { fg = c.constant, bold = conf.bold },

    -- Вызовы методов: match.has(), match.get() → персиковый
    ["@function.method.call.typescript"]    = { fg = c.property },
    ["@function.method.call.javascript"]    = { fg = c.property },

    -- this.field, obj.prop → персиковый
    ["@variable.member.typescript"]         = { fg = c.property },
    ["@variable.member.javascript"]         = { fg = c.property },

    -- typeof, instanceof, keyof, as, in
    ["@keyword.operator.typescript"]        = { fg = c.keyword },
    ["@keyword.operator.javascript"]        = { fg = c.keyword },

    -- export, export default
    ["@keyword.export.typescript"]          = { fg = c.keyword, italic = conf.italic },
    ["@keyword.export.javascript"]          = { fg = c.keyword, italic = conf.italic },

    -- import / require
    ["@keyword.import.typescript"]          = { link = "PreProc" },
    ["@keyword.import.javascript"]          = { link = "PreProc" },

    -- Bash
    ["@function.builtin.bash"]    = { fg = c.builtin, italic = conf.italic },     -- echo, cd, source, export
    ["@variable.parameter.bash"]  = { fg = c.parameter },                         -- $1, $2, $@, $#

    -- Lua
    -- ["@constructor.lua"] уже определён выше (fg = c.type)

    -- YAML
    ["@label.yaml"] = { fg = c.property },                                        -- &anchor, *alias

    -- Ruby
    ["@string.special.symbol.ruby"] = { fg = c.string },                         -- :name, :status

    -- CSS / SCSS
    ["@property.css"]          = { fg = c.keyword },                             -- color, display, margin
    ["@property.scss"]         = { fg = c.keyword },
    ["@property.id.css"]       = { fg = c.func },                                -- #my-id
    ["@property.class.css"]    = { fg = c.func },                                -- .my-class
    ["@type.css"]              = { fg = c.builtin },                             -- px, em, %, rgb
    ["@type.tag.css"]          = { fg = c.keyword },                             -- div, p, span, body
    ["@string.plain.css"]      = { fg = c.fg },                                  -- "Arial", url("...")
    ["@number.css"]            = { fg = c.number },                              -- 10px, 2em, 0.5, 100%
    ["@keyword.directive.css"] = { link = "Keyword" },                           -- @media, @keyframes, @import

    -- HTML
    ["@string.special.url.html"]  = { fg = c.func, underline = true },           -- href="..."
    ["@markup.link.label.html"]   = { fg = c.fg },                               -- Текст между тегами <a>
    ["@character.special.html"]   = { fg = c.error },                            -- &amp; &nbsp; &lt;

    -- C / C++
    ["@keyword.import.c"]   = { fg = c.builtin },                                -- #include
    ["@keyword.import.cpp"] = { fg = c.builtin },

  }

  return hl
end

return M