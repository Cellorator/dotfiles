import { createBinding, For } from 'ags'
import Astal from "gi://Astal?version=4.0"
import Tray from 'gi://AstalTray'
import { BackwardSlashSeparator } from '../widgets/separator'

const tray = Tray.get_default()

export default function SysTray() {
  const items = createBinding(tray, 'items') 
  return <box class='systray'>
           <For each={items}> 
             {(item)  => SysTrayItem(item)}
           </For>
         </box>
}

function SysTrayItem(item: Tray.TrayItem) {
  const button = <menubutton
                   tooltipMarkup={item.tooltipMarkup}
                   menuModel={item.menuModel}>
                   <image class='icon' gicon={createBinding(item, "gicon")} />
                 </menubutton>
  button.insert_action_group("dbusmenu", item.actionGroup)
  item.connect("notify::action-group", () => {
    button.insert_action_group("dbusmenu", item.actionGroup)
  })

  const content = createBinding(tray, 'items').as(items => {
    let arr = [
      button,
      BackwardSlashSeparator()
    ]
    
    if (items.at(-1) === item) {
      arr.pop()
    }
    return arr
  })

  return <box>
           <For each={content}> 
             {(item) => (item)}
           </For>
         </box>
};

