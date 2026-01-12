
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import qs.states
import qs.modules.bar.modules

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }
    color: Config.bar.colorBackground
    implicitHeight: Config.bar.height + Config.wallpaper.borderWidth
    exclusiveZone: Config.bar.height

    RowLayout {
        anchors.fill: parent
        anchors.margins: 2
        spacing: 1

        Item {
            id: right
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Item {
            id: center
            Layout.fillWidth: true
            Layout.fillHeight: true

            Workspaces {
                anchors.centerIn: parent
            }

        }

        Item {
            id: left
            Layout.fillWidth: true
            Layout.fillHeight: true

            Clock {
                id: clockWidget
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: powerWidget.left
                anchors.rightMargin: Config.wallpaper.borderWidth + 2
            }

            Power {
                id: powerWidget
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: Config.wallpaper.borderWidth + 2
            }

        }


    }

}
