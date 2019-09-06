import QtQuick 2.13
import QtQuick.Window 2.12
import Timer 1.0
import Stopwatch 1.0

Window {
    id: window

    visible: true
    title: qsTr("Секундомер")
    width: 300
    height: 300

    // StopwatchItem {
    //     anchors.fill: parent
    // }

    TimerItem {
        anchors.fill: parent
    }
}
