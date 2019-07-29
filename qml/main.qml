import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: window

    visible: true
    width: 640
    height: 480
    title: qsTr("Секундомер")

    RunButton {
        id: runButton
        anchors.centerIn: parent
    }

    Timer {
        id: doubleClickedTimer
        interval: 300
        onTriggered: {
            if (window.visibility == Window.Hidden) {
                window.show();
                window.requestActivate();
            } else {
                window.hide();
            }
        }
    }

    Connections {
        target: Tray

        onClicked: {
            doubleClickedTimer.start();
        }

        onDoubleClicked: {
            doubleClickedTimer.stop();

            Stopwatch.toggle()
        }
    }
}
