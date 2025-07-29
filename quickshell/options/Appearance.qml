
import QtQuick
import Quickshell

pragma Singleton


Singleton {

    property QtObject bar
    property QtObject font


    bar: QtObject {
        property int barHeight: 50
        property int borderRadius: 10
        property int borderRadiusIcon: 7
        property int borderWidth: 2

        property real hPadding: 8
        property real vPadding: 7
        property real hIconPadding: 15
        property real vIconPadding: 2

        property real iconSpacing: 4
        property real barSpacing: 6

        property real topMargin: 4
        property real leftMargin: 4
        property real bottomMargin: 4
        property real rightMargin: 4

        property bool anchorTop: true
        property bool showBackground: true

    }


    font: QtObject {
        property string fontFamily: "JetBrainsMono Nerd Font"
        property string fontFamilyIcons: "JetBrainsMono Nerd Font"

        property int fontSize: 14
    }

}
