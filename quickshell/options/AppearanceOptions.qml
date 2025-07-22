
import QtQuick
import Quickshell

pragma Singleton


Singleton {

    property QtObject barConfig
    property QtObject fontConfig


    barConfig: QtObject {
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

        property real topMargin: 4.5
        property real leftMargin: 2.5
        property real bottomMargin: 1.5
        property real rightMargin: 2.5

        property bool anchorTop: true
        property bool showBackground: true

        property color barColor: Qt.rgba(23/255, 23/255, 255/255, 0.5)
        property color borderColor: "black" 
        property color iconsBackgroundColor: Qt.rgba(244/255, 255/255, 255/255, 0.5)
        property color iconsColor: Qt.rgba(0, 0, 0, 1)
        
        property color colorSystemStatistic: Qt.rgba(1, 1, 1, 1)
        property color colorSystemStatisticBackground: Qt.rgba(1, 1, 1, 1)

    }


    fontConfig: QtObject {
        property string fontFamily: "JetBrainsMono Nerd Font"
        property string fontFamilyIcons: "JetBrainsMono Nerd Font"

        property int fontSize: 14
    }

}
