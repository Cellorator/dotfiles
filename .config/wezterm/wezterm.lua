local wezterm = require ("wezterm")

local config = {}

config.enable_tab_bar = false

config.font = wezterm.font_with_fallback({ "DM Mono", "Symbols Nerd Font" })

-- Colorscheme
config.color_scheme = "Gruvbox Material (Gogh)"
config.colors = {
    cursor_fg = "black"
}

return config
