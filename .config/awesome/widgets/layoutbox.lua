local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

return {
    create = function (s)
        return wibox.widget({
            {
                awful.widget.layoutbox(s),
                widget = wibox.container.margin,
                left = 8,
                right = 8
            },
            widget = wibox.container.background,
            bg = beautiful.bg_focus
        })
    end
}
