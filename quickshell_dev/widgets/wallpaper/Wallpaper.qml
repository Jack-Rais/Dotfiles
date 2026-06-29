
import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.config


PanelWindow {

    required property var modelData
    screen: modelData

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.namespace: "jack:wallpaper"
    exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Image {

        anchors.fill: parent
        asynchronous: true
        smooth: true
        mipmap: true
        fillMode: Image.PreserveAspectCrop

        source: Quickshell.shellDir + Config.wallpaperPath
    }

}
