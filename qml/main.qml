import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: window

    visible: true
    title: qsTr("Секундомер")
    width: maximumWidth
    height: maximumHeight
    maximumWidth: column.width + 2*Consts.margin
    minimumWidth: maximumWidth
    maximumHeight: column.height + 3*Consts.margin
    minimumHeight: maximumHeight

    Column {
        id: column

        width: 250*dp
        spacing: 2*Consts.margin
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 2*Consts.margin
            leftMargin: Consts.margin
        }

        Text {
            id: timerText

            text: Stopwatch.text
            font.pixelSize: Consts.fontBig
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Item {
            width: parent.width
            height: toggleButton.height

            Button {
                id: toggleButton

                text: Stopwatch.isActive
                      ? qsTr("Stop")
                      : qsTr("Start")
                color: Stopwatch.isActive
                       ? Consts.colorRed
                       : Consts.colorGreen
                anchors {
                    left: clearButton.right
                    right: parent.right
                    leftMargin: Consts.margin
                }

                onClicked: {
                    Stopwatch.toggle();
                }
            }

            Button {
                id: clearButton

                text: "X"// qsTr("Clear")

                onClicked: {
                    Stopwatch.clear();
                    Stopwatch.stop();
                }
            }
        }
    } // Column { id: column

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
            // Сворачивает/показывает приложение
            doubleClickedTimer.start();
        }

        onDoubleClicked: {
            // Останавливает/запускает таймер
            doubleClickedTimer.stop();
            Stopwatch.toggle()
        }
    }
}
