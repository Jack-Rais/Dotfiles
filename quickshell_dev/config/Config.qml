pragma Singleton

import QtQuick
import Quickshell

Singleton {


    property QtObject bar: QtObject {

        property list<string> entries: [
            "logo",
            "spacer",
            "power",
        ]

    }

}
