import Workspaces from "./workspaces.js"

export default function Bar() {
    const widgets = Widget.CenterBox({
        className: 'bar-box',
        startWidget: Left(),
        centerWidget: Widget.Label("cool2"),
        endWidget: Right()
    })

    return Widget.Window({
        name: 'bar',
        className: 'bar-window',
        anchor: ['top', 'left', 'right'],
        layer: 'top',
        exclusivity: "exclusive",
        margins: [4, 4, 0, 4],
        child: widgets
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
            Clock(),
        ]
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
