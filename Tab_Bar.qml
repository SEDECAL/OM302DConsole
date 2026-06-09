// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants
import "Configurator.js" as Configurator
import "Singletons"

Rectangle{
    id: tabBar

    property alias buttonASubMenu: buttonASubMenu
    property alias buttonBSubMenu: buttonBSubMenu
    property alias buttonCSubMenu: buttonCSubMenu
    property alias buttonESubMenu: buttonESubMenu
    property alias buttonFSubMenu: buttonFSubMenu
    property alias buttonGSubMenu: buttonGSubMenu
    property alias fakeButton: fakeButton
    property alias buttonA: buttonA
    property alias buttonB: buttonB
    property alias buttonC: buttonC
    property alias buttonD: buttonD
    property alias buttonE: buttonE
    property alias buttonF: buttonF
    property alias buttonG: buttonG

    property int buttonASubMenuItems: 2
    property int buttonBSubMenuItems: 2
    property int buttonCSubMenuItems: 2
    property int buttonESubMenuItems: 2
    property int buttonFSubMenuItems: 3
    property int buttonGSubMenuItems: 2
    property int blinkEfectInterval: 200
    property int subMenuTransitionTime: 300
    property int subMenuTimeOutInterval: 4000

    property double sizeIncrementOnSelection: 0.3
    property string selectedOption: ""
    property color backColor: Storage.getAppDB(Constants.dbAppColor.tabBarBackId, "black")

    readonly property int tabBarWidth: QtConstants.tabBarWidth
    readonly property int numberOfButtons: QtConstants.tabBarNumberOfButtons
    readonly property int marginBetweenButtons: QtConstants.tabBarMarginBetweenButtons

    function blinkEffect(){
        backgroundRectangle.state = "startBlinkEffect"
        subMenuDummyRectangleForBlinkEffect.state = "startBlinkEffect"
    }

    function interChangeIcons(buttonCode){
        switch(buttonCode){
        case Constants.option1_1Id:
            buttonA.tabButtonSubmenuImage.source = buttonA_1.tabButtonImage.source
            buttonA.state = "pressedWithSubmenu"
            break
        case Constants.option1_2Id:
            buttonA.tabButtonSubmenuImage.source = buttonA_2.tabButtonImage.source
            buttonA.state = "pressedWithSubmenu"
            break
        case Constants.option3_1Id:
            buttonB.tabButtonSubmenuImage.source = buttonB_1.tabButtonImage.source
            buttonB.state = "pressedWithSubmenu"
            break
        case Constants.option3_2Id:
            buttonB.tabButtonSubmenuImage.source = buttonB_2.tabButtonImage.source
            buttonB.state = "pressedWithSubmenu"
            break
        case Constants.option4_1Id:
            buttonC.tabButtonSubmenuImage.source = buttonC_1.tabButtonImage.source
            buttonC.state = "pressedWithSubmenu"
            break
        case Constants.option4_2Id:
            buttonC.tabButtonSubmenuImage.source = buttonC_2.tabButtonImage.source
            buttonC.state = "pressedWithSubmenu"
            break
        case Constants.option5_1Id:
            buttonE.tabButtonSubmenuImage.source = buttonE_1.tabButtonImage.source
            buttonE.state = "pressedWithSubmenu"
            break
        case Constants.option5_2Id:
            buttonE.tabButtonSubmenuImage.source = buttonE_2.tabButtonImage.source
            buttonE.state = "pressedWithSubmenu"
            break
        case Constants.option6_1Id:
            buttonF.tabButtonSubmenuImage.source = buttonF_1.tabButtonImage.source
            buttonF.state = "pressedWithSubmenu"
            break
        case Constants.option6_2Id:
            buttonF.tabButtonSubmenuImage.source = buttonF_2.tabButtonImage.source
            buttonF.state = "pressedWithSubmenu"
            break
        case Constants.option6_3Id:
            buttonF.tabButtonSubmenuImage.source = buttonF_3.tabButtonImage.source
            buttonF.state = "pressedWithSubmenu"
            break
        case Constants.option7_1Id:
            buttonG.tabButtonSubmenuImage.source = buttonG_1.tabButtonImage.source
            buttonG.state = "pressedWithSubmenu"
            break
        case Constants.option7_2Id:
            buttonG.tabButtonSubmenuImage.source = buttonG_2.tabButtonImage.source
            buttonG.state = "pressedWithSubmenu"
            break
        }
    }

    function closeSubmenus() {
        buttonASubMenu.state = "buttonASubmenuHide"
        buttonBSubMenu.state = "buttonBSubmenuHide"
        buttonCSubMenu.state = "buttonCSubmenuHide"
        buttonESubMenu.state = "buttonESubmenuHide"
        buttonFSubMenu.state = "buttonFSubmenuHide"
        buttonGSubMenu.state = "buttonGSubmenuHide"
    }

    function unpressAll(){
        buttonA.state = "unpressed"
        buttonB.state = "unpressed"
        buttonC.state = "unpressed"
        buttonE.state = "unpressed"
        buttonD.state = "unpressed"
        buttonF.state = "unpressed"
        buttonG.state = "unpressed"
        selectedOption= "" // pendig for completelly validaion (needed for help managing) ..... delete this comment when proceed
    }

    function startSubMenuTimeOut()
    {
        subMenuTimeOut.restart()
    }

    function tabButtonPressed(buttonCode) {
        subMenuTimeOut.stop()
        appHelpMenu.state = "HideHelp"
        unpressAll()
        closeSubmenus()
        interChangeIcons(buttonCode)
        selectedOption = buttonCode

        if(buttonCode !== fakeButton.tabButtonName){
            Configurator.configureTherapy(buttonCode)
            Configurator.initTherapy()
        }

        if (Constants.option7Id === buttonCode){
            appToolBar.timeLabel.state = "timeLabelInvisible"
            appToolBar.dateLabel.state = "dateLabelInvisible"
        }
        else if ((Constants.option7_1Id === buttonCode) || (Constants.option7_2Id === buttonCode)){
            appToolBar.timeLabel.state = "timeLabelPositionShifted"
            appToolBar.dateLabel.state = "dateLabelPositionShifted"
            applicationWindow.appToolBarEndPatch.visible = true  // ticket #4310 solved (10/06/21)
        }
        else{
            appToolBar.timeLabel.state = "timeLabelPositionOriginal"
            appToolBar.dateLabel.state = "dateLabelPositionOriginal"
            applicationWindow.appToolBarEndPatch.visible = false  // ticket #4310 solved (10/06/21)
        }
    }

    function temporalDisable(miliseconds){
        tabBar.enabled = false
        delayedEnable.duration = miliseconds
        delayedEnable.start()
    }

    states: [
        State {
            name: "tabBarEabled"
            PropertyChanges { target: tabBar; enabled: true }
            PropertyChanges { target: tabBar; opacity: 1 }
            PropertyChanges { target: tabBar; color: backColor }
            PropertyChanges { target: tabBar; visible: true }
            PropertyChanges { target: buttonASubMenu; visible: true }
            PropertyChanges { target: buttonBSubMenu; visible: true }
            PropertyChanges { target: buttonCSubMenu; visible: true }
            PropertyChanges { target: buttonESubMenu; visible: true }
            PropertyChanges { target: buttonFSubMenu; visible: true }
            PropertyChanges { target: buttonGSubMenu; visible: true }
            PropertyChanges { target: backgroundRectangle; visible: true }
        },
        State {
            name: "tabBarDisabled"
            PropertyChanges { target: tabBar; enabled: false }
            PropertyChanges { target: tabBar; opacity: 0.2 }
            PropertyChanges { target: tabBar; color: "transparent" }
            PropertyChanges { target: tabBar; visible: true }
            PropertyChanges { target: buttonASubMenu; visible: false }
            PropertyChanges { target: buttonBSubMenu; visible: false }
            PropertyChanges { target: buttonCSubMenu; visible: false }
            PropertyChanges { target: buttonESubMenu; visible: false }
            PropertyChanges { target: buttonFSubMenu; visible: false }
            PropertyChanges { target: buttonGSubMenu; visible: false }
            PropertyChanges { target: backgroundRectangle; visible: false }
        },
        State {
            name: "tabBarReset"
            PropertyChanges { target: tabBar; enabled: true }
            PropertyChanges { target: tabBar; opacity: 1 }
            PropertyChanges { target: tabBar; color: backColor }
            PropertyChanges { target: tabBar; visible: true }
            PropertyChanges { target: buttonASubMenu; visible: true }
            PropertyChanges { target: buttonBSubMenu; visible: true }
            PropertyChanges { target: buttonCSubMenu; visible: true }
            PropertyChanges { target: buttonESubMenu; visible: true }
            PropertyChanges { target: buttonFSubMenu; visible: true }
            PropertyChanges { target: buttonGSubMenu; visible: true }
            PropertyChanges { target: backgroundRectangle; visible: true }
        },
        State {
            name: "tabBarInvisible"
            PropertyChanges { target: tabBar; visible: false }
            PropertyChanges { target: buttonASubMenu; visible: false }
            PropertyChanges { target: buttonBSubMenu; visible: false }
            PropertyChanges { target: buttonCSubMenu; visible: false }
            PropertyChanges { target: buttonESubMenu; visible: false }
            PropertyChanges { target: buttonFSubMenu; visible: false }
            PropertyChanges { target: buttonGSubMenu; visible: false }
            PropertyChanges { target: backgroundRectangle; visible: false }
        }
    ]
    transitions: [
        Transition {
            to: "tabBarReset"
            ScriptAction { script: {
                    tabBar.unpressAll();
                    tabBar.closeSubmenus();
                    tabButtonPressed(fakeButton.tabButtonName);
                }
            }
        }
    ]

    PropertyAnimation{ id: delayedEnable; target: tabBar; property: "enabled"; to: true; duration: 0 }

    visible: true
    width: tabBarWidth + marginBetweenButtons
    height: parent.height
    color: backColor
    anchors.right: parent.right

    Rectangle{
        id: backgroundRectangle // to hide submenus
        z: 1
        color: tabBar.color
        height: tabBar.height
        width: tabBar.width


        states: [
            State {
                name: "startBlinkEffect"
            },
            State {
                name: "stopBlinkEffect"
            }
        ]
        transitions: [
            Transition {
                to: "startBlinkEffect"
                SequentialAnimation{
                    PropertyAnimation { target: backgroundRectangle; property: "color"; to: Storage.getAppDB(Constants.dbAppColor.tabBarBlinkEffect, "black") ; duration: blinkEfectInterval }
                    PropertyAnimation { target: backgroundRectangle; property: "state"; to: "stopBlinkEffect" }
                }
            },
            Transition {
                to: "stopBlinkEffect"
                PropertyAnimation { target: backgroundRectangle; property: "color"; to: tabBar.color ; duration: 100 }
            }
        ]
    }

    Rectangle{
        id: subMenuDummyRectangleForBlinkEffect
        color: "transparent"
        height: 0
        width: 0

        states: [
            State {
                name: "startBlinkEffect"
            },
            State {
                name: "stopBlinkEffect"
            }
        ]
        transitions: [
            Transition {
                to: "startBlinkEffect"
                SequentialAnimation{
                    PropertyAnimation { target: subMenuDummyRectangleForBlinkEffect; property: "color"; to: Storage.getAppDB(Constants.dbAppColor.tabBarBlinkEffect, "black") ; duration: blinkEfectInterval }
                    PropertyAnimation { target: subMenuDummyRectangleForBlinkEffect; property: "state"; to: "stopBlinkEffect" }
                }
            },
            Transition {
                to: "stopBlinkEffect"
                PropertyAnimation { target: subMenuDummyRectangleForBlinkEffect; property: "color"; to: "transparent" ; duration: 100 }
            }
        ]
    }

    Rectangle{
        width: tabBarWidth
        height: parent.height - marginBetweenButtons
        x: marginBetweenButtons * 0.5
        y: marginBetweenButtons * 0.5
        color: "transparent"
        z:1
        TabButtonItem{
            id: fakeButton
            visible: false
            tabButtonName: "fakeButton"
            z: 1
        }
        TabButtonItem{
            id: buttonA
            y: marginBetweenButtons * 0.5
            z: fakeButton.z
            tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption1Id, "black")
            tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option1Id, "")
            tabButtonName: Constants.option1Id
            distanceBetweenButtons: marginBetweenButtons
            deltaSizeIncrementOnSelection: sizeIncrementOnSelection
        }
        TabButtonItem{
            id: buttonB
            z: fakeButton.z
            tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption3Id, "black")
            anchors.top: buttonA.bottom
            tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option3Id, "")
            tabButtonName: Constants.option3Id
            distanceBetweenButtons: marginBetweenButtons
            deltaSizeIncrementOnSelection: sizeIncrementOnSelection
        }
        TabButtonItem{
            id: buttonC
            z: fakeButton.z
            tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption4Id, "black")
            anchors.top: buttonB.bottom
            tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option4Id, "")
            tabButtonName: Constants.option4Id
            distanceBetweenButtons: marginBetweenButtons
            deltaSizeIncrementOnSelection: sizeIncrementOnSelection
        }
        TabButtonItem{
            id: buttonD
            z: fakeButton.z
            tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption2Id, "black")
            anchors.top: buttonC.bottom
            tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option2Id, "")
            tabButtonName: Constants.option2Id
            distanceBetweenButtons: marginBetweenButtons
            deltaSizeIncrementOnSelection: sizeIncrementOnSelection
        }
        TabButtonItem{
            id: buttonE
            z: fakeButton.z
            tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption5Id, "black")
            anchors.top: buttonD.bottom
            tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option5Id, "")
            tabButtonName: Constants.option5Id
            distanceBetweenButtons: marginBetweenButtons
            deltaSizeIncrementOnSelection: sizeIncrementOnSelection
        }
        TabButtonItem{
            id: buttonF
            z: fakeButton.z
            tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption6Id, "black")
            anchors.top: buttonE.bottom
            tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option6Id, "")
            tabButtonName: Constants.option6Id
            distanceBetweenButtons: marginBetweenButtons
            deltaSizeIncrementOnSelection: sizeIncrementOnSelection
        }
        TabButtonItem{
            id: buttonG
            z: fakeButton.z
            tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption7Id, "black")
            anchors.top: buttonF.bottom
            tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option7Id, "")
            tabButtonName: Constants.option7Id
            distanceBetweenButtons: marginBetweenButtons
            deltaSizeIncrementOnSelection: sizeIncrementOnSelection
        }
        Rectangle{
            id: buttonARectangleForBlinkEffect
            z: buttonA.z - 1
            anchors.centerIn: buttonA
            radius: buttonA.tabButton.radius
            width: buttonA.width + marginBetweenButtons
            height: buttonA.height + marginBetweenButtons
            color: subMenuDummyRectangleForBlinkEffect.color

        }
        Rectangle{
            id: buttonBRectangleForBlinkEffect
            z: buttonB.z - 1
            anchors.centerIn: buttonB
            radius: buttonB.tabButton.radius
            width: buttonB.width + marginBetweenButtons
            height: buttonB.height + marginBetweenButtons
            color: subMenuDummyRectangleForBlinkEffect.color
        }
        Rectangle{
            id: buttonCRectangleForBlinkEffect
            z: buttonC.z - 1
            anchors.centerIn: buttonC
            radius: buttonC.tabButton.radius
            width: buttonC.width + marginBetweenButtons
            height: buttonC.height + marginBetweenButtons
            color: subMenuDummyRectangleForBlinkEffect.color
        }
        Rectangle{
            id: buttonDRectangleForBlinkEffect
            z: buttonD.z - 1
            anchors.centerIn: buttonD
            radius: buttonD.tabButton.radius
            width: buttonD.width + marginBetweenButtons
            height: buttonD.height + marginBetweenButtons
            color: subMenuDummyRectangleForBlinkEffect.color
        }
        Rectangle{
            id: buttonERectangleForBlinkEffect
            z: buttonE.z - 1
            anchors.centerIn: buttonE
            radius: buttonE.tabButton.radius
            width: buttonE.width + marginBetweenButtons
            height: buttonE.height + marginBetweenButtons
            color: subMenuDummyRectangleForBlinkEffect.color
        }
        Rectangle{
            id: buttonFRectangleForBlinkEffect
            z: buttonF.z - 1
            anchors.centerIn: buttonF
            radius: buttonF.tabButton.radius
            width: buttonF.width + marginBetweenButtons
            height: buttonF.height + marginBetweenButtons
            color: subMenuDummyRectangleForBlinkEffect.color
        }
        Rectangle{
            id: buttonGRectangleForBlinkEffect
            z: buttonG.z - 1
            anchors.centerIn: buttonG
            radius: buttonG.tabButton.radius
            width: buttonG.width + marginBetweenButtons
            height: buttonG.height + marginBetweenButtons
            color: subMenuDummyRectangleForBlinkEffect.color
        }
    }

    Item{
        id: buttonASubMenu
        y: buttonA.y + (marginBetweenButtons * 0.5)
        width: tabBarWidth * buttonASubMenuItems
        height: tabBarWidth
        state: "buttonASubmenuHide"

        states: [
            State {
                name: "buttonASubmenuShow"
                PropertyChanges { target: buttonASubMenu; enabled: true }
                PropertyChanges { target: submenu1BackgroundRectangle; visible: true }
            },
            State {
                name: "buttonASubmenuHide"
                PropertyChanges { target: buttonASubMenu; enabled: false }
                PropertyChanges { target: submenu1BackgroundRectangle; visible: false }
            }
        ]
        transitions: [
            Transition {
                to: "buttonASubmenuShow"
                SequentialAnimation{
                    PropertyAnimation { target: buttonASubMenu; property: "x"; to: -tabBarWidth * (buttonASubMenuItems + 0.3); duration: subMenuTransitionTime}
                    ScriptAction{ script: startSubMenuTimeOut() }
                }
            },
            Transition {
                to: "buttonASubmenuHide"
                PropertyAnimation { target: buttonASubMenu; property: "x"; to: 0; duration: subMenuTransitionTime}
            }
        ]

        Row{
            id: submenu1Row
            width: tabBarWidth
            z: buttonASubMenu.z + 1

            TabButtonItem{
                id: buttonA_1
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption1_1Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option1_1Id, "")
                tabButtonName: Constants.option1_1Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
            TabButtonItem{
                id: buttonA_2
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption1_2Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option1_2Id, "")
                tabButtonName: Constants.option1_2Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
        }
        Rectangle{
            id: submenu1BackgroundRectangle
            radius: buttonA_1.tabButton.radius
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonASubMenu.height + marginBetweenButtons
            width: buttonASubMenu.width + marginBetweenButtons
            anchors.centerIn: parent
        }
        Rectangle{
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonASubMenu.height + marginBetweenButtons
            width: buttonA_1.tabButton.radius * 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: -width * 0.5
        }
    }

    Item{
        id: buttonBSubMenu
        y: buttonB.y + (marginBetweenButtons * 0.5)
        width: tabBarWidth * buttonBSubMenuItems
        height: tabBarWidth
        state: "buttonBSubmenuHide"

        states: [
            State {
                name: "buttonBSubmenuShow"
                PropertyChanges { target: buttonBSubMenu; enabled: true }
                PropertyChanges { target: submenu3BackgroundRectangle; visible: true }
            },
            State {
                name: "buttonBSubmenuHide"
                PropertyChanges { target: buttonBSubMenu; enabled: false }
                PropertyChanges { target: submenu3BackgroundRectangle; visible: false }
            }
        ]
        transitions: [
            Transition {
                to: "buttonBSubmenuShow"
                SequentialAnimation{
                    PropertyAnimation { target: buttonBSubMenu; property: "x"; to: -tabBarWidth * (buttonBSubMenuItems + 0.3); duration: subMenuTransitionTime}
                    ScriptAction{ script: startSubMenuTimeOut() }
                }
            },
            Transition {
                to: "buttonBSubmenuHide"
                PropertyAnimation { target: buttonBSubMenu; property: "x"; to: 0; duration: subMenuTransitionTime}
            }
        ]

        Row{
            id: submenu3Row
            width: tabBarWidth
            z: buttonBSubMenu.z + 1

            TabButtonItem{
                id: buttonB_1
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption3_1Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option3_1Id, "")
                tabButtonName: Constants.option3_1Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
            TabButtonItem{
                id: buttonB_2
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption3_2Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option3_2Id, "")
                tabButtonName: Constants.option3_2Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
        }
        Rectangle{
            id: submenu3BackgroundRectangle
            radius: buttonB_1.tabButton.radius
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonBSubMenu.height + marginBetweenButtons
            width: buttonBSubMenu.width + marginBetweenButtons
            anchors.centerIn: parent
        }
        Rectangle{
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonBSubMenu.height + marginBetweenButtons
            width: buttonB_1.tabButton.radius * 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: -width * 0.5
        }
    }

    Item{
        id: buttonCSubMenu
        y: buttonC.y + (marginBetweenButtons * 0.5)
        width: tabBarWidth * buttonCSubMenuItems
        height: tabBarWidth
        state: "buttonCSubmenuHide"

        states: [
            State {
                name: "buttonCSubmenuShow"
                PropertyChanges { target: buttonCSubMenu; enabled: true }
                PropertyChanges { target: submenu4BackgroundRectangle; visible: true }
            },
            State {
                name: "buttonCSubmenuHide"
                PropertyChanges { target: buttonCSubMenu; enabled: false }
                PropertyChanges { target: submenu4BackgroundRectangle; visible: false }
            }
        ]
        transitions: [
            Transition {
                to: "buttonCSubmenuShow"
                SequentialAnimation{
                    PropertyAnimation { target: buttonCSubMenu; property: "x"; to: -tabBarWidth * (buttonCSubMenuItems + 0.3); duration: subMenuTransitionTime}
                    ScriptAction{ script: startSubMenuTimeOut() }
                }
            },
            Transition {
                to: "buttonCSubmenuHide"
                PropertyAnimation { target: buttonCSubMenu; property: "x"; to: 0; duration: subMenuTransitionTime}
            }
        ]

        Row{
            id: submenu4Row
            width: tabBarWidth
            z: buttonCSubMenu.z + 1

            TabButtonItem{
                id: buttonC_1
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption4_1Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option4_1Id, "")
                tabButtonName: Constants.option4_1Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
            TabButtonItem{
                id: buttonC_2
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption4_2Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option4_2Id, "")
                tabButtonName: Constants.option4_2Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
        }
        Rectangle{
            id: submenu4BackgroundRectangle
            radius: buttonC_1.tabButton.radius
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonCSubMenu.height + marginBetweenButtons
            width: buttonCSubMenu.width + marginBetweenButtons
            anchors.centerIn: parent
        }
        Rectangle{
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonCSubMenu.height + marginBetweenButtons
            width: buttonC_1.tabButton.radius * 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: -width * 0.5
        }
    }

    Item{
        id: buttonESubMenu
        y: buttonE.y + (marginBetweenButtons * 0.5)
        width: tabBarWidth * buttonESubMenuItems
        height: tabBarWidth
        state: "buttonESubmenuHide"

        states: [
            State {
                name: "buttonESubmenuShow"
                PropertyChanges { target: buttonESubMenu; enabled: true }
                PropertyChanges { target: submenu5BackgroundRectangle; visible: true }
            },
            State {
                name: "buttonESubmenuHide"
                PropertyChanges { target: buttonESubMenu; enabled: false }
                PropertyChanges { target: submenu5BackgroundRectangle; visible: false }
            }
        ]
        transitions: [
            Transition {
                to: "buttonESubmenuShow"
                SequentialAnimation{
                    PropertyAnimation { target: buttonESubMenu; property: "x"; to: -tabBarWidth * (buttonESubMenuItems + 0.3); duration: subMenuTransitionTime}
                    ScriptAction{ script: startSubMenuTimeOut() }
                }
            },
            Transition {
                to: "buttonESubmenuHide"
                PropertyAnimation { target: buttonESubMenu; property: "x"; to: 0; duration: subMenuTransitionTime}
            }
        ]

        Row{
            id: submenu5Row
            width: tabBarWidth
            z: buttonESubMenu.z + 1

            TabButtonItem{
                id: buttonE_1
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption5_1Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option5_1Id, "")
                tabButtonName: Constants.option5_1Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
            TabButtonItem{
                id: buttonE_2
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption5_2Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option5_2Id, "")
                tabButtonName: Constants.option5_2Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
        }
        Rectangle{
            id: submenu5BackgroundRectangle
            radius: buttonE_1.tabButton.radius
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonESubMenu.height + marginBetweenButtons
            width: buttonESubMenu.width + marginBetweenButtons
            anchors.centerIn: parent
        }
        Rectangle{
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonESubMenu.height + marginBetweenButtons
            width: buttonE_1.tabButton.radius * 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: -width * 0.5
        }
    }

    Item{
        id: buttonFSubMenu
        y: buttonF.y + (marginBetweenButtons * 0.5)
        width: tabBarWidth * buttonFSubMenuItems
        height: tabBarWidth
        state: "buttonFSubmenuHide"

        states: [
            State {
                name: "buttonFSubmenuShow"
                PropertyChanges { target: buttonFSubMenu; enabled: true }
                PropertyChanges { target: submenu6BackgroundRectangle; visible: true }
            },
            State {
                name: "buttonFSubmenuHide"
                PropertyChanges { target: buttonFSubMenu; enabled: false }
                PropertyChanges { target: submenu6BackgroundRectangle; visible: false }
            }
        ]
        transitions: [
            Transition {
                to: "buttonFSubmenuShow"
                SequentialAnimation{
                    PropertyAnimation { target: buttonFSubMenu; property: "x"; to: -tabBarWidth * (buttonFSubMenuItems + 0.3); duration: subMenuTransitionTime}
                    ScriptAction{ script: startSubMenuTimeOut() }
                }
            },
            Transition {
                to: "buttonFSubmenuHide"
                PropertyAnimation { target: buttonFSubMenu; property: "x"; to: 0; duration: subMenuTransitionTime}
            }
        ]

        Row{
            id: submenu6Row
            width: tabBarWidth
            z: buttonFSubMenu.z + 1

            TabButtonItem{
                id: buttonF_1
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption6_1Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option6_1Id, "")
                tabButtonName: Constants.option6_1Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
            TabButtonItem{
                id: buttonF_2
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption6_2Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option6_2Id, "")
                tabButtonName: Constants.option6_2Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
            TabButtonItem{
                id: buttonF_3
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption6_3Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option6_3Id, "")
                tabButtonName: Constants.option6_3Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
        }
        Rectangle{
            id: submenu6BackgroundRectangle
            radius: buttonF_1.tabButton.radius
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonFSubMenu.height + marginBetweenButtons
            width: buttonFSubMenu.width + marginBetweenButtons
            anchors.centerIn: parent
        }
        Rectangle{
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonFSubMenu.height + marginBetweenButtons
            width: buttonF_1.tabButton.radius * 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: -width * 0.5
        }
    }

    Item{
        id: buttonGSubMenu
        y: buttonG.y + (marginBetweenButtons * 0.5)
        width: tabBarWidth * buttonGSubMenuItems
        height: tabBarWidth
        state: "buttonGSubmenuHide"

        states: [
            State {
                name: "buttonGSubmenuShow"
                PropertyChanges { target: buttonGSubMenu; enabled: true }
                PropertyChanges { target: submenu7BackgroundRectangle; visible: true }
            },
            State {
                name: "buttonGSubmenuHide"
                PropertyChanges { target: buttonGSubMenu; enabled: false }
                PropertyChanges { target: submenu7BackgroundRectangle; visible: false }
            }
        ]
        transitions: [
            Transition {
                to: "buttonGSubmenuShow"
                SequentialAnimation{
                    PropertyAnimation { target: buttonGSubMenu; property: "x"; to: -tabBarWidth * (buttonGSubMenuItems + 0.3); duration: subMenuTransitionTime }
                    ScriptAction{ script: startSubMenuTimeOut() }
                }
            },
            Transition {
                to: "buttonGSubmenuHide"
                PropertyAnimation { target: buttonGSubMenu; property: "x"; to: 0; duration: subMenuTransitionTime }
            }
        ]

        Row{
            id: submenu7Row
            width: tabBarWidth
            z: buttonGSubMenu.z + 1

            TabButtonItem{
                id: buttonG_1
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption7_1Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option7_1Id, "")
                tabButtonName: Constants.option7_1Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
            TabButtonItem{
                id: buttonG_2
                tabButton.color: Storage.getAppDB(Constants.dbAppColor.tabBarOption7_2Id, "black")
                tabButtonImage.source: Storage.getAppDB(Constants.dbAppIcon.option7_2Id, "")
                tabButtonName: Constants.option7_2Id
                distanceBetweenButtons: marginBetweenButtons
                changeSizeOnClick: false
            }
        }
        Rectangle{
            id: submenu7BackgroundRectangle
            radius: buttonG_1.tabButton.radius
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonGSubMenu.height + marginBetweenButtons
            width: buttonGSubMenu.width + marginBetweenButtons
            anchors.centerIn: parent
        }
        Rectangle{
            color: subMenuDummyRectangleForBlinkEffect.color
            height: buttonGSubMenu.height + marginBetweenButtons
            width: buttonG_1.tabButton.radius * 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: -width * 0.5
        }
    }

    Timer{
        id: subMenuTimeOut
        interval: subMenuTimeOutInterval
        onTriggered: {
            running = false
            if(buttonGSubMenu.state === "buttonGSubmenuShow")
            {
                appToolBar.timeLabel.state = "timeLabelPositionShifted"
                appToolBar.dateLabel.state = "dateLabelPositionShifted"
            }
            closeSubmenus()
        }
    }
}
