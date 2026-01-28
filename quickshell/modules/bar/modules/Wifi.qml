
import QtQuick

import qs.states
import qs.services
import qs.modules.bar.parts


BaseWidget {

    childWidth: nameText.width

    Text {
        id: nameText
        anchors.centerIn: parent

        text: "Ciao"
        color: Config.bar.colorPrimaryWidgets
        font {
            pixelSize: Config.fontSize
            bold: true
        }
        horizontalAlignment: Text.AlignHCenter
    }

    Component.onCompleted: {
        WifiDaemon.ssidChanged.connect(function(newSSID) {
            nameText.text = newSSID
        })
    }

}
