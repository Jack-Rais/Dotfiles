
import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.modules.bar.parts
import qs.states


BaseWidget {

    id: root
    childWidth: row.implicitWidth
    marginX: 0
    mouseAreaActive: false

    Row {
        anchors.centerIn: parent
        anchors.fill: parent

        id: row
        spacing: 0

        Rectangle {
            width: 30
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            color: "transparent"
        }

        Rectangle {
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: Config.bar.borderWidgetWidth
            color: Config.bar.colorPrimaryWidgets
        }

        Rectangle {
            width: 30
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            color: "transparent"
        }

    }

}
