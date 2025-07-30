
import QtQuick
import Quickshell
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

import qs.options


Item {
    id: root

    property bool colorize: false
    property color color
    property string source: ""
    property string iconFolder: Config.dirs.iconsDir

    IconImage {
        id: iconImage
        anchors {
            fill: parent
            topMargin: Appearance.bar.vIconPadding
            bottomMargin: Appearance.bar.vIconPadding
            leftMargin: Appearance.bar.hIconPadding
            rightMargin: Appearance.bar.hIconPadding
        }
        source: iconFolder + "/" + root.source
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
