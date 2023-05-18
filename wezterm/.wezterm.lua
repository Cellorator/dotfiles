local wezterm = require 'wezterm'

local config = {}

config.font = wezterm.font 'Recursive Mono Linear Static'
--config.font = wezterm.font 'B612 Mono'
--config.font = wezterm.font 'Cascadia Code'
--config.font = wezterm.font 'Hermit'

config.harfbuzz_features = { 'ss01', 'ss02', 'ss03', 'ss04', 'ss05',}

config.color_scheme = 'Gruvbox dark, medium (base16)'
--config.color_scheme = 'Ayu Mirage'
--config.color_scheme = 'ayu'

return config
