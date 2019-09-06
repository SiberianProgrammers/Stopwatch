import QtQuick 2.13

Rectangle {
    id: _button
    
    signal clicked

    height: width
    radius: width/2

    MouseArea {
        property bool contains: Math.sqrt(Math.pow(mouseX - 0.5*width, 2) + Math.pow(mouseY - 0.5*height, 2)) < 0.5*width

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: contains
                     ? Qt.PointingHandCursor
                     : Qt.ArrowCursor
        onClicked: {
            if (contains) {
                _button.clicked();
            } else {
                mouse.accepted = false;
            }
        }
    }
}
