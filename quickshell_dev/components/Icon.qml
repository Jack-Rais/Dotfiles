
import QtQuick
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

import qs.config

Item {
    id: root

    required property string imagePath
    required property color imageColor

    Image {
        id: image
        anchors.centerIn: parent
        anchors.fill: parent
        source: root.imagePath
    }

}
