import { Variable, bind } from 'astal'
import {
    Separator,
    ForwardSlashSeparator,
    LeftHardCircleSeparator,
    RightHardCircleSeparator
} from '../widgets/separator'
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

// Id of focused workspace
const focusedId = bind(hyprland, 'focusedWorkspace').as(fws => fws.id)

// Ids of workspaces with clients
// Done this way because other methods don't update right
const idsWithClients = bind(hyprland, 'clients').as(c => c
  .map(c => c.workspace.id)
  .sort()
  .filter((id, index, ids) => ids.indexOf(id) == index))

function Workspace(id: number) {
  // Determine status to set as className
  const status = Variable.derive(
    [focusedId, idsWithClients],
    (focusedId, idsWithClients) => {
      let arr = []

      if (focusedId == id) {
        arr.push('focused')
      } else if (focusedId == id + 1) {
        arr.push('nextToFocused')
      }

      if (idsWithClients.includes(id)) {
        arr.push('hasClients')
      }

      return arr
    })

  // Determine separators for each workspace box
  const content = status(s => {
    const arr = [
      <label className='label' label={`${id}`} />
    ]

    // Skip putting separators on workspace before the focused one
    if (s.includes('nextToFocused')) {
      if (id == 1) { // leave left of 1 empty
        arr.unshift(Separator(' '))
      }
      return arr
    }

    // Set slash separators in between (right of each widget)
    if (!s.includes('focused')) {
      if (id == 9) { // leave right of 9 empty
        arr.push(Separator(' '))
        return arr
      }

      if (id == 1) { // leave left of 1 empty
        arr.unshift(Separator(' '))
      }

      arr.push(ForwardSlashSeparator())
      return arr
    }

    // Put right and left separators for focused workspace
    arr.unshift(LeftHardCircleSeparator())
    arr.push(RightHardCircleSeparator())

    return arr
  })

  return <button
           className={`workspace ws${id}`}
           onClicked={() => hyprland.dispatch('workspace', `${id}`)}>
           <box className={status(s => s.join(' '))}>
             {content}
           </box>
         </button>
}
