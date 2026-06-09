// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies
import "DebugConstants.js" as DC

Rectangle{
    id: toolBarRectangle

    property alias helpButton: helpButton
    property alias timeLabel: timeLabel
    property alias dateLabel: dateLabel
    property alias playButton: playButton
    property alias stopButton: stopButton
    property alias pauseButton: pauseButton

    property int transitionTime: 40
    property double opacityLevel: 0.2
    property int barDisabledTime: 400

    signal settingsClicked()
    signal pauseClicked()
    signal playClicked()
    signal playPressed()
    signal playReleased()
    signal stopClicked()
    signal helpClicked()
    signal pressureTestClicked()

    function temporalDisable(miliseconds){
        toolBarRectangle.enabled = false
        delayedEnable.duration = miliseconds
        delayedEnable.start()
    }

    color: Storage.getAppDB(Constants.dbAppColor.toolBarRectangleId, "black")
    height: parent.height
    width: parent.width
    state: "void"

    Component.onCompleted: {
        toolBarRectangle.playClicked.connect(Therapies.play)
        toolBarRectangle.playPressed.connect(Therapies.playPressed)
        toolBarRectangle.playReleased.connect(Therapies.playReleased)
        toolBarRectangle.helpClicked.connect(Therapies.help)
        toolBarRectangle.stopClicked.connect(Therapies.stop)
        toolBarRectangle.pauseClicked.connect(Therapies.pause)
        toolBarRectangle.settingsClicked.connect(Therapies.settings)
        toolBarRectangle.pressureTestClicked.connect(Therapies.launchPressureTester)
    }

    states: [
        State {
            name: "settingsHelp"
            PropertyChanges { target: pauseActuator; enabled: false }
            PropertyChanges { target: playActuator; enabled: false }
            PropertyChanges { target: stopActuator; enabled: false }
            PropertyChanges { target: settingsActuator; enabled: true }
            PropertyChanges { target: helpActuator; enabled: true }
        },
        State {
            name: "settingsPlayHelp"
            PropertyChanges { target: pauseActuator; enabled: false }
            PropertyChanges { target: playActuator; enabled: true }
            PropertyChanges { target: stopActuator; enabled: false }
            PropertyChanges { target: settingsActuator; enabled: true }
            PropertyChanges { target: helpActuator; enabled: true }
        },
        State {
            name: "void"
            PropertyChanges { target: pauseActuator; enabled: false }
            PropertyChanges { target: playActuator; enabled: false }
            PropertyChanges { target: stopActuator; enabled: false }
            PropertyChanges { target: settingsActuator; enabled: false }
            PropertyChanges { target: helpActuator; enabled: false }
        },
        State {
            name: "full"
            PropertyChanges { target: pauseActuator; enabled: true }
            PropertyChanges { target: playActuator; enabled: true }
            PropertyChanges { target: stopActuator; enabled: true }
            PropertyChanges { target: settingsActuator; enabled: true }
            PropertyChanges { target: helpActuator; enabled: true }
        },
        State {
            name: "justHelp"
            PropertyChanges { target: pauseActuator; enabled: false }
            PropertyChanges { target: playActuator; enabled: false }
            PropertyChanges { target: stopActuator; enabled: false }
            PropertyChanges { target: settingsActuator; enabled: false }
            PropertyChanges { target: helpActuator; enabled: true }
        },
        State {
            name: "pauseStop"
            PropertyChanges { target: pauseActuator; enabled: true }
            PropertyChanges { target: playActuator; enabled: false }
            PropertyChanges { target: stopActuator; enabled: true }
            PropertyChanges { target: settingsActuator; enabled: false }
            PropertyChanges { target: helpActuator; enabled: false }
        },
        State {
            name: "playStop"
            PropertyChanges { target: pauseActuator; enabled: false }
            PropertyChanges { target: playActuator; enabled: true }
            PropertyChanges { target: stopActuator; enabled: true }
            PropertyChanges { target: settingsActuator; enabled: false }
            PropertyChanges { target: helpActuator; enabled: false }
        },
        State {
            name: "justStop"
            PropertyChanges { target: pauseActuator; enabled: false }
            PropertyChanges { target: playActuator; enabled: false }
            PropertyChanges { target: stopActuator; enabled: true }
            PropertyChanges { target: settingsActuator; enabled: false }
            PropertyChanges { target: helpActuator; enabled: false }
        },
        State {
            name: "justPlay"
            PropertyChanges { target: pauseActuator; enabled: false }
            PropertyChanges { target: playActuator; enabled: true }
            PropertyChanges { target: stopActuator; enabled: false }
            PropertyChanges { target: settingsActuator; enabled: false }
            PropertyChanges { target: helpActuator; enabled: false }
        }
    ]
    transitions: [
        Transition {
            to: "settingsHelp"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: helpButton; property: "opacity"; to: 1; duration: transitionTime}
        },
        Transition {
            to: "settingsPlayHelp"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: helpButton; property: "opacity"; to: 1; duration: transitionTime}
        },
        Transition {
            to: "void"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: helpButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
        },
        Transition {
            to: "justHelp"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: helpButton; property: "opacity"; to: 1; duration: transitionTime}
        },
        Transition {
            to: "void"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
        },
        Transition {
            to: "full"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: 1; duration: transitionTime}
        },
        Transition {
            to: "justStop"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: helpButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
        },
        Transition {
            to: "justPlay"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: helpButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
        },
        Transition {
            to: "pauseStop"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: helpButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
        },
        Transition {
            to: "playStop"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: playButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: stopButton; property: "opacity"; to: 1; duration: transitionTime}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
            PropertyAnimation { target: helpButton; property: "opacity"; to: opacityLevel; duration: transitionTime}
        }
    ]

    PropertyAnimation{ id: delayedEnable; target: toolBarRectangle; property: "enabled"; to: true; duration: 0 }

    Image{
        id: pauseButton
        height: parent.height
        width: parent.height
        anchors.centerIn: parent
        source: Storage.getAppDB(Constants.dbAppIcon.pauseId, "")
        opacity: pauseActuator.down ? 0.4 : 1 // opacityLevel
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        Button{
            id: pauseActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.toolBarConsoleLog,"pause button clicked...")
                toolBarRectangle.temporalDisable(barDisabledTime)
                pauseClicked()
            }
        }
    }

    Image{
        id: playButton
        height: parent.height
        width: parent.height
        anchors.right: pauseButton.left
        anchors.rightMargin: parent.height * 0.20
        source:  Storage.getAppDB(Constants.dbAppIcon.playId, "")
        opacity: playActuator.down ? 0.4 : 1 // opacityLevel
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
//      Button{
//      #4836
        MouseArea{
            id: playActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.toolBarConsoleLog,"play button clicked...")
                toolBarRectangle.temporalDisable(barDisabledTime)
                toolBarRectangle.playClicked()
            }
            onPressed: {
                //DEB->debug.log(DC.toolBarConsoleLog,"play button pressed...")
                toolBarRectangle.playPressed()
            }
            onReleased: {
                //DEB->debug.log(DC.toolBarConsoleLog,"play button released...")
                toolBarRectangle.playReleased()
            }
        }
    }

    Image{
        id: stopButton
        height: parent.height
        width: parent.height
        anchors.left: pauseButton.right
        anchors.leftMargin: parent.height * 0.20
        source: Storage.getAppDB(Constants.dbAppIcon.stopId, "")
        opacity: stopActuator.down ? 0.4 : 1 // opacityLevel
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        Button{
            id: stopActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.toolBarConsoleLog, "stop button clicked...")
                toolBarRectangle.temporalDisable(barDisabledTime)
                stopClicked()
            }
        }
    }

    Image{
        id: settingsButton
        height: parent.height
        width: parent.height
        anchors.leftMargin: parent.height * 0.20
        anchors.left: helpButton.right
        source: Storage.getAppDB(Constants.dbAppIcon.configId, "")
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        opacity: settingsActuator.down ? 0.4 : 1
        Button{
            id: settingsActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.toolBarConsoleLog, "settings button clicked...")
                toolBarRectangle.temporalDisable(barDisabledTime)
                settingsClicked()
            }
        }
    }

    Image{
        id: helpButton
        height: parent.height
        width: parent.height
        anchors.left: parent.left
        anchors.leftMargin: parent.height * 0.20
        source:  Storage.getAppDB(Constants.dbAppIcon.helpId, "")
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        opacity: helpActuator.down ? 0.4 : 1
        Button{
            id: helpActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {
                toolBarRectangle.temporalDisable(barDisabledTime)
                toolBarRectangle.helpClicked()
            }
        }
    }

    Label{
        id: timeLabel
        states: [
            State {
                name: "timeLabelPositionOriginal"
            },
            State {
                name: "timeLabelPositionShifted"
            },
            State {
                name: "timeLabelInvisible"
            }
        ]
        transitions: [
            Transition {
                to: "timeLabelPositionOriginal"
                NumberAnimation { target: timeLabel; property: "anchors.rightMargin"; to: toolBarRectangle.height * 0.20; duration: 40}
                PropertyAnimation { target: timeLabel; property: "opacity"; to: 1; duration: 40}
            },
            Transition {
                to: "timeLabelPositionShifted"
                NumberAnimation { target: timeLabel; property: "anchors.rightMargin"; to: toolBarRectangle.height * 0.70; duration: 40}
                PropertyAnimation { target: timeLabel; property: "opacity"; to: 1; duration: 40}
            },
            Transition {
                to: "timeLabelInvisible"
                PropertyAnimation { target: timeLabel; property: "opacity"; to: 0; duration: 40}
            }
        ]

        height: parent.height * 0.5
        width:  parent.height * 1.1
        anchors.right: parent.right
        anchors.rightMargin: parent.height * 0.20
        anchors.top: parent.top
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
        color: Storage.getAppDB(Constants.dbAppColor.toolBarTimeLabelId, "black")
        opacity: 0.7
        text:  Qt.formatTime(new Date(),"hh:mm")
        font.pixelSize:parent.width * 0.022//0.25
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "green"
            visible: false
        }
    }

    Label{
        id: dateLabel
        states: [
            State {
                name: "dateLabelPositionOriginal"
            },
            State {
                name: "dateLabelPositionShifted"
            },
            State {
                name: "dateLabelInvisible"
            }
        ]
        transitions: [
            Transition {
                to: "dateLabelPositionOriginal"
                NumberAnimation { target: dateLabel; property: "anchors.rightMargin"; to: toolBarRectangle.height * 0.20; duration: 40}
                PropertyAnimation { target: dateLabel; property: "opacity"; to: 1; duration: 40}
            },
            Transition {
                to: "dateLabelPositionShifted"
                NumberAnimation { target: dateLabel; property: "anchors.rightMargin"; to: toolBarRectangle.height * 0.70; duration: 40}
                PropertyAnimation { target: dateLabel; property: "opacity"; to: 1; duration: 40}
            },
            Transition {
                to: "dateLabelInvisible"
                PropertyAnimation { target: dateLabel; property: "opacity"; to: 0; duration: 40}
            }
        ]

        height: parent.height * 0.5
        width:  parent.height * 1.1
        anchors.right: parent.right
        anchors.rightMargin: parent.height * 0.20
        anchors.bottom: parent.bottom
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        color: Storage.getAppDB(Constants.dbAppColor.toolBarDateLabelId, "black")
        opacity: 0.7
        text:  Qt.formatDate(new Date(), "dd/MM/yy")
        font.pixelSize:parent.width * 0.022//0.25
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "green"
            visible: false
        }
    }

    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            timeLabel.text =  Qt.formatTime(new Date(), "hh:mm")
            dateLabel.text =  Qt.formatDate(new Date(), "dd/MM/yy")
        }
    }
}

