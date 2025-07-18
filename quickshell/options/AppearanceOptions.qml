
import QtQuick
import Quickshell

pragma Singleton


Singleton {

    property QtObject barConfig


    barConfig: QtObject {
        property int barHeight: 40
        property int borderRadius: 10

        property real topMargin: 2.5
        property real leftMargin: 2.5
        property real bottomMargin: 0
        property real rightMargin: 2.5


        property bool anchorTop: true
        property bool showBackground: true
    }

}
