pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import qs.config
import qs.components
import qs.modules.bar

Variants {
    model: Quickshell.screens

    Scope {
        id: scope

        required property ShellScreen modelData

        Exclusions {
            screen: modelData
            bar: bar
        }

        StyledWindow {
            id: win

            screen: scope.modelData
            name: "painters"
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            WlrLayershell.layer: visibilities.power ? WlrLayer.Top : WlrLayer.Bottom
            aboveWindows: true

            mask: Region {
                x: Appearance.borders.thickness
                y: Appearance.bar.height
                width: win.width - Appearance.borders.thickness * 2
                height: win.height - Appearance.bar.height - Appearance.borders.thickness
                intersection: Intersection.Xor

                regions: regions.instances
            }

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            PersistentProperties {
                id: visibilities

                property bool power
            }

            Variants {
                id: regions
                model: panels.children

                Region {
                    required property Item modelData

                    x: modelData.x + Appearance.borders.thickness
                    y: modelData.y + Appearance.bar.height
                    width: modelData.width
                    height: modelData.height
                    intersection: Intersection.Subtract

                }
            }

            HyprlandFocusGrab {
                id: focusGrab

                active: visibilities.power
                windows: [win]
                onCleared: {
                    visibilities.power = false
                }
            }

            Border {
                bar: bar
                anchors.fill: parent
            }

            Panels {
                id: panels

                screen: scope.modelData
                visibilities: visibilities
                bar: bar
            }

            Bar {
                id: bar
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }

                screen: scope.modelData
                visibilities: visibilities
            }

        }

    }
}
