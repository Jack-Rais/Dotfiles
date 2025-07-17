import QtQuick 
import Quickshell 
import "../colors/colors.qml" as Colors

PanelWindow {
    
    id: bar
    implicitHeight: 50
    color: Colors.color0
    
    anchors {
        top: true
        left: true
        right: true
    }
    
    Rectangle {
        
        id: widgetSinistro
        
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }

        width: 100
        height: parent.height * 0.8
        color: Qt.rgba(1, 1, 1, 0.8)   
        border.color: "#ff0000"     
        border.width: 2
        radius: 4

        Text {
            anchors.centerIn: parent
            text: "Widget"
            color: "black"
            font.bold: true
        }

    }
}

