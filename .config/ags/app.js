import Bar from "./modules/bar/main.js"
import Notifications from "./modules/notifications/main.js"

App.config({
    windows: [
        Notifications(),
        Bar(),
    ],
    style: "./style.css"
})
