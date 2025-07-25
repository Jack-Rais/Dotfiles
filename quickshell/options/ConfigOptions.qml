
import QtQuick
import Quickshell

pragma Singleton


Singleton {

    property QtObject barConfig
    property QtObject dirsConfig

    barConfig: QtObject {
        property string osIcon: "arch-logo.svg"
        
        property string batteryFullIcon: "full_battery.svg"
        property string batteryChargingIcon: "charging_battery.svg"
        property string batteryAlertIcon: "alert_battery.svg"
        property string batteryHighIcon: "almost_charged_battery.svg"
        property string batteryLowIcon: "almost_alert_battery.svg"

        property string cpuIcon: "cpu.svg"
        property string ramIcon: "ram.svg"
        property string powerIcon: "power.svg"
    }

    dirsConfig: QtObject {
        property string iconsDir: "root:/assets/icons/"
    }
}
