import QtQuick
import Quickshell
import qs.services
import qs.modules.notif.parts

Scope {

    // Lista di notifiche
    ListView {
        id: notificationsListView
        width: parent.width
        height: parent.height

        model: ListModel {}  // Modello per contenere le notifiche

        delegate: Item {
            width: parent.width
            height: 60  // Puoi personalizzare l'altezza della notifica

            Rectangle {
                width: parent.width
                height: 50
                color: "black"
                border.color: "white"
                border.width: 2
                radius: 5

                Text {
                    anchors.centerIn: parent
                    text: modelData.summary
                    color: "white"
                }

                Timer {
                    id: hideNotificationTimer
                    interval: 5000  // Il timer per nascondere la notifica
                    running: true
                    repeat: false
                    onTriggered: {
                        model.remove(index)
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        // Quando arriva una nuova notifica
        NotificationsDaemon.newNotificationReceived.connect(function(notification) {
            // Aggiungi la notifica al modello della lista
            notificationsListView.model.append({
                summary: notification.summary,
                body: notification.body
            });
        })
    }
}
