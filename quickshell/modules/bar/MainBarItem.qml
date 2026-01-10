
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.states

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }
    // color: Config.bar.colorBackground
    color: "white"
    implicitHeight: Config.bar.height

    RowLayout {
        anchors.fill: parent
        anchors.margins: 2
        spacing: 0

        Item {
            id: right
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                color: "black"
            }
        }

        Rectangle {
            id: center
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: "black"

            Repeater {
                model: 9

                Rectangle {
                    required property int index
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                    implicitWidth: 10
                    implicitHeight: 10

                    color: isActive ? Config.bar.colorActiveWorkspace : (
                        ws ? Config.bar.colorInactiveWorkspace : Config.bar.colorClosedWorkspace
                    )
                }
            }

        }

        Item {
            id: left
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                anchors.fill: parent
                color: "black"
            }
        }


    }

}
