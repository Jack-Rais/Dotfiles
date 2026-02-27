pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.modules.bar.components

BaseWidget {
    id: root

    required property ShellScreen screen
    readonly property var occupied: Hyprland.workspaces.values.reduce((acc, curr) => {
        acc[curr.id] = curr.lastIpcObject.windows > 0;
        return acc;
    }, {})
    readonly property int activeWsId: Hyprland.monitorFor(screen).activeWorkspace?.id ?? 1
    childWidth: workspacesLayout.implicitWidth + Appearance.bar.padding * 2


    Rectangle {
        anchors.fill: parent
        radius: Appearance.bar.iconRadius
        color: Colors.surface_container
    }

    OccupiedBg {
        workspaces: workspaces
        occupied: root.occupied
        anchors.fill: parent
    }

    RowLayout {
        id: workspacesLayout

        anchors.centerIn: parent
        spacing: Appearance.bar.padding / 2

        Repeater {
            model: 8
            id: workspaces

            Workspace {
                occupied: root.occupied
            }

        }

    }

    ActiveIndicator {
        anchors.verticalCenter: parent.verticalCenter
        activeWsId: root.activeWsId
        workspaces: workspaces
        layoutParent: workspacesLayout
    }

}
