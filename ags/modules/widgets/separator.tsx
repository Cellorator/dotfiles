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
    return <label class='separators' label={str} />
}
