-- colors/vague.lua

-- Это entry point (точка входа) colorscheme'а.
-- Neovim автоматически загружает этот файл при выполнении команды:
--   :colorscheme vague
--
-- Файл должен быть максимально минималистичным — он просто вызывает
-- внутреннюю функцию, которая настраивает все highlight groups.

require("vague")._colorscheme()