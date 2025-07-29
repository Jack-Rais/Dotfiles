import QtQuick
import QtQuick.Controls

import "root:/options"
import "root:/assets"


Button {
    id: root

    property bool toggled
    property string buttonText
    property real buttonRadius: Appearance.bar.borderRadius

    property var downAction
    property var releaseAction
    property var altAction
    property var middleClickAction

    property color colorBackground: ColorsUtils.withAlpha(Colors.primary_container, 0.6)
    property color colorBackgroundHover: ColorsUtils.withAlpha(Colors.on_primary, 0.6)
    
    property color buttonColor: root.toggled ? colorBackgroundHover : colorBackground

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.RightButton

        onPressed: (event) => {

            if (event.button === Qt.RightButton) {
                if (root.altAction) root.altAction();
                return;
            }
            if (event.button === Qt.MiddleButton) {
                if (root.middleClickAction) root.middleClickAction();
                return;
            }
            root.toggled = true
            if (root.downAction) root.downAction();

        }

        onReleased: (event) => {
            root.toggled = false
            if (event.button != Qt.LeftButton) return;
            if (root.releaseAction) root.releaseAction();
            root.click()
        }

        onCanceled: (event) => {
            root.toggled = false
        }

    }

    background: Rectangle {
        id: buttonBackground

        radius: root.buttonRadius
        implicitHeight: 50
        color: root.buttonColor
    }

}
