// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: gunAnimation

    property alias gunGif: gunGif
    property int gunAnimationY: gunAnimation.y
    property int gunAnimationHeight: gunAnimation.height

    Component.onCompleted: {
      gunAnimationHeight = gunAnimation.height
      gunAnimationY = gunAnimation.y
    }

    states:[
        State{
            id: viewGunAnimation
        },
        State{
            id: noViewGunAnimation
        }
    ]
    transitions:[
        Transition {
            to: "viewGunAnimation"
            PropertyAnimation { target: gunAnimation; property: "opacity"; to: 1}
            SequentialAnimation{
                ParallelAnimation{
                    PropertyAnimation { target: gunAnimation; property: "height"; to: gunAnimationHeight; duration: 150}
                    PropertyAnimation { target: gunAnimation; property: "y"; to: gunAnimationY; duration: 150}
                }
//                ParallelAnimation{
//                    PropertyAnimation { target: cumulatedLabel; property: "opacity"; to: 1; duration: 200}
//                    PropertyAnimation { target: unitsLabel; property: "opacity"; to: 1; duration: 200}
//                    PropertyAnimation { target: progressTool; property: "opacity"; to: 1; duration: 200}
//                }
            }
        },
        Transition {
            to: "noViewGunAnimation"
            ParallelAnimation{

                PropertyAnimation { target: gunAnimation; property: "height"; to: 0; duration: 200}
                PropertyAnimation { target: gunAnimation; property: "y"; to: gunAnimationY + gunAnimationHeight; duration: 200}

//                PropertyAnimation { target: cumulatedLabel; property: "opacity"; to: 0; duration: 150}
//                PropertyAnimation { target: progressTool; property: "opacity"; to: 0; duration: 75}
//                PropertyAnimation { target: unitsLabel; property: "opacity"; to: 0; duration: 150}
            }
        }
    ]

    color: "#333333"
    radius: 3
    state: "noViewGunAnimation"
    opacity: 0
    visible:false

    AnimatedImage {
//      anchors.fill: parent
        id: gunGif
//      height: parent.height * 0.8
        height: parent.height * 0.4
        width: height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "/Images/GUN _0_000.gif"
        paused: false
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "green"
            visible: false
        }
    }

}

