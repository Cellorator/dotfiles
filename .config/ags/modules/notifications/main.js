const notifications = await Service.import("notifications")

export default function Notifications() {
    const list = Widget.Box({
        vertical: true,
        homogeneous: false,
        spacing: 6,
        children: [Widget.Label("sdfhjs")]
    })

    list.hook(notifications, (_, id) => {
        const n = notifications.getNotification(id)
        if (n)
            list.children = [Notification(n), ...list.children]
    }, 'notified')

    // list.hook(notifications, (_, id) => {
    //     list.children.find(n => )
    // })

    return Widget.Window({
        name: 'notifications',
        className: 'notifications',
        css: "background-color: transparent",
        anchor: ['right', 'top', 'bottom'],
        margins: [35, 6, 0, 0],
        exclusivity: "ignore",
        child: list
    })
}

function Notification(n) {
    print(n.summary)
    const title = Widget.Label({
        label: n.summary
    })

    return Widget.EventBox({
        child: Widget.Box({
            children: [
                title,
            ]
        }),
    })
}
