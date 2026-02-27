
pragma Singleton

import Quickshell
import QtQuick

import qs.config


Singleton {

    property QtObject borders: QtObject {
        property color backgroundColor: Colors.surface
    }

}
