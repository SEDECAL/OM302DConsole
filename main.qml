// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.XmlListModel 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.LocalStorage 2.12
import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard.Styles 2.2
import QtQuick.VirtualKeyboard.Settings 2.2
import QtMultimedia 5.10
//import QtTest 1.2
//import FileIO 1.0

import "storage.js" as Storage
import "DebugConstants.js" as DC
import "Constants.js" as Constants
import "Configurator.js" as Configurator
import "Therapies.js" as Therapies
import "SocketManagement.js" as SocketManagement
import "Singletons"

ApplicationWindow {
    id: applicationWindow

    property alias tabBar: tabBar
    property alias keyboard: keyboard
    property alias requestDataTimer: requestDataTimer
    property alias magnitudeSelector: magnitudeSelector
    property alias mainBussyIndicator: mainBussyIndicator
    property alias cumulatedBoard: cumulatedBoard
    property alias appToolBarEndPatch: appToolBarEndPatch

    property int atmosphericPressure: 950 // walk around to know atmospheric pressure in some parts of the code
    property int atmPressForAutohemo: 0 // 4833
    property int periodicInfoDelay:  0 // miliseconds
    property int selectedLanguage: 0
    property string selectedLanguageId: ""
    property string controlBoardSW: ""
    property string interfaceSW: ""

    property double generationTime: 0

    readonly property int slowRequestDataTime: 2000
    readonly property int quickRequestDataTime: 400
    readonly property int startUpRequestDataTime: 60000
    readonly property int requestDataTimerInterval: 4000

    property bool skipStartUp: false
    property bool viewGrid: false
    property bool skipError: false  // #4316

    function initLanguageSettings(){
        applicationWindow.selectedLanguage = Number(Storage.getLanguageDB(Constants.dbLanguageSelectedLanguageId, ""))
        applicationWindow.selectedLanguageId = Storage.getLanguageDB(Constants.dbLanguageId + selectedLanguage , "")
        VirtualKeyboardSettings.locale = Storage.getLanguageDB(Constants.dbLanguageKeyboardLocaleId + selectedLanguage, "")
    }

    visible: false
    width: QtConstants.screenWidth
    height: QtConstants.screenHeight
    color: Storage.getAppDB(Constants.dbAppColor.mainBackColorId, "black")
    title: qsTr("OM302D")

    Component.onCompleted: {
        visible = true
        consoleSocket.onConnected.connect(SocketManagement.onConnected)
        consoleSocket.onDisconnected.connect(SocketManagement.onDisconnected)
        consoleSocket.onRead.connect(SocketManagement.onRead)
        consoleSocket.onWrite.connect(SocketManagement.onWrite)
        consoleSocket.onWritten.connect(SocketManagement.onWritten)
        console.log("Component.onCompleted: applicationWindow           ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
    }

    onPeriodicInfoDelayChanged: consoleSocket.sendData(Constants.SET_PERIODIC_INFO_DELAY + periodicInfoDelay + "\r")

    Timer {
        id: socketConnectionTimer
        interval: 1000//2000
        repeat: true
        running: true
        onTriggered:{
            interval: 2000
            consoleSocket.startConnection()
        }
        Component.onCompleted: console.log("Component.onCompleted: socketConnectionTimer       ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
    }

    MouseArea{
        id: globalTouchDetection
        property bool showGlobalTouchConsole: true
        anchors.fill: parent
        propagateComposedEvents: true
        z:100
        onPressed: {
            //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Global touch detection pressed...")
            mouse.accepted = false
            saveScreenTimer.restart()
            //RP appConfigurationMenu.state = "HideConfigurationMenu"
        }
        Component.onCompleted: console.log("Component.onCompleted: globalTouchDetection        ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
    }

//  TO INCLUDE STATES TO SAVESCREEN SYSTEM:
//  1. Include the state in saveScreenTimer -> onTriggered switch.
//  2. Include the state in the state transition system to program saveScreenTimer.restart() on state change.

    Timer {
        id: saveScreenTimer
        interval: Storage.getAppDB(Constants.dbConstants.saveScreenTimeOutId, "")
        repeat: true
        running: true
        onTriggered: {
            //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Save screen timer time out...")
            switch (appConsole.state){
            case Constants.CONSOLE_ST_READY:
            case Constants.CONSOLE_ST_PRESSURE_TEST:
            case Constants.CONSOLE_ST_EDITING:
                //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Returning to save screen state...")
                gadgetMenu.state = "noViewGadgetMenu"
                magnitudeSelector.closeMagnitudeSelectors()
                Therapies.closeGadgets()
                Configurator.hideMagnitudeSelector()
                tabBar.closeSubmenus()
                tabBar.unpressAll()
                appConsole.state = Constants.CONSOLE_ST_SAVE_SCREEN
                brandName.state = "saveScreenMode"  // do not include this into  "CONSOLE_ST_SAVE_SCREEN" description bellow (problems during transitions)
                break
            default:
                break
            }
        }
    }

    Item{
        id: appConsole
        anchors.fill: parent
        property string stateBefore: ""
        state: skipStartUp ? Constants.CONSOLE_ST_SAVE_SCREEN : Constants.CONSOLE_ST_START_UP

        Component.onCompleted: console.log("Component.onCompleted: appConsole                  ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())

        states: [
            State {
                name: Constants.CONSOLE_ST_INIT
                PropertyChanges { target: appToolBar; enabled: false }
                PropertyChanges { target: appToolBar; opacity: 0.2 }
                PropertyChanges { target: appToolBar; state: "void"}
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0 }
                PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: true }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: brandName; state: "runMode" }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_READY
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: "settingsHelp"}
                PropertyChanges { target: tabBar; state: "tabBarReset" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0}
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: true }
                PropertyChanges { target: brandName; state: "runMode" }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_EDITING
                PropertyChanges { target: startUp; visible: false }
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; visible: true }
                PropertyChanges { target: appToolBar; state: Configurator.toolBarStateDependingOnTherapyWhileEditing() } // (01/02/2021 bug trac 3669)
                PropertyChanges { target: tabBar; state: "tabBarEabled" }
                PropertyChanges { target: magnitudeSelector; enabled: true }
                PropertyChanges { target: magnitudeSelector; opacity: 1 }
                PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: true }
                PropertyChanges { target: brandName; state: "runMode" }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "viewGadgetMenu" }
                PropertyChanges { target: serviceMenu; visible: false }
                PropertyChanges { target: normalizationImage; visible: true }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_SETTING
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: "justStop" }
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.5 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: true }
                PropertyChanges { target: cumulatedBoard; state: Configurator.cumulatedBoardStateDependingOnTherapy() }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: true }
                PropertyChanges { target: brandName; state: "adjustingMode" }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateAnimated"}
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: saveScreenTimer; running: false }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_GENERATING_CUM_VIEW
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: Configurator.toolBarStateDependingOnTherapyWhileGenerating() }
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.5 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: Configurator.cumulatedBoardStateDependingOnTherapy() }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton.frameImage; state: "playView"}
                PropertyChanges { target: emergencyPauseButton; visible: Configurator.emergencyButtonVisibilityDependingOnTherapy()}
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateAnimated"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_GENERATING_CONT_VIEW
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: Configurator.toolBarStateDependingOnTherapyWhileGenerating()}
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.5 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: Configurator.cumulatedBoardStateDependingOnTherapy() }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton.frameImage; state: "playView"}
                PropertyChanges { target: emergencyPauseButton; visible: Configurator.emergencyButtonVisibilityDependingOnTherapy()}
                PropertyChanges { target: normalizationImage; state: Configurator.normalizationImageStateDependingOnTherapy()}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_COMPLETED//"completed"
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: "justPlay" }
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.2 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: Configurator.totalBoardStateDependigOnTherapy() } //"viewTotalBoardOKIcon" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_SERVICE_MENU
                PropertyChanges { target: appToolBar; visible: false }
                PropertyChanges { target: tabBar; state: "tabBarInvisible" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: serviceMenu; visible: true }
                PropertyChanges { target: normalizationImage; visible: false }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: appHelpMenu; state: "HideHelp" }
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_CANCELED
                PropertyChanges { target: appToolBar; enabled: false }
                PropertyChanges { target: appToolBar; opacity: 0.2 }
                PropertyChanges { target: appToolBar; state: "void"}
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.2 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "viewTotalBoardCancelledIcon" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_FLUSHING
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: "justStop"}
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.5 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noviewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: waitingBoard; visible: true }
                PropertyChanges { target: waitingBoard; configuredWaitingTime: Configurator.waitingTimeDependingOnTherapy() }
                PropertyChanges { target: waitingBoard; waitingIcon: Configurator.waitingIconDependingOnTherapy() }
                PropertyChanges { target: waitingBoard; waitingProgressTool.value: 0 }
                PropertyChanges { target: waitingBoard; waitingProgressTool.visible: true }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_DEPRESSURING
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: "void"}
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.5 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard.pressureIndicator; state: "simulateDepressure" }
                PropertyChanges { target: cumulatedBoard.syringeAnimation; state: "viewSyringeAnimationEnd" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_WAITING_THERAPY_TIME
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: Configurator.toolBarStateDependingOnTherapyWhileWaitingTime()}
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.5 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: Configurator.cumulatedBoardStateDependingOnTherapy() }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: waitingBoard; visible: false }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_VACCUM
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: Configurator.toolBarStateDependingOnTherapyWhileVaccum() }
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.5 }
              PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: Configurator.cumulatedBoardStateDependingOnTherapy() }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_OVERPRESSURE
                PropertyChanges { target: appToolBar; enabled: false }
                PropertyChanges { target: appToolBar; opacity: 0.2 }
                PropertyChanges { target: appToolBar; state: "void"}
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.2 }
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "viewTotalBoardOverPressureIcon" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_ERROR
                StateChangeScript {script: memoryBoard.exitMemory()}
                StateChangeScript {script: Therapies.closeGadgets()} // ticket #4213
                StateChangeScript {script: Configurator.reduceMagnitudeSelector()}  // borrar en configurator
                PropertyChanges { target: appToolBar; enabled: false }
                PropertyChanges { target: appToolBar; opacity: 0.2 }
                PropertyChanges { target: appToolBar; state: "void"}
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.2 }
                PropertyChanges { target: magnitudeSelector; state: "noInputSelected"}
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "viewTotalBoardErrorIcon" }
                PropertyChanges { target: brandName; visible: false }
