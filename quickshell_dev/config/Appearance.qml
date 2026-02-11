pragma Singleton

import Quickshell
import QtQuick

Singleton {

    property QtObject general: QtObject {
        property int windowRounding: 20
        property color defaultHoverColor: Colors.on_surface
    }

    property QtObject font: QtObject {
        property int iconSize: 13
    }

    property QtObject wallpaper: QtObject {
        property string source: "/assets/wallpaper.png"
    }

    property QtObject bar: QtObject {
        property int height: 34
        property int spacing: 3
        property int padding: 4

        // [Workspaces]
        property int workActivePadding: 4
        property int workPadding: 2

        property int iconRadius: 12
        property string logoPath: "/assets/logo.svg"

        property color powerIconColor: Colors.error
        property color logoIconColor: Colors.tertiary
    }

    property QtObject borders: QtObject {
        property int padding: 5
        property int thickness: 5
    }

}
