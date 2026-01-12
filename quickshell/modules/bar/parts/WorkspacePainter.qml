import Quickshell
import Quickshell.Hyprland
import QtQuick

import qs.states


Item {
    required property bool isOccupied
    required property bool isActive
    required property int workspaceNumber  // Meglio di index per chiarezza

    implicitWidth: 15
    implicitHeight: 15

    Rectangle {

        id: background
        anchors.fill: parent
        radius: Config.windowRounding

        color: {
            if (mouseArea.containsMouse) {
                return Config.bar.colorHoveredWorkspace
            }
            return "transparent"
        }
        border {
            width: Config.bar.borderWidgetWidth
            color: isActive ? Config.bar.colorActiveWorkspace : Config.bar.colorInactiveWorkspace
        }

    }

    Rectangle {

        visible: isOccupied && (!mouseArea.containsMouse || isActive)
        anchors.centerIn: parent
        radius: Config.windowRounding
        width: parent.width / 3
        height: parent.height / 3

        color: isActive ? Config.bar.colorActiveWorkspace : Config.bar.colorInactiveWorkspace
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            console.log("Workspace clicked:", workspaceNumber)
            Hyprland.dispatch("workspace " + (workspaceNumber + 1))
        }
    }
}
