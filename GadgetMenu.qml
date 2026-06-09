// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12

import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies
import "DebugConstants.js" as DC

Rectangle {
    id: gadgetMenuId

    property alias testPressureButton: testPressureButton
    property alias bloodVolumeButton: bloodVolumeButton
    property alias memoryButton: memoryButton
    property alias syringeCalculatorButton: syringeCalculatorButton
    property alias salineHemoTherapyCalculatorButton: salineHemoTherapyCalculatorButton

    property int margin: 8
    property int buttonRadius: 4
    property int testPressureButtonCenterX: gadgetMenuId.x + buttonsColumn.x +  testPressureButton.x + (testPressureButton.width * 0.5)
    property int testPressureButtonTopY: gadgetMenuId.y + (margin * 2)
    property int testBloodVolumeButtonCenterX: gadgetMenuId.x + buttonsColumn.x +  bloodVolumeButton.x + (bloodVolumeButton.width * 0.5)
    property int testBloodVolumeButtonTopY: gadgetMenuId.y + (margin * 2)
    property int memoryButtonCenterX: gadgetMenuId.x + buttonsColumn.x +  memoryButton.x + (memoryButton.width * 0.5)
    property int memoryButtonTopY: gadgetMenuId.y + (margin * 2)
    property int syringeCalculatorButtonCenterX: gadgetMenuId.x + buttonsColumn.x +  syringeCalculatorButton.x + (syringeCalculatorButton.width * 0.5)
    property int syringeCalculatorButtonTopY: gadgetMenuId.y + (margin * 2)
    property int salineHemoTherapyCalculatorButtonCenterX: gadgetMenuId.x + buttonsColumn.x +  salineHemoTherapyCalculatorButton.x + (salineHemoTherapyCalculatorButton.width * 0.5)
    property int salineHemoTherapyCalculatorButtonTopY: gadgetMenuId.y + (margin * 2)

    property double opacityOnButtonPressed: 0.4

    function temporalDisable(miliseconds){
        gadgetMenuId.enabled = false
        delayedEnable.duration = miliseconds
        delayedEnable.start()
    }

    states:[
        State{
            name: "viewGadgetMenu"
            PropertyChanges { target: buttonsColumn; enabled: true}
            PropertyChanges { target: gadgetMenuId; opacity: 1 }
        },
        State{
            name: "noViewGadgetMenu"
            PropertyChanges { target: buttonsColumn; opacity: 0}
            PropertyChanges { target: buttonsColumn; enabled: false}
            PropertyChanges { target: gadgetMenuId; opacity: 0 }
        },
        State{
            name: "gadgetMenuEnabled"
            PropertyChanges { target: buttonsColumn; enabled: true}
            PropertyChanges { target: gadgetMenuId; opacity: 1 }
        },
        State{
            name: "gadgetMenuDisabled"
            PropertyChanges { target: buttonsColumn; enabled: false}
            PropertyChanges { target: gadgetMenuId; opacity: 0.2 }
        }
    ]
    transitions:[
        Transition {
            to: "viewGadgetMenu"
            PropertyAnimation { target: buttonsColumn; property: "opacity"; to: 1; duration: 700}
        },
        Transition {
            to: "noViewGadgetMenu"
            PropertyAnimation { target: buttonsColumn; property: "opacity"; to: 0; duration: 100}
            PropertyAnimation { target: gadgetMenuId; property: "opacity"; to: 0; duration: 100}
        }
    ]

    PropertyAnimation{ id: delayedEnable; target: gadgetMenuId; property: "enabled"; to: true; duration: 0 }

    width: margin + ((memoryButton.height + margin) * memoryButton.visible) + ((syringeCalculatorButton.height + margin) * syringeCalculatorButton.visible)  + ((salineHemoTherapyCalculatorButton.height + margin) * salineHemoTherapyCalculatorButton.visible) + ((bloodVolumeButton.height + margin) * bloodVolumeButton.visible) + ((testPressureButton.height + margin) * testPressureButton.visible)
    height: parent.height
    color: Storage.getAppDB(Constants.dbAppColor.gadgetMenuPanelId, "black")
    radius: buttonRadius
    state: "noViewGadgetMenu"

    Row{
        id: buttonsColumn
        height: parent.height - (2 * margin)
        spacing: margin
        state: "hideAllGadgets"
        anchors.centerIn: parent

        states:[
            State{
                name: "viewAllGadgets"
                PropertyChanges { target: bloodVolumeButton; visible: true}
                PropertyChanges { target: testPressureButton; visible: true}
            },
            State{
                name: "hideAllGadgets"
                PropertyChanges { target: bloodVolumeButton; visible: false}
                PropertyChanges { target: testPressureButton; visible: false}
            },
            State{
                name: "viewBloodVolumeButton"
                PropertyChanges { target: bloodVolumeButton; visible: true}
            },
            State{
                name: "viewTestPressureButton"
                PropertyChanges { target: testPressureButton; visible: true}
            }
        ]

        Rectangle {
            id: memoryButton
            width: parent.height
            height: parent.height
            color: Storage.getAppDB(Constants.dbAppColor.gadgetMenuButtonId, "black")
            radius: buttonRadius
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.saveId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: memoryButtonButton.down ? opacityOnButtonPressed : 1
            }
            Button{
                id: memoryButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    //DEB->debug.log(DC.gadgetMenuLog, "memory gadget pressed...")
                    Therapies.launchMemory()

                }
            }
        }

        Rectangle {
            id: syringeCalculatorButton
            width: parent.height
            height: parent.height
            color: Storage.getAppDB(Constants.dbAppColor.gadgetMenuButtonId, "black")
            radius: buttonRadius
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.syringeCaculatorId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: syringeCalculatorButtonButton.down ? opacityOnButtonPressed : 1
            }
            Button{
                id: syringeCalculatorButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    //DEB->debug.log(DC.gadgetMenuLog, "syringe calculator gadget pressed...")
                    Therapies.launchSyringeCalculator()
                }
            }
        }

        Rectangle {
            id: salineHemoTherapyCalculatorButton
            width: parent.height
            height: parent.height
            color: Storage.getAppDB(Constants.dbAppColor.gadgetMenuButtonId, "black")
            radius: buttonRadius
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.salineHemoTherapyCalcId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: salineHemoTherapyCalculatorButtonButton.down ? opacityOnButtonPressed : 1
            }
            Button{
                id: salineHemoTherapyCalculatorButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    //DEB->debug.log(DC.gadgetMenuLog, "saline hemotherapy calculator gadget pressed...")
                    Therapies.launchSalineHemoTherapyCalculator()
                }
            }
        }

        Rectangle {
            id: bloodVolumeButton
            width: parent.height
            height: parent.height
            color: Storage.getAppDB(Constants.dbAppColor.gadgetMenuButtonId, "black")
            radius: buttonRadius
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.bloodCaculatorId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: bloodVolumeButtonButton.down ? opacityOnButtonPressed : 1
            }
            Button{
                id: bloodVolumeButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    //DEB->debug.log(DC.gadgetMenuLog, "blood volume calculation gadget pressed...")
                    Therapies.launchBloodVolume()
                }
            }
        }

        Rectangle {
            id: testPressureButton
            width: parent.height
            height: parent.height
            color: Storage.getAppDB(Constants.dbAppColor.gadgetMenuButtonId, "black")
            radius: buttonRadius
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.checkPressureId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: testPressureButtonButton.down ? opacityOnButtonPressed : 1
            }
            Button{
                id: testPressureButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    //DEB->debug.log(DC.gadgetMenuLog, "test pressure gadget pressed...")
                    Therapies.launchPressureTester()
                }
            }
        }
    }
}

