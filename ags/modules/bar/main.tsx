// import { Astal, Gtk, Gdk } from "astal/gtk3"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import Workspaces from "./workspaces"
import Clock from "./clock"
// import SysTray from "./sysTray"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  return <window
           visible
           class='bar-window'
           gdkmonitor={gdkmonitor}
           anchor={Astal.WindowAnchor.TOP
             | Astal.WindowAnchor.LEFT
             | Astal.WindowAnchor.RIGHT}
           marginTop={4}
           marginLeft={4}
           marginRight={4}
           exclusivity={Astal.Exclusivity.EXCLUSIVE}>
           <centerbox class='bar-box'>
             <box $type='start' class='left' halign={Gtk.Align.START}>
               <Workspaces />
             </box>

             <box $type='center' class='middle'></box>

             <box $type='end' class='right' halign={Gtk.Align.END}>
               <Clock />
             </box>
           </centerbox>
         </window>
}



// import { bind } from 'astal'
// import Battery from "gi://AstalBattery"
// function BatteryLevel() {
//     const bat = Battery.get_default()

//     return <box className="Battery"
//         visible={bind(bat, "isPresent")}>
//         <icon icon={bind(bat, "batteryIconName")} />
//         <label label={bind(bat, "percentage").as(p =>
//             `${Math.floor(p * 100)} %`
//         )} />
//     </box>
// }

