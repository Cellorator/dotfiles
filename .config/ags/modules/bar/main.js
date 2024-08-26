import Workspaces from "./workspaces.js"
import SysTray from "./sysTray.js"
import Clock from "./clock.js"

export default function Bar() {
    const widgets = Widget.CenterBox({
        className: 'bar-box',
        startWidget: Left(),
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
        hpack: 'start',
        className: 'left',
        children: [
            Workspaces(),
        ]
    })
}

function Right() {
    return Widget.Box({
        hpack: 'end',
        className: 'right',
        children: [
            SysTray(),
            Clock(),
        ]
    })
}
