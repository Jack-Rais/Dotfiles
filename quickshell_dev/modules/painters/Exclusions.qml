pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.components
import qs.config

Scope {
    id: root

    required property ShellScreen screen
    required property Item bar

    component ExclusiveZone: StyledWindow {
        screen: root.screen
        name: "exclusion-border"
        exclusiveZone: Appearance.borders.thickness + Appearance.borders.padding
        mask: Region {}
        implicitWidth: 1
        implicitHeight: 1
    }

    ExclusiveZone {
        anchors.top: true
        exclusiveZone: root.bar.exclusiveZone
    }

    ExclusiveZone {
        anchors.bottom: true
    }


    ExclusiveZone {
        anchors.left: true
    }

    ExclusiveZone {
        anchors.right: true
    }
}
