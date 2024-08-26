import {
    Separator,
    ForwardSlashSeparator,
    LeftHardCircleSeparator,
    RightHardCircleSeparator
} from "../widgets/separator.js"

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
    return workspaces.filter(ws => ws.windows != 0).map(ws => ws.id)
})
function Workspace(id) {
    const status = Utils.merge([activeId, idsWithClients], (activeId, idsWithClients) => {
        let s = [];
        if (activeId == id) {
            s.push('active')
        } else if (activeId == id + 1) {
            s.push('nextToActive')
        }
        if (idsWithClients.includes(id)) {
            s.push('hasClients')
        }

        return s
    })

    const content = Widget.Box({
        children: status.as(s => {
            const arr = [
                Widget.Label({
                    label: `${id}`,
                    class_name: 'label'
                })
            ]


            if (s.includes('nextToActive')) {
                if (id == 1) {
                    arr.unshift(Separator(' '))
                }
                return arr
            }

            if (!s.includes('active')) {
                if (id == 9) {
                    arr.push(Separator(' '))
                    return arr
                }

                if (id == 1) {
                    arr.unshift(Separator(' '))
                }
                arr.push(ForwardSlashSeparator())
                return arr
            }

            arr.unshift(LeftHardCircleSeparator())
            arr.push(RightHardCircleSeparator())
            return arr
        })
    })

    return Widget.Button({
        name: `workspace${id}`,
        class_names: status.as(s => ['workspace', ...s]),
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: content,
    })
}
