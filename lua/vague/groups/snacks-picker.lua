-- lua/vague/groups/snacks-picker.lua

-- Подсветка для Snacks Picker — мощного универсального picker'а из Snacks.nvim
-- (поиск файлов, grep, git status, buffers, diagnostics и т.д.)

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  -- stylua: ignore
  local hl = {
    -- Основные элементы интерфейса
    SnacksPickerMatch             = { link = "TelescopeMatching" },     -- Совпадения в поиске (выделение)
    SnacksPickerPrompt            = { link = "TelescopePromptPrefix" }, -- Префикс в строке ввода

    -- Выделение текущей строки
    SnacksPickerCursorLine        = { link = "TelescopeSelection" },
    SnacksPickerListCursorLine    = { link = "TelescopeSelection" },
    SnacksPickerPreviewCursorLine = { link = "TelescopeSelection" },

    -- Git-статусы (интеграция с neo-tree)
    SnacksPickerGitStatusUntracked = { link = "NeoTreeGitUntracked" },
    SnacksPickerGitStatusModified  = { link = "NeoTreeGitModified" },
    SnacksPickerGitStatusStaged    = { link = "NeoTreeGitAdded" },
  }

  return hl
end

return M