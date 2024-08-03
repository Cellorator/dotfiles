local wibox = require("wibox")
local beautiful = require("beautiful")
local separators = require("widgets.separators")

function create_piece(str)
    return wibox.widget({
        {
            widget = wibox.widget.textclock,
            format = str
        },
        widget = wibox.container.margin,
        right = 8,
        left = 8
    })
end
day = create_piece("%A")
date = create_piece("%e %b %Y")
time = create_piece("%R")

return {
    create = function ()
        return {
            {
                layout = wibox.layout.fixed.horizontal,
                day,
                separators.soft_back_slash,
                date,
                separators.soft_back_slash,
                time,
            },
            widget = wibox.container.background,
            fg = beautiful.fg_focus,
            bg = beautiful.bg_focus,
        }
    end
}