/*              PropertyChanges { target: pressureTester; state: "noViewPressureTester" }*/
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_PRESSURE_TEST
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: "justHelp" }
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: true }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateDisabled"}
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu"}//"gadgetMenuDisabled" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_PRESSURE_TEST_ERROR
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 1 }
                PropertyChanges { target: appToolBar; state: "justHelp" }
                PropertyChanges { target: tabBar; state: "tabBarDisabled" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0.5 }
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: true }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateDisabled"}
                PropertyChanges { target: pressureTester; state: "viewPressureTesterError" }
  /*            PropertyChanges { target: pressureTester; state: (pressureTester.errorCodeLabel.text === "2") ? "viewPressureTesterError"  : "noViewPressureTesterQuick" }*/
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },

            State {
                name: Constants.CONSOLE_ST_SAVE_SCREEN
                PropertyChanges { target: startUp; visible: false }
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 0 }
                PropertyChanges { target: appToolBar; state: Configurator.toolBarStateWhileEditing()}
                PropertyChanges { target: magnitudeSelector; enabled: true }
                PropertyChanges { target: magnitudeSelector; opacity: 0 }
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateHide"}
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: bloodVolume; state: "noViewBloodVolume" }
                PropertyChanges { target: saveScreen; state: "viewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: tabBar; state: "tabBarInvisible" }
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_START_UP
                PropertyChanges { target: startUp; visible: true }
                PropertyChanges { target: startUp.viewStartUpButton; state: startUp.viewStartUpButton.state }
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 0 }
                PropertyChanges { target: appToolBar; visible: false }
                PropertyChanges { target: tabBar; state: "tabBarInvisible" }
                PropertyChanges { target: magnitudeSelector; enabled: true }
                PropertyChanges { target: magnitudeSelector; opacity: 0 }
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateHide"}
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: bloodVolume; state: "noViewBloodVolume" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: serviceMenu; visible: false }
                PropertyChanges { target: normalizationImage; visible: false }
                PropertyChanges { target: emergencyPauseButton; visible: false }
