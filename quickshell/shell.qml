import Quickshell
import QtQuick
import "./modules/bar/"


ShellRoot {
    id: root
    
    property bool enableBar: true


    Loader { active: enableBar; sourceComponent: Bar {} }

}
