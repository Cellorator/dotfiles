from libqtile import backend, bar, layout, widget, qtile, hook
from libqtile.lazy import lazy
from libqtile.config import Group, Match, Screen, ScratchPad, DropDown
from libqtile.config import EzKey as Key
from libqtile.config import EzDrag as Drag
from libqtile.config import EzKeyChord as KeyChord
from libqtile.utils import send_notification


@hook.subscribe.client_focus
def changed_focus(window):
    # Add IS_FLOATING windows property for floating windows
    # Currently only used for picom adding shadows to floating windows only
    window.window.set_property("IS_FLOATING", str(window.floating), type="STRING", format=8)

    # Make focus window appear on top
    current_window = qtile.current_window
    if current_window.floating:
        window.bring_to_front()


@lazy.function
def notify(qtile, title, msg):
    send_notification(title, msg)


auto_fullscreen = True
auto_minimize = False
reconfigure_screens = True

focus_on_window_activation = "smart"
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
float_kept_above = True

mod = "mod4"
keys = [
    Key("M-<Tab>", lazy.screen.toggle_group(), desc="Move window focus to other window"),
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key("M-h", lazy.layout.left(), desc="Move focus to left"),
    Key("M-l", lazy.layout.right(), desc="Move focus to right"),
    Key("M-j", lazy.layout.down(), desc="Move focus down"),
    Key("M-k", lazy.layout.up(), desc="Move focus up"),
    Key("A-<Tab>", lazy.group.focus_back(), desc="Switch between windows"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key("M-S-h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key("M-S-l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key("M-S-j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key("M-S-k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key("M-S-C-h", lazy.layout.swap_column_left()),
    Key("M-S-C-l", lazy.layout.swap_column_right()),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key("M-C-h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key("M-C-l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key("M-C-j", lazy.layout.grow_down(), desc="Grow window down"),
    Key("M-C-k", lazy.layout.grow_up(), desc="Grow window up"),
    Key("M-C-i", lazy.layout.grow()),
    Key("M-n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key("M-S-<Tab>", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    Key("M-f", lazy.window.toggle_floating()),
    Key("M-m", lazy.window.toggle_maximize()),
    Key("M-S-m", lazy.window.toggle_fullscreen()),
    Key("M-S-w", lazy.window.kill(), desc="Kill focused window"),
    Key("M-<Space>", lazy.next_layout()),

    Key("M-C-r", lazy.reload_config(), desc="Reload the config"),
    Key("M-C-q", lazy.shutdown(), desc="Shutdown Qtile"),

    Key("M-r", lazy.spawn("rofi -show drun"), desc="Launch rofi"),
    Key("M-<Return>", lazy.spawn("wezterm"), desc="Launch terminal"),
    Key("M-b", lazy.spawn("firefox"), desc="Spawn browser"),
    Key("M-s", lazy.spawn("gnome-screenshot -i"), desc="Take screenshot"),

    Key("M-S-<Return>", lazy.group["scratchpad"].dropdown_toggle("terminal"), desc="Launch terminal as scratchpad"),
    Key("C-S-<escape>", lazy.group["scratchpad"].dropdown_toggle("monitor"), desc="Launch htop"),
]

# Drag floating layouts.
mouse = [
    Drag("M-<Button1>", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag("M-<Button3>", lazy.window.set_size_floating(), start=lazy.window.get_size()),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                f"M-{i.name}",
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                f"M-S-{i.name}",
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

groups.append(
        ScratchPad("scratchpad", [
            DropDown("terminal", "wezterm -e", height=0.7, width=0.5, x=0.25, y=0.15, opacity=1),
            DropDown("monitor", "wezterm -e htop", height=0.7, width=0.5, x=0.25, y=0.15, opacity=1),
        ])
)

black = "1d2021"
blue = "83a598"
aqua = "8ec07c"
orange = "fe8019"

layouts = [
    layout.Columns(
        border_focus=blue,
        border_focus_stack=aqua,
        border_normal=black,
        border_normal_stack=black,
        border_width=2
    ),
    layout.Floating(
        border_focus=orange,
        border_normal=black,
        border_width=0,
    ),
    layout.Max(),
]

widget_defaults = dict(
    font="DM Mono",
    fontsize=14,
    border=blue,
    borderwidth=2,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper="/usr/share/backgrounds/pacman-ghosts.jpg",
        wallpaper_mode="fill",

        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    padding=5,
                ),
                widget.GroupBox(
                    highlight_method="line",
                    highlight_color=black,
                    this_current_screen_border=blue,
                ),
                widget.TaskList(
                    max_title_width=250,
                ),
                widget.Chord(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            ],
            24,
            background=black,
        ),
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
floating_layout = layout.Floating(
    border_focus=orange,
    border_normal=black,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="Godot_Engine"),  # Godot
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ])

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
