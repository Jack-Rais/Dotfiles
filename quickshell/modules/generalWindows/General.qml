
import QtQuick
import QtQuick.Controls
import Quickshell

import qs.states
import qs.modules.common
import qs.modules.generalWindows.powerPopup


PanelWindow {

    id: root
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    margins {
        top: Config.wallpaper.borderWidth
        bottom: Config.wallpaper.borderWidth
        right: Config.wallpaper.borderWidth
        left: Config.wallpaper.borderWidth
    }
    mask: Region {}
    color: "transparent"



}
