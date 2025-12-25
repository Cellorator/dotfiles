import { createPoll } from "ags/time"
import { BackwardSlashSeparator } from "../widgets/separator.js"

const day = createPoll("", 1000, 'date "+%A"')
const date = createPoll("", 1000, 'date "+%b %d"')
const time = createPoll("", 1000, 'date "+%H:%M"')

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
