const hyprland = await Service.import("hyprland")

export default function Workspaces() {
    const workspaces = [...Array(9).keys()]
        .map(id => id + 1)
        .map(id => Widget.Button({
            child: Widget.Label(`${id}`),
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
            className: currentStatus(id),
        }))

    hyprland.connect("client-added", address => print(address))

    return Widget.Box({
        className: "workspaces",
        children: workspaces,
    })
}

function currentStatus(id) {
    const activeId = hyprland.active.workspace.bind("id").as(String)

    if (!hasAClient(id)) return ""
    if (id === activeId) return "active"
    return "hasClient"
}

function hasAClient(id) {
    return hyprland.workspaces.filter(ws => ws.id === id).length != 0
}
