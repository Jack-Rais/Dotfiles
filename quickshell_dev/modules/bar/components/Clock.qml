
import QtQuick

import qs.config
import qs.services
import qs.components


BaseWidget {

    childWidth: logo.implicitWidth + Appearance.bar.padding * 6

    Text {
        id: logo

        text: Time.format("hh:mm")
        anchors.centerIn: parent

        font.bold: true
        font.pointSize: 12
        color: Appearance.bar.logoIconColor
    }



}
