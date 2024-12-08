import { Variable, bind, Binding } from 'astal'
import {
    Separator,
    ForwardSlashSeparator,
    LeftHardCircleSeparator,
    RightHardCircleSeparator
} from '../widgets/separator.js'
import Hyprland from 'gi://AstalHyprland'

export default function Workspaces() {
  return <box className='workspaces'>
           {
             [...Array(9).keys()]
               .map(id => id + 1)
               .map(Workspace)
           }
         </box>
}

// export default function Workspaces() {
//     const hypr = Hyprland.get_default()

//     return <box className="Workspaces">
//         {bind(hypr, "workspaces").as(wss => wss
//             .sort((a, b) => a.id - b.id)
//             .map(ws => (
//                 <button
//                     className={bind(hypr, "focusedWorkspace").as(fw =>
//                         ws === fw ? "focused" : "")}
//                     onClicked={() => ws.focus()}>
//                     {ws.id}
//                 </button>
//             ))
//         )}
//     </box>
// }

const hyprland = Hyprland.get_default()

const focusedId = bind(hyprland, 'focusedWorkspace').as(fws => fws.id)

function Workspace(id: Number) {
  const hyprland = Hyprland.get_default()
  // Id of active workspace
  // const activeId = bind(hyprland.focusedWorkspace, 'id')
  // Array that keeps track of workspace status for theming
  // let s = []

  // if (activeId == id) {
  //   s.push('active')
  // } else if (activeId == id + 1) {
  //   s.push('nextToActive')
  // }

  // const hasClients = bind(hyprland, 'workspaces')
  //   .as(workspaces => workspaces[id].windows != 0)
  // if (hasClients) {
  //   s.push('hasClients')
  // }

  // const status = s.join(' ')

    // const Content = Widget.Box({
    //     children: status.as(s => {
    //         const arr = [
    //             Widget.Label({
    //                 label: `${id}`,
    //                 class_name: 'label'
    //             })
    //         ]


    //         if (s.includes('nextToActive')) {
    //             if (id == 1) {
    //                 arr.unshift(Separator(' '))
    //             }
    //             return arr
    //         }

    //         if (!s.includes('active')) {
    //             if (id == 9) {
    //                 arr.push(Separator(' '))
    //                 return arr
    //             }

    //             if (id == 1) {
    //                 arr.unshift(Separator(' '))
    //             }
    //             arr.push(ForwardSlashSeparator())
    //             return arr
    //         }

    //         arr.unshift(LeftHardCircleSeparator())
    //         arr.push(RightHardCircleSeparator())
    //         return arr
    //     })
    // })

  return <button
           className={`workspace ws${id}`}
           onClicked={() => hyprland.dispatch('workspace', `${id}`)}>
           <box
             className={focusedId.as(fid => {
               let arr = []
               if (fid == id) {
                 arr.push('focused')
               }
               return arr.join(' ')
             })}>
             <label className='label' label={`${id}`} />
           </box>
         </button>
    // return Widget.Button({
    //     name: `workspace${id}`,
    //     class_names: status.as(s => ['workspace', ...s]),
    //     on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
    //     child: content,
    // })
}
