// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants

Rectangle {
    id: syringeAnimation

    property alias syringeGif: syringeGif
    property int syringeAnimationY: syringeAnimation.y
    property int syringeAnimationHeight: syringeAnimation.height

    Component.onCompleted: {
      syringeAnimationHeight = syringeAnimation.height
      syringeAnimationY = syringeAnimation.y
    }

    states:[
        State{
            name: "viewSyringeAnimation"
        },
        State{
            name: "noViewSyringeAnimation"
        },
        State{
            name: "viewSyringeAnimationEnd"
            PropertyChanges {target: syringeGif; paused: true }
            PropertyChanges {target: syringeGif; currentFrame: frameCount - 1 }
        }
    ]
    transitions:[
        Transition {
            to: "viewSyringeAnimation"
            PropertyAnimation { target: syringeAnimation; property: "opacity"; to: 1}
            PropertyAnimation { target: syringeGif; property: "visible"; to: true}
            SequentialAnimation{
                ParallelAnimation{
                    PropertyAnimation { target: syringeAnimation; property: "height"; to: syringeAnimationHeight; duration: 150}
                    PropertyAnimation { target: syringeAnimation; property: "y"; to: syringeAnimationY; duration: 150}
                }
            }
        },
        Transition {
            to: "noViewSyringeAnimation"
            SequentialAnimation{
                ParallelAnimation{
                    PropertyAnimation { target: syringeAnimation; property: "height"; to: 0; duration: 200}
                    PropertyAnimation { target: syringeAnimation; property: "y"; to: syringeAnimationY + syringeAnimationHeight; duration: 200}
                }

                PropertyAnimation { target: syringeGif; property: "visible"; to: false}
            }
        }
    ]

    color: "transparent"
    radius: 3
    state: "noViewSyringeAnimation"
    opacity: 0
    visible:false

    AnimatedImage {
        id: syringeGif
        height: parent.height * 0.8
        width: height
        visible: false
        anchors.centerIn: parent
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.syringeFillGifId, "") : "" // 12/2021

        onVisibleChanged: {
            // to ensure that animation starts always from the begining
            syringeGif.currentFrame = frameCount
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "green"
            visible: false
        }
    }
}
