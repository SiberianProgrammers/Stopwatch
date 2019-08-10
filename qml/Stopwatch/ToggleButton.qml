import QtQuick 2.12
import "../Components"
import ".."

RoundButton {
    id: _toggleButton
    
    color: Stopwatch.isActive
           ? Consts.colorRed
           : Consts.colorGreen
    width: Math.max(200*dp, stopwatchText.width + 2*Consts.margin)
    anchors.centerIn: parent

    Text {
        id: stopwatchText

        text: Stopwatch.text
        color: "white"
        font.pixelSize: Consts.fontBig
        anchors.centerIn: parent
    }

    Text {
        text: Stopwatch.isActive
              ? qsTr("press to stop")
              : qsTr("press to start")
        color: "#c0c0c0"
        font.pixelSize: Consts.fontNormal
        anchors {
            top: stopwatchText.bottom
            horizontalCenter: stopwatchText.horizontalCenter
        }
    }

    onClicked: {
        Stopwatch.toggle();
    }
}
