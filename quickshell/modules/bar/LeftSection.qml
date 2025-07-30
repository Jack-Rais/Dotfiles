import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.common
import qs.options
import qs.assets


Item {
    id: root
    property bool hovered: false
    implicitWidth: leftSectionRowLayout.implicitWidth
    implicitHeight: leftSectionRowLayout.implicitHeight

    required property color colorBackground
    required property color colorBackgroundHover
    required property color colorIcon
    required property color colorIconBorder

    RowLayout {
        id: leftSectionRowLayout
        anchors.fill: parent
        spacing: 10
        
        CustomButton {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.fillWidth: false
            Layout.fillHeight: true

            Layout.topMargin: Appearance.bar.hPadding
            Layout.bottomMargin: Appearance.bar.hPadding
            Layout.leftMargin: Appearance.bar.vPadding
            Layout.rightMargin: Appearance.bar.vPadding

            implicitWidth: distroIcon.width

            colBackground: colorBackground
            colBackgroundHover: colorBackgroundHover
            colBorder: colorIconBorder

            CustomIcon {
                id: distroIcon
                anchors.centerIn: parent
                
                height: Appearance.bar.sectionsHeight - Appearance.bar.vPadding * 2
                width: Appearance.bar.sectionsHeight - Appearance.bar.hPadding * 2 + Appearance.bar.hIconPadding * 2

                source: Config.bar.osIcon
                colorize: true
                color: colorIcon
            }
        }

        
    }
    
}
