import Workspaces from "./workspaces.js"
import { Separator } from "../widgets/separator.js"

export default function Bar() {
    return Widget.Window({
        name: 'bar',
        anchor: ['top', 'left', 'right'],
        layer: "overlay",
        exclusivity: "exclusive",
        margins: [3, 6, 0, 6],
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
