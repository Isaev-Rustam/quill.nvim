-- lua/vague/groups/neotest.lua

-- Подсветка для плагина neotest (тестирование в Neovim).

local M = {}

---@param conf VagueColorscheme.InternalConfig
---@return table
M.get_colors = function(conf)
  local c = conf.colors

  -- stylua: ignore
  local hl = {
    -- Основные элементы интерфейса
    NeotestTest             = { fg = c.comment },   -- Обычный тест (не запущен)
    NeotestDir              = { fg = c.comment },   -- Директории в дереве тестов
    NeotestFile             = { fg = c.constant },  -- Файлы с тестами
    NeotestNamespace        = { fg = c.parameter }, -- Группы/пространства тестов (describe, context)

    -- Результаты выполнения тестов
    NeotestPassed           = { fg = c.plus },      -- Успешно пройденный тест (зелёный)
    NeotestFailed           = { fg = c.error },     -- Проваленный тест (красный)
    NeotestSkipped          = { fg = c.warning },   -- Пропущенный тест (жёлтый/оранжевый)

    -- Состояния во время выполнения
    NeotestRunning          = { fg = c.hint },      -- Тест в процессе выполнения
    NeotestWatching         = { fg = c.warning },   -- Режим watch (наблюдение за изменениями)

    -- Выделение и фокус
    NeotestFocused          = { fg = c.delta, bold = conf.bold }, -- Текущий (фокусированный) тест
    NeotestMarked           = { fg = c.delta },     -- Помеченные тесты

    -- Дополнительные элементы
    NeotestTarget           = { fg = c.hint },      -- Целевой файл/проект
    NeotestAdapterName      = { fg = c.hint, bold = conf.bold }, -- Название адаптера (pytest, jest и т.д.)
    NeotestIndent           = { fg = c.comment },   -- Отступы в дереве тестов
  }

  return hl
end

return M