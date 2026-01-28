pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.config
import qs.modules.bar.components

Item {
    id: root

    required property PersistentProperties visibilities
    required property ShellScreen screen
    readonly property int exclusiveZone: Appearance.bar.height + Appearance.borders.padding
    height: Appearance.bar.height

    RowLayout {
        anchors.fill: parent
        anchors.centerIn: parent
        anchors.margins: 5
        spacing: 3

        Repeater {
            model: Config.bar.entries

            DelegateChooser {
                role: "id"

                DelegateChoice {
                    roleValue: "spacer"
                    delegate: Rectangle {
                        Layout.fillWidth: true
                    }
                }

                DelegateChoice {
                    roleValue: "logo"
                    delegate: OsIcon {}
                }

                DelegateChoice {
                    roleValue: "power"
                    delegate: Power {
                        visibilities: root.visibilities
                    }
                }
            }
        }
    }

}
