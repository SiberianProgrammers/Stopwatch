import QtQuick 2.12
import QtQuick.Window 2.12

Rectangle {
    id: runButton
    
    color: Stopwatch.isActive
           ? "#aa3030" // "red"
           : "#317e04" // "green"
    width: 200
    height: 200
    radius: 0.5*width

    Text {
        text: Stopwatch.seconds
        color: "white"
        font {
            pixelSize: 40
        }
        
        anchors.centerIn: parent
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: {
            Stopwatch.toggle();
        }
    }
}
