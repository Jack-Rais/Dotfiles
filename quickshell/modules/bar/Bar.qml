
import QtQuick
import QtQuick.Layouts
import Quickshell

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


            Rectangle {
                id: barContent
                height: barHeight
                radius: AppearanceOptions.barConfig.borderRadius

                color: AppearanceOptions.barConfig.showBackground
                    ? AppearanceOptions.barConfig.barColor : "transparent"

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

                Item {
                    id: LeftSection
                    implicitHeight: barHeight - AppearanceOptions.barHeight.barPadding
                    width: (barRoot.width - MiddleSection.width) / 2

                    RowLayout {
                        id: archLogoRowLayout
                        anchors {
                            verticalCenter: parent.verticalCenter
                            fill: parent
                        }
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        Layout.leftMargin: AppearanceOptions.barConfig.barSpacing / 2
                        Layout.fillWidth: false
                        Layout.fillHeight: true

                        Rectangle {
                            radius: AppearanceOptions.barConfig.borderRadius
                            
                        }

                    }
                }
                
            }

        }

    }

}
