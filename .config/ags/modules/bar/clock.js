export default Clock

import {
    BackwardSlashSeparator,
} from "../widgets/separator.js"

const day = Variable("", {
    poll: [1000, 'date "+%A"'],
})

const date = Variable("", {
    poll: [1000, 'date "+%b %d"']
})

const time = Variable("", {
    poll: [1000, 'date "+%H:%M"'],
})


function Clock() {
    const dayWidget = Widget.Label({
        label: day.bind(),
        className: 'day'
    })
    const dateWidget = Widget.Label({
        label: date.bind(),
        className: 'date'
    })
    const timeWidget = Widget.Label({
        label: time.bind(),
        className: 'time'
    })
    return Widget.Box({
        className: 'clock',
        children: [
            dayWidget,
            BackwardSlashSeparator(),
            dateWidget,
            BackwardSlashSeparator(),
            timeWidget,
        ]
    })
}
