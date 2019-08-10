import QtQuick 2.12

Item {
    id: _stopwatchItem

    ToggleButton {
        id: toggleButton
    }

    ClearButton {
        id: clearButton
        anchors {
            centerIn: toggleButton
            verticalCenterOffset: (0.5*toggleButton.width + 0.0*width)* Math.cos(Math.PI/4)
            horizontalCenterOffset: anchors.verticalCenterOffset
        }
    }

    Timer {
        id: doubleClickedTimer
        interval: 300
        onTriggered: {
            if (window.visibility === Window.Hidden) {
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
