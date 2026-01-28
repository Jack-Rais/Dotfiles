import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.states
import qs.services
import qs.modules.bar.parts

BaseWidget {

    id: background
    childWidth: timeText.width

    Text {
        id: timeText
        anchors.centerIn: parent

        text: Qt.formatDateTime(ClockDaemon.date, "hh:mm ddd d")
        color: Config.bar.colorPrimaryWidgets
        font {
            pixelSize: Config.fontSize
            bold: true
        }
        horizontalAlignment: Text.AlignHCenter
    }

}
