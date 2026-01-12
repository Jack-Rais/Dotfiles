import Quickshell
import Quickshell.Wayland
import QtQuick.Shapes
import QtQuick

import qs.states
import qs.modules.common


Variants {
    model: Quickshell.screens

    PanelWindow {
        id: root
        required property ShellScreen modelData
        screen: modelData

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Background
        color: "black"  // Fallback color while loading

        Image {
            id: wallpaper
            anchors.fill: parent
            asynchronous: true
            cache: false
            mipmap: true
            smooth: true

            sourceSize: Qt.size(width, height)

            fillMode: Image.PreserveAspectCrop
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter

            source: "./../../assets/" + Config.wallpaper.source

            onSourceChanged: {}

        }

        Item {
            id: roundedBorders
            anchors.fill: parent
            anchors.topMargin: Config.bar.height


            Rectangle {
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                implicitWidth: Config.wallpaper.borderWidth
                color: Config.wallpaper.colorBackground
            }

            Rectangle {
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                implicitWidth: Config.wallpaper.borderWidth
                color: Config.wallpaper.colorBackground
            }

            Rectangle {
                anchors {
                    right: parent.right
                    bottom: parent.bottom
                    left: parent.left
                }
                implicitHeight: Config.wallpaper.borderWidth
                color: Config.wallpaper.colorBackground
            }

            InvertedRounding {

                anchors {
                    top: parent.top
                    left: parent.left
                    margins: Config.wallpaper.borderWidth
                }
                roundingColor: Config.bar.colorBackground
                rounding: Config.windowRounding
                rotation: 270

            }

            InvertedRounding {

                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    margins: Config.wallpaper.borderWidth
                }
                roundingColor: Config.bar.colorBackground
                rounding: Config.windowRounding
                rotation: 180

            }

            InvertedRounding {

                anchors {
                    bottom: parent.bottom
                    right: parent.right
                    margins: Config.wallpaper.borderWidth
                }
                roundingColor: Config.bar.colorBackground
                rounding: Config.windowRounding
                rotation: 90

            }

            InvertedRounding {

                anchors {
                    top: parent.top
                    right: parent.right
                    margins: Config.wallpaper.borderWidth
                }
                roundingColor: Config.bar.colorBackground
                rounding: Config.windowRounding
                rotation: 0
                visible: GlobalStates.bar.topRightAngleVisible

            }
        }

    }

}
