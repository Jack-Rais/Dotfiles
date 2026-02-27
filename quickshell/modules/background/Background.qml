
import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.config
import qs.components

Variants {
    model: Quickshell.screens

    StyledWindow {

        required property ShellScreen modelData

        name: "wallpaper"
        screen: modelData
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Background
        color: "black"

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        Image {
            anchors.fill: parent
            asynchronous: true
            cache: false
            mipmap: true
            smooth: true

            sourceSize: Qt.size(width, height)

            fillMode: Image.PreserveAspectCrop
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter

            source: Quickshell.shellDir + Appearance.wallpaper.source
        }

    }

}
