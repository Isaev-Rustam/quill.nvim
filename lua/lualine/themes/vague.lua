-- lua/lualine/themes/quill.lua

-- Это тема для плагина lualine.nvim.
--
-- Lualine автоматически ищет тему по пути:
--   lua/lualine/themes/<theme-name>.lua
--
-- Файл просто проксирует цвета из системы quill.
-- Он вызывает функцию из groups/lualine.lua, которая возвращает
-- таблицу с настройками для всех режимов (normal, insert, visual и т.д.).

local curr_internal_conf = require("quill.config.internal").current
return require("quill.groups.lualine").get_colors(curr_internal_conf)