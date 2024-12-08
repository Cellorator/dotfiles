import { Astal, Gtk, Gdk } from "astal/gtk3"
import Workspaces from "./workspaces"
import Clock from "./clock"
import SysTray from "./sysTray"

// import Audio from "./audio.js"

// export default function Bar() {
//     const widgets = Widget.CenterBox({
//         className: 'bar-box',
//         startWidget: Left(),
//         endWidget: Right()
//     })

//     return Widget.Window({
//         name: 'bar',
//         className: 'bar-window',
//         anchor: ['top', 'left', 'right'],
//         layer: 'top',
//         exclusivity: "exclusive",
//         margins: [4, 4, 0, 4],
//         child: widgets
//     })
// }

export default function Bar(gdkmonitor: Gdk.Monitor) {
  return <window
           className='bar-window'
           gdkmonitor={gdkmonitor}
           anchor={Astal.WindowAnchor.TOP
             | Astal.WindowAnchor.LEFT
             | Astal.WindowAnchor.RIGHT}
           marginTop={4}
           marginLeft={4}
           marginRight={4}
           exclusivity={Astal.Exclusivity.EXCLUSIVE}>
           <centerbox className='bar-box'>
             <box className='left' halign={Gtk.Align.START}>
               <Workspaces />
             </box>

             <box>
             </box>

             <box className='right' halign={Gtk.Align.END}>
               <SysTray />
               <Clock />
             </box>
           </centerbox>
         </window>
}
