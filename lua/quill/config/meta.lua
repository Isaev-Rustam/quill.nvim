-- lua/quill/config/meta.lua

-- Файл с Type Annotations (типами) для colorscheme'а.
-- Нужен для удобства и подсказок при конфигурации в Neovim (Lua LSP).

-- Причина существования двух файлов (meta.lua + internal.lua):
-- Чтобы при использовании require("quill").setup({}) не было раздражающих
-- предупреждений от Lua LSP о "missing fields".
-- Да, приходится поддерживать два файла, но это сильно повышает удобство.

---@alias CodeStyle "none"|"italic"|"bold"

-- ================================================================
-- Цветовая палитра (можно переопределять пользователем)
-- ================================================================
---@class QuillColorscheme.colors
---@field bg?          string   -- Основной фон редактора
---@field inactiveBg?  string   -- Фон неактивных окон, tabline, statusline
---@field fg?          string   -- Основной цвет текста
---@field floatBorder? string   -- Границы всплывающих окон (Telescope, hover и т.д.)
---@field line?        string   -- CursorLine, ColorColumn, Pmenu
---@field comment?     string   -- Комментарии
---@field builtin?     string   -- Встроенные функции/типы
---@field func?        string   -- Функции
---@field string?      string   -- Строки
---@field number?      string   -- Числа
---@field property?    string   -- Свойства объектов
---@field constant?    string   -- Константы
---@field parameter?   string   -- Параметры функций
---@field visual?      string   -- Цвет визуального выделения
---@field error?       string   -- Ошибки
---@field warning?     string   -- Предупреждения
---@field hint?        string   -- Подсказки
---@field operator?    string   -- Операторы
---@field keyword?     string   -- Ключевые слова
---@field type?        string   -- Типы данных
---@field search?      string   -- Подсветка поиска
---@field plus?        string   -- Добавления (diff, success)
---@field delta?       string   -- Изменения (diff, matching)

-- ================================================================
-- Основная конфигурация плагина
-- ================================================================
---@class QuillColorscheme.Config
---@field transparent?   boolean                          -- Прозрачный фон
---@field bold?          boolean                          -- Использовать жирный текст
---@field italic?        boolean                          -- Использовать курсив
---@field colors?        QuillColorscheme.colors          -- Переопределение цветов
---@field on_highlights? fun(highlights: table<string, vim.api.keyset.highlight>, colors: QuillColorscheme.InternalConfig.colors)
--                   ^ Хук для тонкой настройки любой highlight-группы

-- Глобальная переменная для конфигурации (можно задать до загрузки темы)
---@type QuillColorscheme.Config | fun():QuillColorscheme.Config | nil
vim.g.quill_colorscheme = vim.g.quill_colorscheme