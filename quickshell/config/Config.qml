pragma Singleton

import QtQuick
import Quickshell

Singleton {


    property QtObject bar: QtObject {

        property list<string> entries_left: [
            "logo",
            "battery",
            "spacer",
        ]

        property list<string> entries_center: [
            "spacer",
            "workspaces",
            "spacer"
        ]

        property list<string> entries_right: [
            "spacer",
            "clock",
            "power"
        ]

        readonly property var sysBatteryIcons: ({
            discharging: {
                0: "/icons/battery-critical.svg",
                15: "/icons/battery-low.svg",
                40: "/icons/battery-medium.svg",
                70: "/icons/battery-high.svg",
                90: "/icons/battery-full.svg"
            },
            charging: {
                0: "/icons/battery-charging-critical.svg",
                15: "/icons/battery-charging-low.svg",
                40: "/icons/battery-charging-medium.svg",
                70: "/icons/battery-charging-high.svg",
                90: "/icons/battery-charging-full.svg"
            }
        })

    }

}
