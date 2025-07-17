
import Quickshell
import QtQuick
import Quickshell.Hyprland

PanelWindow {

  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30

  Text {
    anchors.centerIn: parent
    text: "Il mio primo widget"
  }
}