//              PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime} #4311
            },
            State {
                name: Constants.CONSOLE_ST_START_UP_ERROR
                PropertyChanges { target: startUp; visible: true }
                PropertyChanges { target: startUp.skipErrorButton; visible: true }
                PropertyChanges { target: startUp.viewStartUpButton; state: "view" }
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 0 }
                PropertyChanges { target: appToolBar; visible: false }
                PropertyChanges { target: tabBar; state: "tabBarInvisible" }
                PropertyChanges { target: magnitudeSelector; enabled: true }
                PropertyChanges { target: magnitudeSelector; opacity: 0 }
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateHide"}
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: bloodVolume; state: "noViewBloodVolume" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: serviceMenu; visible: false }
                PropertyChanges { target: normalizationImage; visible: false }
                PropertyChanges { target: emergencyPauseButton; visible: false }
//              PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}  #4311
            },
            State {
                name: Constants.CONSOLE_ST_WAIT_AFTER_START_UP
                PropertyChanges { target: startUp; visible: true }
                PropertyChanges { target: startUp.viewStartUpButton; state: startUp.viewStartUpButton.state }
                PropertyChanges { target: appToolBar; enabled: true }
                PropertyChanges { target: appToolBar; opacity: 0 }
                PropertyChanges { target: appToolBar; visible: false }
                PropertyChanges { target: tabBar; state: "tabBarInvisible" }
                PropertyChanges { target: magnitudeSelector; enabled: true }
                PropertyChanges { target: magnitudeSelector; opacity: 0 }
                PropertyChanges { target: mainBussyIndicator; running: false }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: totalsBoard; state: "noViewTotalBoard" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateHide"}
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: bloodVolume; state: "noViewBloodVolume" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: serviceMenu; visible: false }
                PropertyChanges { target: normalizationImage; visible: false }
                PropertyChanges { target: emergencyPauseButton; visible: false }
