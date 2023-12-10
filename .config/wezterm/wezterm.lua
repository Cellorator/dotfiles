local wezterm = require ("wezterm")

local config = {}

config.font = wezterm.font("DMMono Nerd Font")
config.color_scheme = "Gruvbox dark, medium (base16)"

config.keys = {
    {
        key = "Enter",
        mods = "CTRL",
        action = wezterm.action.SpawnTab("CurrentPaneDomain")
    },
    {
        key = "w",
        mods = "CTRL",
        action = wezterm.action.CloseCurrentTab({confirm = false})
    },
    {
        key = "h",
        mods = "CTRL",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        key = "l",
        mods = "CTRL",
        action = wezterm.action.ActivateTabRelative(1)
    },

}

return config
