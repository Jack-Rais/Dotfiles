import QtQuick
import Quickshell

pragma Singleton


Singleton {

    property QtObject global

    global: QtObject {
        property bool screenLocked: false
    }

}
