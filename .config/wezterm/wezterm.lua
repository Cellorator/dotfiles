local wezterm = require ("wezterm")

local config = {}

config.enable_tab_bar = false

config.font = wezterm.font("DM Mono")

-- Colorscheme
config.color_scheme = "Gruvbox Material (Gogh)"
config.colors = {
    cursor_fg = "black"
}

return config
