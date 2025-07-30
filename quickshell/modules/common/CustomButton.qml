import QtQuick
import QtQuick.Controls

import qs.options
import qs.assets


Button {
    id: root

    property bool toggled
    property string buttonText
    property real buttonRadius: Appearance.bar.borderRadius

    property var downAction
    property var releaseAction
    property var altAction
    property var middleClickAction

    required property color colBackground
    required property color colBackgroundHover
    required property color colBorder
    
    property color buttonColor: root.toggled ? colBackgroundHover : colBackground

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

        border.color: colBorder
        border.width: Appearance.bar.borderRadiusIcon
    }

}
