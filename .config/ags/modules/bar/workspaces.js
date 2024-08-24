import { ForwardSlashSeparator, RightHardCircleSeparator } from "../widgets/separator.js"
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
    const status = Utils.merge([activeId, idsWithClients], (activeId, idsWithClients) => {
        if (activeId === id) return 'active'
        if (idsWithClients.includes(id)) return 'hasClients'
        return ''
    })

    const content = Widget.Box({
        children: status.as(s => {
            const arr = [
                Widget.Label({
                    label: `${id}`,
                    class_name: 'label'
                })
            ]
            if (s == 'active') {
                arr.push(RightHardCircleSeparator())
            } else {
                arr.push(ForwardSlashSeparator())
            }
            return arr
        })
    })

    return Widget.Button({
        name: `workspace${id}`,
        class_name: status,
        attribute: status.as(i => `${i}`),
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: content,
    })
}
