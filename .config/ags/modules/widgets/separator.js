export {
    Separator,
    ForwardSlashSeparator,
    LeftHardCircleSeparator,
    RightHardCircleSeparator
}

function ForwardSlashSeparator() {
    return Separator('')
}

function LeftHardCircleSeparator() {
    return Separator('')
}

function RightHardCircleSeparator() {
    return Separator('')
}

function Separator(str) {
    return Widget.Label({
        label: str,
        class_name: 'separators'
    })
}
