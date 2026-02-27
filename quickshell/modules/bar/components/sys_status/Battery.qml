pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Services.UPower

import qs.config
import qs.modules.bar.components

BaseWidget {
    id: root
    childWidth: circle.width + percent.width + Appearance.bar.padding * 2

    property real percentage: UPower.displayDevice.percentage * 100
    property bool charging: UPower.displayDevice.changeRate < 0
    property var iconMap: Config.bar.sysBatteryIcons
    property int strokeWidth: Appearance.bar.sysStrokeWidth

    Rectangle {
        anchors.fill: parent
        radius: Appearance.general.windowRounding
        color: Colors.surface_container
    }

    Row {
        anchors.centerIn: parent
        anchors.fill: parent
        spacing: 1

        Item {
            id: circle

            width: root.height - Appearance.bar.padding
            height: root.height - Appearance.bar.padding
            anchors.verticalCenter: parent.verticalCenter

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

        Text {
            id: percent

            text: `${Math.round(root.percentage)}%`
            anchors.verticalCenter: parent.verticalCenter

            font.pointSize: 10
            color: Appearance.bar.logoIconColor
        }

    }

}
