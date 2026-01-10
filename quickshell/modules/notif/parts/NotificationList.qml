import QtQuick
import qs.services

Item {
    implicitHeight: 100

    ListView {
        anchors.fill: parent
        model: NotificationsDaemon.NotificationService.trackedModel
        delegate: Rectangle {
            width: parent.width
            height: 60
            Column {
                Text { text: modelData.summary }
                Text { text: modelData.body }
            }
        }
    }
}
