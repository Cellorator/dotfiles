local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
)

return {
    create = function (s)
        return wibox.widget({
            {
                awful.widget.layoutbox(s),
                widget = wibox.container.margin,
                left = 8,
                right = 8
            },
            buttons = tasklist_buttons,
            widget = wibox.container.background,
            bg = beautiful.bg_focus
        })
    end
}
