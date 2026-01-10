pragma Singleton

import QtQuick
import Quickshell
import qs.states

Singleton {

    property int windowRounding: 10

    property QtObject bar: QtObject {

        // General
        property int height: 35

        // Colors
        property color colorBackground: Colors.on_primary_fixed
        property color colorBackgroundWidget: Colors.surface_container_low
        property color colorClosedWorkspace: Colors.on_primary
        property color colorInactiveWorkspace: Colors.primary_container
        property color colorActiveWorkspace: Colors.primary

        // Borders
        property int borderWidth: 10                                // Better if its even
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
