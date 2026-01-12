
import QtQuick
import qs.states

Rectangle {
    id: root

    radius: Config.windowRounding
    implicitHeight: Config.bar.height - Config.bar.padding

    color: Config.bar.colorWidgetBackground
    border {
        width: Config.bar.borderWidgetWidth
        color: Config.bar.colorPrimaryWidgets
    }

}
