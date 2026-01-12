
import Quickshell
import QtQuick
import qs.states
import Qt5Compat.GraphicalEffects

Item {
    implicitWidth: Config.bar.height - Config.bar.padding
    implicitHeight: Config.bar.height - Config.bar.padding

    Rectangle {
        id: background
        anchors.fill: parent
        radius: Config.windowRounding
        color: Config.bar.colorWidgetBackground
        border {
            color: Config.bar.colorPrimaryWidgets
            width: Config.bar.borderWidgetWidth
        }

        Image {
            id: logoPower
            anchors.fill: parent
            anchors.margins: 7
            source: "./../../../assets/power.svg"
            sourceSize: Qt.size(width, height)

            layer.enabled: true
            layer.effect: ColorOverlay {
                color: Config.bar.colorPrimaryWidgets
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            background.color = Config.bar.colorWidgetBackgroundClicked
        }

        onExited: {
            background.color = Config.bar.colorWidgetBackground
        }

    }
}
