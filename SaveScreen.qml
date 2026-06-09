// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard.Styles 2.2
import QtQuick.VirtualKeyboard.Settings 2.2

import "Constants.js" as Constants
import "DebugConstants.js" as DC
import "Therapies.js" as Therapies
import "storage.js" as Storage

Item{
    id: saveScreen

    property alias circularButtonE: circularButtonE
    property alias saveScreenNormalizationImage: saveScreenNormalizationImage

    property int buttonRadius: 4
    property int xOffset: (parent.height * 0.8) - (buttomSize * 0.5)//640 - (buttomSize * 0.5)
    property int yOffset: (parent.height * 0.5) - (buttomSize * 0.5) // 400 - (buttomSize * 0.5)
    property int buttomSize: parent.height * 0.1
    property int circularMenuRadius: (parent.height * 0.34)//275
    property int numberOfButtons: 8
    property int transitionTime: 800
    property int saveScreenTimeOut: 10000

    property double angle: 2 * 3.1416 / numberOfButtons
    property double angleOffset: (angle * 1) + 3.1416

    property string lastButtomPressed: ""

    property variant buttomOiginX: [0, 0, 0, 0, 0, 0, 0, 0]
    property variant buttomOiginY: [0, 0, 0, 0, 0, 0, 0, 0]
    property variant buttomEndX:   [0, 0, 0, 0, 0, 0, 0, 0]
    property variant buttomEndY:   [0, 0, 0, 0, 0, 0, 0, 0]

    function pressButtomSimulation(){
        switch(lastButtomPressed){
        case "circularButtonA":
            tabBar.buttonA.tabButtonPressedActions()
            break
        case "circularButtonB":
            tabBar.buttonB.tabButtonPressedActions()
            break
        case "circularButtonC":
            tabBar.buttonC.tabButtonPressedActions()
            break
        case "circularButtonD":
            tabBar.buttonD.tabButtonPressedActions()
            break
        case "circularButtonE":
            tabBar.buttonE.tabButtonPressedActions()
            break
        case "circularButtonF":
            tabBar.buttonF.tabButtonPressedActions()
            break
        case "circularButtonG":
            tabBar.buttonG.tabButtonPressedActions()
            break
        }
    }

    Component.onCompleted: {
        circularButtonA.x = xOffset + (circularMenuRadius * Math.cos((angle * 0) + angleOffset))
        circularButtonA.y = yOffset + (circularMenuRadius * Math.sin((angle * 0) + angleOffset))
        circularButtonB.x = xOffset + (circularMenuRadius * Math.cos((angle * 1) + angleOffset))
        circularButtonB.y = yOffset + (circularMenuRadius * Math.sin((angle * 1) + angleOffset))
        circularButtonC.x = xOffset + (circularMenuRadius * Math.cos((angle * 2) + angleOffset))
        circularButtonC.y = yOffset + (circularMenuRadius * Math.sin((angle * 2) + angleOffset))
        circularButtonD.x = xOffset + (circularMenuRadius * Math.cos((angle * 3) + angleOffset))
        circularButtonD.y = yOffset + (circularMenuRadius * Math.sin((angle * 3) + angleOffset))
        circularButtonE.x = xOffset + (circularMenuRadius * Math.cos((angle * 4) + angleOffset))
        circularButtonE.y = yOffset + (circularMenuRadius * Math.sin((angle * 4) + angleOffset))
        circularButtonF.x = xOffset + (circularMenuRadius * Math.cos((angle * 5) + angleOffset))
        circularButtonF.y = yOffset + (circularMenuRadius * Math.sin((angle * 5) + angleOffset))
        circularButtonG.x = xOffset + (circularMenuRadius * Math.cos((angle * 6) + angleOffset))
        circularButtonG.y = yOffset + (circularMenuRadius * Math.sin((angle * 6) + angleOffset))

        buttomOiginX[1] = circularButtonA.x
        buttomOiginX[2] = circularButtonB.x
        buttomOiginX[3] = circularButtonC.x
        buttomOiginX[4] = circularButtonD.x
        buttomOiginX[5] = circularButtonE.x
        buttomOiginX[6] = circularButtonF.x
        buttomOiginX[7] = circularButtonG.x

        buttomOiginY[1] = circularButtonA.y
        buttomOiginY[2] = circularButtonB.y
        buttomOiginY[3] = circularButtonC.y
        buttomOiginY[4] = circularButtonD.y
        buttomOiginY[5] = circularButtonE.y
        buttomOiginY[6] = circularButtonF.y
        buttomOiginY[7] = circularButtonG.y

        buttomEndX[1] = tabBar.x + tabBar.buttonA.x + tabBar.buttonA.distanceBetweenButtons
        buttomEndX[2] = tabBar.x + tabBar.buttonB.x + tabBar.buttonA.distanceBetweenButtons
        buttomEndX[3] = tabBar.x + tabBar.buttonC.x + tabBar.buttonA.distanceBetweenButtons
        buttomEndX[4] = tabBar.x + tabBar.buttonD.x + tabBar.buttonA.distanceBetweenButtons
        buttomEndX[5] = tabBar.x + tabBar.buttonE.x + tabBar.buttonA.distanceBetweenButtons
        buttomEndX[6] = tabBar.x + tabBar.buttonF.x + tabBar.buttonA.distanceBetweenButtons
        buttomEndX[7] = tabBar.x + tabBar.buttonG.x + tabBar.buttonA.distanceBetweenButtons

        buttomEndY[1] = tabBar.y + tabBar.buttonA.y + tabBar.buttonA.distanceBetweenButtons
        buttomEndY[2] = tabBar.y + tabBar.buttonB.y + tabBar.buttonA.distanceBetweenButtons
        buttomEndY[3] = tabBar.y + tabBar.buttonC.y + tabBar.buttonA.distanceBetweenButtons
        buttomEndY[4] = tabBar.y + tabBar.buttonD.y + tabBar.buttonA.distanceBetweenButtons
        buttomEndY[5] = tabBar.y + tabBar.buttonE.y + tabBar.buttonA.distanceBetweenButtons
        buttomEndY[6] = tabBar.y + tabBar.buttonF.y + tabBar.buttonA.distanceBetweenButtons
        buttomEndY[7] = tabBar.y + tabBar.buttonG.y + tabBar.buttonA.distanceBetweenButtons

        buttomSize = tabBar.buttonA.tabButtonImage.width
    }

    states:[
        State{
            name: "noViewSaveScreen"
        },
        State{
            name: "viewSaveScreen"
        },
        State{
            name: "hideSaveScreen"
        }
    ]
    transitions:[
        Transition {
            to: "noViewSaveScreen"
            SequentialAnimation{
                PropertyAnimation { target: saveScreen; property: "visible"; to: false; duration: 0}
                ParallelAnimation{
                    PropertyAnimation { target: circularButtonA; property: "x"; to: buttomEndX[1]; duration: 0}
                    PropertyAnimation { target: circularButtonA; property: "y"; to: buttomEndY[1]; duration: 0}
                    PropertyAnimation { target: circularButtonB; property: "x"; to: buttomEndX[2]; duration: 0}
                    PropertyAnimation { target: circularButtonB; property: "y"; to: buttomEndY[2]; duration: 0}
                    PropertyAnimation { target: circularButtonC; property: "x"; to: buttomEndX[3]; duration: 0}
                    PropertyAnimation { target: circularButtonC; property: "y"; to: buttomEndY[3]; duration: 0}
                    PropertyAnimation { target: circularButtonD; property: "x"; to: buttomEndX[4]; duration: 0}
                    PropertyAnimation { target: circularButtonD; property: "y"; to: buttomEndY[4]; duration: 0}
                    PropertyAnimation { target: circularButtonE; property: "x"; to: buttomEndX[5]; duration: 0}
                    PropertyAnimation { target: circularButtonE; property: "y"; to: buttomEndY[5]; duration: 0}
                    PropertyAnimation { target: circularButtonF; property: "x"; to: buttomEndX[6]; duration: 0}
                    PropertyAnimation { target: circularButtonF; property: "y"; to: buttomEndY[6]; duration: 0}
                    PropertyAnimation { target: circularButtonG; property: "x"; to: buttomEndX[7]; duration: 0}
                    PropertyAnimation { target: circularButtonG; property: "y"; to: buttomEndY[7]; duration: 0}
                }
            }
        },
        Transition {
            to: "viewSaveScreen"
            SequentialAnimation{
                ParallelAnimation{
                    PropertyAnimation { target: saveScreen; property: "visible"; to: true; duration: 0}
                }
                ParallelAnimation{
                    PropertyAnimation { target: circularButtonA; property: "x"; to: buttomOiginX[1]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonA; property: "y"; to: buttomOiginY[1]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonB; property: "x"; to: buttomOiginX[2]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonB; property: "y"; to: buttomOiginY[2]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonC; property: "x"; to: buttomOiginX[3]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonC; property: "y"; to: buttomOiginY[3]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonD; property: "x"; to: buttomOiginX[4]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonD; property: "y"; to: buttomOiginY[4]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonE; property: "x"; to: buttomOiginX[5]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonE; property: "y"; to: buttomOiginY[5]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonF; property: "x"; to: buttomOiginX[6]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonF; property: "y"; to: buttomOiginY[6]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonG; property: "x"; to: buttomOiginX[7]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonG; property: "y"; to: buttomOiginY[7]; duration: transitionTime}
                    PropertyAnimation { target: backgroundRectangle; property: "opacity"; to: 1; duration: transitionTime}
                }
                PropertyAnimation { target: saveScreenNormalizationImage; property: "opacity"; to: 1; duration: transitionTime}
            }
        },
        Transition {
            to: "hideSaveScreen"
            SequentialAnimation{
                ParallelAnimation{
                    PropertyAnimation { target: circularButtonA; property: "x"; to: buttomEndX[1]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonA; property: "y"; to: buttomEndY[1]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonB; property: "x"; to: buttomEndX[2]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonB; property: "y"; to: buttomEndY[2]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonC; property: "x"; to: buttomEndX[3]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonC; property: "y"; to: buttomEndY[3]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonD; property: "x"; to: buttomEndX[4]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonD; property: "y"; to: buttomEndY[4]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonE; property: "x"; to: buttomEndX[5]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonE; property: "y"; to: buttomEndY[5]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonF; property: "x"; to: buttomEndX[6]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonF; property: "y"; to: buttomEndY[6]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonG; property: "x"; to: buttomEndX[7]; duration: transitionTime}
                    PropertyAnimation { target: circularButtonG; property: "y"; to: buttomEndY[7]; duration: transitionTime}
                    PropertyAnimation { target: backgroundRectangle; property: "opacity"; to: 0; duration: transitionTime}
                    PropertyAnimation { target: saveScreenNormalizationImage; property: "opacity"; to: 0; duration: transitionTime * 0.7}
                }
                PropertyAnimation { target: delayTimer; property: "running"; to: true; duration: 0}
            }
        }
    ]

    state: "viewSaveScreen"

    Rectangle{
        id: backgroundRectangle
        anchors.fill: parent
        color: "black"
    }

    Timer {
        id: delayTimer
        interval: 1
        repeat: false
        running: false
        onTriggered: {
            saveScreen.visible = "false"
            appConsole.state = Constants.CONSOLE_ST_EDITING
            pressButtomSimulation()
        }
    }

    Rectangle {
        id: circularButtonA
        width: buttomSize
        height: buttomSize
        color: tabBar.buttonA.tabButton.color
        radius: buttonRadius
        Image{
            anchors.fill: parent
            source: tabBar.buttonA.tabButtonImage.source
            opacity: circularButtonButtonA.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: circularButtonButtonA
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Save screen menu button 1 pressed...")
                saveScreen.state= "hideSaveScreen"
                lastButtomPressed = "circularButtonA"
                saveScreenTimer.running = true
                brandName.state = "runMode"
            }
        }
    }

    Rectangle {
        id: circularButtonB
        width: buttomSize
        height: buttomSize
        color: tabBar.buttonB.tabButton.color
        radius: buttonRadius
        Image{
            anchors.fill: parent
            source: tabBar.buttonB.tabButtonImage.source
            opacity: circularButtonB.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: circularButtonButtonB
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Save screen menu button 2 pressed...")
                saveScreen.state = "hideSaveScreen"
                lastButtomPressed = "circularButtonB"
                saveScreenTimer.running = true
                brandName.state = "runMode"
            }
        }
    }

    Rectangle {
        id: circularButtonC
        width: buttomSize
        height: buttomSize
        color: tabBar.buttonC.tabButton.color
        radius: buttonRadius
        Image{
            anchors.fill: parent
            source: tabBar.buttonC.tabButtonImage.source
            opacity: circularButtonC.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: circularButtonButtonC
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Save screen menu button 3 pressed...")
                saveScreen.state = "hideSaveScreen"
                lastButtomPressed = "circularButtonC"
                saveScreenTimer.running = true
                brandName.state = "runMode"
            }
        }
    }

    Rectangle {
        id: circularButtonE
        width: buttomSize
        height: buttomSize
        color: tabBar.buttonE.tabButton.color
        radius: buttonRadius
        Image{
            anchors.fill: parent
            source: tabBar.buttonE.tabButtonImage.source
            opacity: circularButtonE.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: circularButtonButtonE
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Save screen menu button 4 pressed...")
                saveScreen.state = "hideSaveScreen"
                lastButtomPressed = "circularButtonE"
                saveScreenTimer.running = true
                brandName.state = "runMode"
            }
        }
    }

    Rectangle {
        id: circularButtonD
        width: buttomSize
        height: buttomSize
        color: tabBar.buttonD.tabButton.color
        radius: buttonRadius
        Image{
            anchors.fill: parent
            source: tabBar.buttonD.tabButtonImage.source
            opacity: circularButtonD.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: circularButtonButtonD
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Save screen menu button 5 pressed...")
                saveScreen.state = "hideSaveScreen"
                lastButtomPressed = "circularButtonD"
                saveScreenTimer.running = true
                brandName.state = "runMode"
            }
        }
    }

    Rectangle {
        id: circularButtonF
        width: buttomSize
        height: buttomSize
        color: tabBar.buttonF.tabButton.color
        radius: buttonRadius
        Image{
            anchors.fill: parent
            source: tabBar.buttonF.tabButtonImage.source
            opacity: circularButtonF.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: circularButtonButtonF
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Save screen menu button 6 pressed...")
                saveScreen.state = "hideSaveScreen"
                lastButtomPressed = "circularButtonF"
                saveScreenTimer.running = true
                brandName.state = "runMode"
            }
        }
    }

    Rectangle {
        id: circularButtonG
        width: buttomSize
        height: buttomSize
        color: tabBar.buttonG.tabButton.color
        radius: buttonRadius
        Image{
            anchors.fill: parent
            source: tabBar.buttonG.tabButtonImage.source
            opacity: circularButtonG.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: circularButtonButtonG
            opacity: 0
            anchors.fill: parent
            onClicked: {
                //DEB->debug.log(DC.saveScreenEventsConsoleLog, "Save screen menu button 7 pressed...")
                saveScreen.state = "hideSaveScreen"
                lastButtomPressed = "circularButtonG"
                saveScreenTimer.running = true
                brandName.state = "runMode"
            }
        }
    }

    NormalizationImage{
        id: saveScreenNormalizationImage
        height: 100
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 40
        anchors.bottomMargin: 40
        state: "normalizationImageStateStatic"
    }

    DCImage{
        id: saveScreenDcImage
        height: saveScreenNormalizationImage.height
        anchors.left: saveScreenNormalizationImage.left
        anchors.bottom: saveScreenNormalizationImage.top
        visible: saveScreenNormalizationImage.visible
        opacity: saveScreenNormalizationImage.opacity
        dcIconGif.paused: true
    }
}
