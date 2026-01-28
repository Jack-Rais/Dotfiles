
import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell

import qs.config
import qs.components
import qs.modules.bar.components

BaseWidget {

    required property PersistentProperties visibilities
    childWidth: Appearance.bar.height - Appearance.bar.padding * 2

    StateLayer {

        anchors.fill: parent
        anchors.centerIn: parent
        radius: Appearance.bar.iconRadius

        function onClicked(): void {
            root.visibilities.power = !root.visibilities.power
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
