
import QtQuick
import qs.states

Rectangle {
    id: root

    required property int childWidth
    property int marginX: Config.bar.marginX
    property bool mouseAreaActive: true

    signal clicked()

    radius: Config.windowRounding
    implicitHeight: Config.bar.height - Config.bar.padding
    implicitWidth: childWidth + marginX

    color: Config.bar.colorWidgetBackground
    border {
        width: Config.bar.borderWidgetWidth
        color: Config.bar.colorPrimaryWidgets
    }

    Loader {
        id: mouseAreaLoader
        active: mouseAreaActive
        sourceComponent: mouseAreaActive ? mouseAreaComponent : null
        anchors.fill: parent
    }

    Component {
        id: mouseAreaComponent

        MouseArea {

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onEntered: {
                root.color = Config.bar.colorWidgetBackgroundClicked
            }

            onExited: {
                root.color = Config.bar.colorWidgetBackground
            }

            onClicked: {
                root.clicked()
            }

        }
    }

}
