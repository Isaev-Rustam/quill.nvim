-- ~/lua/catppuccin/groups/treesitter.lua
local M = {}

function M.get()
	if vim.treesitter.highlighter.hl_map then
		vim.notify_once(
			[[Catppuccin (info):
nvim-treesitter integration requires neovim 0.8
If you want to stay on nvim 0.7, pin catppuccin tag to v0.2.4 and nvim-treesitter commit to 4cccb6f494eb255b32a290d37c35ca12584c74d0.
]],
			vim.log.levels.INFO
		)
		return {}
	end

	-- Справочник: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
	local colors = {

		-- ══════════════════════════════════════════════════════════
		-- ПЕРЕМЕННЫЕ И ИДЕНТИФИКАТОРЫ
		-- ══════════════════════════════════════════════════════════

		["@variable"] = { fg = C.text, style = O.styles.variables or {} },
		-- Любое имя переменной, у которого нет более специфичной группы
		-- Пример: x, result, data → белый (C.text)

		["@variable.builtin"] = { fg = C.blue, style = O.styles.properties or {} },
		-- Переменные, встроенные в язык: this, self, super, arguments

		["@variable.parameter"] = { fg = C.text, style = O.styles.variables or {} },
		-- Параметры функции в её сигнатуре: function foo(NUM, TARGET)
		-- Оранжевый — в точке объявления параметра

		["@variable.member"] = { fg = C.lavender },
		-- Поля структур/объектов: foo.BAR, self.name

		-- ══════════════════════════════════════════════════════════
		-- КОНСТАНТЫ
		-- ══════════════════════════════════════════════════════════

		["@constant"] = { link = "Constant" },
		-- Пользовательские константы: MAX_SIZE, PI
		-- Наследует от syntax.lua → C.peach (оранжевый)

		["@constant.builtin"] = { fg = C.peach, style = O.styles.keywords or {} },
		-- Встроенные константы языка: nil, null, true, false, None, undefined
		-- те же цвет что у Boolean/Number

		["@constant.macro"] = { link = "Macro" },
		-- Константы из макросов препроцессора: NULL, EOF в C
		-- Наследует от syntax.lua → C.mauve (фиолетовый)

		-- ══════════════════════════════════════════════════════════
		-- МОДУЛИ И МЕТКИ
		-- ══════════════════════════════════════════════════════════

		["@module"] = { fg = C.yellow, style = O.styles.miscs or { "italic" } },
		-- Модули и пространства имён: import X from 'y', namespace Foo
		-- Жёлтый курсив — выделяет импорты среди остального кода

		["@label"] = { link = "Label" },
		-- Метки: case:, default:, goto label, :label: в Lua
		-- Наследует от syntax.lua → C.sapphire (сине-серый)

		-- ══════════════════════════════════════════════════════════
		-- СТРОКИ И ЛИТЕРАЛЫ
		-- ══════════════════════════════════════════════════════════

		["@string"] = { link = "String" },
		-- Обычные строковые литералы: "hello", 'world'
		-- Наследует от syntax.lua → C.green (лаймовый)

		["@string.documentation"] = { fg = C.teal, style = O.styles.strings or {} },
		-- Строки-документация: Python docstrings """, Julia doc-комментарии
		-- Бирюзовый — чуть отличается от обычных строк

		["@string.regexp"] = { fg = C.pink, style = O.styles.strings or {} },
		-- Регулярные выражения: /pattern/, r"regex"
		-- Фуксия — отличает regex от обычных строк

		["@string.escape"] = { fg = C.pink, style = O.styles.strings or {} },
		-- Escape-последовательности внутри строк: \n, \t, \\, \u0041
		-- Фуксия — те же цвет что у regex

		["@string.special"] = { link = "Special" },
		-- Особые строки: даты, форматные строки, шаблоны
		-- Наследует → C.pink

		["@string.special.path"] = { link = "Special" },
		-- Пути к файлам в строках
		-- Наследует → C.pink

		["@string.special.symbol"] = { fg = C.flamingo },
		-- Символы/атомы: :symbol в Ruby, :atom в Elixir
		-- Оранжево-коралловый

		["@string.special.url"] = { fg = C.blue, style = { "italic", "underline" } },
		-- URL-адреса, ссылки и email вне разметки
		-- Фиолетовый, курсив, подчёркивание

		["@punctuation.delimiter.regex"] = { link = "@string.regexp" },
		-- Разделители регулярных выражений (/ в /pattern/)
		-- Наследует цвет от @string.regexp → фуксия

		-- ══════════════════════════════════════════════════════════
		-- СИМВОЛЫ И ЧИСЛА
		-- ══════════════════════════════════════════════════════════

		["@character"] = { link = "Character" },
		-- Символьные литералы: 'c', '\n' в C/Rust
		-- Наследует от syntax.lua → C.teal (бирюзовый)

		["@character.special"] = { link = "SpecialChar" },
		-- Специальные символы: wildcards, метасимволы
		-- Наследует → C.pink

		["@boolean"] = { link = "Boolean" },
		-- Булевы значения: true, false, True, False
		-- Наследует от syntax.lua → C.peach (оранжевый)

		["@number"] = { link = "Number" },
		-- Целые числа: 42, 0xFF, 0b1010
		-- Наследует от syntax.lua → C.peach (оранжевый)

		["@number.float"] = { link = "Float" },
		-- Числа с плавающей точкой: 3.14, 2.3e10
		-- Наследует → C.peach (через Float → Number)

		-- ══════════════════════════════════════════════════════════
		-- ТИПЫ
		-- ══════════════════════════════════════════════════════════

		["@type"] = { link = "Type" },
		-- Пользовательские типы: MyClass, Result<T>, Vec<i32>
		-- Наследует от syntax.lua → C.yellow (жёлтый)

		["@type.builtin"] = { fg = C.mauve, style = O.styles.types or {} },
		-- Встроенные типы языка: int, string, bool, void, any
		-- Фиолетовый — отличается от пользовательских типов

		["@type.definition"] = { link = "Type" },
		-- Определения типов: typedef, type Alias = ...
		-- Наследует → C.yellow

		["@attribute"] = { link = "Constant" },
		-- Аннотации и декораторы: @decorator в Python, #[derive] в Rust
		-- Наследует → C.peach

		["@property"] = { fg = C.yellow, style = O.styles.properties or {} },
		-- Доступ к свойствам объекта: foo.PROPERTY
		-- (переопределяется для CSS и других языков)

		-- ══════════════════════════════════════════════════════════
		-- ФУНКЦИИ
		-- ══════════════════════════════════════════════════════════

		["@function"] = { link = "Function" },
		-- Определения и вызовы функций: function foo() {}, foo()
		-- Наследует от syntax.lua → C.blue (фиолетово-синий)

		["@function.builtin"] = { fg = C.peach, style = O.styles.functions or {} },
		-- Встроенные функции языка: print(), len(), table.insert()
		-- Оранжевый — выделяет стандартную библиотеку

		["@function.call"] = { link = "Function" },
		-- Вызовы функций отдельно от определений: foo()
		-- Наследует → C.blue

		["@function.macro"] = { fg = C.pink, style = O.styles.functions or {} },
		-- Макро-функции: macro_rules! в Rust, #define FOO() в C
		-- Фуксия — отличает макросы от обычных функций

		["@function.method"] = { link = "Function" },
		-- Определения методов класса: def method(self):
		-- Наследует → C.blue

		["@function.method.call"] = { link = "Function" },
		-- Вызовы методов: obj.method()
		-- Наследует → C.blue

		["@constructor"] = { fg = C.yellow },
		-- Конструкторы: new Foo(), __init__(), = {} в Lua
		-- Жёлтый — как тип, которому принадлежит конструктор

		["@operator"] = { link = "Operator" },
		-- Операторы: +, -, *, /, =, ==, ->, ::, instanceof
		-- Наследует от syntax.lua → C.sky (голубой)

		-- ══════════════════════════════════════════════════════════
		-- КЛЮЧЕВЫЕ СЛОВА
		-- ══════════════════════════════════════════════════════════

		["@keyword"] = { link = "Keyword" },
		-- Ключевые слова, не попавшие в другие категории
		-- Наследует от syntax.lua → C.mauve (фиолетовый)

		["@keyword.modifier"] = { link = "Keyword" },
		-- Модификаторы: const, static, public, private, readonly, async
		-- Наследует → C.mauve

		["@keyword.type"] = { link = "Keyword" },
		-- Ключевые слова типов: struct, enum, class, interface, type
		-- Наследует → C.mauve

		["@keyword.coroutine"] = { link = "Keyword" },
		-- Корутины: async, await, go, yield, suspend
		-- Наследует → C.mauve

		["@keyword.function"] = { fg = C.mauve, style = O.styles.keywords or {} },
		-- Слова для объявления функций: function, def, fn, fun, sub
		-- Фиолетовый

		["@keyword.operator"] = { fg = C.mauve, style = O.styles.keywords or {} },
		-- Операторы-ключевые слова: and, or, not, in, is, instanceof, typeof
		-- Фиолетовый

		["@keyword.import"] = { link = "Include" },
		-- Импорты: import, require, use, #include, extern crate
		-- Наследует от syntax.lua → C.mauve

		["@keyword.repeat"] = { link = "Repeat" },
		-- Циклы: for, while, loop, do, foreach
		-- Наследует от syntax.lua → C.mauve

		["@keyword.return"] = { fg = C.mauve, style = O.styles.keywords or {} },
		-- Возврат из функции: return, yield
		-- Фиолетовый

		["@keyword.debug"] = { link = "Exception" },
		-- Отладочные ключевые слова: debugger, breakpoint
		-- Наследует → C.mauve

		["@keyword.exception"] = { link = "Exception" },
		-- Исключения: try, catch, throw, raise, rescue, finally
		-- Наследует → C.mauve

		["@keyword.conditional"] = { link = "Conditional" },
		-- Условия: if, else, elif, switch, case, when, unless
		-- Наследует от syntax.lua → C.mauve

		["@keyword.conditional.ternary"] = { link = "Operator" },
		-- Тернарный оператор: ? и : в выражении cond ? a : b
		-- Наследует от Operator → C.sky (голубой)

		["@keyword.directive"] = { link = "PreProc" },
		-- Директивы препроцессора и шебанги: #pragma, #!/usr/bin/env
		-- Наследует → C.pink

		["@keyword.directive.define"] = { link = "Define" },
		-- Директивы определения: #define, #undef
		-- Наследует → C.pink

		["@keyword.export"] = { fg = C.mauve, style = O.styles.keywords },
		-- Экспорт в JS/TS: export, export default, module.exports
		-- Фиолетовый

		-- ══════════════════════════════════════════════════════════
		-- ПУНКТУАЦИЯ
		-- ══════════════════════════════════════════════════════════

		["@punctuation.delimiter"] = { link = "Delimiter" },
		-- Разделители: ; . , : в обычном коде
		-- Наследует от syntax.lua → C.overlay2 (приглушённый)

		["@punctuation.bracket"] = { fg = C.overlay2 },
		-- Скобки: ( ) [ ] { }
		-- Приглушённый — не отвлекают от содержимого

		["@punctuation.special"] = { link = "Special" },
		-- Особая пунктуация: {} в интерполяции строк ${}, * в splat
		-- Наследует → C.pink

		-- ══════════════════════════════════════════════════════════
		-- КОММЕНТАРИИ
		-- ══════════════════════════════════════════════════════════

		["@comment"] = { link = "Comment" },
		-- Обычные комментарии: // ..., # ..., /* ... */
		-- Наследует от syntax.lua → C.overlay2 (серый, курсив)

		["@comment.documentation"] = { link = "Comment" },
		-- Документирующие комментарии: JSDoc, /** */, ///, ##
		-- Наследует → C.overlay2

		["@comment.error"] = { fg = C.base, bg = C.red },
		-- Теги ошибок в комментариях: ERROR:, BUG:, FIXME:
		-- Белый текст на красном фоне — очень заметно

		["@comment.warning"] = { fg = C.base, bg = C.yellow },
		-- Теги предупреждений: WARNING:, WARN:, HACK:
		-- Тёмный текст на жёлтом фоне

		["@comment.hint"] = { fg = C.base, bg = C.blue },
		-- Теги подсказок: HINT:, NOTE:
		-- Тёмный текст на синем фоне

		["@comment.todo"] = { fg = C.base, bg = C.flamingo },
		-- Теги задач: TODO:, FIXME:
		-- Тёмный текст на оранжевом фоне

		["@comment.note"] = { fg = C.base, bg = C.rosewater },
		-- Теги заметок: NOTE:, INFO:
		-- Тёмный текст на светлом фоне

		-- ══════════════════════════════════════════════════════════
		-- РАЗМЕТКА (Markdown, RST, AsciiDoc)
		-- ══════════════════════════════════════════════════════════

		["@markup"] = { fg = C.text },
		-- Обычный текст в файлах разметки
		-- Основной белый — читаемый текст

		["@markup.strong"] = { fg = C.red, style = { "bold" } },
		-- **Жирный текст** в markdown
		-- Красный жирный — выделяется визуально

		["@markup.italic"] = { fg = C.red, style = { "italic" } },
		-- *Курсивный текст* в markdown
		-- Красный курсив

		["@markup.strikethrough"] = { fg = C.text, style = { "strikethrough" } },
		-- ~~Зачёркнутый текст~~ в markdown
		-- Белый зачёркнутый

		["@markup.underline"] = { link = "Underlined" },
		-- Подчёркнутый текст
		-- Наследует style = underline

		["@markup.heading"] = { fg = C.blue },
		-- Заголовки общие: # Heading
		-- Фиолетово-синий (переопределяется rainbow-цветами ниже для markdown)

		["@markup.heading.markdown"] = { style = { "bold" } },
		-- Заголовки в markdown делаются жирными (цвет даёт rainbow ниже)

		["@markup.math"] = { fg = C.blue },
		-- Математические формулы: $x^2$ в LaTeX, $$...$$ блоки
		-- Фиолетово-синий

		["@markup.quote"] = { fg = C.pink },
		-- Блочные цитаты: > цитата в markdown
		-- Фуксия

		["@markup.environment"] = { fg = C.pink },
		-- Окружения разметки: \begin{} в LaTeX
		-- Фуксия

		["@markup.environment.name"] = { fg = C.blue },
		-- Имя окружения: figure, table в \begin{figure}
		-- Фиолетово-синий

		["@markup.link"] = { fg = C.lavender },
		-- Ссылки, сноски, цитаты в разметке
		-- Лавандовый

		["@markup.link.label"] = { fg = C.lavender },
		-- Текст ссылки: [ЭТОТ ТЕКСТ](url)
		-- Лавандовый

		["@markup.link.url"] = { fg = C.blue, style = { "italic", "underline" } },
		-- URL в ссылках: [text](ЭТА ССЫЛКА)
		-- Фиолетово-синий, курсив, подчёркивание

		["@markup.raw"] = { fg = C.green },
		-- Инлайн-код `вот так` и блоки кода в markdown
		-- Лаймовый — как строки в коде

		["@markup.list"] = { fg = C.teal },
		-- Маркеры списков: - / * / + / 1. в markdown
		-- Бирюзовый

		["@markup.list.checked"] = { fg = C.green },
		-- Выполненные задачи: [x] задача выполнена
		-- Зелёный — готово

		["@markup.list.unchecked"] = { fg = C.overlay1 },
		-- Невыполненные задачи: [ ] задача не выполнена
		-- Приглушённый серый

		-- ══════════════════════════════════════════════════════════
		-- DIFF
		-- ══════════════════════════════════════════════════════════

		["@diff.plus"] = { link = "diffAdded" },
		-- Добавленные строки в diff-файлах: + строка
		-- Наследует → C.green

		["@diff.minus"] = { link = "diffRemoved" },
		-- Удалённые строки в diff-файлах: - строка
		-- Наследует → C.red

		["@diff.delta"] = { link = "diffChanged" },
		-- Изменённые строки в diff-файлах
		-- Наследует → C.blue

		-- ══════════════════════════════════════════════════════════
		-- HTML / JSX ТЕГИ
		-- ══════════════════════════════════════════════════════════

		["@tag"] = { fg = C.blue },
		-- HTML/XML имена тегов: <DIV>, <span>, <MyComponent>
		-- Фиолетово-синий

		["@tag.builtin"] = { fg = C.blue },
		-- Встроенные JSX теги: <div>, <React.Fragment>
		-- Фиолетово-синий

		["@tag.attribute"] = { fg = C.yellow, style = O.styles.miscs or { "italic" } },
		-- Атрибуты тегов: <div CLASS="foo" id="bar">
		-- Жёлтый курсив

		["@tag.delimiter"] = { fg = C.teal },
		-- Разделители тегов: < > / в <div> </div> <br/>
		-- Бирюзовый — тише чем имя тега

		-- ══════════════════════════════════════════════════════════
		-- ПРОЧЕЕ
		-- ══════════════════════════════════════════════════════════

		["@error"] = { link = "Error" },
		-- Синтаксические ошибки, которые распознал парсер
		-- Наследует от syntax.lua → C.red

		-- ══════════════════════════════════════════════════════════
		-- СПЕЦИФИЧНЫЕ ДЛЯ ЯЗЫКОВ
		-- ══════════════════════════════════════════════════════════

		-- Bash
		["@function.builtin.bash"] = { fg = C.red, style = O.styles.miscs or { "italic" } },
		-- Встроенные команды bash: echo, cd, source, export
		-- Красный курсив

		["@variable.parameter.bash"] = { fg = C.green },
		-- Позиционные параметры в bash: $1, $2, $@, $#
		-- Зелёный — как строки (bash параметры часто строки)

		-- Markdown — заголовки по уровням через rainbow-цвета
		["@markup.heading.1.markdown"] = { link = "rainbow1" }, -- # H1 → красный
		["@markup.heading.2.markdown"] = { link = "rainbow2" }, -- ## H2 → оранжевый
		["@markup.heading.3.markdown"] = { link = "rainbow3" }, -- ### H3 → жёлтый
		["@markup.heading.4.markdown"] = { link = "rainbow4" }, -- #### H4 → зелёный
		["@markup.heading.5.markdown"] = { link = "rainbow5" }, -- ##### H5 → синий
		["@markup.heading.6.markdown"] = { link = "rainbow6" }, -- ###### H6 → лавандовый

		-- HTML — заголовки как обычный текст (не rainbow, т.к. HTML в коде)
		["@markup.heading.html"] = { link = "@markup" },
		["@markup.heading.1.html"] = { link = "@markup" },
		["@markup.heading.2.html"] = { link = "@markup" },
		["@markup.heading.3.html"] = { link = "@markup" },
		["@markup.heading.4.html"] = { link = "@markup" },
		["@markup.heading.5.html"] = { link = "@markup" },
		["@markup.heading.6.html"] = { link = "@markup" },

		-- Java
		["@constant.java"] = { fg = C.teal },
		-- Константы в Java (enum-члены, static final): MAX_VALUE
		-- Бирюзовый — отличается от обычных констант

		-- CSS / SCSS
		["@property.css"] = { fg = C.blue },
		["@property.scss"] = { fg = C.blue },
		-- CSS-свойства: color, display, margin → фиолетово-синий

		["@property.id.css"] = { fg = C.yellow },
		-- Селекторы по id: #my-id → жёлтый

		["@property.class.css"] = { fg = C.yellow },
		-- Селекторы по классу: .my-class → жёлтый

		["@type.css"] = { fg = C.lavender },
		-- Типы значений CSS: px, em, %, rgb → лавандовый

		["@type.tag.css"] = { fg = C.blue },
		-- Тег-селекторы CSS: div, p, span, body → синий

		["@string.plain.css"] = { fg = C.text },
		-- Строковые значения CSS: "Arial", url("...") → белый

		["@number.css"] = { fg = C.peach },
		-- Числа в CSS: 10px, 2em, 0.5, 100% → оранжевый

		["@keyword.directive.css"] = { link = "Keyword" },
		-- CSS at-rules: @media, @keyframes, @import, @font-face

		-- HTML специфика
		["@string.special.url.html"] = { fg = C.green },
		-- URL в атрибутах href, src: <a href="ЭТА ССЫЛКА">
		-- Зелёный — отличается от обычных URL в коде

		["@markup.link.label.html"] = { fg = C.text },
		-- Текст между тегами ссылки: <a href="...">ЭТОТ ТЕКСТ</a>
		-- Белый — обычный читаемый текст

		["@character.special.html"] = { fg = C.red },
		-- HTML-сущности: &amp; &nbsp; &lt; &gt;
		-- Красный — чтобы заметить спецсимволы

		-- Lua
		["@constructor.lua"] = { link = "@punctuation.bracket" },
		-- Конструктор таблиц в Lua: = { } (скобки, не функция)
		-- Наследует цвет скобок → C.overlay2

		-- Python
		["@constructor.python"] = { fg = C.sky },
		-- Конструкторы Python: __init__(), __new__()
		-- Голубой — выделяет магические методы

		-- YAML
		["@label.yaml"] = { fg = C.yellow },
		-- Якоря и алиасы YAML: &anchor, *alias
		-- Жёлтый

		-- Ruby
		["@string.special.symbol.ruby"] = { fg = C.flamingo },
		-- Символы Ruby: :name, :status
		-- Оранжево-коралловый

		-- PHP
		["@function.method.php"] = { link = "Function" },
		["@function.method.call.php"] = { link = "Function" },
		-- Методы в PHP → стандартный синий как все функции

		-- C / C++
		["@keyword.import.c"] = { fg = C.yellow },
		["@keyword.import.cpp"] = { fg = C.yellow },
		-- #include в C/C++ → жёлтый (отличается от mauve других import)

		-- C#
		["@attribute.c_sharp"] = { fg = C.yellow },
		-- Атрибуты C#: [Serializable], [HttpGet]
		-- Жёлтый

		-- Git
		["@comment.warning.gitcommit"] = { fg = C.yellow },
		-- Предупреждения в git-commit сообщениях
		-- Жёлтый

		["@string.special.path.gitignore"] = { fg = C.text },
		-- Пути/паттерны в .gitignore: *.log, dist/
		-- Белый — как обычный текст

		-- Разное
		gitcommitSummary = { fg = C.rosewater, style = O.styles.miscs or { "italic" } },
		-- Первая строка коммит-сообщения
		-- Почти белый курсив

		zshKSHFunction = { link = "Function" },
		-- Функции в zsh/ksh скриптах → стандартный синий
	}

	return colors
end

return M