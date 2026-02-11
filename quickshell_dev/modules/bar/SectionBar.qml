
import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.modules.bar.components
import qs.modules.bar.components.workspaces


RowLayout {
    id: root

    required property list<string> entries
    required property PersistentProperties visibilities
    required property ShellScreen screen

    Layout.preferredWidth: parent.width/3

    anchors.margins: 5
    spacing: 3

    Repeater {
        model: entries

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

            DelegateChoice {
                roleValue: "workspaces"
                delegate: Workspaces {
                    screen: root.screen
                }
            }

        }
    }
}
