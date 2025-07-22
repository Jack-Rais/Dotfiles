import QtQuick
import QtQuick.Layouts
import Quickshell
import Qt5Compat.GraphicalEffects

import "root:/options/"

Rectangle {
    id: root

    property string iconName

    Layout.preferredWidth: iconLogo.paintedWidth + AppearanceOptions.barConfig.hIconPadding * 2
    Layout.fillHeight: true

    color: AppearanceOptions.barConfig.iconsBackgroundColor
    radius: AppearanceOptions.barConfig.borderRadiusIcon

    Rectangle {
        id: iconLogoConfig

        anchors {
            fill: parent
            centerIn: parent
            leftMargin: AppearanceOptions.barConfig.hIconPadding
            rightMargin: AppearanceOptions.barConfig.hIconPadding
        }

        color: "transparent"

        Image {
            id: iconLogo
            anchors.centerIn: parent

            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter

            source: ConfigOptions.dirsConfig.iconsDir + iconName
            fillMode: Image.PreserveAspectFit
            smooth: true
            antialiasing: true
            visible: false
        }

        ColorOverlay {
            id: iconLogoCover
            anchors {
                fill: iconLogo
                centerIn: parent
            }
            source: iconLogo
            color: AppearanceOptions.barConfig.iconsColor
        }

    }

}