//              PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.slowRequestDataTime}  #4311
            },
            State {
                name: Constants.CONSOLE_ST_AUX_STATE_1
                PropertyChanges { target: appToolBar; visible: false }
                PropertyChanges { target: tabBar; state: "tabBarInvisible" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0 }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: serviceMenu; visible: true }
                PropertyChanges { target: normalizationImage; visible: false }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_AUX_STATE_2
                PropertyChanges { target: appToolBar; visible: false }
                PropertyChanges { target: tabBar; state: "tabBarInvisible" }
                PropertyChanges { target: magnitudeSelector; enabled: false }
                PropertyChanges { target: magnitudeSelector; opacity: 0 }
                PropertyChanges { target: cumulatedBoard; state: "noViewCumulated" }
                PropertyChanges { target: brandName; visible: false }
                PropertyChanges { target: pressureTester; state: "noViewPressureTester" }
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
                PropertyChanges { target: serviceMenu; visible: true }
                PropertyChanges { target: normalizationImage; visible: false }
                PropertyChanges { target: emergencyPauseButton; visible: false }
                PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic"}
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            },
            State {
                name: Constants.CONSOLE_ST_DEFAULT
                PropertyChanges { target: saveScreen; state: "noViewSaveScreen" }
                PropertyChanges { target: applicationWindow; periodicInfoDelay: applicationWindow.quickRequestDataTime}
            }
        ]

        transitions: [
            Transition {
                to: Constants.CONSOLE_ST_READY
                ScriptAction{ script: saveScreenTimer.restart()}
            },
            Transition {
                to: Constants.CONSOLE_ST_SETTING
                ScriptAction{ script: Therapies.resolvePressureMetterIndicatorLimits()}  // #4324
            },
            Transition {
                to: Constants.CONSOLE_ST_EDITING
                ScriptAction{ script: saveScreenTimer.restart()}
            },
            Transition {
                to: Constants.CONSOLE_ST_PRESSURE_TEST
                ScriptAction{ script: saveScreenTimer.restart()}
            },
            Transition {
                to: Constants.CONSOLE_ST_SAVE_SCREEN
            },
            Transition {
                to: Constants.CONSOLE_ST_AUX_STATE_1
                ScriptAction{ script: {serviceMenu.freeButtonsClicked(serviceMenu.calibrationType); serviceMenu.protectedButtonsClicked(serviceMenu.calibrationType)}}  // TODO: create a funcion grouping that from service menu
            },
            Transition {
                to: Constants.CONSOLE_ST_AUX_STATE_2
                ScriptAction{ script: {serviceMenu.freeButtonsClicked(serviceMenu.calibrationType); serviceMenu.protectedButtonsClicked(serviceMenu.calibrationType)}}
            }
        ]


