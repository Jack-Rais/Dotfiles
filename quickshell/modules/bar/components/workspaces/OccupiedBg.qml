pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import qs.config


Item {

    id: root
    required property Repeater workspaces
    required property var occupied

    property list<var> pills: []

    component Pill: QtObject {
        property int start
        property int end
    }

    Component {
        id: pillComp

        Pill {}
    }

    onOccupiedChanged: {
        if (!occupied) return;

        let keys = Object.keys(occupied)
            .map(x => Number(x))
            .sort((a, b) => a - b);

        let count = 0;

        let currentStart = null;
        let currentEnd = null;

        for (let i = 0; i < keys.length; i++) {
            const ws = keys[i];

            if (currentStart === null) {
                currentStart = ws;
                currentEnd = ws;
            } else if (ws === currentEnd + 1) {
                currentEnd = ws;
            } else {
                if (pills[count]) {
                    pills[count].start = currentStart;
                    pills[count].end = currentEnd;
                } else {
                    pills.push(pillComp.createObject(root, {
                        start: currentStart,
                        end: currentEnd
                    }));
                }
                count++;
                currentStart = ws;
                currentEnd = ws;
            }
        }

        if (currentStart !== null) {
            if (pills[count]) {
                pills[count].start = currentStart;
                pills[count].end = currentEnd;
            } else {
                pills.push(pillComp.createObject(root, {
                    start: currentStart,
                    end: currentEnd
                }));
            }
            count++;
        }

        if (pills.length > count) {
            pills.splice(count).forEach(p => p.destroy());
        }

    }


    Repeater {
        model: ScriptModel {
            values: pills.filter(p => p)
        }

        Rectangle {

            required property var modelData

            readonly property int startItemX: root.workspaces.itemAt(modelData.start - 1).x + Appearance.bar.padding
            readonly property int endItemX: root.workspaces.itemAt(modelData.end - 1).x + root.workspaces.itemAt(modelData.end - 1).width + Appearance.bar.padding

            x: startItemX
            width: endItemX - startItemX

            anchors.verticalCenter: root.verticalCenter

            height: Appearance.bar.height - Appearance.bar.padding * 2 - Appearance.bar.workPadding * 2
            radius: Appearance.general.windowRounding
            color: Colors.surface_container_highest

        }
    }

}
