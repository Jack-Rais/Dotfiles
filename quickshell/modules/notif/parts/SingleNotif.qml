import Quickshell
import Quickshell.Services.Notifications
import QtQuick

import qs.states


PanelWindow {

    id: root
    property var notif

    property string summary: notif ? notif.summary : ""
    property string body: notif ? notif.body : ""

    anchors {
        top: true
        right: true
    }
    color: "transparent"

    onNotifChanged: {
        console.log(summary)
        // notifText.text = summary
    }
    implicitWidth: Config.notifications.popupWidth + Config.notifications.padding
    implicitHeight: Config.notifications.popupHeight + Config.notifications.padding

    Rectangle {
        color: Colors.on_primary
        radius: Config.windowRounding

        anchors {
            rightMargin: Config.notifications.padding
            topMargin: Config.notifications.padding
            top: parent.top
            right: parent.right
        }

        implicitWidth: Config.notifications.popupWidth
        implicitHeight: Config.notifications.popupHeight
    }
}
