import { bind, Variable } from 'astal'
import { Astal, Gtk, Gdk } from 'astal/gtk3'
import Notifd from 'gi://AstalNotifd'
import {
    LeftHardCircleSeparator,
    RightHardCircleSeparator
} from '../widgets/separator.js'

const notifd = Notifd.get_default()

export default function Notifications(gdkmonitor: Gdk.Monitor) {
  // let notifications = []

  // notifd.connect('notified', (_, id) => {
  //   const n = notifd.get_notification(id)
  //   if (n) {
  //     notifications.unshift(n)
  //   }
  // })

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
// export default function Notifications(monitor = 0) {
//     const list = Widget.Box({
//         vertical: true,
//         children: notifications.popups.map(Notification),
//     })

//     function onNotified(_, /** @type {number} */ id) {
//         const n = notifications.getNotification(id)
//         if (n)
//             list.children = [Notification(n), ...list.children]
//     }

//     function onDismissed(_, /** @type {number} */ id) {
//         list.children.find(n => n.attribute.id === id)?.destroy()
//     }

//     list.hook(notifications, onNotified, "notified")
//         .hook(notifications, onDismissed, "dismissed")

//     return Widget.Window({
//         monitor,
//         name: `notifications${monitor}`,
//         anchor: ['top', 'right'],
//         margins: [0, 6],
//         css: 'background-color: transparent',
//         child: Widget.Box({
//             class_name: "notifications",
//             vertical: true,
//             child: list
//         })
//     })
// }

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

// function Notification(n) {
//     const title = Widget.CenterBox({
//         className: 'title',
//         hpack: 'center',
//         startWidget: LeftHardCircleSeparator(),
//         centerWidget: Widget.Label(n.summary),
//         endWidget: RightHardCircleSeparator()
//     })
//     const body = Widget.Label({
//         class_name: "body",
//         label: n.body,
//         wrap: true,
//         justification: 'center',
//     })
//     const actions = Widget.Box({
//         class_name: "actions",
//         hpack: 'center',
//         children: n.actions.map(({ id, label }) => Widget.Button({
//             class_name: "action-button",
//             on_clicked: () => {
//                 n.invoke(id)
//                 n.dismiss()
//             },
//             child: Widget.Label(label),
//         })),
//     })

//     return Widget.EventBox(
//         {
//             attribute: { id: n.id },
//             on_primary_click: n.dismiss,
//         },
//         Widget.Box(
//             {
//                 class_name: `notification ${n.urgency}`,
//                 vertical: true,
//                 children: [
//                     title,
//                     body,
//                     actions
//                 ]
//             },
//         ),
//     )
// }
