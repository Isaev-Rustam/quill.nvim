-- ~/lua/catppuccin/init.lua

-- =============================================
-- Главный файл плагина Catppuccin
-- Здесь задаются настройки по умолчанию, происходит загрузка темы,
-- компиляция в байт-код (для скорости) и обработка пользовательских настроек.
-- =============================================

---@type Catppuccin
local M = {

  -- ============================
  -- НАСТРОЙКИ ПО УМОЛЧАНИЮ (default_options)
  -- Всё, что здесь написано, применяется, если пользователь ничего не передал в setup()
  -- ============================
  default_options = {
    flavour = "mocha",                    -- Какая схема используется по умолчанию (у тебя только mocha)

    background = {
      light = "mocha",                    -- Если vim.o.background = "light" — использовать mocha
      dark  = "mocha",                    -- Если vim.o.background = "dark"  — использовать mocha
    },

    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    -- Папка, куда сохраняется скомпилированная тема (в байт-код).
    -- Это сильно ускоряет запуск Neovim, потому что не нужно каждый раз заново собирать все highlight-группы.

    transparent_background = false,       -- Делать фон прозрачным (true = прозрачный)
    float = {
      transparent = false,                -- Прозрачные floating окна
      solid = false,                      -- Использовать сплошной фон для floating окон
    },

    term_colors = false,                  -- Устанавливать цвета для встроенного терминала Neovim
    kitty = vim.env.KITTY_WINDOW_ID and true or false,
    -- Специальная настройка для терминала Kitty (решает проблему с прозрачностью)

    dim_inactive = {                      -- Затемнять неактивные окна
      enabled = false,
      shade = "dark",                     -- "dark" или "light"
      percentage = 0.15,                  -- На сколько процентов затемнять
    },

    -- Отключение стилей (если хочешь полностью убрать курсив/жирный/подчёркивание)
    no_italic = false,
    no_bold = false,
    no_underline = false,

    -- Стили по умолчанию для разных типов синтаксиса
    styles = {
      comments = { "italic" },            -- Комментарии курсивом
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },

    -- Стили для LSP-диагностики (подсказки, ошибки и т.д.)
    lsp_styles = {
      virtual_text = {                    -- Виртуальный текст (inline)
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
        ok = { "italic" },
      },
      underlines = {                      -- Подчёркивание
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
        ok = { "underline" },
      },
      inlay_hints = {
        background = true,                -- Подсвечивать фон для inlay hints
      },
    },

    default_integrations = true,          -- Включать ли интеграции по умолчанию
    auto_integrations = false,            -- Автоматически определять установленные плагины и включать их поддержку
    -- (у тебя сейчас false — это хорошо для минимальной версии)

    -- Список интеграций (поддержка других плагинов: nvim-tree, telescope, cmp и т.д.)
    integrations = {
      alpha = true,
      blink_cmp = { enabled = true, style = "bordered" },
      blink_indent = true,
      fzf = true,
      cmp = true,
      dap = true,
      dap_ui = true,
      dashboard = true,
      diffview = false,
      flash = true,
      gitsigns = true,
      markdown = true,
      neogit = true,
      neotree = true,
      nvimtree = true,
      ufo = true,
      rainbow_delimiters = true,
      render_markdown = true,
      telescope = { enabled = true },
      treesitter_context = true,

      -- Специальные настройки для некоторых плагинов
      barbecue = {
        dim_dirname = true,
        bold_basename = true,
        dim_context = false,
        alt_background = false,
      },
      illuminate = {
        enabled = true,
        lsp = false,
      },
      indent_blankline = {
        enabled = true,
        scope_color = "",
        colored_indent_levels = false,
      },
      navic = {
        enabled = false,
        custom_bg = "NONE",
      },
      dropbar = {
        enabled = true,
        color_mode = false,
      },
      colorful_winsep = {
        enabled = false,
        color = "red",
      },
      mini = {
        enabled = true,
        indentscope_color = "overlay2",
      },
      lir = {
        enabled = false,
        git_status = false,
      },
      snacks = { enabled = false },
    },

    color_overrides = {},                 -- Здесь можно переопределять цвета палитры
    highlight_overrides = {},             -- Здесь можно переопределять любые highlight-группы
  },

  -- ============================
  -- Внутренние переменные
  -- ============================
  flavours = { mocha = 1 },               -- Список доступных схем (у тебя только одна)
  path_sep = jit and (jit.os == "Windows" and "\\" or "/") or package.config:sub(1, 1),
  -- Определяет разделитель путей (/ или \) в зависимости от ОС

  options = {},                           -- Сюда будет записана итоговая конфигурация после setup()
}

