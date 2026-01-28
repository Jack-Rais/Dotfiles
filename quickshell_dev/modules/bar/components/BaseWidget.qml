
import QtQuick
import Quickshell

import qs.config

Item {

    required property int childWidth

    implicitHeight: Appearance.bar.height - Appearance.bar.padding * 2
    implicitWidth: childWidth

}
