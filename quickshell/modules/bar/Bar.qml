
import QtQuick
import QtQuick.Window
import QtQuick.Shapes
import Quickshell
import qs.modules.common
import qs.states


Scope {

    MainBarItem {}

    PanelWindow {
        id: corners

        visible: true
        color: "transparent" // colore di sfondo della finestra
        aboveWindows: false

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }


        Shape {
            id: borderShape
            anchors.fill: parent

            ShapePath {
                strokeWidth: Config.wallpaper.borderWidth
                strokeColor: Config.bar.colorBackground
                fillColor: "transparent"   // Cornice non riempita

                // Iniziamo dall'angolo in alto a sinistra + raggio
                startX: corners.width
                startY: 0

                // PathLine { x: corners.width; y: 0}
                PathLine { x: corners.width ; y: corners.height }
                PathLine { x: 0; y: corners.height }
                PathLine { x: 0; y: 0 }
            }
        }

        InvertedRounding {

            anchors {
                top: parent.top
                left: parent.left
                margins: Config.wallpaper.borderWidth / 2
            }
            roundingColor: Config.bar.colorBackground
            rounding: Config.windowRounding
            rotation: 270

        }

        InvertedRounding {

            anchors {
                bottom: parent.bottom
                left: parent.left
                margins: Config.wallpaper.borderWidth / 2
            }
            roundingColor: Config.bar.colorBackground
            rounding: Config.windowRounding
            rotation: 180

        }

        InvertedRounding {

            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: Config.wallpaper.borderWidth / 2
            }
            roundingColor: Config.bar.colorBackground
            rounding: Config.windowRounding
            rotation: 90

        }

        InvertedRounding {

            anchors {
                top: parent.top
                right: parent.right
                margins: Config.wallpaper.borderWidth / 2
            }
            roundingColor: Config.bar.colorBackground
            rounding: Config.windowRounding
            rotation: 0
            visible: GlobalStates.bar.topRightAngleVisible

        }
    }

}
