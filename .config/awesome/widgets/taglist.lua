local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local separators = require("widgets.separators")

local taglist_template = {
    {
        -- For some reason the widget order is flipped
        layout = wibox.layout.fixed.horizontal,
        {
            id = "right_separator_role",
            widget = wibox.container.background
        },
        {
            {
                {
                    id = "index_role",
                    widget = wibox.widget.textbox
                },
                widget = wibox.container.margin,
                left = 4,
                right = 4,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
        {
            id = "left_separator_role",
            widget = wibox.container.background
        },
    },
    widget = wibox.container.background,
    create_callback = function (self, t, index, tags)
        -- Set index numbers
        self:get_children_by_id("index_role")[1].text = index

        -- Set pointers to separators
        self.right_separator = self:get_children_by_id("left_separator_role")[1]
        self.left_separator = self:get_children_by_id("right_separator_role")[1]

        -- Make reset functions for each tag widget then run them
        self.reset = function ()
            self.fg = beautiful.fg_normal
            self.bg = beautiful.bg_normal
            self.right_separator.widget = separators.soft_forward_slash

            if index == 1 then
                self.left_separator.widget = separators.hard_circle_right
                self.left_separator.fg = beautiful.fg_normal
                self.left_separator.bg = beautiful.bg_normal
            elseif index == 9 then
                self.right_separator.widget = nil
            end
        end
        self.reset()

        -- Change appearance of selected tags, called in update_callback
        local select_first = function ()
            if index == 1 then
                self.fg = beautiful.fg_focus
                self.left_separator.widget = separators.soft_circle_right
                self.left_separator.fg = beautiful.fg_focus
                self.left_separator.bg = beautiful.bg_focus

                self.right_separator.widget = separators.hard_circle_right
                self.right_separator.fg = beautiful.bg_focus
                self.left_separator.fg = beautiful.fg_focus
            end
        end
        self.select = function ()
            self.fg = beautiful.fg_focus
            -- First tag
            select_first()

            -- Rest of tags
            if index ~= 1 then
                self.right_separator.widget = separators.hard_circle_right
                self.right_separator.fg = beautiful.bg_focus
                if index == 9 then
                    self.right_separator.widget = nil
                end
            end
        end

        -- Make first tag look selected
        select_first()
    end,
    update_callback = function (self, t, index, tags)
        -- Change visuals for selected tags
        local selected_tags = awful.screen.focused().selected_tags
        for _, tag in ipairs(selected_tags) do
            -- Not selected tags
            if tag ~= t then
                self.reset()
                -- Set right_separator of tags to left of selected
                if tag == tags[index + 1] then
                    self.right_separator.widget = separators.hard_circle_left
                end
                goto continue
            end
            -- Selected tags
            self.select()
            ::continue::
        end
    end
}

local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
    end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

return {
    create = function (s)
        return awful.widget.taglist({
                screen  = s,
                filter  = awful.widget.taglist.filter.all,
                buttons = taglist_buttons,
                widget_template = taglist_template
        })
    end
}
