pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes
import Quickshell

import qs.config
import qs.modules.bar.components

BaseWidget {
    id: root
    childWidth: circle.width

    required property real percentage
    property var iconMap: Config.bar.sysBatteryIcons
    property int strokeWidth: Appearance.bar.sysStrokeWidth

    Item {
        id: circle
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }

        width: height
        height: parent.height

        Item {

            anchors {
                fill: parent
                margins: Appearance.bar.sysMargins
            }

            Shape {
                id: shape
                anchors.fill: parent
                preferredRendererType: Shape.CurveRenderer

                ShapePath {
                    strokeColor: Colors.primary
                    strokeWidth: root.strokeWidth
                    capStyle: ShapePath.RoundCap
                    fillColor: "transparent"

                    PathAngleArc {
                        centerX: circle.width / 2 - Appearance.bar.sysMargins
                        centerY: circle.height / 2 - Appearance.bar.sysMargins
                        radiusX: circle.width / 2 - root.strokeWidth / 2 - Appearance.bar.sysMargins
                        radiusY: circle.height / 2 - root.strokeWidth / 2 - Appearance.bar.sysMargins
                        startAngle: -90
                        sweepAngle: (percentage / 100) * 360
                    }
                }
            }

        }

    }

}
