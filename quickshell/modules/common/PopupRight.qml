
import Quickshell
import QtQuick
import QtQuick.Controls
import qs.states


Popup {

    id: root
    topMargin: Config.wallpaper.borderWidth
    rightMargin: Config.wallpaper.borderWidth

    required property int baseHeight
    required property int baseWidth
    required property Item childComp

    implicitHeight: baseHeight // + invertedRounding.height
    implicitWidth: baseWidth // + invertedRounding.width
    modal: true
    focus: true

}
