import Quickshell
import QtQuick

import qs.modules.notif.parts
import qs.states


PanelWindow {

    anchors {
        top: true
        right: true
        bottom: true
    }

    implicitWidth: Config.notifications.width
    aboveWindows: true
    exclusiveZone: 0
    color: "transparent"

    Rectangle {
        id: rootNotificationCenter

        color: Colors.surface_container
        anchors.fill: parent
        anchors {
            bottomMargin: Config.notifications.margin
            topMargin: Config.notifications.margin
            rightMargin: Config.notifications.margin
        }
        border {
            color: Colors.on_primary_fixed
            width: Config.notifications.borderWidth
        }

        radius: Config.windowRounding

        HeaderNotifications {
            id: headerNotifications

            anchors {
                top: rootNotificationCenter.top
                left: rootNotificationCenter.left
                right: rootNotificationCenter.right
            }
        }

        NotificationList {
            id: notidicationList

            anchors {
                top: headerNotifications.bottom
                left: rootNotificationCenter.left
                right: rootNotificationCenter.right
            }
        }

    }

}
