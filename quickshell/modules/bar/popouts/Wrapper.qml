pragma ComponentBehavior: Bound

import QtQuick
import Quickshell


Item {

    id: root

    required property ShellScreen screen

    // readonly property real nonAnimHeight: y > 0 || hasCurrent ? children.find(c => c.shouldBeActive)?.implicitHeight ?? content.implicitHeight : 0
    // readonly property real nonAnimWidth: children.find(c => c.shouldBeActive)?.implicitWidth ?? content.implicitWidth
    // readonly property Item current: content.item?.current ?? null

}
