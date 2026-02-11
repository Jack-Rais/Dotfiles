pragma Singleton

import QtQuick
import Quickshell

Singleton {


    property QtObject bar: QtObject {

        property list<string> entries_left: [
            "logo",
            "spacer",
        ]

        property list<string> entries_center: [
            "spacer",
            "workspaces",
            "spacer"
        ]

        property list<string> entries_right: [
            "spacer",
            "power"
        ]

    }

}
