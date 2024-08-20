const hyprland = await Service.import("hyprland")

function Workspaces() {
    const activeId = hyprland.active.workspace.bind("id")
    const workspaces = hyprland.bind("workspaces")
        .as(ws => ws.map(({ id }) => Widget.Button({
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
            child: Widget.Label(`${id}`),
            className: activeId.as(i => `${i === id ? "focused" : ""}`),
        })))

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
            Clock(),
        ]
    })
}

function Bar() {
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

App.config({
    windows: [Bar()]
})
