-- lua/vague/groups/init.lua

-- Центральный реестр (index) всех групп подсветки.
-- Именно здесь собираются highlight-группы из всех отдельных файлов.
--
-- Этот файл используется в highlights.lua для загрузки всех определений цветов.

local curr_internal_conf = require("vague.config.internal").current

-- Вспомогательная функция для удобной загрузки групп.
-- Принимает имя файла (без .lua) и вызывает get_colors() из соответствующего модуля.
---@param group string
local function init(group)
  return require("vague.groups." .. group).get_colors(curr_internal_conf)
end

-- Список всех поддерживаемых групп подсветки.
-- Добавляйте сюда новые файлы, когда добавляете поддержку нового плагина.
return {
  blink               = init("blink"),               -- blink.cmp
  cmp                 = init("cmp"),                 -- nvim-cmp
  common              = init("common"),              -- Основные группы Neovim (самое важное)
  dashboard           = init("dashboard"),           -- alpha.nvim / dashboard-nvim
  diff                = init("diff"),                -- git diff, vimdiff
  fzf_lua             = init("fzf-lua"),             -- fzf-lua
  html                = init("html"),                -- HTML подсветка
  lsp_native          = init("lsp-native"),          -- Встроенная LSP-подсветка (@lsp.*)
  lsp_plugin          = init("lsp-plugin"),          -- Diagnostic-ы и другие LSP группы
  mini                = init("mini"),                -- mini.nvim (statusline, diff и др.)
  modes               = init("modes"),               -- modes.nvim (визуальные режимы)
  neotest             = init("neotest"),             -- neotest
  neotree             = init("neotree"),             -- neo-tree.nvim
  rainbow_delimiters  = init("rainbow-delimiters"),  -- rainbow-delimiters
  snacks_input        = init("snacks-input"),        -- snacks.nvim input
  snacks_picker       = init("snacks-picker"),       -- snacks.nvim picker
  syntax              = init("syntax"),              -- Базовая синтаксическая подсветка
  telescope           = init("telescope"),           -- telescope.nvim
  treesitter          = init("treesitter"),          -- nvim-treesitter
  vim_better_whitespace = init("vim-better-whitespace"), -- vim-better-whitespace
}