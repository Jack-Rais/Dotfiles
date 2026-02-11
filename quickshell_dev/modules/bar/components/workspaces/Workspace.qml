pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.config

Item {
    id: root

    required property int index
    required property var occupied

    readonly property int size: Appearance.bar.height - Appearance.bar.padding * 2 - Appearance.bar.workPadding * 2

    Layout.alignment: Qt.AlignVCenter
    Layout.preferredWidth: size
    Layout.preferredHeight: size

    readonly property int ws: index + 1
    readonly property bool isOccupied: occupied[ws] ?? false

    // Rectangle {
    //     anchors.fill: parent
    //     color: Qt.rgba(0, 0, 0, 0.5)
    //     radius: Appearance.general.windowRounding
    // }

    Rectangle {
        id: workspacePoint

        anchors.centerIn: parent
        color: Colors.on_surface
        radius: Appearance.general.windowRounding
        implicitHeight: 4
        implicitWidth: 4
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            Hyprland.dispatch("workspace " + root.ws)
        }

        onEntered: {
            workspacePoint.implicitHeight = 8
            workspacePoint.implicitWidth = 8
        }

        onExited: {
            workspacePoint.implicitHeight = 4
            workspacePoint.implicitWidth = 4
        }
    }

}
