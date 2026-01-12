import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.states
import qs.services
import qs.modules.bar.parts

BaseWidget {

    id: background
    implicitWidth: timeText.width + Config.bar.marginX

    Text {
        id: timeText
        anchors.centerIn: parent

        text: Qt.formatDateTime(ClockDaemon.date, "hh:mm | ddd d")
        color: Config.bar.colorPrimaryWidgets
        font {
            pixelSize: Config.fontSize
            bold: true
        }
        horizontalAlignment: Text.AlignHCenter
        Layout.alignment: Qt.AlignHCenter
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
