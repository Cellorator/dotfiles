import { Astal, Gtk, Gdk } from "astal/gtk3"
import Workspaces from "./workspaces"
import Clock from "./clock"
import SysTray from "./sysTray"

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

             <box className='middle'>
             </box>

             <box className='right' halign={Gtk.Align.END}>
               <SysTray />
               <Clock />
             </box>
           </centerbox>
         </window>
}
