import { BackwardSlashSeparator } from "../widgets/separator.js"

const systemtray = await Service.import('systemtray')

export default function SysTray() {
    return Widget.Box({
        className: 'systray',
        children: systemtray.bind('items').as(i => i.map(SysTrayItem))
    })
}

function SysTrayItem(item) {
    const content = Widget.Box({
        children: systemtray.bind('items').as(items => {
            let arr = [
                Widget.Icon({
                    className: 'icon',
                    icon: item.bind('icon'),
                    size: 20
                }),
                BackwardSlashSeparator()
            ]
            if (items.at(-1) === item) {
                arr.pop()
            }
            return arr
        })
    })

    return Widget.Button({
        tooltipMarkup: item.bind('tooltip_markup'),
        onPrimaryClick: (_, event) => item.activate(event),
        onSecondaryClick: (_, event) => item.openMenu(event),
        child: content
    })
};

