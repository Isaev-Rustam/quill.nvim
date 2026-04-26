-- ~/lua/catppuccin/palettes/mocha.lua

return {
	-- АКЦЕНТНЫЕ ЦВЕТА
	rosewater = "#f8f8f2", -- курсор (фон), WinBar (имя файла сверху)
	flamingo = "#f28c61", -- обычные переменные, TODO
	pink = "#f0abfc", -- регулярные выражения, escape-символы, Special
	mauve = "#bd93f9", -- ключевые слова (if, else, function, return и т.п.)
	red = "#ff5555", -- ошибки, CurSearch, удалённые строки в diff
	maroon = "#f28c61", -- параметры функций
	peach = "#f28c61", -- константы, числа, встроенные функции
	yellow = "#fdba74", -- типы данных, предупреждения (warnings)
	green = "#cff486", -- строки, добавленные строки в diff
	teal = "#5eead4", -- символы, hints (подсказки), режим INSERT
	sky = "#8be9fd", -- операторы, поиск (Search/IncSearch), информация
	sapphire = "#6272a4", -- метки (labels), preprocessor
	blue = "#a78bfa", -- функции, заголовки, HTML-теги, директории
	lavender = "#a78bfa", -- номер текущей строки (CursorLineNr), UI акценты

	-- ТЕКСТОВАЯ ШКАЛА
	text = "#e7e5e4", -- основной текст в редакторе
	subtext1 = "#d6d3d1", -- чуть приглушённый текст
	subtext0 = "#a8a29e", -- вспомогательный текст (в статусбаре и т.п.)
	overlay2 = "#a8a29e", -- комментарии
	overlay1 = "#78716c", -- Conceal, NonText, FoldColumn, EndOfBuffer
	overlay0 = "#57534e", -- номера строк (LineNr), слабые UI элементы

	-- ФОНОВАЯ ШКАЛА
	surface2 = "#4e4845", -- тонкий highlight
	surface1 = "#44403c", -- выделение (Visual), бордеры, selection, LspReference
	surface0 = "#363130", -- текущая строка (CursorLine), панели, Pmenu
	base = "#1c1917", -- основной фон редактора (Normal)
	mantle = "#292524", -- фон статуслайна, floating окон, панелей
	crust = "#0c0a09", -- самый тёмный: SignColumnSB, TabLine, разделители окон
}
