
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

import qs.components.containers
import qs.modules.bar
import qs.modules.painters

Variants {
    model: Quickshell.screens

    Scope {
        id: scope

        required property ShellScreen modelData

        BordersExclusion {
            screen: scope.modelData
            bar: barWrapper
        }

        StyledWindow {
            id: win

            readonly property bool hasFullscreen: Hyprland.monitorFor(screen)?.activeWorkspace?.toplevels.values.some(t => t.lastIpcObject.fullscreen === 2) ?? false

            onHasFullscreenChanged: {
                visibilities.power = false
            }

            screen: scope.modelData
            name: "drawers"
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: win.popupVisible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            mask: Region { item: barWrapper }

            HyprlandFocusGrab {
                id: focusGrab
                active: visibilities.power
                windows: [win]

                onCleared: {
                    visibilities.power = false
                }
            }

            PersistentProperties {
                id: visibilities

                property bool power

            }

            Border {
                bar: barWrapper
            }

            Bar {}

        }


        // StyledWindow {
        //     id: win
        //
        //     screen: scope.modelData
        //     name: "painters"
        //     WlrLayershell.exclusionMode: ExclusionMode.Ignore
        //     WlrLayershell.keyboardFocus: WlrKeyboardFocus.None // To change
        //
        //     readonly property bool hasFullscreen: Hyprland.monitorFor(screen)?.activeWorkspace?.toplevels.values.some(t => t.lastIpcObject.fullscreen === 2) ?? false
        //
        //     anchors {
        //         top: true
        //         left: true
        //         right: true
        //         bottom: true
        //     }
        //
        //     HyprlandFocusGrab {
        //         id: focusGrab
        //     }
        //
        //     Rectangle {
        //         id: bar
        //         anchors {
        //             top: parent.top
        //             left: parent.left
        //             right: parent.right
        //         }
        //         height: 30
        //         property int exclusiveZone: 30
        //         color: "black"
        //     }
        //
        //
        // }

    }

}
