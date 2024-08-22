import { Separator } from "./separator.js"

export default function Bar() {
    return Widget.Window({
        name: 'bar',
        anchor: ['top', 'left', 'right'],
        layer: "overlay",
        exclusivity: "exclusive",
        margins: [4, 8, 0, 8],
        child: Widget.CenterBox({
            startWidget: Left(),
            centerWidget: Widget.Label("cool2"),
            endWidget: Right()
        })
    })
}

function Left() {
    return Widget.Box({
        spacing: 8,
        children: [
            Workspaces(),
        ]
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        children: [
            SysTray(),
            Separator("", "red", "blue"),
            Clock(),
        ]
    })
}

const hyprland = await Service.import("hyprland")

function Workspaces() {
    const activeId = hyprland.active.workspace.bind("id")
    const workspaces = [...Array(10).keys()]
        .map(id => id + 1)
        .map(id => Widget.Button({
            child: Widget.Label(`${id}`),
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
            className: activeId.as(i => `${i === id ? "focused" : ""}`),
        }))

    return Widget.Box({
        className: "workspaces",
        children: workspaces,
    })
}

const date = Variable("", {
    poll: [1000, 'date "+%H:%M %b %e"'],
})

function Clock() {
    return Widget.Label({
        label: date.bind(),
    })
}


const systemtray = await Service.import('systemtray')

/** @param {import('types/service/systemtray').TrayItem} item */
const SysTrayItem = item => Widget.Button({
    child: Widget.Icon().bind('icon', item, 'icon'),
    tooltipMarkup: item.bind('tooltip_markup'),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
});

function SysTray() {
    return Widget.Box({
        children: systemtray.bind('items').as(i => i.map(SysTrayItem))
    })
}
