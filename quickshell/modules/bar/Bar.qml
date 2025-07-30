
import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.options
import qs.services
import qs.assets


Scope {
    id: bar
    
    property bool showBackground: Appearance.bar.showBackground

    property color colBackground: ColorsUtils.withAlpha(Colors.primary, 0.6)
    property color colBorder: Colors.on_primary_fixed
    
    property color colIconsBackground: ColorsUtils.withAlpha(Colors.primary, 0.4)
    property color colIconsBackgroundHover: Colors.primary
    property color colIcons: Colors.primary_container
    property color colIconsBorder: Colors.on_primary_fixed

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
                exclusiveZone: Appearance.bar.barHeight - Config.general.hyprland_gaps_out
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
                        border.color: colBorder

                        color: colBackground

                    }
                    
                    LeftSection {
                        id: leftSection
                        anchors {
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                            leftMargin: Appearance.bar.leftMargin + Appearance.bar.borderWidth
                        }
                        height: Appearance.bar.sectionsHeight
                        width: (barRoot.width) / 2 -
                               Appearance.bar.leftMargin -
                               Appearance.bar.borderWidth


                        colorBackground: colIconsBackground
                        colorBackgroundHover: colIconsBackgroundHover
                        colorIcon: colIcons
                        colorIconBorder: colIconsBorder
                    }

                }
            }

        }
    }

}
