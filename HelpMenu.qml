// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import QtMultimedia 5.8

import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies
import "DebugConstants.js" as DC

Item{
    id: helpMenu

    property alias  helpImageViewer: helpImageViewer
    property alias  helpSuggestionBubble:helpSuggestionBubble
    property alias  helpMenuMouseArea: helpMenuMouseArea
    property alias  helpVideoViewer: helpVideoViewer

    property int    numberOfHelpButtons: 5
    property int    buttonsRadius: parent.width * 0.003
    property int    helpSuggestionBubbleWidth: helpMenu.width * 1.6
    property int    helpSuggestionBubbleHeight: helpMenu.width * 1.2
    property int    helpSuggestionBubbleY: parent.height - (helpMenu.width * 2.3) + helpSuggestionBubbleHeight
    property double disabledOpacity: 0.3
    property double disabledOpacityBack: disabledOpacity
    property string helpType: ""
    property string alternativeHelpVideoTutorialFile: ""

    function helpInfoAvalilable(source, page){
        var ret

        if((source !== null) && (page !== null))
        {
            ret = true
        }
        else{
            tabBar.blinkEffect()
            //DEB->debug.log(DC.helpMenuConsoleLog, "Help info not available in DB. Source:", source, ", Page:", page)
            ret = false
        }
        return ret
    }

    function showHelp(helpType){
        var source
        var page
        var numPages

        //DEB->debug.log(DC.helpMenuConsoleLog, "Help query: ", helpType)

        helpDocViewer.docSource = ""
        helpVideoViewer.video.source = ""
        helpImageViewer.image.source = ""

        switch(helpType){
        case Constants.helpDocId:
            source = Storage.getAppDB(tabBar.selectedOption + Constants.helpDocId + applicationWindow.selectedLanguageId.substring(0,(applicationWindow.selectedLanguageId.length - 1)) , "")
            page = Storage.getAppDB(tabBar.selectedOption + Constants.helpDocId + applicationWindow.selectedLanguageId + Constants.helpDocPageId, "")
            numPages = Storage.getAppDB(tabBar.selectedOption + Constants.helpDocId + applicationWindow.selectedLanguageId  + Constants.helpDocNumPagesId, "")           
            if(helpInfoAvalilable(source, page))
            {
                helpDocViewer.docSource = source
                helpDocViewer.startPage = page
                helpDocViewer.maxPages = numPages
                helpDocViewer.state = "ShowHelpDocViewer"
                //DEB->debug.log(DC.helpMenuConsoleLog, "Help doc source: " + helpDocViewer.doc.source + " " + helpDocViewer.page.value)
            }
            break
        case Constants.helpTroubleShootDocId:
            source = Storage.getAppDB(tabBar.selectedOption + Constants.helpTroubleShootDocId + applicationWindow.selectedLanguageId.substring(0,(applicationWindow.selectedLanguageId.length - 1)) , "")
            page = Storage.getAppDB(tabBar.selectedOption + Constants.helpTroubleShootDocId + applicationWindow.selectedLanguageId  + Constants.helpTroubleShootDocPageId, "1")
            numPages = Storage.getAppDB(tabBar.selectedOption + Constants.helpTroubleShootDocId + applicationWindow.selectedLanguageId  + Constants.helpTroubleShootDocNumPagesId, "1")
            if(helpInfoAvalilable(source, page))
            {
                helpDocViewer.docSource = source
                helpDocViewer.startPage = page
                helpDocViewer.maxPages = numPages
                helpDocViewer.state = "ShowHelpDocViewer"
                //DEB->debug.log(DC.helpMenuConsoleLog, "Help troubleshoot doc source: " + helpDocViewer.doc.source + " " + helpDocViewer.page.value)
            }
            break
        case Constants.helpTutorialVideoId:
            if(alternativeHelpVideoTutorialFile === ""){
                source = Storage.getAppDB(tabBar.selectedOption + Constants.helpTutorialVideoId, "")
            }
            else{
                source = Storage.getAppDB(appHelpMenu.alternativeHelpVideoTutorialFile, "")
            }
            if(helpInfoAvalilable(source, 0))
            {
                helpVideoViewer.video.source = source
                helpVideoViewer.state= "ShowVideoPlayer"
                //DEB->debug.log(DC.helpMenuConsoleLog, "Help tutorial video source: " + helpVideoViewer.video.source)
            }
            break
        case Constants.helpConnectionImgId:
            source = Storage.getAppDB(tabBar.selectedOption + Constants.helpConnectionImgId, "")
            if(helpInfoAvalilable(source, 0))
            {
                helpImageViewer.image.source = source
                helpImageViewer.state= "ShowImageViewer"
                //DEB->debug.log(DC.helpMenuConsoleLog, "Help connection image source: " + helpImageViewer.image.source)
            }
            break
        case Constants.helpTherapyVideoId:
            source = Storage.getAppDB(tabBar.selectedOption + Constants.helpTherapyVideoId, "")
            if(helpInfoAvalilable(source, 0))
            {
                helpVideoViewer.video.source = source
                helpVideoViewer.state= "ShowVideoPlayer"
                //DEB->debug.log(DC.helpMenuConsoleLog, "Help therapy video source: " + helpVideoViewer.video.source)
            }
            break
        }
    }

    function cleanUpSpaceForMenuBar(){
        if(tabBar.selectedOption === Constants.option2Id){
            magnitudeSelector.fullViewOffsetCorrection = 0
            magnitudeSelector.updateFullViewSelectors()
        }
        if((tabBar.selectedOption === Constants.option5_1Id) && (magnitudeSelector.theraphyCycles !== 1)){
            magnitudeSelector.fullViewOffsetCorrection = 0
            magnitudeSelector.updateFullViewSelectors()
        }
    }

    function recoverElementsPositionWhenHideHelp(){
        if(tabBar.selectedOption === Constants.option2Id){
            magnitudeSelector.fullViewOffsetCorrection = magnitudeSelector.defaultFullViewOffsetCorrection
            magnitudeSelector.updateFullViewSelectors()
        }
        if((tabBar.selectedOption === Constants.option5_1Id) && (magnitudeSelector.theraphyCycles !== 1)){
            magnitudeSelector.fullViewOffsetCorrection = magnitudeSelector.defaultFullViewOffsetCorrection
            magnitudeSelector.updateFullViewSelectors()
        }
    }

    states: [
        State {
            name: "ShowHelp"
            PropertyChanges   { target: buttonsColumn; y: parent.height - buttonsColumn.height - buttonsColumn.width }
            PropertyChanges   { target: helpDocumentButton; enabled: true }
            PropertyChanges   { target: helpTutorialButton; enabled: true }
            PropertyChanges   { target: helpConnectionButton; enabled: true }
            PropertyChanges   { target: helpVideoButton; enabled: true }
            PropertyChanges   { target: helpTroubleShootingVideoButton; enabled: true }
            StateChangeScript { script: helpMenuTimeOut.restart() }
        },
        State {
            name: "ShowJustVideoTurorialHelp"
            PropertyChanges   { target: buttonsColumn; y: parent.height - buttonsColumn.height - buttonsColumn.width }
            PropertyChanges   { target: helpDocumentButton; enabled: false }
            PropertyChanges   { target: helpTutorialButton; enabled: true }
            PropertyChanges   { target: helpConnectionButton; enabled: false }
            PropertyChanges   { target: helpVideoButton; enabled: false }
            PropertyChanges   { target: helpTroubleShootingVideoButton; enabled: false }
            StateChangeScript { script: helpMenuTimeOut.restart() }
        },
        State {
            name: "HideHelp"
            PropertyChanges   { target: buttonsColumn; y: parent.height }
            StateChangeScript { script: helpMenuTimeOut.restart() }
        }
    ]

    transitions: [
        Transition {
            to: "ShowHelp"
            SequentialAnimation{
//              PropertyAnimation { target: helpMenu; property: "disabledOpacity"; to: 1 }
                PropertyAnimation { target: helpMenu; property: "enabled"; to: false }
                PropertyAnimation { target: buttonsColumn; property: "y"; to: parent.height - buttonsColumn.height - buttonsColumn.width; duration: 300 }
                PropertyAnimation { target: helpMenu; property: "enabled"; to: true }
//              PropertyAnimation { target: helpMenu; property: "disabledOpacity"; to: disabledOpacityBack }
            }
        },
        Transition {
            to: "ShowJustVideoTurorialHelp"
            ScriptAction { script: cleanUpSpaceForMenuBar() }
        },
        Transition {
            to: "HideHelp"
            PropertyAnimation { target: buttonsColumn; property: "y"; to: parent.height; duration: 300 }
            ScriptAction { script: Therapies.closeHelp() }
            ScriptAction { script: recoverElementsPositionWhenHideHelp() }
        }
    ]

    state: "HideHelp"
    width: parent.width
    height: parent.height

    MouseArea{
        id: helpMenuMouseArea
        anchors.fill: parent
        onActiveFocusChanged: {                 // help menu auto hide system
            if(!focus){                         // this avoid 3 consecutive warnings
                helpMenu.state = "HideHelp"     // this generates a controled warning
                //DEB->debug.log(DC.helpMenuConsoleLog, "Hiding help menu...")
            }
        }
    }

    Column{
        id: buttonsColumn
        spacing: parent.width * 0.035
        width: parent.width
        height: ( parent.width + spacing ) * numberOfHelpButtons
        Rectangle {
            id: helpDocumentButton
            width: parent.width
            height: parent.width
            color: Storage.getAppDB(Constants.dbAppColor.HelpMenuButtonId, "black")
            radius: buttonsRadius
            opacity: (enabled) ? 1 : disabledOpacity
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.helpDocId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: (helpDocumentButtonButton.down) ?  disabledOpacity : 1
            }
            Button{
                id: helpDocumentButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    showHelp(Constants.helpDocId)
                    helpMenu.state = "HideHelp"
                }
            }
        }

        Rectangle {
            id: helpTutorialButton
            width: parent.width
            height: parent.width
            color: Storage.getAppDB(Constants.dbAppColor.HelpMenuButtonId, "black")
            radius: buttonsRadius
            opacity: (enabled) ? 1 : disabledOpacity
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.helpTutorialVideoId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: (helpTutorialButtonButton.down) ?  disabledOpacity : 1
            }
            Button{
                id: helpTutorialButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    showHelp(Constants.helpTutorialVideoId)
                    helpMenu.state = "HideHelp"
                }
            }
        }

        Rectangle {
            id: helpConnectionButton
            width: parent.width
            height: parent.width
            color: Storage.getAppDB(Constants.dbAppColor.HelpMenuButtonId, "black")
            radius: buttonsRadius
            opacity: (enabled) ? 1 : disabledOpacity
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.helpConnectionImgId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: (helpConnectionButtonButton.down) ?  disabledOpacity : 1
            }
            Button{
                id: helpConnectionButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked:  {
                    showHelp(Constants.helpConnectionImgId)
                    helpMenu.state = "HideHelp"
                }
            }
        }

        Rectangle {
            id: helpVideoButton
            width: parent.width
            height: parent.width
            color: Storage.getAppDB(Constants.dbAppColor.HelpMenuButtonId, "black")
            radius: buttonsRadius
            opacity: (enabled) ? 1 : disabledOpacity
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.helpTherapyVideoId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: (helpVideoButtonButton.down) ?  disabledOpacity : 1
            }
            Button{
                id: helpVideoButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    showHelp(Constants.helpTherapyVideoId)
                    helpMenu.state = "HideHelp"
                }
            }
        }

        Rectangle {
            id: helpTroubleShootingVideoButton
            width: parent.width
            height: parent.width
            color: Storage.getAppDB(Constants.dbAppColor.HelpMenuButtonId, "black")
            radius: buttonsRadius
            opacity: (enabled) ? 1 : disabledOpacity
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.helpTroubleShootDocId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: (helpTroubleShootingVideoButtonButton.down) ?  disabledOpacity : 1
            }
            Button{
                id: helpTroubleShootingVideoButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    showHelp(Constants.helpTroubleShootDocId)
                    helpMenu.state = "HideHelp"
                }
            }
        }
    }

    ImageViewer{
        id: helpImageViewer
        y:0
        x: -parent.width * 0.20
        width: helpMenu.parent.width
        height:helpMenu.parent.height
        state: "HideImageViewer"
    }
    VideoPlayer{
        id: helpVideoViewer
        y:0
        x: -parent.width * 0.20
        width: helpMenu.parent.width
        height:helpMenu.parent.height
        state: "HideVideoPlayer"
    }
    HelpDocViewer{
        id: helpDocViewer
        y:0
        x: -parent.width * 0.20
        width: helpMenu.parent.width
        height: helpMenu.parent.height
        visible: false
    }

    Rectangle{
        id: helpSuggestionBubble
        y: parent.parent.height - (parent.width * 2.3)
        x: parent.width
        width: parent.width * 1.6
        height: parent.width * 1.2
        color:"transparent"
        opacity: 0
        state : "QuickHideHelpSuggestionBubble"
        visible: false

        states: [
            State {
                name: "ShowHelpSuggestionBubble"
                PropertyChanges { target: helpSuggestionBubble; opacity: 1 }
                PropertyChanges { target: helpSuggestionBubble; enabled: true }
                PropertyChanges { target: helpSuggestionBubbleMouseArea; focus: true }
                PropertyChanges { target: hideHelpSuggestionBubbleDelayTimer; running: true }
            },
            State {
                name: "HideHelpSuggestionBubble"
                PropertyChanges { target: helpSuggestionBubble; opacity: 0 }
                PropertyChanges { target: helpSuggestionBubble; enabled: false }
                PropertyChanges { target: helpSuggestionBubbleMouseArea; focus: false }
            },
            State {
                name: "QuickHideHelpSuggestionBubble"
                PropertyChanges { target: helpSuggestionBubble; opacity: 0 }
                PropertyChanges { target: helpSuggestionBubble; enabled: false }
                PropertyChanges { target: helpSuggestionBubbleMouseArea; focus: false }
            }
        ]

        transitions: [
            Transition {
                to: "ShowHelpSuggestionBubble"
                PropertyAnimation { target: helpSuggestionBubble; property: "opacity"; to: 1; duration: 600 }
                PropertyAnimation { target: helpSuggestionBubbleMouseArea; property: "focus"; to: true; duration: 0 }
            },
            Transition {
                to: "HideHelpSuggestionBubble"
                SequentialAnimation{
                    PropertyAnimation { target: helpSuggestionBubble; property: "opacity"; to: 0; duration: 800 }
                }
            }
        ]

        Timer {
            id: hideHelpSuggestionBubbleDelayTimer
            interval: 2000;
            running: false;
            repeat: false
            onTriggered: helpSuggestionBubble.state = "HideHelpSuggestionBubble"
        }

        Image {
            id: helpSuggestionBubbleImage
            source: Storage.getAppDB(Constants.dbAppIcon.helpSuggestionBubbleId, "")
            anchors.fill: parent
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }

        MouseArea{
            id: helpSuggestionBubbleMouseArea
            anchors.fill: parent
            focus: true
            onClicked: {  showHelp(Constants.helpConnectionImgId); helpSuggestionBubble.state = "QuickHideHelpSuggestionBubble"  }
            onActiveFocusChanged: {                                                  // help menu auto hide system
                if(!focus){                                                          // this avoid 3 consecutive warnings
                    helpSuggestionBubble.state = "QuickHideHelpSuggestionBubble"     // this generates a controled warning
                    //DEB->debug.log(DC.helpMenuConsoleLog, "Hiding help suggestion bubble...")
                }
            }
        }
    }

    Timer{
        id: helpMenuTimeOut
        interval: 5000 // #4832
        onTriggered: {
            running = false
            helpMenu.state = "HideHelp"
        }
    }
}

