local wibox = require("wibox")
local beautiful = require("beautiful")
local separators = require("widgets.separators")

return {
    create = function ()
        return wibox.widget({
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    separators.hard_circle_left,
                    widget = wibox.container.background,
                    fg = beautiful.bg_normal,
                    bg = beautiful.wibar_bg
                },
                {
                    {
                        wibox.widget.systray(),
                        widget = wibox.container.background,
                        fg = beautiful.bg_systray,
                        bg = beautiful.wibar_bg,
                    },
                    widget = wibox.container.margin,
                    right = 8,
                },
                separators.hard_circle_left,
            },
            widget = wibox.container.background,
            fg = beautiful.fg_normal,
            bg = beautiful.bg_systray,
        })
    end
}
