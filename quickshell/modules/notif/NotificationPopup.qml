import QtQuick
import Quickshell
import qs.services
import qs.modules.notif.parts


Scope {

    // Loader per caricare e distruggere la notifica
    Loader {
        id: notificationLoader
        anchors.centerIn: parent
        active: false

        sourceComponent: SingleNotif {}
    }

    Component.onCompleted: {
        NotificationsDaemon.newNotificationReceived.connect(function(notification) {
            notificationLoader.active = true
            notificationLoader.item.notif = notification
            hideNotificationTimer.start()
        })
    }

    Timer {
        id: hideNotificationTimer
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            console.log("Prova, finito timer")
            notificationLoader.active = false
        }
    }
}
