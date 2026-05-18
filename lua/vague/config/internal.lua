-- lua/vague/config/internal.lua

-- Этот файл отвечает за внутреннюю конфигурацию colorscheme'а.
-- Здесь хранятся настройки по умолчанию и логика их применения.

local M = {}

---@class VagueColorscheme.InternalConfig
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
  ---@param colors VagueColorscheme.InternalConfig.colors
  on_highlights = function(highlights, colors) end,

  ---@class VagueColorscheme.InternalConfig.colors
  colors = {
    ---@type string
    bg          = "#141415",   -- Основной фон редактора (Normal)
    ---@type string
    inactiveBg  = "#1c1c24",   -- Фон неактивных окон, statusline, tabline
    ---@type string
    fg          = "#cdcdcd",   -- Основной цвет текста
    ---@type string
    floatBorder = "#878787",   -- Границы floating окон, telescope, neo-tree и т.д.
    ---@type string
    line        = "#252530",   -- CursorLine, ColorColumn, Pmenu и т.п.
    ---@type string
    comment     = "#606079",   -- Комментарии
    ---@type string
    builtin     = "#b4d4cf",   -- Встроенные функции и типы (@function.builtin, @type.builtin)
    ---@type string
    func        = "#c48282",   -- Обычные функции
    ---@type string
    string      = "#e8b589",   -- Строки
    ---@type string
    number      = "#e0a363",   -- Числа
    ---@type string
    property    = "#c3c3d5",   -- Свойства и поля объектов (@property, @variable.member)
    ---@type string
    constant    = "#aeaed1",   -- Константы, enum'ы
    ---@type string
    parameter   = "#bb9dbd",   -- Параметры функций (@variable.parameter)
    ---@type string
    visual      = "#333738",   -- Цвет визуального выделения (Visual)
    ---@type string
    error       = "#d8647e",   -- Ошибки, удаления в diff, DiagnosticError
    ---@type string
    warning     = "#f3be7c",   -- Предупреждения, DiagnosticWarn
    ---@type string
    hint        = "#7e98e8",   -- Подсказки, DiagnosticHint, некоторые иконки
    ---@type string
    operator    = "#90a0b5",   -- Операторы (+, -, =, -> и т.д.)
    ---@type string
    keyword     = "#6e94b2",   -- Ключевые слова (if, else, for, return, import...)
    ---@type string
    type        = "#9bb4bc",   -- Типы данных (class, struct, type ...)
    ---@type string
    search      = "#405065",   -- Подсветка поиска (Search, IncSearch)
    ---@type string
    plus        = "#7fa563",   -- Добавления в diff, успешные тесты
    ---@type string
    delta       = "#f3be7c",   -- Изменения в diff, Telescope matching
  },
}

-- Сохраняем оригинальные настройки по умолчанию (полезно для сброса)
M._DEFAULT_SETTINGS = DEFAULT_SETTINGS

-- Текущие активные настройки (будут изменяться при setup())
M.current = M._DEFAULT_SETTINGS

-- Читаем пользовательские настройки из глобальной переменной.
-- Поддерживает как таблицу, так и функцию (ленивая инициализация).
local opts = type(vim.g.vague_colorscheme) == "function"
    and vim.g.vague_colorscheme()
    or vim.g.vague_colorscheme
    or {}

---@param user_opts VagueColorscheme.Config
M.set = function(user_opts)
  -- Глубоко объединяем настройки по умолчанию + пользовательские
  M.current = vim.tbl_deep_extend(
    "force",
    vim.deepcopy(M.current),
    user_opts or opts
  )
end

return M