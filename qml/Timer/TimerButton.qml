import QtQuick 2.13
import QtQuick.Shapes 1.13
import Components 1.0

Item {
    id: _timerButtonContainer

    width: parent.width
    height: 40*dp

    Rectangle {
        id: _timerButton

        property double percent: model.percent // 0.0 .. 1.0
        property double fontSize: Consts.fontNormal
        property double arcThickness: 18*dp

        color: Consts.colorTimerButton[0]

        // Этап 1
        // MouseArea {
        //     anchors.fill: parent
        //     onClicked: {
        //         statesItem.toggle();
        //     }
        // }

        // Этап 2
        Timer {
            interval: 150
            running: true
            repeat: true
            onTriggered: {
                if (_timerButton.percent < 1.0) {
                    _timerButton.percent += 0.05;
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                _timerButton.percent = 0.0
            }
        }

        Text {
            id: textItem

            text: model.text
            font.pixelSize: _timerButton.fontSize
            color: "white"
            anchors.centerIn: parent
        }

        // Индикатор отсчитанного времени
        Shape {
            id: arcItem

            property double thickness: 0
            property double radius: width/2 - thickness/2

            z: -1
            visible: false
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: -thickness+1
            }
            layer {
                // antialiasing - MSAA
                enabled: true
                smooth: true
                samples: 8
            }

            ShapePath {
                startX: arcItem.width/2
                startY: arcItem.thickness/2
                fillColor: "transparent"
                strokeColor: Consts.colorTimerButton[1]
                // strokeWidth: arcItem.thickness/2
                strokeWidth: arcItem.thickness

                PathAngleArc {
                    centerX: arcItem.width/2
                    centerY: arcItem.height/2
                    // radiusX: arcItem.radius - arcItem.thickness/4
                    // radiusY: arcItem.radius - arcItem.thickness/4
                    radiusX: arcItem.radius
                    radiusY: arcItem.radius
                    startAngle: 0
                    sweepAngle: 360
                }
            }

            ShapePath {
                startX: arcItem.width/2
                startY: arcItem.thickness/2
                fillColor: Consts.colorTimerButton[2]
                strokeColor: Consts.colorTimerButton[2]
                strokeWidth: 0

                PathAngleArc {
                    id: pathAngleArc

                    centerX: arcItem.width/2
                    centerY: arcItem.height/2
                    radiusX: arcItem.radius+arcItem.thickness/2
                    radiusY: arcItem.radius+arcItem.thickness/2

                    // Вариант 1
                     startAngle: 90-180*_timerButton.percent
                     sweepAngle: 360*_timerButton.percent
                     Behavior on startAngle { NumberAnimation { duration: 150 } }
                     Behavior on sweepAngle { NumberAnimation { duration: 150 } }

                    // Вариант 2
                    // startAngle: -90
                    // sweepAngle: 360*_timerButton.percent
                    // Behavior on sweepAngle { NumberAnimation { duration: 150 } }

                    // Вариант 3
                    // startAngle: -90 + 360*_timerButton.percent
                    // sweepAngle: 360 - 360*_timerButton.percent
                    // Behavior on startAngle { NumberAnimation { duration: 150 } }
                    // Behavior on sweepAngle { NumberAnimation { duration: 150 } }
                }
            }
        }

        Item {
            id: statesItem

            // Этап1
            // state: "list"
            // Этап2
            state: "full"
            states: [
                State {
                    name: "list"
                    ParentChange {
                        target: _timerButton
                        parent: _timerButtonContainer
                        x: (parent.width - width)/2
                        y: 0
                    }
                    PropertyChanges {
                        target: _timerButton
                        width: Math.min(100*dp, parent.width - 2*Consts.margin)
                        height: _timerButtonContainer.height
                        radius: 5*dp
                        fontSize: Consts.fontNormal
                    }
                }
                , State {
                    name: "full"
                    ParentChange {
                        target: _timerButton
                        parent: fullTimerContainer
                        x: (parent.width - width)/2
                        y: (parent.height - height)/2
                    }
                    PropertyChanges {
                        target: fullTimerContainer
                        visible: true
                        opacity: 1.0
                    }
                    PropertyChanges {
                        target: _timerButton
                        width: Math.min(parent.width - 2*Consts.margin, parent.height - 2*Consts.margin)
                               - 2*arcItem.thickness
                        height: width
                        radius: width/2
                        fontSize: Consts.fontBig
                    }
                    PropertyChanges {
                        target: arcItem
                        visible: true
                        thickness: _timerButton.arcThickness
                    }
                }
            ] // states: [

            transitions: [
                Transition {
                    to: "full"
                    reversible: true

                    SequentialAnimation {
                        PropertyAction {
                            target: fullTimerContainer
                            property: "visible"
                        }
                        ParallelAnimation {
                            ParentAnimation {
                                via: topContainer
                                NumberAnimation {
                                    properties: "x, y"
                                    duration: 300
                                    easing.type: Easing.InOutQuad
                                }
                            }
                            NumberAnimation {
                                target: _timerButton
                                properties: "width, height, radius, fontSize"
                                duration: 300
                                easing.type: Easing.InOutQuad
                            }
                            NumberAnimation {
                                target: fullTimerContainer
                                properties: "opacity"
                                duration: 300
                                easing.type: Easing.InOutQuad
                            }
                        } // ParallelAnimation {
                        PropertyAction {
                            target: arcItem
                            property: "visible"
                        }
                        NumberAnimation {
                            target: arcItem
                            properties: "thickness"
                            duration: 50
                            easing.type: Easing.OutInQuad
                        }
                    } // SequentialAnimation {
                } // Transition {
            ] // transitions: [

            function toggle() {
                if (state == "list") {
                    state = "full";
                } else {
                    state = "list";
                }
            }
        } // Item { id: statesItem
    }
}
