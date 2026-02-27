pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.config
import qs.modules.bar.components

Item {
    id: root

    required property PersistentProperties visibilities
    required property ShellScreen screen
    readonly property int exclusiveZone: Appearance.bar.height
    height: Appearance.bar.height

    RowLayout {
        anchors.fill: parent
        anchors.centerIn: parent
        anchors {
            leftMargin: 5
            rightMargin: 5
        }

        // Left part
        SectionBar {
            entries: Config.bar.entries_left
            visibilities: root.visibilities
            screen: root.screen
        }

        // Center part
        SectionBar {
            entries: Config.bar.entries_center
            visibilities: root.visibilities
            screen: root.screen
        }

        // Right part
        SectionBar {
            entries: Config.bar.entries_right
            visibilities: root.visibilities
            screen: root.screen
        }

    }

}
