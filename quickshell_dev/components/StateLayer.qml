
import QtQuick

import qs.config


MouseArea {
    id: root

    property bool disabled
    property bool showHoverBackground: true
    property color color: Appearance.general.defaultHoverColor
    property real radius: parent?.radius ?? 0

    function onClicked(): void {}

    anchors.fill: parent
    enabled: !disabled
    cursorShape: disabled ? undefined : Qt.PointingHandCursor
    hoverEnabled: true

    Rectangle {
        anchors.fill: parent
        radius: root.radius
        color: Qt.alpha(
            root.color, root.disabled ? 0 : root.pressed ? 0.12 : (root.showHoverBackground && root.containsMouse) ? 0.08 : 0
        )
    }

    onClicked: !disabled && onClicked()

}
