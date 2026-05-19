-- lua/quill/config/internal.lua

-- Этот файл отвечает за внутреннюю конфигурацию colorscheme'а.
-- Здесь хранятся настройки по умолчанию и логика их применения.

local M = {}

---@class QuillColorscheme.InternalConfig
local DEFAULT_SETTINGS = {

  ---@type boolean
  transparent = false,

  ---@type boolean
  bold = true,

  ---@type boolean
  italic = true,

  -- Пользовательский хук, который вызывается после генерации всех highlight групп.
  -- Позволяет тонко настраивать или добавлять любые группы.
  ---@param highlights table<string, vim.api.keyset.highlight>
  ---@param colors QuillColorscheme.InternalConfig.colors
  on_highlights = function(highlights, colors) end,

  ---@class QuillColorscheme.InternalConfig.colors
  colors = {
    ---@type string
    bg          = "#1c1917",   -- Основной фон редактора (Normal)
    ---@type string
    inactiveBg  = "#292524",   -- Фон неактивных окон, statusline, tabline
    ---@type string
    fg          = "#d6d3d1",   -- Основной цвет текста
    ---@type string
    floatBorder = "#44403c",   -- Границы floating окон, telescope, neo-tree и т.д.
    ---@type string
    line        = "#292524",   -- CursorLine, ColorColumn, Pmenu и т.п.
    ---@type string
    comment     = "#78716c",   -- Комментарии
    ---@type string
    builtin     = "#5eead4",   -- Встроенные функции и типы (@function.builtin, @type.builtin)
    ---@type string
    func        = "#f28c61",   -- Обычные функции
    ---@type string
    string      = "#f0abfc",   -- Строки
    ---@type string
    number      = "#a78bfa",   -- Числа
    ---@type string
    property    = "#fdba74",   -- Свойства и поля объектов (@property, @variable.member)
    ---@type string
    constant    = "#a78bfa",   -- Константы, enum'ы
    ---@type string
    parameter   = "#f8f8f2",   -- Параметры функций (@variable.parameter)
    ---@type string
    visual      = "#44403c",   -- Цвет визуального выделения (Visual)
    ---@type string
    error       = "#f28c61",   -- Ошибки, удаления в diff, DiagnosticError
    ---@type string
    warning     = "#fdba74",   -- Предупреждения, DiagnosticWarn
    ---@type string
    hint        = "#5eead4",   -- Подсказки, DiagnosticHint, некоторые иконки
    ---@type string
    operator    = "#d6d3d1",   -- Операторы (+, -, =, -> и т.д.)
    ---@type string
    keyword     = "#a78bfa",   -- Ключевые слова (if, else, for, return, import...)
    ---@type string
    type        = "#d6d3d1",   -- Типы данных (class, struct, type ...)
    ---@type string
    search      = "#a855f7",   -- Подсветка поиска (Search, IncSearch)
    ---@type string
    plus        = "#cff486",   -- Добавления в diff, успешные тесты
    ---@type string
    delta       = "#fdba74",   -- Изменения в diff, Telescope matching
  },
}

-- Сохраняем оригинальные настройки по умолчанию (полезно для сброса)
M._DEFAULT_SETTINGS = DEFAULT_SETTINGS

-- Текущие активные настройки (будут изменяться при setup())
M.current = M._DEFAULT_SETTINGS

-- Читаем пользовательские настройки из глобальной переменной.
-- Поддерживает как таблицу, так и функцию (ленивая инициализация).
local opts = type(vim.g.quill_colorscheme) == "function"
    and vim.g.quill_colorscheme()
    or vim.g.quill_colorscheme
    or {}

---@param user_opts QuillColorscheme.Config
M.set = function(user_opts)
  -- Глубоко объединяем настройки по умолчанию + пользовательские
  M.current = vim.tbl_deep_extend(
    "force",
    vim.deepcopy(M.current),
    user_opts or opts
  )
end

return M