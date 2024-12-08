import { Variable, bind } from 'astal'
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


const hyprland = Hyprland.get_default()

// Id of active workspace
const activeId = bind(hyprland.focusedWorkspace, 'id')

function Workspace(id) {
  // Array that keeps track of workspace status for theming
  let s = []

  if (activeId == id) {
    s.push('active')
  } else if (activeId == id + 1) {
    s.push('nextToActive')
  }

  const hasClients = bind(hyprland, 'workspaces')
    .as(workspaces => workspaces[id].windows != 0)
  if (hasClients) {
    s.push('hasClients')
  }

  const status = s.join(' ')

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

  return <button className='workspace'>
           <box
             className={bind(hyprland.focusedWorkspace, 'id')
               .as(fid => {
                 let arr = []
                 if (fid == id) {
                   arr.push('active')
                 }
                 return arr.join('')
               })}>
             <label className='label' label={id.toString()} />
           </box>
         </button>
    // return Widget.Button({
    //     name: `workspace${id}`,
    //     class_names: status.as(s => ['workspace', ...s]),
    //     on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
    //     child: content,
    // })
}
