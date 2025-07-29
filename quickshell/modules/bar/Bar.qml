
import QtQuick
import QtQuick.Layouts
import Quickshell

import "root:/options/"
import "root:/services/"
import "root:/assets"

Scope {
    id: bar
    
    property bool showBackground: Appearance.bar.showBackground

    Variants {

        model: Quickshell.screens

        LazyLoader {
            id: barLoader
            active: !States.global.screenLocked
            required property ShellScreen modelData

            component: PanelWindow {
                id: barRoot
                screen: barLoader.modelData

                property var brightnessMonitor: Brightness.getMonitorForScreen(barLoader.modelData)

                exclusionMode: ExclusionMode.Ignore
                exclusiveZone: Appearance.bar.barHeight + Appearance.bar.topMargin + Appearance.bar.bottomMargin
                implicitHeight: Appearance.bar.barHeight
                mask: Region {
                    item: barContent
                }
                color: "transparent"
                
                anchors {
                    top: Appearance.bar.anchorTop
                    bottom: !Appearance.bar.anchorTop
                    left: true
                    right: true
                }

                Item {
                    
                    id: barContent
                    anchors {
                        right: parent.right
                        left: parent.left
                        top: parent.top
                    }

                    implicitHeight: Appearance.bar.barHeight
                    height: Appearance.bar.barHeight

                    Rectangle {

                        id: barBackground
                        visible: showBackground
                        anchors {
                            fill: parent
                            leftMargin: Appearance.bar.leftMargin
                            rightMargin: Appearance.bar.rightMargin
                            topMargin: Appearance.bar.topMargin
                            bottomMargin: Appearance.bar.bottomMargin
                        }

                        radius: Appearance.bar.borderRadius
                        border.width: Appearance.bar.borderWidth
                        border.color: Colors.on_primary_fixed

                        color: ColorsUtils.withAlpha(Colors.inverse_primary, 0.6)

                    }
                    
                    LeftSection {
                        id: leftSection
                        anchors.left: parent.left
                        implicitHeight: Appearance.bar.barHeight
                        height: Appearance.bar.barHeight
                        width: (barRoot.width) / 2
                    }

                }
            }

        }
    }

}
