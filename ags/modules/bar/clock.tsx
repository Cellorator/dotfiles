import { createPoll } from "ags/time"
import GLib from "gi://GLib"
import { BackwardSlashSeparator } from "../widgets/separator.js"

const d = GLib.DateTime.new_now_local()
const day = createPoll("", 1000, () => d.format("%A"))
const date = createPoll("", 1000, () => d.format("%b %d"))
const time = createPoll("", 1000, () => d.format("%H:%M"))

export default function Clock() {
  return <box
           class='clock'>
           <label class='day' label={day} />
           <BackwardSlashSeparator />
           <label class='date' label={date} />
           <BackwardSlashSeparator />
           <label class='time' label={time} />
         </box>
}
