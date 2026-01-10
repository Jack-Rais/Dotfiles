pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {

    id: root
    property var notificationList: []


    NotificationServer {

        id: notifServer
        // actionIconsSupported: true
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        bodySupported: true
        imageSupported: true
        keepOnReload: false
        persistenceSupported: true

        onNotification: (notification) => {
            // console.log("Notifica arrivata: " + notification.summary)

            root.notificationList.push(notification)
            root.newNotificationReceived(notification)

        }
    }

    signal newNotificationReceived(Notification body)

}
