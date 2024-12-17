import { bind, Variable } from 'astal'
import { Astal, Gtk, Gdk } from 'astal/gtk3'
import Notifd from 'gi://AstalNotifd'
import {
    LeftHardCircleSeparator,
    RightHardCircleSeparator
} from '../widgets/separator.js'

const notifd = Notifd.get_default()

export default function Notifications(gdkmonitor: Gdk.Monitor) {
  return <window
           className='notifications-window'
           gdkmonitor={gdkmonitor}
           anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
           exclusivity={Astal.Exclusivity.IGNORE}>
           <box vertical>
             {
               bind(notifd, 'notifications').as(notifs => notifs
                 .map(n => n.id)
                 .sort()
                 .reverse()
                 .map(Notification))
             }
           </box>
         </window>
}

function Notification(id: number) {
  const n = notifd.get_notification(id)
  return <eventbox
           onClick={() => {
             n.dismiss()
           }}>
           <box className={`notification ${n.id}`} vertical>
             <centerbox className='title' halign={Gtk.Align.CENTER}>
               <LeftHardCircleSeparator />
               <label label={n.summary} />
               <RightHardCircleSeparator />
             </centerbox>

             <label className='body' wrap
               justify={Gtk.Justification.CENTER}
               label={n.body} />

             <box className='actions' halign={Gtk.Align.CENTER}>
               {n.actions.map(({id, label}) =>
                 <button
                   onClick={() => {
                     n.invoke(id)
                   }}
                   label={label}>
                 </button>
               )}
             </box>
           </box>
         </eventbox>
}
