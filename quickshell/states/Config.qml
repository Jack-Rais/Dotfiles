pragma Singleton

import QtQuick
import Quickshell
import qs.states

Singleton {

    property int windowRounding: 20
    property int fontSize: 13

    property QtObject wallpaper: QtObject {

        property string source: "background.png"

        property int borderWidth: 5
        property color colorBackground: Colors.surface

    }

    property QtObject bar: QtObject {

        // General
        property int height: 35
        property int padding: 5
        property int marginX: 30
        property int borderWidgetWidth: 2

        // Icons
        property string powerSvgPath: "/assets/power.svg"

        // Colors
        property color colorBackground: Colors.surface

        property color colorWidgetBackground: "transparent"
        property color colorWidgetBackgroundClicked: Qt.rgba(
            Config.bar.colorPrimaryWidgets.r,
            Config.bar.colorPrimaryWidgets.g,
            Config.bar.colorPrimaryWidgets.b,
            0.1
        )

        property color colorPrimaryWidgets: Colors.primary

        property color colorInactiveWorkspace: Colors.surface_container_highest
        property color colorActiveWorkspace: Colors.primary
        property color colorHoveredWorkspace: Colors.secondary_container

    }

    property QtObject powerPopup: QtObject {

        // General
        property int width: 300
        property int height: 200

    }

    property QtObject notifications: QtObject {

        // General
        property int width: 350
        property int margin: 5
        property int padding: 10

        property int borderWidth: 2

        // PopUp
        property real popupWidth: 400
        property real popupHeight: 100

        // Header
        property int headerHeight: 30

    }


}
