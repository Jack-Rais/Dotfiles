
import Quickshell
import Quickshell.Io
import QtQuick

import qs.states
import qs.services
import qs.modules.notif
import qs.modules.bar
import qs.modules.background


ShellRoot {

    id: root

    MainBarItem {}
    Background {}
    // Notifications { id: notifications }
    // NotificationPopup {}
    //
    // IpcHandler {
    //     target: "notifications"
    //
    //     function toggle(): void {
    //         notifications.visible = !notifications.visible
    //     }
    // }

}
