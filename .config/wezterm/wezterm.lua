local wezterm = require("wezterm")

local config = {}

config.font = wezterm.font_with_fallback({
	"Cartograph CF",
	"Symbols Nerd Font"  -- Icon glyphs are small without this
})
config.font_size = 10.5

-- Colorscheme
-- config.color_scheme = "Gruvbox dark, medium (base16)"
config.color_scheme = "Gruvbox Material (Gogh)"

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

return config
