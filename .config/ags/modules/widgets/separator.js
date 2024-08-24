export { ForwardSlashSeparator, RightHardCircleSeparator }

function ForwardSlashSeparator() {
    return Separator('')
}

function RightHardCircleSeparator() {
    return Separator('')
}

function Separator(str, class_name) {
    return Widget.Label({
        label: str,
        class_name: `separator`
    })
}
