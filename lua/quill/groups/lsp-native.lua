-- lua/quill/groups/lsp-native.lua

-- Подсветка семантических токенов от LSP (Native LSP Semantic Tokens).
-- Эти группы имеют НАИВЫСШИЙ приоритет — перекрывают treesitter.
--
-- Иерархия цветов для типов:
--   number, string, bool        → бирюзовый bold   (c.builtin)  — встроенные типы
--   Map, Array, MyClass         → фиолетовый italic (c.constant) — пользовательские типы
--   переменные (match, diff...) → серый/белый       (c.fg)       — @variable
--   константы readonly          → фиолетовый bold   (c.constant) — отличаются от типов стилем

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- ====================== Типы ======================
    ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },             -- nil, true, false, undefined
    ["@lsp.type.builtinType"]     = { fg = c.builtin, bold = conf.bold },       -- number, string, boolean, void, any, never
    ["@lsp.type.class"]           = { fg = c.constant, italic = conf.italic },  -- Map, Array, Set, MyClass, React.FC
    ["@lsp.type.enum"]            = { fg = c.constant, italic = conf.italic },  -- enum Direction {}
    ["@lsp.type.interface"]       = { fg = c.constant, italic = conf.italic },  -- interface IUser {}
    ["@lsp.type.typeParameter"]   = { fg = c.constant },                        -- Generics: T, K, V
    ["@lsp.type.type"]            = { fg = c.constant, italic = conf.italic },  -- type Alias = ..., кастомные типы

    -- ====================== Функции и методы ======================
    ["@lsp.type.function"]                   = { link = "@function.call" },         -- foo()
    ["@lsp.type.method"]                     = { link = "@function.method.call" },  -- obj.method()
    ["@lsp.typemod.function.builtin"]        = { link = "@function.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },      -- console.log, Math.floor
    ["@lsp.typemod.function.definition"]     = { link = "@function" },              -- function foo() {}
    ["@lsp.typemod.method.definition"]       = { link = "@function" },              -- getName() {}

    -- ====================== Переменные ======================
    ["@lsp.type.variable"]                   = { link = "@variable" },
    ["@lsp.typemod.variable.local"]          = { link = "@variable" },

    -- readonly переменные — bold отличает от обычных переменных
    ["@lsp.typemod.variable.readonly"]       = { fg = c.constant, bold = conf.bold },
    ["@lsp.typemod.property.readonly"]       = { fg = c.constant, bold = conf.bold },

    -- Переменные из стандартной библиотеки (console, process, Math...)
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },

    -- Определение переменной при объявлении
    ["@lsp.typemod.variable.definition"]     = { link = "@variable" },

    -- ====================== Параметры ======================
    ["@lsp.type.parameter"]     = { link = "@variable.parameter" },

    -- ====================== Свойства / поля ======================
    ["@lsp.type.property"]      = { link = "@property" },
    ["@lsp.type.enumMember"]    = { fg = c.constant, bold = conf.bold },

    -- ====================== Прочее ======================
    ["@lsp.type.namespace"]       = { link = "@module" },
    ["@lsp.type.macro"]           = { link = "Macro" },
    ["@lsp.type.selfParameter"]   = { link = "@variable.builtin" },
    ["@lsp.type.generic"]         = { fg = c.constant },
    ["@lsp.type.comment"]         = { link = "Comment" },

    -- ====================== TypeScript / JavaScript ======================

    -- Переменные
    ["@lsp.typemod.variable.local.typescript"]      = { link = "@variable" },
    ["@lsp.typemod.variable.local.javascript"]      = { link = "@variable" },
    ["@lsp.typemod.variable.local.typescriptreact"] = { link = "@variable" },

    -- readonly/const переменные в TS
    ["@lsp.typemod.variable.readonly.typescript"]   = { fg = c.constant, bold = conf.bold },
    ["@lsp.typemod.variable.readonly.javascript"]   = { fg = c.constant, bold = conf.bold },

    -- Встроенные типы
    ["@lsp.type.builtinType.typescript"]            = { fg = c.builtin, bold = conf.bold },
    ["@lsp.type.builtinType.javascript"]            = { fg = c.builtin, bold = conf.bold },

    -- Классы и интерфейсы
    ["@lsp.type.class.typescript"]                  = { fg = c.constant, italic = conf.italic },
    ["@lsp.type.class.javascript"]                  = { fg = c.constant, italic = conf.italic },
    ["@lsp.type.interface.typescript"]              = { fg = c.constant, italic = conf.italic },
    ["@lsp.type.type.typescript"]                   = { fg = c.constant, italic = conf.italic },

    -- Методы и функции
    ["@lsp.typemod.method.definition.typescript"]   = { link = "@function" },
    ["@lsp.typemod.method.definition.javascript"]   = { link = "@function" },
    ["@lsp.typemod.function.async.typescript"]      = { link = "@function" },
    ["@lsp.typemod.function.async.javascript"]      = { link = "@function" },
  }

  return hl
end

return M