import Bar from "./modules/bar/main.js"
import Notifications from "./modules/notifications/main.js"

Utils.timeout(100, () => Utils.notify({
    summary: "cool",
    body: "AGGGFDDF",
    actions: {
        "COOL AFAIN": () => print("pressed"),
    },
}))

App.config({
    windows: [
        Bar(),
        Notifications()
    ],
    style: "./style.css"
})
