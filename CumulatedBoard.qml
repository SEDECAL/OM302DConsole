// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12

import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies

Rectangle {
    id: cumulatedBoardItem

    property alias cumulatedBoard: cumulatedBoardItem
    property alias cumulatedO3: cumulatedO3
    property alias cumulatedTime: cumulatedTime
    property alias cumulatedPressure: cumulatedPressure
    property alias cumulatedVolume: cumulatedVolume
    property alias syringeAnimation: syringeAnimation
    property alias pressureIndicator: pressureIndicator
    property alias cumulatedTimeSeconds: cumulatedTimeSeconds
    property alias cyclesLabel: cyclesLabel
    property alias cyclesCounter: cyclesCounter
    property alias waveImage: waveImage
    property alias addingBloodImage: addingBloodImage
    property alias removingBloodImage: removingBloodImage
    property alias addingSalineImage: addingSalineImage
    property alias removingSalineImage: removingSalineImage
    property alias nextCycleConfirmation: nextCycleConfirmation
    property alias pushBloodMouseArea: pushBloodMouseArea
    property alias pushingBloodImageTimer: pushingBloodImageTimer
    property alias pushBloodPressureIndicator: pushBloodPressureIndicator

    property bool viewGrid: false

    function getConversionFactor(parameterId){
        var units = Storage.getAppDB(parameterId + Constants.unitsId, "*")

        if( units === Storage.getAppDB(parameterId + Constants.unitsAId, "*") ){
            return Storage.getAppDB(parameterId + Constants.conversionFactorAId, "1")
        }
        else if( units === Storage.getAppDB(parameterId + Constants.unitsBId, "*") ){
            return Storage.getAppDB(parameterId + Constants.conversionFactorBId, "1")
        }
        return 1
    }

    Component.onCompleted: {
        state = "noViewCumulated"
    }

    states:[
        State{
            name: "viewCumulated"
            PropertyChanges { target: cumulatedBoardItem; visible: true }
            PropertyChanges { target: cumulatedO3; state: "viewCumulatedBar" }
            PropertyChanges { target: cumulatedVolume; state: "viewCumulatedBar" }
            PropertyChanges { target: cumulatedTime; state: "viewCumulatedBar" }
            PropertyChanges { target: cumulatedPressure; state: "viewCumulatedBar" }
            PropertyChanges { target: pressureIndicator; state: "viewPressureMetter" }
            PropertyChanges { target: cumulatedTimeSeconds; state: "viewCumulatedBar" }
            PropertyChanges { target: syringeAnimation; state: "viewSyringeAnimation" }
        },
        State{
            name: "noViewCumulated"
            PropertyChanges { target: cumulatedBoardItem; visible: false }
            PropertyChanges { target: cumulatedO3; state: "noViewCumulatedBar" }
            PropertyChanges { target: cumulatedVolume; state: "noViewCumulatedBar" }
            PropertyChanges { target: cumulatedTime; state: "noViewCumulatedBar" }
            PropertyChanges { target: cumulatedPressure; state: "noViewCumulatedBar" }
            PropertyChanges { target: pressureIndicator; state: "noViewPressureMetter" }
            PropertyChanges { target: cumulatedTimeSeconds; state: "noViewCumulatedBar" }
            PropertyChanges { target: syringeAnimation; state: "noViewSyringeAnimation" }
        }
    ]

    state : "viewCumulated"
    width: parent.width
    color: "transparent"
    border.color: (viewGrid) ? "green" : "transparent"

    Row{
        id: dataRow
        spacing:30
        height: parent.height
        anchors.centerIn: parent

        CumulatedItem{
            id: cumulatedO3            
            width: cumulatedBoardItem.width * 0.174
            height: parent.height            
            progressColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumO3ProgressId, "black")
            progressBackgroundColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumO3ProgressBackId, "black")
            unitsLabel.text: Storage.getAppDB(Constants.dbParameter.doseId + Constants.unitsId, "*")
            conversionFactor: getConversionFactor(Constants.dbParameter.doseId)
        }
        CumulatedItem{
            id: cumulatedVolume
            width: cumulatedBoardItem.width * 0.174
            height: parent.height
            progressColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumVolumeProgressId, "black")
            progressBackgroundColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumVolumeProgressBackId, "black")
            unitsLabel.text: Storage.getAppDB(Constants.dbParameter.volumeId + Constants.unitsId, "*")
            conversionFactor: getConversionFactor(Constants.dbParameter.volumeId)
        }
        CumulatedItem{
            id: cumulatedTimeSeconds
            width: cumulatedBoardItem.width * 0.174
            height: parent.height
            unitsLabel.text: "sec"
            progressColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumTimeSecProgressId, "black")
            progressBackgroundColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumTimeSecProgressBackId, "black")
        }
        CumulatedItem{
            id: cumulatedTime
            width: cumulatedBoardItem.width * 0.174
            height: parent.height
            unitsLabel.text: "min"
            progressColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumTimeProgressId, "black")
            progressBackgroundColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumTimeProgressBackId, "black")
        }
        CumulatedItem{
            id: cumulatedPressure
            width: cumulatedBoardItem.width * 0.174
            height: parent.height
            unitsLabel.text:Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsId, "*")
            progressColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumPressureProgressId, "black")
            progressBackgroundColor: Storage.getAppDB(Constants.dbAppColor.cumBrdCumPressureProgressBackId, "black")
            conversionFactor: getConversionFactor(Constants.dbParameter.pressureId)
        }
        SyringeAnimation{
            id: syringeAnimation
            width: cumulatedBoardItem.width * 0.174
            height: parent.height
        }
        PressureMetter{
            id: pressureIndicator
            width: cumulatedBoardItem.width * 0.174
            height: parent.height
            unitsLabel.text: "mbar"
            indicatorsImage: (visible) ? Storage.getAppDB(Constants.dbAppIcon.pressureLimitPointer2Id, "") : ""
        }
    }

    Rectangle{
        id: cyclesCounter
        width: cumulatedBoardItem.width * 0.21 * 0.333
        height: width
        anchors.right: dataRow.left
        anchors.rightMargin: dataRow.spacing
        anchors.bottom : dataRow.bottom
        color: "transparent"//Storage.getAppDB(Constants.dbAppColor.cumBrdPanelId, "black")
        border.color: "transparent"
        radius: 4

        Image{
            anchors.fill: parent
            anchors.margins: parent.width * 0.05
            source: Storage.getAppDB(Constants.dbAppIcon.cyclesCounterId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Label{
            id: cyclesLabel
            color: Storage.getAppDB(Constants.dbAppColor.cumBrdCyclesLabelId, "black")
            text: "/"
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.height * 0.35
            fontSizeMode: Text.Fit

            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "red"
                visible: viewGrid
            }
        }
    }

    AnimatedImage{
        id: waveImage
        width: Math.round(cumulatedBoardItem.width * 0.21)
        height: width
        anchors.left: dataRow.right
        anchors.leftMargin: dataRow.spacing
        anchors.bottom: dataRow.bottom
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.shakeBottleGifId, "") : "" //12/2021
        opacity: 0
        visible: false
        playing: visible
        asynchronous: true   // performance improvement

        states:[
            State{
                name: "viewWave"
                PropertyChanges { target: waveImage; visible: true }//CB->  v
            },
            State{
                name: "noViewWave"
                PropertyChanges { target: waveImage; opacity: 0 }
                PropertyChanges { target: waveImage; visible: false }//CB->  v
            }
        ]
        transitions:[
            Transition {
                to: "viewWave"
                PropertyAnimation { target: waveImage; property: "opacity"; to: 1; duration: 1000 }
            }
        ]
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "orange"
            visible: viewGrid
        }
    }

    AnimatedImage{
        id: addingBloodImage
        width: Math.round((cumulatedO3.width * 2) + dataRow.spacing)
        height: width
        anchors.centerIn: parent
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.fillBloodBottleId, "") : "" //12/2021
        opacity: 0
        visible: false
        playing: visible
        asynchronous: true // performance improvement

        states:[
            State{
                name: "viewAddingBlood"
                PropertyChanges { target: cyclesCounter; anchors.right: addingBloodImage.left }
                PropertyChanges { target: addingBloodImage; visible: true }//CB->  v
            },
            State{
                name: "noViewAddingBlood"
                PropertyChanges { target: addingBloodImage; opacity: 0 }
                PropertyChanges { target: cyclesCounter; anchors.right: dataRow.left }
                PropertyChanges { target: addingBloodImage; visible: false }//CB->  v
            }
        ]
        transitions:[
            Transition {
                to: "viewAddingBlood"
                SequentialAnimation{
                    ScriptAction{script: cyclesCounter.anchors.right = addingBloodImage.left }
                    PropertyAnimation { target: addingBloodImage; property: "opacity"; to: 1; duration: 1000 }
                }
            }
        ]
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "olive"
            visible: viewGrid
        }
    }

    AnimatedImage{
        id: removingBloodImage
        width: Math.round((cumulatedO3.width * 2) + dataRow.spacing)
        height: width
        anchors.centerIn: parent
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.emptyBloodBottleId, "") : "" //12/2021
        opacity: 0
        visible: false
        playing: visible
        asynchronous: true // performance improvement

        states:[
            State{
                name: "viewRemovingBlood"
                PropertyChanges { target: cyclesCounter; anchors.right: addingBloodImage.left }
                PropertyChanges { target: removingBloodImage; visible: true }//CB->  v
            },
            State{
                name: "noViewRemovingBlood"
                PropertyChanges { target: removingBloodImage; opacity: 0 }
                PropertyChanges { target: cyclesCounter; anchors.right: dataRow.left }
                PropertyChanges { target: removingBloodImage; visible: false }//CB->  v
            }
        ]
        transitions:[
            Transition {
                to: "viewRemovingBlood"
                SequentialAnimation{
                    ScriptAction{script: cyclesCounter.anchors.right = addingBloodImage.left }
                    PropertyAnimation { target: removingBloodImage; property: "opacity"; to: 1; duration: 1000 }
                }
            }
        ]
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "pink"
            visible: viewGrid
        }
    }

    Image{
        id: pushingBloodImage
        property bool blinkState: false

        z: removingBloodImage.z + 1
        visible: false
        width: removingBloodImage.width * 0.25
        height: width
        anchors.verticalCenter: removingBloodImage.verticalCenter
        anchors.horizontalCenter: removingBloodImage.horizontalCenter
        anchors.verticalCenterOffset: -width
        anchors.horizontalCenterOffset: -width * 0.20
        source: Storage.getAppDB(Constants.dbAppIcon.bloodPushArrowId, "")
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement

        Timer {
            id: pushingBloodImageTimer
            interval: 500
            repeat: true
            running: pushBloodMouseArea.pressed
            onRunningChanged: {
                pushingBloodImage.visible = pushingBloodImageTimer.running
            }
            onTriggered: {
                pushingBloodImage.visible = !pushingBloodImage.visible
            }
        }

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "blue"
            visible: viewGrid
        }

    }

    AnimatedImage{
        id: addingSalineImage
        width: Math.round((cumulatedO3.width * 2) + dataRow.spacing)
        height: width
        anchors.centerIn: parent
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.fillSalineBottleId, "") : "" //12/2021
        opacity: 0
        visible: false
        playing: visible
        asynchronous: true // performance improvement

        states:[
            State{
                name: "viewAddingSaline"
                PropertyChanges { target: cyclesCounter; anchors.right: addingSalineImage.left }
                PropertyChanges { target: addingSalineImage; visible: true }//CB->  v
            },
            State{
                name: "noViewAddingSaline"
                PropertyChanges { target: addingSalineImage; opacity: 0 }
                PropertyChanges { target: cyclesCounter; anchors.right: dataRow.left }
                PropertyChanges { target: addingSalineImage; visible: false }//CB->  v
            }
        ]
        transitions:[
            Transition {
                to: "viewAddingSaline"
                SequentialAnimation{
                    ScriptAction{script: cyclesCounter.anchors.right = addingSalineImage.left }
                    PropertyAnimation { target: addingSalineImage; property: "opacity"; to: 1; duration: 1000 }
                }
            }
        ]
    }

    AnimatedImage{
        id: removingSalineImage
        width: Math.round((cumulatedO3.width * 2) + dataRow.spacing)
        height: width
        anchors.centerIn: parent
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.emptySalineBottleId, "") : "" //12/2021
        opacity: 0
        visible: false
        playing: visible
        asynchronous: true // performance improvement

        states:[
            State{
                name: "viewRemovingSaline"
                PropertyChanges { target: cyclesCounter; anchors.right: removingSalineImage.left }
                PropertyChanges { target: removingSalineImage; visible: true }//CB->  v
            },
            State{
                name: "noViewRemovingSaline"
                PropertyChanges { target: removingSalineImage; opacity: 0 }
                PropertyChanges { target: cyclesCounter; anchors.right: dataRow.left }
                PropertyChanges { target: removingSalineImage; visible: false }//CB->  v
            }
        ]
        transitions:[
            Transition {
                to: "viewRemovingSaline"
                SequentialAnimation{
                    ScriptAction{script: cyclesCounter.anchors.right = addingBloodImage.left }
                    PropertyAnimation { target: removingSalineImage; property: "opacity"; to: 1; duration: 1000 }
                }
            }
        ]
    }

    Item{
        id: nextCycleConfirmation
        visible: false
        height: width
        width: Math.round(parent.width * 0.284)
        anchors.centerIn: parent
        Image{
            id: nextCycleConfirmationImage
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.cyclesForQuestion, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Image{
            id: questionMarkImage
            anchors.fill: parent
            visible: false
            source: Storage.getAppDB(Constants.dbAppIcon.nextCycleQuestionMark, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Timer {
            interval: 1000
            repeat: true
            running: parent.visible
            onTriggered: nextCycleConfirmationImage.visible = ! nextCycleConfirmationImage.visible
        }
    }

    Rectangle{
        id: pushBlood
        width: cumulatedBoardItem.width * 0.21 * 0.333
        height: width
        x: parent.width - cyclesCounter.x - (width * 2)
        anchors.bottom: dataRow.bottom
        color: Storage.getAppDB(Constants.dbAppColor.cumBrdPanelId, "black")
        border.color: "transparent"
        radius: 4
        visible: removingBloodImage.visible
        opacity: pushBloodMouseArea.pressed ? 0.4 : 1

        Image{
            anchors.fill: parent
            anchors.margins: parent.width * 0.05
            source: Storage.getAppDB(Constants.dbAppIcon.bloodPushId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        MouseArea{
            id: pushBloodMouseArea
            anchors.fill: parent
            onPressed:  { Therapies.startBloodPush() }
            onReleased: { Therapies.stopBloodPush() }
        }
    }

    PressureMetter{
        id: pushBloodPressureIndicator
        width: pressureIndicator.width * 0.7
        height: pressureIndicator.height * 0.7
        unitsLabel.text: pressureIndicator.unitsLabel.text
        indicatorsImage: (visible) ? Storage.getAppDB(Constants.dbAppIcon.pressureLimitPointer2Id, "") : ""
        anchors.bottom: pushBlood.top
        anchors.bottomMargin: height * 0.1
        anchors.horizontalCenter: pushBlood.horizontalCenter
        visible: pushBlood.visible
        state: "viewPressureMetter"
        cumulatedLabel.text: pressureIndicator.cumulatedLabel.text

        onVisibleChanged: {
            var range, maxValue, minValue

            maxValue = (applicationWindow.atmosphericPressure + parseInt(200)) * cumulatedBoard.pressureIndicator.conversionFactor
            minValue = (applicationWindow.atmosphericPressure - parseInt(200)) * cumulatedBoard.pressureIndicator.conversionFactor
            range = maxValue - minValue
            pushBloodPressureIndicator.progressTool.maximumValue = (range / 0.80) + minValue  // practical value to get desired effect on color gradient scale
            pushBloodPressureIndicator.progressTool.minimumValue =  minValue
            pushBloodPressureIndicator.progressTool.value = minValue + (range * 0.5)
        }
    }
}





