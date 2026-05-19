-- lua/quill/groups/common.lua

-- Основные highlight-группы Neovim (самые важные и часто используемые).
-- Это фундаментальная подсветка интерфейса редактора.

local M = {}

---@param conf QuillColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    ColorColumn        = { bg = c.line },          -- Цветная колонка (по `:set colorcolumn=80`)
    Conceal            = { fg = c.func },          -- Скрытый текст (например, в markdown, help)
    CurSearch          = { fg = c.fg, bg = c.search }, -- Текущее найденное совпадение при поиске
    CursorColumn       = { bg = c.line },          -- Вертикальная линия под курсором
    CursorLine         = { bg = c.line },          -- Горизонтальная строка под курсором
    CursorLineNr       = { fg = c.fg },            -- Номер текущей строки (текущий LineNr)
    Debug              = { fg = c.constant },      -- Отладочные сообщения
    debugPC            = { fg = c.bg, bg = c.fg }, -- Текущая позиция в отладчике
    debugBreakpoint    = { fg = c.bg, bg = c.operator }, -- Точка останова в отладчике
    Directory          = { fg = c.hint },         -- Цвет директорий в netrw, telescope и т.д.
    OkMsg              = { fg = c.plus },          -- Сообщения об успехе
    ErrorMsg           = { fg = c.error, bold = conf.bold }, -- Сообщения об ошибках
    FloatTitle         = { link = "NormalFloat" }, -- Заголовок floating окон
    FloatShadow        = { bg = c.visual },        -- Тень floating окон
    FloatShadowThrough = { bg = c.visual },        -- Тень при наложении окон
    Folded             = { fg = c.comment, bg = not conf.transparent and c.line or nil }, -- Свернутый код
    FoldColumn         = { fg = c.comment },       -- Колонка со сворачиванием (+, -)
    IncSearch          = { fg = c.bg, bg = c.search }, -- Поиск по мере набора (incremental search)
    LineNr             = { fg = c.comment },       -- Номера строк
    MatchParen         = { fg = c.fg, bg = c.visual }, -- Подсветка парных скобок
    MoreMsg            = { fg = c.func, bold = conf.bold }, -- Сообщение "more" (при -- More --)
    MsgSeparator       = { fg = c.string, bg = not conf.transparent and c.line or nil, bold = conf.bold },
    NonText            = { fg = c.comment },       -- Невидимые символы (eol, extends, precedes)
    Normal             = { fg = c.fg, bg = not conf.transparent and c.bg or nil }, -- Основной текст и фон
    NormalFloat        = { fg = c.fg, bg = not conf.transparent and c.inactiveBg or nil }, -- Фон floating окон
    ModeMsg            = { fg = c.string },        -- Сообщение о режиме (например -- INSERT --)
    Pmenu              = { fg = c.fg, bg = not conf.transparent and c.line or nil }, -- Popup меню (автодополнение)
    PmenuThumb         = { bg = c.comment },       -- Ползунок в popup меню
    Question           = { fg = c.constant },      -- Вопросы (например, при :confirm)
    QuickFixLine       = { bg = c.inactiveBg },    -- Текущая строка в quickfix/loclist
    qfError            = { fg = c.error },         -- Ошибки в quickfix
    Search             = { fg = c.fg, bg = c.search }, -- Обычный поиск
    SignColumn         = { fg = c.fg },            -- Колонка знаков (git, diagnostics и т.д.)
    SpecialKey         = { fg = c.comment },       -- Специальные клавиши (например, <Tab>)
    SpellBad           = { sp = c.error, undercurl = true }, -- Орфографическая ошибка
    SpellCap           = { sp = c.delta, undercurl = true }, -- Слово с большой буквы
    SpellLocal         = { sp = c.hint, undercurl = true },
    SpellRare          = { sp = c.constant, undercurl = true },
    StatusLine         = { fg = c.fg, bg = not conf.transparent and c.inactiveBg or nil }, -- Активная statusline
    StatusLineTerm     = { fg = c.fg, bg = not conf.transparent and c.inactiveBg or nil },
    StatusLineNC       = { fg = c.comment },       -- Неактивная statusline
    StatusLineTermNC   = { fg = c.comment },
    Substitute         = { fg = c.type, bg = c.visual }, -- Подсветка при :substitute
    TabLine            = { fg = c.comment, bg = not conf.transparent and c.inactiveBg or nil }, -- Неактивные табы
    Visual             = { bg = c.visual },        -- Визуальное выделение
    VisualNOS          = { bg = c.comment, underline = true }, -- Выделение в терминале без GUI
    WarningMsg         = { fg = c.warning, bold = conf.bold }, -- Предупреждения
    Whitespace         = { fg = c.line },          -- Пробельные символы (trailing spaces и т.д.)
    WildMenu           = { fg = c.bg, bg = c.func }, -- Выпадающее меню командной строки
    WinSeparator       = { fg = c.floatBorder },   -- Разделители окон (вертикальные и горизонтальные)
    WinBar             = { fg = c.fg, bg = c.inactiveBg }, -- WinBar (строка сверху окна)
    WinBarNC           = { fg = c.comment },       -- Неактивная WinBar
  }

  return hl
end

return M