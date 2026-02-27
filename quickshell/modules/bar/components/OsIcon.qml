
import QtQuick
import Quickshell
import Quickshell.Widgets

import qs.config
import qs.components


BaseWidget {

    childWidth: Appearance.bar.height - Appearance.bar.padding * 2

    Text {
        id: logo

        text: ""
        anchors.centerIn: parent

        font.bold: true
        font.pointSize: 15
        color: Appearance.bar.logoIconColor
    }

}
