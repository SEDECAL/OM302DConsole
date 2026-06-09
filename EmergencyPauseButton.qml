// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import QtQuick.LocalStorage 2.12
import QtGraphicalEffects 1.12

import "storage.js" as Storage
import "Constants.js" as Constants
import "DebugConstants.js" as DC

Rectangle {
    id: emergencyPauseButton

    property alias frameImage: frameImage

    property int buttonSize: 70

    property double startX
    property double startY
    property double startHeight
    property double startWidth
    property double maxOpacity: 0.8

    property string playImage: Storage.getAppDB(Constants.dbAppIcon.emergPlayPauseFrameOrangeId, "")
    property string pauseImage: Storage.getAppDB(Constants.dbAppIcon.emergPlayPauseFrameGreenId, "")

    function temporalDisable(miliseconds){
        emergencyPauseButton.enabled = false
        delayedEnable.duration = miliseconds
        delayedEnable.start()
    }

    PropertyAnimation{ id: delayedEnable; target: emergencyPauseButton; property: "enabled"; to: true; duration: 0 }

    states: [
        State { id: emergencyPauseButtonMaxView },
        State { id: emergencyPauseButtonMinView }
    ]
    transitions: [
        Transition {
            to: "emergencyPauseButtonMaxView"
            PropertyAnimation { target: emergencyPauseButton; property: "height"; to: startHeight; duration: 500}
            PropertyAnimation { target: emergencyPauseButton; property: "width"; to: startWidth; duration: 500}
            PropertyAnimation { target: emergencyPauseButton; property: "x"; to: startX; duration: 500}
            PropertyAnimation { target: emergencyPauseButton; property: "y"; to: startY; duration: 500}
            PropertyAnimation { target: frameImage; property: "opacity"; to: maxOpacity; duration: 500}
            PropertyAnimation { target: maximizeButtom; property: "opacity"; to: 0; duration: 500}
            PropertyAnimation { target: blackMask; property: "color"; to: "black"; duration: 500}
            PropertyAnimation { target: emergencyPauseButtonAnimation; property: "running"; to: emergencyPauseButton.visible; duration: 0}
        },
        Transition {
            to: "emergencyPauseButtonMinView"
            SequentialAnimation{
                ParallelAnimation{
                    PropertyAnimation { target: emergencyPauseButton; property: "height"; to: 50; duration: 500}
                    PropertyAnimation { target: emergencyPauseButton; property: "width"; to: 50; duration: 500}
                    PropertyAnimation { target: emergencyPauseButton; property: "x"; to: 0; duration: 500}
                    PropertyAnimation { target: emergencyPauseButton; property: "y"; to: startHeight - buttonSize; duration: 500}
                    PropertyAnimation { target: minimizeButtom; property: "opacity"; to: 0; duration: 500}
                    PropertyAnimation { target: frameImage; property: "opacity"; to: 0; duration: 500}
                    PropertyAnimation { target: emergencyPauseButtonAnimation; property: "running"; to: false; duration: 0}
                    PropertyAnimation { target: blackMask; property: "color"; to: "transparent "; duration: 500}
                }
                PropertyAnimation { target: maximizeButtom; property: "opacity"; to: 1; duration: 500}
                PropertyAnimation { target: emergencyPauseButton; property: "opacity"; to: 1; duration: 500}
            }
        }
    ]

    color: Storage.getAppDB(Constants.dbAppColor.emPauseButtonPanelId, "black")
    border.color: "transparent"

    Component.onCompleted: {
        startX = x
        startY =  y
        startHeight = emergencyPauseButton.height
        startWidth = emergencyPauseButton.width
    }

    Rectangle{
        id: blackMask
        color: Storage.getAppDB(Constants.dbAppColor.emPauseButtonBlackMaskId, "white")
        border.color: "transparent"
        opacity: 0
        width: parent.width * 0.975
        height: parent.height * 0.97
        x: (parent.width - width) * 0.5
        y: (parent.height - height) * 0.5
    }

    Image{
        id: frameImage

        property bool delayRefresh: false // GUI play/pause button update mixed with socket therapy state update to solve ticket #4085

        anchors.fill: parent
        source: Storage.getAppDB(Constants.dbAppIcon.emergPlayPauseFrameOrangeId, "")
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement

        states: [
            State { name: "playView"
                PropertyChanges { target: frameImage; source: playImage }
                PropertyChanges { target: frameImage; delayRefresh: true }
                StateChangeScript{ script: appToolBar.state = "playStop" }
            },
            State { name: "pauseView"
                PropertyChanges { target: frameImage; source: pauseImage }
                PropertyChanges { target: frameImage; delayRefresh: true }
                StateChangeScript{ script: appToolBar.state = "pauseStop" }
            }
        ]
        state: "playView"

        NumberAnimation on opacity {
            id: emergencyPauseButtonAnimation
            running: emergencyPauseButton.visible
            from: maxOpacity
            to: 0

            loops: Animation.Infinite
            duration: 4000
            easing.type: Easing.InOutQuint//Easing.InBack

        }
    }

    Button{
        id: emergencyPauseButtonButtom
        opacity: 0
        anchors.fill: parent
        onClicked: {
            //DEB->debug.log(DC.emergencyPauseButtomLog, "Emergency pause buttom pushed...")
            consoleSocket.sendData(Constants.ENT_SIM)
            frameImage.state = (frameImage.state === "playView") ? "pauseView" : "playView"
            emergencyPauseButton.temporalDisable(300)
        }
    }

    Rectangle{
        id: minimizeButtom
        width: buttonSize
        height: buttonSize
        color: Storage.getAppDB(Constants.dbAppColor.emPauseButtonButonId, "black")
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 40
        anchors.rightMargin:40
        opacity: frameImage.opacity
        Image{
            anchors.fill: parent
            source: (frameImage.state === "playView") ? Storage.getAppDB(Constants.dbAppIcon.minimizeFrameOrangeId, "") : Storage.getAppDB(Constants.dbAppIcon.minimizeFrameGreenId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: minimizeButtomButtom
            anchors.fill: parent
            opacity: 0
            onClicked: {
                //DEB->debug.log(DC.emergencyPauseButtomLog, "Minimize emergency pause buttom...")
                emergencyPauseButton.state = "emergencyPauseButtonMinView"
            }
        }
    }

    Rectangle{
        id: maximizeButtom
        width: buttonSize
        height: buttonSize
        color: Storage.getAppDB(Constants.dbAppColor.emPauseButtonButonId, "black")
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: 20
        anchors.leftMargin: 30
        opacity: 0
        Image{
            anchors.fill: parent
            source: (frameImage.state === "playView") ? (visible) ? Storage.getAppDB(Constants.dbAppIcon.maximizeFramePlayId, "") : "" : (visible) ? Storage.getAppDB(Constants.dbAppIcon.maximizeFramePauseId, "") : ""
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: maximizeButtomButtom
            anchors.fill: parent
            opacity: 0
            onClicked: {
                //DEB->debug.log(DC.emergencyPauseButtomLog, "Maximize emergency pause buttom...")
                emergencyPauseButton.state = "emergencyPauseButtonMaxView"
            }
        }
    }
}

