
import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io

import qs.config
import qs.components
import qs.modules.bar.components

BaseWidget {

    required property PersistentProperties visibilities
    childWidth: Appearance.bar.height - Appearance.bar.padding * 2

    Process {
        id: shutdownProc
        running: false
        command: [ "shutdown", "now" ]
    }

    StateLayer {

        anchors.fill: parent
        anchors.centerIn: parent
        radius: Appearance.bar.iconRadius

        function onClicked(): void {
            // root.visibilities.power = !root.visibilities.power
            shutdownProc.running = true
        }

    }

    Text {
        id: icon

        text: ""
        anchors.centerIn: parent

        font.bold: true
        font.pointSize: Appearance.font.iconSize
        color: Colors.error
    }

}
