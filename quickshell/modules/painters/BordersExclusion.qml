pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import qs.config
import qs.components.containers

Scope {
    id: root

    required property ShellScreen screen
    required property Item bar

    component ExclusionZone: StyledWindow {
        screen: root.screen
        name: "border-exclusion"
        exclusiveZone: Config.border.thickness
        mask: Region {}
        implicitWidth: 1
        implicitHeight: 1
    }

    ExclusionZone {
        anchors.top: true
        exclusiveZone: root.bar.exclusiveZone
    }

    ExclusionZone {
        anchors.left: true
    }

    ExclusionZone {
        anchors.right: true
    }

    ExclusionZone {
        anchors.bottom: true
    }

}
