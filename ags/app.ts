import { App } from "astal/gtk3"
import Bar from "./modules/bar/main"
import Notifications from "./modules/notifications/main"

App.start({
  css: './style.css',
  main() {
    const monitors = App.get_monitors()
    monitors.map(Bar)
    monitors.map(Notifications)
  },
})
