import { App } from "astal/gtk3"
import style from "./style.css"
import Bar from "./modules/bar/main"

App.start({
    css: style,
    main() {
        App.get_monitors().map(Bar)
    },
})
