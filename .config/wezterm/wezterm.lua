local wezterm = require("wezterm")

local config = {}

config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0
}

config.keys = {
	{
		action = wezterm.action.DisableDefaultAssignment,
		key = 'w',
		mods = 'SUPER',
	},
}

config.font = wezterm.font("DM Mono")

-- Colorscheme
-- config.color_scheme = "Gruvbox dark, medium (base16)"
config.color_scheme = "Gruvbox Material (Gogh)"

return config
