export {
    Separator,
    ForwardSlashSeparator,
    BackwardSlashSeparator,
    LeftHardCircleSeparator,
    RightHardCircleSeparator
}

function ForwardSlashSeparator() {
    return Separator('')
}

function BackwardSlashSeparator() {
    return Separator('')
}

function LeftHardCircleSeparator() {
    return Separator('')
}

function RightHardCircleSeparator() {
    return Separator('')
}

function Separator(str) {
    return <label label={str} />
    // return Widget.Label({
    //     label: str,
    //     class_name: 'separators'
    // })
}
