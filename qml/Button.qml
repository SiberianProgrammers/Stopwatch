import QtQuick 2.12
import QtQuick.Window 2.12

Rectangle {
    id: _button
    
    property alias text: textItem.text
    signal clicked

    radius: Consts.buttonRadius
    width: textItem.width + 2*Consts.margin
    height: Consts.buttonHeight
    color: Consts.colorGray

    Text {
        id: textItem
        color: "white"
        font.pixelSize: Consts.fontNormal
        anchors.centerIn: parent
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: {
            _button.clicked();
        }
    }
}
