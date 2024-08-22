export function Separator(text, fg, bg) {
    return Widget.Label({
        label: text,
        css: `color: ${fg}; background-color: ${bg}`
    })
}
