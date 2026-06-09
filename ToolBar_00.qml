// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

Rectangle{
    property alias helpButton: helpButton
//  property alias toolBar: toolBar

    property double opacityLevel: 0.2
    property int transitionTime: 40

    signal settingsClicked()
    signal pauseClicked()
    signal playClicked()
    signal stopClicked()
    signal helpClicked()

    id: toolBarRectangle
    color: "#333333"
    height: parent.height
    width: parent.width
    state: "settingsHelp"

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
            to: "justHelp"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: 0.2; duration: 40}
            PropertyAnimation { target: playButton; property: "opacity"; to: 0.2; duration: 40}
            PropertyAnimation { target: stopButton; property: "opacity"; to: 0.2; duration: 40}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: 0.2; duration: 40}
            PropertyAnimation { target: helpButton; property: "opacity"; to: 1; duration: 40}
        },
        Transition {
            to: "void"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: opacityLevel; duration: 40}
            PropertyAnimation { target: playButton; property: "opacity"; to: opacityLevel; duration: 40}
            PropertyAnimation { target: stopButton; property: "opacity"; to: opacityLevel; duration: 40}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: 40}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: opacityLevel; duration: 40}
        },
        Transition {
            to: "full"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: 1; duration: 40}
            PropertyAnimation { target: playButton; property: "opacity"; to: 1; duration: 40}
            PropertyAnimation { target: stopButton; property: "opacity"; to: 1; duration: 40}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: 1; duration: 40}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: 1; duration: 40}
        },
        Transition {
            to: "justStop"
            PropertyAnimation { target: pauseButton; property: "opacity"; to: 0.2; duration: 40}
            PropertyAnimation { target: playButton; property: "opacity"; to: 0.2; duration: 40}
            PropertyAnimation { target: stopButton; property: "opacity"; to: 1; duration: 40}
            PropertyAnimation { target: settingsButton; property: "opacity"; to: 0.2; duration: 40}
            PropertyAnimation { target: helpButton; property: "opacity"; to: 0.2; duration: 40}
        }
    ]

    Image{
        id: pauseButton
        height: parent.height
        width: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source:"Images/ic_pause_circle_outline_white_48dp.png"
        opacity: opacityLevel
        Button{
            id: pauseActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {console.log("pause button clicked..."); pauseClicked()}
        }
    }
    Image{
        id: playButton
        height: parent.height
        width: parent.height
        anchors.right: pauseButton.left
        anchors.rightMargin: parent.height * 0.20
        source:"Images/ic_play_circle_outline_white_48dp.png"
        opacity: opacityLevel
        Button{
            id: playActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {console.log("play button clicked..."); playClicked()}
        }
    }
    Image{
        id: stopButton
        height: parent.height
        width: parent.height
        anchors.left: pauseButton.right
        anchors.leftMargin: parent.height * 0.20
        source:"Images/ic_stop_circle_outline_white_48dp.png"
        opacity: opacityLevel
        Button{
            id: stopActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {console.log("stop button clicked..."); stopClicked()}
        }
    }
    Image{
        id: settingsButton
        height: parent.height
        width: parent.height
        anchors.left: parent.left
        anchors.leftMargin: parent.height * 0.20
        source:"Images/ic_settings_white_48dp.png"
        Button{
            id: settingsActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {console.log("settings button clicked..."); settingsClicked()}
        }
    }
    Image{
        id: helpButton
        states: [
            State {
                name: "iconPositionOriginal"
            },
            State {
                name: "iconPositionShifted"
            }
        ]
        transitions: [
            Transition {
                to: "iconPositionOriginal"
                NumberAnimation { target: helpButton; property: "anchors.rightMargin"; to: toolBarRectangle.height * 0.20; duration: 40}
            },
            Transition {
                to: "iconPositionShifted"
                NumberAnimation { target: helpButton; property: "anchors.rightMargin"; to: toolBarRectangle.height * 0.80; duration: 40}
            }
        ]
        height: toolBarRectangle.height
        width: toolBarRectangle.height
        anchors.right: toolBarRectangle.right
        anchors.rightMargin: toolBarRectangle.height * 0.20
        source:"Images/ic_help_outline_white_48dp.png"
        state:"iconPositionOriginal"
        Button{
            id: helpActuator
            opacity: 0
            anchors.fill: parent
            onClicked: {console.log("help button clicked..."); helpClicked()}
        }
    }
}