-- Копируем настройки по умолчанию в текущие
M.options = M.default_options

-- ============================
-- ФУНКЦИЯ КОМПИЛЯЦИИ
-- ============================
function M.compile()
  local user_flavour = M.flavour
  -- :TODO 
  -- Перебираем все flavour'ы (у тебя только mocha) и компилируем их в байт-код
  for flavour, _ in pairs(M.flavours) do
    M.flavour = flavour
    require("catppuccin.lib.compiler").compile(flavour)
  end
  M.flavour = user_flavour -- Возвращаем обратно пользовательский flavour
end

-- ============================
-- ВСПОМОГАТЕЛЬНАЯ ФУНКЦИЯ
-- ============================
local function get_flavour(default)
  return "mocha"   -- У тебя всегда возвращается только mocha
end

local did_setup = false   -- Флаг, чтобы setup() не вызывался несколько раз

-- ============================
-- ЗАГРУЗКА ТЕМЫ (load)
-- ============================
function M.load(flavour)
    if not did_setup then
        M.setup()
    end

    M.flavour = "mocha"

    local compiled_path = M.options.compile_path .. M.path_sep .. M.flavour

    local f = loadfile(compiled_path)
    if not f then
        M.compile()
        f = assert(loadfile(compiled_path), "could not load cache")
    end

    f(M.flavour)
end
-- ============================
-- НАСТРОЙКА ПЛАГИНА (setup)
-- ============================
---@type fun(user_conf: CatppuccinOptions?)
function M.setup(user_conf)
  did_setup = true

  -- Parsing user config
  user_conf = user_conf or {}

  -- Если пользователь включил auto_integrations — автоматически добавляем поддержку установленных плагинов
  if user_conf.auto_integrations == true then
    user_conf.integrations = vim.tbl_deep_extend(
      "force",
      require("catppuccin.lib.detect_integrations").create_integrations_table(),
      user_conf.integrations or {}
    )
  end

  -- Если пользователь явно отключил default_integrations — очищаем список
  if user_conf.default_integrations == false then
    M.default_options.integrations = {}
  end

  -- Объединяем пользовательские настройки с настройками по умолчанию
  M.options = vim.tbl_deep_extend("keep", user_conf, M.default_options)

  -- Применяем пользовательские highlight_overrides
  M.options.highlight_overrides.all = user_conf.custom_highlights or M.options.highlight_overrides.all

  -- ============================
  -- СИСТЕМА КЭШИРОВАНИЯ (чтобы не компилировать каждый раз)
  -- ============================
  local cached_path = M.options.compile_path .. M.path_sep .. "cached"
  local file = io.open(cached_path)
  local cached = nil
  if file then
    cached = file:read()
    file:close()
  end

  -- Создаём хэш текущей конфигурации (чтобы понять, изменилось ли что-то)
  local git_path = debug.getinfo(1).source:sub(2, -24) .. ".git"
  local git = vim.fn.getftime(git_path)
  local hash = require("catppuccin.lib.hashing").hash(user_conf)
    .. (git == -1 and git_path or git)
    .. (vim.o.winblend == 0 and 1 or 0)
    .. (vim.o.pumblend == 0 and 1 or 0)

  -- Если хэш изменился — перекомпилируем тему
  if cached ~= hash then
    M.compile()
    file = io.open(cached_path, "wb")
    if file then
      file:write(hash)
      file:close()
    end
  end
end

-- ============================
-- КОМАНДЫ Neovim
-- ============================

-- Команда :Catppuccin <flavour>
vim.api.nvim_create_user_command(
  "Catppuccin",
  function(inp)
    vim.api.nvim_command("colorscheme catppuccin-" .. get_flavour(inp.args))
  end,
  {
    nargs = 1,
    complete = function(line)
      return vim.tbl_filter(function(val)
        return vim.startswith(val, line)
      end, vim.tbl_keys(M.flavours))
    end,
  }
)

-- Команда :CatppuccinCompile — принудительная перекомпиляция
vim.api.nvim_create_user_command("CatppuccinCompile", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^catppuccin%.") then
      package.loaded[name] = nil
    end
  end
  M.compile()
  vim.notify("Catppuccin (info): compiled cache!", vim.log.levels.INFO)
  vim.cmd.colorscheme("catppuccin-nvim")
end, {})

-- Если включён debug-режим — автоматически перекомпилировать при сохранении файлов темы
if vim.g.catppuccin_debug then
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*/catppuccin/*",
    callback = function()
      vim.schedule(function()
        vim.cmd("CatppuccinCompile")
      end)
    end,
  })
end

return M