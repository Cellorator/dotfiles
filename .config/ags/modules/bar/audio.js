import { BackwardSlashSeparator } from "../widgets/separator.js"
const audio = await Service.import("audio")

const opened = Variable(false)
App.connect("window-toggled", (_, name, visible) => {
    Utils.timeout(500, () => opened.value = false)
})

export default function Audio() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })

    const slider = Widget.Slider({
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => audio.speaker.volume = value,
        setup: self => self.hook(audio.speaker, () => {
            self.value = audio.speaker.volume || 0
        }),
    })

    const menu = Widget.Window({
        name: "audio-menu",
        child: Widget.Revealer({
            reveal_child: opened.bind(),
            child: Widget.Box({
                children: [
                    Widget.Label("jello"),
                    icon,
                    slider
                ]
            })
        })
    })

    const content = Widget.Box({
        class_name: "audio",
        children: [
            BackwardSlashSeparator(),
            Widget.Icon({
                icon: "audio-volume-high-symbolic"
            })
        ],
    })

    return Widget.Button({
        on_primary_click: (_, event) => {
            opened.value = true
            App.addWindow(menu)
        },
        child: content,
    })
}
