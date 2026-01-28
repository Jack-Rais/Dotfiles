
import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.states
import qs.modules.bar.parts


BaseWidget {

    childWidth: workspacesLayout.width
    mouseAreaActive: false

    RowLayout {
        id: workspacesLayout
        anchors.centerIn: parent
        spacing: 3

        Repeater {
            model: 9

            delegate: Loader {
                required property int index
                property var occupied: Hyprland.workspaces.values.find(ws => ws.id === index + 1) ?? null
                property bool active: Hyprland.focusedWorkspace?.id === (index + 1)

                sourceComponent: WorkspacePainter {
                    isOccupied: occupied
                    isActive: active
                    workspaceNumber: index
                }

            }

        }

    }

}
