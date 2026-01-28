pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import qs.config

Item {
    id: root

    required property ShellScreen screen
    required property PersistentProperties visibilities
    required property Item bar

    anchors.fill: parent
    anchors.margins: Appearance.borders.thickness
    anchors.topMargin: bar.exclusiveZone

    // To do https://github.com/caelestia-dots/shell/blob/2ddc367e4e12c13fc9499550fab62772408a6b47/modules/drawers/Panels.qml

}
