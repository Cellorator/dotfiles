import { createBinding, For, This } from "ags"
import app from "ags/gtk4/app"
import Bar from "./modules/bar/main"
// import Notifications from "./modules/notifications/main"

app.start({
  css: './style.css',
  main() {
    const monitors = app.get_monitors()
    monitors.map(Bar)
  },
})
