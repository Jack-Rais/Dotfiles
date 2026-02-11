pragma ComponentBehavior: Bound

import QtQuick

import qs.config


Rectangle {
    id: root

    required property int activeWsId
    required property Repeater workspaces
    required property Item layoutParent

    property real start: workspaces.count > 0 ? workspaces.itemAt(activeWsId - 1)?.x ?? 0 : 0
    property real currentSize: workspaces.count > 0 ? workspaces.itemAt(activeWsId - 1)?.size ?? 0 : 0

    x: layoutParent.x + start + Appearance.bar.workActivePadding
    implicitHeight: currentSize - Appearance.bar.workActivePadding * 2
    implicitWidth: currentSize - Appearance.bar.workActivePadding * 2
    radius: Appearance.general.windowRounding

    color: Colors.primary

    Behavior on start {
        NumberAnimation {
            easing.bezierCurve: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
            duration: 200
        }
    }

}


// Rectangle {
//     id: indicator
//
//     required property int activeWsId
//     required property Repeater workspaces
//
//     property Item wsCurr: workspaces.itemAt(activeWsId)
//     property real wsX: 0
//     property real wsY: 0
//
//     readonly property int activeSize: Appearance.bar.height - Appearance.bar.padding * 2 - Appearance.bar.workActivePadding * 2
//
//     x: wsX
//     y: wsY
//     implicitHeight: activeSize
//     implicitWidth: activeSize
//     radius: Appearance.general.windowRounding
//     color: Colors.primary
//
//     function updatePosition() {
//         var w = workspaces.itemAt(activeWsId - 1)
//         if (w) {
//             wsX = w.x + w.width/2 - activeSize/2
//             wsY = w.y + w.height/2 - activeSize/2
//         }
//     }
//
//     Behavior on wsX { NumberAnimation { duration: 200 } }
//     Behavior on wsY { NumberAnimation { duration: 200 } }
// }