//        Timer {
//            id: requestDataTimer
//            interval: 1000
//            running: false
//            repeat: true
//            onTriggered: {
//                interval = requestDataTimerInterval

//                if(applicationWindow.interfaceSW === ""){
//                    consoleSocket.sendData(Constants.GET_VER)
//                    startUp.startUpAnimation1.playing = true
//                }
//                else if(Constants.calibrationPressure === 0){
//                    consoleSocket.sendData(Constants.GET_PAR)
//                }
//                else{
//                    consoleSocket.sendData(Constants.KEEP_ALIVE)
//                }
//            }
//            Component.onCompleted: console.log("Component.onCompleted: requestDataTimer            ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
//        }

        Timer {  /* #4332 */
            id: requestDataTimer
            interval: 1000
            running: false
            repeat: true
            onTriggered: {
                interval = requestDataTimerInterval
                consoleSocket.sendData(Constants.KEEP_ALIVE)
            }
            Component.onCompleted: console.log("Component.onCompleted: requestDataTimer            ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        StartUp{
            id: startUp
        }

        Tab_Bar{
            id: tabBar
            z: appToolBar.z +2//+ 1//1
            onOpacityChanged:  (tabBar.opacity === 1) ? applicationWindow.appToolBarEndPatch.opacity = 0 : applicationWindow.appToolBarEndPatch.opacity = 1 // ticket #4310 solved (10/06/21)
            Component.onCompleted: console.log("Component.onCompleted: tabBar                      ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        Tool_Bar{
            id: appToolBar
            z: memoryBoard.z + 2
            height: QtConstants.screenWidth * 0.07
            anchors.right: tabBar.left
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            Component.onCompleted: console.log("Component.onCompleted: appToolBar                  ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        Rectangle{  // ticket #4310 solved (10/06/21)
            id: appToolBarEndPatch
            anchors.right: appToolBar.right
            anchors.bottom: appToolBar.bottom
            width: 30
            height: appToolBar.height
            color: Storage.getAppDB(Constants.dbAppColor.mainBackColorId, "black")
            visible: false
            opacity: 0
            z: appToolBar.z + 1
        }

        MagnitudeSelector{
            id: magnitudeSelector
            y: QtConstants.magnitudeSelectorY
            width: QtConstants.screenWidth - tabBar.width
            height: QtConstants.magnitudeSelectorHeight
            z: 3
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "orange"
                visible: viewGrid
            }
            Component.onCompleted: console.log("Component.onCompleted: magnitudeSelector           ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        CumulatedBoard{
            id: cumulatedBoard
            y: (2 * magnitudeSelector.y) +  magnitudeSelector.height
            width: QtConstants.screenWidth - tabBar.width //1280 - 133
            height: QtConstants.screenHeight - (3 * magnitudeSelector.y) - magnitudeSelector.height - appToolBar.height
            Component.onCompleted: console.log("Component.onCompleted: cumulatedBoard              ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        TotalsBoard{
            id: totalsBoard
            visible: true
            x: 66
            y: parent.height * 0.5
            anchors.horizontalCenterOffset: -tabBar.width * 0.5
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0
            onAccepted: {
                appConsole.state = Constants.CONSOLE_ST_EDITING // not sure if it is necessary (kept since verification is very advanced)
                consoleSocket.sendData(Constants.CNL_SIM)
            }
            Component.onCompleted: console.log("Component.onCompleted: totalsBoard                 ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        WaitingBoard{
            id: waitingBoard
            width: QtConstants.screenWidth * 0.55
            anchors.top: parent.top
            anchors.topMargin: QtConstants.screenWidth * 0.17
            anchors.left: parent.left
            anchors.leftMargin: (parent.width - tabBar.width - waitingBoard.width) / 2
            visible: false
            Component.onCompleted: console.log("Component.onCompleted: waitingBoard                ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        HelpMenu{
            id: appHelpMenu
            width: QtConstants.screenWidth * 0.070
            anchors.left: parent.left
            anchors.leftMargin: width * 0.20
            Component.onCompleted: console.log("Component.onCompleted: appHelpMenu                 ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        NormalizationImage{
            id: normalizationImage
            height:100
            anchors.left: dcImage.left
            anchors.top: dcImage.bottom
            visible: true
            Component.onCompleted: console.log("Component.onCompleted: normalizationImage          ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        DCImage{
            id: dcImage
            y: cumulatedBoard.y
            x: appToolBar.helpButton.x * 0.8
            height: normalizationImage.height
            visible: normalizationImage.visible
            opacity: normalizationImage.opacity
            dcIconGif.currentFrame: normalizationImage.normalizationGif.currentFrame
            dcIconGif.visible: normalizationImage.normalizationGif.visible
            dcIconGif.playing: normalizationImage.normalizationGif.playing
            Component.onCompleted: console.log("Component.onCompleted: dcImage                     ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        GadgetMenu{
            id: gadgetMenu
            height: QtConstants.screenHeight * 0.12
            anchors.horizontalCenter: appToolBar.horizontalCenter
            anchors.bottom: appToolBar.top
            anchors.bottomMargin: appToolBar.height * 0.77
            z: 2
            Component.onCompleted: console.log("Component.onCompleted: gadgetMenu                  ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        BrandName{
            id: brandName
            z: 1
            height: (parent.height - appToolBar.height) * 0.2
            width: (parent.width - tabBar.width) * 0.6
            y:  (parent.height - appToolBar.height) * 0.465
            x: saveScreenModeX

            visible: true
            Component.onCompleted:{
                saveScreenModeX= ((parent.width - tabBar.width) - width) * 0.3
                runModeX = ((parent.width - tabBar.width) - width) * 0.5
                adjustingModeX = ((parent.width - tabBar.width) - width) * 0.7
                state = "saveScreenMode"
                console.log("Component.onCompleted: brandName                   ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
            }
        }

        AnimatedImage{
            id: mainBussyIndicator
            property bool running: false
            height: Math.round(brandName.height * 2.05)
            width: height
            visible: running
            anchors.centerIn: brandName
            anchors.horizontalCenterOffset: - brandName.businessName.contentWidth * 0.4
            source: visible ? Storage.getAppDB(Constants.dbAppIcon.busyIndicator, "") : "" // 12/2021
            asynchronous: true
            Component.onCompleted: console.log("Component.onCompleted: mainBussyIndicator          ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        PressureTester{
            id: pressureTester
            state: "noViewPressureTester"
            z: gadgetInOutEffect.z + 1
            Component.onCompleted: console.log("Component.onCompleted: pressureTester              ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        BloodVolume{
            id: bloodVolume
            state: "noViewBloodVolume"
            z: gadgetInOutEffect.z + 1
            Component.onCompleted: console.log("Component.onCompleted: noViewBloodVolume           ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        SaveScreen{
            id: saveScreen
            anchors.fill: parent
            Component.onCompleted: console.log("Component.onCompleted: saveScreen                  ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
            visible: true
        }

        DebugWindow{
            id: debug
            z:100
            Component.onCompleted: console.log("Component.onCompleted: debug                       ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        InputPanel {
            id: keyboard
            y: parent.height
            width: 0
            visible: false
            z: memoryBoard.z + 1

            Component.onCompleted: {
                console.log("Component.onCompleted: keyboard                    ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
                //not available here (just wrote down here for information)
                //console.log("languages: ", VirtualKeyboardSettings.availableLocales)
                //[ar_AR,bg_BG,cs_CZ,da_DK,de_DE,el_GR,en_GB,en_US,es_ES,es_MX,et_EE,fa_FA,fi_FI,fr_CA,fr_FR,he_IL,hi_IN,hr_HR,hu_HU,id_ID,it_IT,ja_JP,ko_KR,ms_MY,nb_NO,nl_NL,pl_PL,pt_BR,pt_PT,ro_RO,ru_RU,sk_SK,sl_SI,sq_AL,sr_SP,sv_SE,th_TH,tr_TR,uk_UA,vi_VN,zh_CN,zh_TW]
            }

            states: State {
                name: "visible";
                when: keyboard.active
                PropertyChanges {
                    target: keyboard
                    y: if(memoryBoard.visible){
                           (QtConstants.fullViewInputElementY + QtConstants.magnitudeSelectorY) +
                           (QtConstants.fullViewInputElementWith * QtConstants.fullViewInputElementAspectRatio) -
                            keyboard.height - (keyboard.height * 0.035) // memoryBottomBar.height (Walk around: resolve in better way)
                       }
                       else if(serviceMenu.visible & !serviceMenu.serviceMenuShowData.visible){
                           serviceMenu.y + serviceMenu.height - keyboard.height
                       }
                       else{
                           parent.height
                       }
                }
            }

            transitions: Transition {
                from: ""; // default initial state
                to: "visible";
                reversible: true; // toggle visibility with reversible: true;
                ParallelAnimation {
                    NumberAnimation {
                        properties: "y"
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        ServiceMenu{
            id: serviceMenu
            visible: false
            z: memoryBoard.z
            Component.onCompleted: {
                serviceMenu.serviceMenuShowDateTime.updateDateAndTime() // avoid a lot of simultaneous information changes when configuration date and time option is opened for the first time afer start up
                console.log("Component.onCompleted: serviceMenu                 ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
            }
        }

        EmergencyPauseButton{
            id: emergencyPauseButton
            visible: false
            width: Math.round(parent.width - tabBar.width)
            height: Math.round(parent.height - appToolBar.height)
            z:10
            Component.onCompleted: console.log("Component.onCompleted: emergencyPauseButton        ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        Memory{
            id: memoryBoard
            z:9
            MouseArea{
                id: patchMouseArea  // patch to solve uncontrolled virtual keypad activation
                height: parent.height * 0.04
                width: parent.width
                z: parent.z + 5
                onClicked: {
                  //console.log("Patch. Pending resolution...")
                }
            }
            Component.onCompleted: console.log("Component.onCompleted: memoryBoard                 ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

//
//      Walk aroud: resolve in better way
//
        Rectangle{
            id: memoryExternBottomBarReplication
            x: QtConstants.fullViewInputElementX
            y: QtConstants.fullViewInputElementY + QtConstants.magnitudeSelectorY + (QtConstants.fullViewInputElementWith * QtConstants.fullViewInputElementAspectRatio)
            width: QtConstants.fullViewInputElementWithtotalsIcon
            height: appToolBar.y - y
            color: applicationWindow.color
            visible: memoryBoard.visible
            border.color: "transparent"
            z: memoryBoard.z + 2
            Component.onCompleted: console.log("Component.onCompleted: memoryExtBottomBarRep       ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        SyringeCalculator{
            id: syringeCalculator
            visible: false
            z: gadgetInOutEffect.z + 1
            Component.onCompleted: console.log("Component.onCompleted: syringeCalculator           ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        SalineHemoTherapyCalculator{
            id: salineHemoTherapyCalculator
            visible: false
            z: gadgetInOutEffect.z + 1

            Component.onCompleted: console.log("Component.onCompleted: salineHemoTherapyCalculator ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
        }

        GadgetInOutEffect{
            id: gadgetInOutEffect
            z: gadgetMenu.z + 1
        }

        DatabaseInit{ // Create database if needed (place at the end to update data base first)
            Component.onCompleted: {
                applicationWindow.initLanguageSettings()
                console.log("Component.onCompleted: DatabaseInit                ", new Date().getHours(), ":", new Date().getMinutes(), ":", new Date().getSeconds())
            }
        }

        Rectangle{
            id: sendSebugCommad
            width: 100
            height: 100
            y: 500
            z:10000000
            visible: false
            color: "transparent"
            border.color: "orange"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    consoleSocket.sendData(Constants.SIMULATION_ERROR + ",1\r")
                    console.log("Debug message sended.........")
                }
            }
        }

//
//     Test area
//
        Rectangle{
            id: debugRectangle
            y:0
            width:100
            height: 100
            z:10000000
            visible: false
            color: "transparent"
            border.color: "orange"

            MouseArea{
                anchors.fill: parent

                onClicked: {
//                  console.log("", )
//                    Therapies.salineBublingTime()
//                    Therapies.salineBublingTime2()
//                    applicationWindow.skipError = ! applicationWindow.skipError
                }
                onPressAndHold: {
//                  console.log("", )

                }
            }
        }

        TextArea {
            id: debugTextArea
            width: appConsole.width * 0.5
            height: 150
            z:1000000
            visible: false
            color: "white"
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 10


            text: {
                "controlBoardSW: " + applicationWindow.controlBoardSW + debugTextArea.font.family +
//                "\ninterfaceSW: " + applicationWindow.interfaceSW +
//                "\nconsoleSW: " + Constants.consoleSW +
//                "\ndataBaseVer: " + Constants.dataBaseVer +
//                "\nappConsole.state: " + appConsole.state +
//                "\ntotalsBoard.state:  " + totalsBoard.state +
//                "\nperiodicInfoDelay: " + periodicInfoDelay +
//                "\ntabBar.opacity: " + tabBar.opacity +


//              "\nserviceMenu.resetNeeded" + serviceMenu.resetNeeded +
//              "\npressureTester.state: " +  pressureTester.state +
//              "\ngadgetMenu.state: " +  gadgetMenu.state +
//              "\nmagnitudeSelector.state: " +  magnitudeSelector.state +
//              "\nmagnitudeSelector.inputFlow.slider.value: " +  magnitudeSelector.inputFlow.slider.value +
//              "\nmagnitudeSelector.inputFlow.saveStamp: " + magnitudeSelector.inputFlow.saveStamp +
//              "\nmagnitudeSelector.currentSelectedItem: " + magnitudeSelector.currentSelectedItem +
//              "\nappHelpMenu.alternativeHelpVideoTutorialFile: " + appHelpMenu.alternativeHelpVideoTutorialFile +
//              "\nmagnitudeSelector.maxAvailableFlow: " + magnitudeSelector.maxAvailableFlow +
//              "\nmagnitudeSelector.inputTotalConcentration.changeSliderRangeButton.opacity: " + magnitudeSelector.inputTotalConcentration.changeSliderRangeButton.opacity +
//              "\nmagnitudeSelector.inputTotalConcentration.changeSliderRangeButton.visible: " + magnitudeSelector.inputTotalConcentration.changeSliderRangeButton.visible +
//              "\nmagnitudeSelector.inputO3.multilabelMainLabel: " + magnitudeSelector.inputO3.multilabelMainLabel +
//              "\nmagnitudeSelector.inputO3.multilabelView: " + magnitudeSelector.inputO3.multilabelView +
//              "\nmagnitudeSelector.inputO3.buttonsVisibility: " + magnitudeSelector.inputO3.buttonsVisibility +
//              "\nbrandName.width: " + brandName.width +
//              "\nbusinessName.width: " + brandName.businessName.width +
//              "\nbrandName.businessName.contentWidth: " + brandName.businessName.contentWidth
//              "\normalizationImage.state: " + normalizationImage.state
//              "\npressureTester.state: " + pressureTester.state
//              "\npressureIndicator.state: " +cumulatedBoard.pressureIndicator.state
//              "\ngenerationTime:" +applicationWindow.generationTime +
//              "\ninputO3.state: " + magnitudeSelector.inputO3.state +
//              "\nselectedLanguage: " + selectedLanguage +
//              "\nselectedLanguageId: " + selectedLanguageId
                "\n"
            }
            Rectangle{
                anchors.fill: parent
                color: "#00000000"
                border.color: "pink"
                opacity: 0.6
            }
        }
    }  // end of appConsole item

}

