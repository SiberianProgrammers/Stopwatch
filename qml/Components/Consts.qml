pragma Singleton

import QtQuick 2.13

QtObject {
    readonly property real margin: 20*dp
    readonly property real fontBig: 40*dp
    readonly property real fontNormal: 15*dp

    readonly property real buttonRadius: 10*dp
    readonly property real buttonHeight: 60*dp

    readonly property color colorRed: "#aa3030"
    readonly property color colorGreen: "#317e04"
    readonly property color colorGray: "#888888"

    readonly property var colorTimerButton: ["#008DD2", "#EEEEEE", "#00A0E3"]
}
