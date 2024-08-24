import { ForwardSlashSeparator } from "../widgets/separator.js"
const hyprland = await Service.import("hyprland")

export default function Workspaces() {
    const workspaces = [...Array(9).keys()]
        .map(id => id + 1)
        .map(Workspace)

    return Widget.Box({
        className: "workspaces",
        children: workspaces,
    })
}

const activeId = hyprland.active.workspace.bind("id").as(Number)
// Get array of ids of workspaces with at least one client
const idsWithClients = hyprland.bind("workspaces").as(workspaces => {
    return workspaces.filter(ws => ws.windows !== 0).map(ws => ws.id)
})
function Workspace(id) {
    return Widget.Button({
        name: `workspace${id}`,
        className: Utils.merge([activeId, idsWithClients], (activeId, idsWithClients) => {
            if (activeId === id) return "active"
            if (idsWithClients.includes(id)) return "hasClients"
            return ""
        }),
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: Widget.Box({
            children: [Widget.Label(`${id}`), ForwardSlashSeparator()]
        })
    })
}
