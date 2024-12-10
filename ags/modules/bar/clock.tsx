import { Variable } from "astal"
import { BackwardSlashSeparator } from "../widgets/separator.js"

const day = Variable("").poll(1000, 'date "+%A"')
const date = Variable("").poll(1000, 'date "+%b %d"')
const time = Variable("").poll(1000, 'date "+%H:%M"')

export default function Clock() {
  return <box
           className='clock'>
           <label className='day' label={day()} />
           <BackwardSlashSeparator />
           <label className='date' label={date()} />
           <BackwardSlashSeparator />
           <label className='time' label={time()} />
         </box>
}
