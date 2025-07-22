
import QtQuick
import QtQuick.Layouts
import Quickshell
import Qt5Compat.GraphicalEffects

import "root:/options/"


Scope {

    id: bar
    readonly property int barHeight: AppearanceOptions.barConfig.barHeight

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barRoot
            implicitHeight: barHeight
            exclusiveZone: barHeight

            property ShellScreen modelData
            screen: modelData

            mask: Region {
                item: barContent
            }

            color: "transparent"

            anchors {
                top: AppearanceOptions.barConfig.anchorTop? true : false
                bottom: AppearanceOptions.barConfig.anchorTop? false: true
                left: true
                right: true
            }


            Item {
                id: barContent
                height: barHeight

                anchors {
                    right: parent.right
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom

                    topMargin: AppearanceOptions.barConfig.topMargin
                    leftMargin: AppearanceOptions.barConfig.leftMargin
                    bottomMargin: AppearanceOptions.barConfig.bottomMargin
                    rightMargin: AppearanceOptions.barConfig.rightMargin
                }

                Rectangle {
                    id: barColor
                    color: AppearanceOptions.barConfig.showBackground
                        ? AppearanceOptions.barConfig.barColor : "transparent"
                    radius: AppearanceOptions.barConfig.borderRadius

                    anchors.fill: parent
                    anchors.centerIn: parent

                    border.width: AppearanceOptions.barConfig.borderWidth
                    border.color: AppearanceOptions.barConfig.borderColor
                }

                RowLayout {
                    id: barLayout

                    anchors {
                        fill: parent
                        centerIn: parent

                        // topMargin: AppearanceOptions.barConfig.topMargin
                        // leftMargin: AppearanceOptions.barConfig.leftMargin
                        // bottomMargin: AppearanceOptions.barConfig.bottomMargin
                        // rightMargin: AppearanceOptions.barConfig.rightMargin
                    }


                    RowLayout {
                        id: leftSection

                        Layout.fillHeight: true

                        Layout.topMargin: AppearanceOptions.barConfig.hPadding
                        Layout.bottomMargin: AppearanceOptions.barConfig.hPadding
                        Layout.leftMargin: AppearanceOptions.barConfig.vPadding

                        spacing: AppearanceOptions.barConfig.hPadding
                        
                        
                        IconItem {
                            id: osLogoContainer
                            Layout.fillHeight: true

                            iconName: ConfigOptions.barConfig.osIcon
                        }

                        Rectangle {
                            id: filler
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "transparent"
                        }

                    }

                    RowLayout {
                        id: middleSection
                        Layout.alignment: Qt.AlignVCenter

                        Rectangle {
                            id: fillerCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "transparent"
                        }
                    }

                    RowLayout {
                        id: rightSection

                        Layout.fillHeight: true

                        Layout.topMargin: AppearanceOptions.barConfig.hPadding
                        Layout.bottomMargin: AppearanceOptions.barConfig.hPadding
                        Layout.rightMargin: AppearanceOptions.barConfig.vPadding

                        spacing: AppearanceOptions.barConfig.hPadding
                        layoutDirection: Qt.RightToLeft
                        
                        IconItem {
                            id: powerLogoContainer
                            Layout.fillHeight: true

                            iconName: ConfigOptions.barConfig.powerIcon
                        }

                        Rectangle {
                            id: fillerRight
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "transparent"
                        }

                    }


                }

            }

        }

    }

}
