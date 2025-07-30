import QtQuick
import Quickshell

pragma Singleton


Singleton {

    property QtObject bar
    property QtObject dirs
    property QtObject general

    bar: QtObject {
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

    dirs: QtObject {
        property string iconsDir: "root:/assets/icons"
    }

    general: QtObject {
        property int hyprland_gaps_out: 4 // Hyprland screen gaps_out in "hypr/conf/window.conf"
    }
}
