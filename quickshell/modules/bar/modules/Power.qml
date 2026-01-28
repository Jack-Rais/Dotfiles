import Quickshell
import QtQuick
import Qt5Compat.GraphicalEffects

import qs.modules.bar.parts
import qs.states

BaseWidget {

    id: root
    childWidth: logoPower.width
    marginX: Config.bar.marginX / 1.5

    Image {
        id: logoPower
        anchors.centerIn: parent
        source: Quickshell.shellDir + Config.bar.powerSvgPath

        sourceSize.width: Math.min(parent.width, parent.height) * 0.55
        sourceSize.height: Math.min(parent.width, parent.height) * 0.55
        fillMode: Image.PreserveAspectFit
        mipmap: true
        smooth: true
    }

    ColorOverlay {
        anchors.fill: logoPower
        source: logoPower
        color: Config.bar.colorPrimaryWidgets
    }

    onClicked: {
        GlobalStates.powerPopup.popupVisible = !GlobalStates.powerPopup.popupVisible
    }

}
