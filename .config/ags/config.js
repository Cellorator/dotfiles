import Bar from "./modules/bar/main.js"
import Notifications from "./modules/notifications/main.js"

App.config({
    windows: [
        Notifications(),
        Bar(),
    ],
    style: "./style.css"
})

Utils.timeout(100, () => Utils.notify({
    summary: "cool",
    body: "AGGGFDDF",
    actions: {
        "COOL AFAIN": () => print("pressed"),
    },
}))
