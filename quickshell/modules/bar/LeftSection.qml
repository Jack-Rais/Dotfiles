import QtQuick
import QtQuick.Layouts
import Quickshell

import "root:/modules/common"
import "root:/options"
import "root:/assets"


Item {
    id: root
    property bool hovered: false
    implicitWidth: leftSectionRowLayout.implicitWidth
    implicitHeight: leftSectionRowLayout.implicitHeight

    RowLayout {
        id: leftSectionRowLayout
        anchors.fill: parent
        spacing: 10
        
        CustomButton {
            
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: Appearance.bar.borderRadius
            Layout.fillWidth: false
            property real buttonPadding: 5

            implicitWidth: distroIcon.width + buttonPadding * 2
            implicitHeight: distroIcon.height + buttonPadding * 2

            buttonRadius: Appearance.bar.borderRadius
            
            CustomIcon {
                id: distroIcon
                anchors.centerIn: parent
                width: 19.5
                height: 19.5
                source: Config.bar.osIcon
                colorize: true
                color: Colors.surface
            }
        }
    }
    
}
