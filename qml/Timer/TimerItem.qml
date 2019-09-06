import QtQuick 2.13
import Components 1.0

Item {
    id: _timerItem

    ListView {
        id: timersList

        model: timersModel
        delegate: TimerButton { }
        spacing: Consts.margin
        anchors {
            fill: parent
            topMargin: Consts.margin
        }
    }

    Rectangle {
        id: fullTimerContainer
        anchors.fill: parent
        visible: false
        opacity: 0.0

        MouseArea {
            anchors.fill: parent
            onClicked: {}
            onWheel: {}
        }
    }
    Item {
        id: topContainer
        z: 1000
    }

    ListModel {
        id: timersModel

        // Этап1
        ListElement { text: "15 min"; percent: 0.0 }
        ListElement { text: "20 min"; percent: 0.2 }
        ListElement { text: "30 min"; percent: 0.6 }
        ListElement { text: "40 min"; percent: 1.0 }

        // Этап2
        // ListElement { text: "15 min"; percent: 0.0 }
        // ListElement { text: "20 min"; percent: 0.2 }
        // ListElement { text: "30 min"; percent: 0.6 }
        // ListElement { text: "40 min"; percent: 1.0 }
    }
}
