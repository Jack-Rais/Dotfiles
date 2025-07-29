
import QtQuick
import Quickshell
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

import "root:/options"

Item {
    id: root

    property bool colorize: false
    property color color
    property string source: ""
    property string iconFolder: Config.dirs.iconsDir

    width: 30
    height: 30

    IconImage {
        id: iconImage
        anchors.fill: parent
        source: iconFolder + "/" + root.source
        implicitSize: root.height
    }

    Loader {
        active: root.colorize
        anchors.fill: iconImage
        sourceComponent: ColorOverlay {
            source: iconImage
            color: root.color
        }
    }
}
