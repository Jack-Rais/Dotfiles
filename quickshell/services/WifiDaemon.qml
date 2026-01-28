pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {

    id: root
    property string currentSSID: ""
    signal ssidChanged(string newSSID)

    Process {
        id: proc
        command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d ':' -f2"]

        stdout: StdioCollector {
            onStreamFinished: {
                var ssid = text.trim()
                if (ssid !== root.currentSSID) {
                    root.currentSSID = ssid
                    root.ssidChanged(ssid)
                }
            }
        }
    }

    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: {
            proc.running = true
        }
    }

}
