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
  const content = <box>
                    {bind(tray, 'items').as(items => {
                      let arr = [
                        <icon className='icon' gIcon={bind(item, 'gicon')}></icon>,
                        BackwardSlashSeparator()
                      ]

                      if (items.at(-1) === item) {
                        arr.pop()
                      }
                      return arr
                    })}
                  </box>

  const menu = item.create_menu()

  return <button
           tooltipMarkup={bind(item, 'tooltipMarkup')}
           onDestroy={() => menu?.destroy()}
           onClick={(self, event) => {
             if (event.button == Astal.MouseButton.PRIMARY) {
               item.activate(100, 100)
             } else if (event.button == Astal.MouseButton.SECONDARY) {
               menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
             }
           }}>
           {content}
         </button>
};

