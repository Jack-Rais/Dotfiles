
import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.config


PanelWindow {

    required property var modelData
    screen: modelData

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Config.barHeight
    color: "transparent"

    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    WlrLayershell.layer: WlrLayer.Overlay

    // Bar content
    Item {

        anchors {
            fill: parent
            leftMargin: Config.barMargin
            topMargin: Config.barMargin
            rightMargin: Config.barMargin
        }

        OsIcon {}


    }

}
