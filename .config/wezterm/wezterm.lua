local wezterm = require("wezterm")

local config = {}

config.font = wezterm.font("Hurmit Nerd Font")
config.font_size = 10.5
config.custom_block_glyphs = false

-- Colorscheme
-- config.color_scheme = "Gruvbox dark, medium (base16)"
config.color_scheme = "Kanagawa Dragon (Gogh)"

config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0
}

config.keys = {
	{
		-- Disable close keybind
		action = wezterm.action.DisableDefaultAssignment,
		key = 'w',
		mods = 'SUPER',
	},
}

config.window_close_confirmation = "NeverPrompt"

config.mux_enable_ssh_agent = false

return config
