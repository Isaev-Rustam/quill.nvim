-- lua/vague/groups/lsp-native.lua

-- Подсветка семантических токенов от LSP (Native LSP Semantic Tokens).
-- Эти группы предоставляет сам Neovim через Language Server Protocol.
--
-- Большинство правил здесь просто "линкуются" на уже существующие Treesitter-группы,
-- чтобы цвета были согласованными между Treesitter и LSP.

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  -- stylua: ignore
  local hl = {
    -- ====================== Типы ======================
    ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" }, -- Встроенные константы (например nil, true)
    ["@lsp.type.builtinType"]     = { link = "@type.builtin" },     -- Встроенные типы (int, string, bool)
    ["@lsp.type.class"]           = { link = "Structure" },         -- Классы
    ["@lsp.type.enum"]            = { link = "Structure" },         -- Enum'ы
    ["@lsp.type.interface"]       = { link = "Structure" },         -- Интерфейсы
    ["@lsp.type.typeParameter"]   = { link = "Typedef" },           -- Параметры типов (generics)

    -- ====================== Функции и методы ======================
    ["@lsp.type.function"]        = { link = "@function.call" },    -- Вызовы функций
    ["@lsp.type.method"]          = { link = "@function.method" },  -- Вызовы методов
    ["@lsp.typemod.function.builtin"]        = { link = "@function.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" }, -- Функции из стандартной библиотеки
    ["@lsp.typemod.function.definition"]     = { link = "@function" },         -- Определения функций

    -- ====================== Переменные ======================
    ["@lsp.type.variable"]                   = { link = "@constant" },          -- Переменные
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@constant.builtin" },  -- Встроенные переменные
    ["@lsp.typemod.variable.definition"]     = { link = "@property" },          -- Определение переменной

    -- ====================== Другие ======================
    ["@lsp.type.namespace"]   = { link = "@module" },           -- Пространства имён
    ["@lsp.type.parameter"]   = { link = "@variable.parameter" }, -- Параметры функций
    ["@lsp.type.property"]    = { link = "@type" },             -- Свойства/поля
    ["@lsp.type.enumMember"]  = { link = "@variable.member" },  -- Значения enum
    ["@lsp.type.macro"]       = { link = "Macro" },             -- Макросы
    ["@lsp.type.selfParameter"] = { link = "Special" },         -- Параметр self/this
    ["@lsp.type.generic"]     = { link = "@type" },             -- Генерики
    ["@lsp.type.comment"]     = { link = "Comment" },           -- Комментарии от LSP
  }

  return hl
end

return M