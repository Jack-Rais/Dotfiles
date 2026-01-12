pragma Singleton

import Quickshell


Singleton {

    id: root
    readonly property date date: clock.date

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

}
