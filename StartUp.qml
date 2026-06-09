// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Controls 1.4 as QQC1
import QtQuick.Controls.Styles 1.0
import QtGraphicalEffects 1.0
import "Constants.js" as Constants
import "storage.js" as Storage
import "Therapies.js" as Therapies

Rectangle {
    id: startUp

    property alias startUpHiddenText: startUpHiddenText
    property alias skipErrorButton: skipErrorButton
    property alias viewStartUpButton: viewStartUpButton
    property alias continueButton: continueButton
    property alias erroId: erroId
    property alias skipInitButton: skipInitButton
    property alias scrollStartUpText: scrollStartUpText
    property alias startUpAnimation1: startUpAnimation1

    property bool viewGrid: false

    function launchLogoAnimation(){
        startUpAnimation1.source = ""  // necessary to "unload" animation one. Animation one and two stay together during visible property changes overloading the memory resources
        startUpAnimation1.visible = false
        startUpAnimation2.visible = true
    }

    color: Storage.getAppDB(Constants.dbAppColor.startUpBackFrameId, "black")
    anchors.fill: parent
    visible: false

    AnimatedImage {
        id: startUpAnimation1
        anchors.centerIn: parent
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.startUpAnimation1Id, "") : "" // 12/2021
        playing: false
        visible: parent.visible
        z: 0

        onVisibleChanged: {
            if(visible){
                startUpAnimation1Timer.restart()
            }else{
                startUpAnimation1.playing = false
            }
        }

        Timer {
            id: startUpAnimation1Timer
            interval: 1000
            onTriggered: startUpAnimation1.playing = true
        }

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "yellow"
            visible: viewGrid
        }
    }
    AnimatedImage {
        id: startUpAnimation2
        anchors.centerIn: parent
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.startUpAnimation2Id, "") : "" //12/2021
        playing: visible
        visible: false
        z: 0

        onFrameChanged: {
            if(currentFrame === (frameCount - 1)){
                startUpAnimation2.source = ""
                startUpAnimation2.visible = false
                startUpAnimation3.visible = true
            }
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "olive"
            visible: viewGrid
        }
    }
    AnimatedImage {
        id: startUpAnimation3
        anchors.centerIn: parent
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.startUpAnimation3Id, "") : "" //12/2021
        visible: false
        playing: visible
        z: 0

        onFrameChanged: {
            if(currentFrame === (frameCount - 1)){
//              paused = true
//              startUpAnimation3.source = ""
//              startUpAnimation3.visible = false
            }
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "darkolivegreen"
            visible: viewGrid
        }
    }

    TextArea{
        id: scrollStartUpTittleText
        width: flickableStartUpText.width
        height: parent.height * 0.04
        anchors.left: flickableStartUpText.left
        anchors.bottom: flickableStartUpText.top
        //      text: "Start up info \n"
        text: Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "34", "") + "\n"
        color: Storage.getAppDB(Constants.dbAppColor.startUpTextId, "black")//"white"
        wrapMode: Text.WrapAnywhere
        visible: flickableStartUpText.visible
        z: 1
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "blue"
            visible: viewGrid
        }
    }

    Flickable {
        id: flickableStartUpText
        width: parent.width * 0.18
        height: parent.height * 0.242 // 0.28
        anchors.left: parent.left
        anchors.leftMargin: parent.height * 0.125 * 0.3
        anchors.bottom: parent.bottom
        flickableDirection: Flickable.VerticalFlick
        visible: viewStartUpButton.state === "view" ? true : false
        z: 1
        TextArea.flickable:
            TextArea {
            id: scrollStartUpText
            color: Storage.getAppDB(Constants.dbAppColor.startUpTextId, "black")//"white"
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft
            text: ""
            wrapMode: Text.WordWrap
        }
        ScrollBar.vertical: ScrollBar {
            policy: (scrollStartUpText.height > flickableStartUpText.height) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        }

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "green"
            visible: viewGrid
        }
    }

    TextArea{
        id: startUpHiddenText
        anchors.left: flickableStartUpText.right
        width: parent.width * 0.25
        height: parent.height
        //      text: "Start up info \n"
        text: Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "34", "") + "\n"
        color: Storage.getAppDB(Constants.dbAppColor.startUpTextId, "black")
        wrapMode: Text.WrapAnywhere
        visible: false
        z: 1
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "orange"
            visible: viewGrid
        }
    }

    TextArea{
        id: parametersText
        anchors.left: startUpHiddenText.right
        width: parent.width * 0.25
        height: parent.height
        text: ""
        color: Storage.getAppDB(Constants.dbAppColor.startUpTextId, "black")
        wrapMode: Text.WrapAnywhere
        visible: false
        z: 1

        onVisibleChanged: {
//          if(visible){
//              text = "Parameters \n"
//              text = text + "Calibration pressure: " + Constants.calibrationPressure + "\n"
//              text = text + "O3 sensor gain: " + Constants.o3Sensorgain + "\n"
//              text = text + "Ini period: " + Constants.periodIni + "\n"
//              text = text + "Pressure compensation: " + Constants.pressureCompensation + "\n"
//              text = text + "Flow gain 1: " + Constants.flowGainSector1 + "\n"
//              text = text + "Flow gain 2: " + Constants.flowGainSector2 + "\n"
//              text = text + "Flow gain 3: " + Constants.flowGainSector3 + "\n"
//              text = text + "1 \u03BCg pulses: " + Constants.oneMicrogramePulses + "\n"
//              text = text + "O3 pulses 1: " + Constants.o3PulsesSector1 + "\n"
//              text = text + "O3 pulses 2: " + Constants.o3PulsesSector2 + "\n"
//              text = text + "O3 pulses 3: " + Constants.o3PulsesSector3 + "\n"
//          }
            if(visible){
                text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "61", "")
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "20", "") + Constants.calibrationPressure
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "21", "") + Constants.o3Sensorgain
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "22", "") + Constants.periodIni
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "23", "") + Constants.pressureCompensation
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "24", "") + Constants.flowGainSector1
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "25", "") + Constants.flowGainSector2
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "26", "") + Constants.flowGainSector3
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "27", "") + Constants.oneMicrogramePulses
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "28", "") + Constants.o3PulsesSector1
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "29", "") + Constants.o3PulsesSector2
                text = text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "30", "") + Constants.o3PulsesSector3
            }
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "brown"
            visible: viewGrid
        }
    }

    Rectangle{
        id: viewStartUpButton
        height: parent.height * 0.125
        width: height
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: height * 0.3
        anchors.bottomMargin: anchors.rightMargin
        color: "transparent"
        state: "noView"
        z: 1
        enabled: false // disabled until any information available
        opacity: enabled ? 1 : 0.2

        states: [
            State {
                name: "view"
                PropertyChanges { target: viewstartUpHiddenText; text: "No view start up"}
                PropertyChanges { target: viewstartUpButtonImage; source: Storage.getAppDB(Constants.dbAppIcon.noViewStartUpInfoId, "")}
            },
            State {
                name: "noView"
                PropertyChanges { target: viewstartUpHiddenText; text: "View start up"}
                PropertyChanges { target: viewstartUpButtonImage; source: Storage.getAppDB(Constants.dbAppIcon.viewStartUpInfoId, "")}
            }
        ]
        onStateChanged: {
            if(viewStartUpButton.state === "view"){
                consoleSocket.sendData(Constants.STOP_ST_UP + ",1\r")

            }else{
                consoleSocket.sendData(Constants.STOP_ST_UP + ",0\r")
            }
        }
        Text{
            id: viewstartUpHiddenText
            visible: false
        }
        Image{
            id: viewstartUpButtonImage
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.viewStartUpInfoId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            enabled: viewStartUpButton.enabled
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(viewStartUpButton.state === "view"){
                    viewStartUpButton.state = "noView"
                    if(appConsole.state === Constants.CONSOLE_ST_WAIT_AFTER_START_UP){
                        consoleSocket.sendData(Constants.ENT_SIM)
                    }
                }else{
                    viewStartUpButton.state = "view"
                }
            }
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: viewGrid
        }
    }

    Rectangle{
        id: skipErrorButton
        height: viewStartUpButton.height
        width: height
        anchors.right: viewStartUpButton.right
        anchors.bottom: viewStartUpButton.top
        anchors.bottomMargin: height * 0.3
        color: "transparent"
        visible: false
        z: 1

        Text{
            text: "Skip error"
            visible: false
        }
        Image{
            id: skipErrorButtonImage
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.skipStartUpErrorId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                consoleSocket.sendData(Constants.CNL_SIM)
                skipErrorButton.visible = false
            }
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "olive"
            visible: viewGrid
        }
    }

    Rectangle{
        id: errorIcon
        height: viewStartUpButton.height
        width: height
        anchors.right: viewStartUpButton.right
        anchors.top: parent.top
        anchors.topMargin: viewStartUpButton.anchors.bottomMargin
        color: "transparent"
        visible: skipErrorButton.visible
        z: 1

        Text{
            id: erroId
            text: ""
            height: parent.height * 0.23
            width: parent.width * 0.23
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignRight
            color: Storage.getAppDB(Constants.dbAppColor.startUpTextId, "black")//"white"
            z: parent.z +2
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "orange"
                visible: viewGrid
            }
        }
        Image{
            id: errorImage
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.errorCircleId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "olive"
            visible: viewGrid
        }
    }


    Rectangle{
        id: skipInitButton
        property bool pendingToShow: true

        height: viewStartUpButton.height
        width: height
        color: "transparent"
        visible: false

        anchors.top: viewStartUpButton.top
        anchors.right: viewStartUpButton.left
        anchors.rightMargin: height * 0.3
        z: viewStartUpButton.z

        onVisibleChanged:{

            if(visible){
                skipInitButtonVisibleTimer.running = true
                pendingToShow = false
            }
        }

        Image{
            id: skipInitButtonImage
            anchors.fill: parent
            source:  Storage.getAppDB(Constants.dbAppIcon.configId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                consoleSocket.sendData(Constants.ENT_SIM)
                serviceMenu.alwaysReset = true
                Therapies.settings()
                console.log("Skip init...")
            }
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "olive"
            visible: viewGrid
        }
    }
    Timer{
        id: skipInitButtonVisibleTimer
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            skipInitButton.visible = false
        }
    }

    Rectangle{
//
//      Alternative continue button (to avoid stop after start up)
//
        id: continueButton
        height: 100
        width: height
        anchors.right: parent.right
        anchors.top: skipErrorButton.bottom
        color: "transparent"
        visible: false
        z: 1
        onVisibleChanged: {
            if(visible){
                consoleSocket.sendData(Constants.ENT_SIM)
            }
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "magenta"
            visible: viewGrid
        }
    }
}
