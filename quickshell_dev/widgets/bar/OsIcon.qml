
import QtQuick
import QtQuick.Controls

import qs.config


Button {

    implicitHeight: parent.height
    implicitWidth: parent.height

    onClicked: function () {
        States.launcherOpen = !States.launcherOpen
    }

    background: Rectangle {

        topLeftRadius: Config.radius
        bottomLeftRadius: Config.radius
        topRightRadius: Config.radius
        bottomRightRadius: Config.radius

        color: Colors.surface

    }

    Text {

        id: logo

        text: ""
        anchors.centerIn: parent

        font.bold: true
        font.pointSize: 16
        color: Colors.on_surface
    }

}
