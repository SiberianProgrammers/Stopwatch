import QtQuick 2.12

RoundButton {
    id: clearButton
    
    width: 40*dp
    color: Consts.colorGray

    Rectangle {
        width: 2*dp
        height: 0.5*parent.height
        rotation: 45
        color: "white"
        anchors.centerIn: parent
    }

    Rectangle {
        width: 2*dp
        height: 0.5*parent.height
        rotation: -45
        color: "white"
        anchors.centerIn: parent
    }

    onClicked: {
        Stopwatch.clear();
        Stopwatch.stop();
    }
}
