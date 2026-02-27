pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import qs.config
import qs.modules.bar.popouts as BarPopouts

Item {
    id: root

    required property ShellScreen screen
    required property PersistentProperties visibilities
    required property Item bar

    anchors.fill: parent
    anchors.margins: Appearance.borders.thickness
    anchors.topMargin: bar.exclusiveZone

    BarPopouts.Wrapper {
        id: popouts

        screen: root.screen
    }

}
