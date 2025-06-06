-- Powerline font based separators between widgets
local wibox = require("wibox")

local textbox_from = function (str)
    return wibox.widget({
        widget = wibox.widget.textbox,
        markup = "<span font='11'>"..str.."</span>"
        -- markup = str
    })
end

return {
    soft_forward_slash =  textbox_from(""),
    soft_back_slash = textbox_from(""),
    lower_right_triangle = textbox_from(""),

    soft_circle_right = textbox_from(""),
    hard_circle_right= textbox_from(""),
    hard_circle_left= textbox_from("")
}
