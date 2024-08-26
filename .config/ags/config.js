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
    summary: "cooooooooooooooool",
    body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    actions: {
        "COOL AFAIN": () => print("pressed"),
    },
}))
