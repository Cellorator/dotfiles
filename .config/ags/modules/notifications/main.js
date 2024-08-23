const notifications = await Service.import("notifications")

export default function Notifications() {
    return Widget.Window({
        name: 'notifications',
        className: 'notifications',
        anchor: ['right', 'top', 'bottom'],
        margins: [35, 6, 0, 0],
        exclusivity: "ignore",
        child: Widget.Box({
            vertical: true,
            homogeneous: false,
            spacing: 6,
            // children: notifications.bind('popups').as(notifs => notifs.map(Notification))
            children: [ Widget.Label('hello') ]
        })
    })
}

function Notification() {
    return Widget.Label('hello')
}
