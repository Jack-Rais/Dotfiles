
import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.config
import qs.modules.bar.components.sys_status

BaseWidget {

    childWidth: systemLayout.implicitWidth + Appearance.bar.padding * 2

    // Rectangle {
    //     anchors.fill: systemLayout
    //     radius: Appearance.general.windowRounding
    //     color: Colors.surface_container
    // }

    RowLayout {
        id: systemLayout
        spacing: 2

        Battery {}

    }

}
