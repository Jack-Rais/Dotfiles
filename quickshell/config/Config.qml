pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import qs.states

Singleton {

    property QtObject border: QtObject {
        property int thickness: 3
    }

}
