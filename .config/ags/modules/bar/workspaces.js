const hyprland = await Service.import("hyprland")

export default function Workspaces() {
    const activeId = hyprland.active.workspace.bind("id").as(Number)
    // Get array of ids of workspaces with at least one client
    const idsWithClients = hyprland.bind("workspaces").as(workspaces => {
        return workspaces.filter(ws => ws.windows !== 0).map(ws => ws.id)
    })

    const workspaces = [...Array(9).keys()]
        .map(id => id + 1)
        .map(id => Widget.Button({
            child: Widget.Label(`${id}`),
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
            className: Utils.merge([activeId, idsWithClients], (activeId, idsWithClients) => {
                if (activeId === id) return "active"
                if (idsWithClients.includes(id)) return "hasClients"
                return ""
            })
        }))

    return Widget.Box({
        className: "workspaces",
        children: workspaces,
    })
}
