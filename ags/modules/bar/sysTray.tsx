import { bind } from 'astal'
import { Astal, Gdk } from 'astal/gtk3'
import Tray from 'gi://AstalTray'
import { BackwardSlashSeparator } from '../widgets/separator'

const tray = Tray.get_default()

export default function SysTray() {
  return <box className='systray'>
           {
             bind(tray, 'items').as(items => items.map(SysTrayItem))
           }
         </box>
}

function SysTrayItem(item: Tray.TrayItem) {
  const button = <menubutton
                   tooltipMarkup={bind(item, "tooltipMarkup")}
                   usePopover={false}
                   actionGroup={bind(item, "action-group").as(ag => ["dbusmenu", ag])}
                   menuModel={bind(item, "menu-model")}>
                   <icon className='icon' gIcon={bind(item, "gicon")} />
                 </menubutton>

  return <box>
           {bind(tray, 'items').as(items => {
             let arr = [
               button,
               BackwardSlashSeparator()
             ]

             if (items.at(-1) === item) {
               arr.pop()
             }
             return arr
           })}
         </box>
};

