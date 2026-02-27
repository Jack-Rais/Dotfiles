import Quickshell
import Quickshell.Wayland

PanelWindow {
    required property string name

    WlrLayershell.namespace: `jackshell-${name}`
    color: "transparent"
}
