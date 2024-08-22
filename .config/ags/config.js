import Bar from "./bar.js"
import NotificationPopups from "./notificationPopups.js"

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
        // NotificationPopups()
    ],
    style: "./style.css"
})
