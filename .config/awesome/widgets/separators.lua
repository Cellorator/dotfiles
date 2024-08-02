-- Powerline font based separators between widgets
local wibox = require("wibox")

return {
    soft_forward_slash=  wibox.widget({
        widget = wibox.widget.textbox,
        markup = "<span font='14'></span>"
    }),

    soft_back_slash = wibox.widget({
        widget = wibox.widget.textbox,
        markup = "<span font='14'></span>"
    }),

    soft_circle_right= wibox.widget({
        widget = wibox.widget.textbox,
        markup = "<span font='14'></span>"
    }),

    hard_circle_right= wibox.widget({
        widget = wibox.widget.textbox,
        markup = "<span font='14'></span>"
    }),

    hard_circle_left= wibox.widget({
        widget = wibox.widget.textbox,
        markup = "<span font='14'></span>",
    }),
}
