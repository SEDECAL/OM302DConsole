// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Styles 1.4

import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies
import "DebugConstants.js" as DC
import "Singletons"

Rectangle{
    id: bloodVolumeContainer

    property alias slider: slider
    property alias unitsLabel: unitsLabel
    property alias magnitudeLabel: magnitudeLabel
    property alias cancelButton: cancelButton
    property alias bloodVolumeIndicator: bloodVolumeIndicator

    property int fullViewX: QtConstants.fullViewInputElementX
    property int fullViewY: QtConstants.fullViewInputElementY + QtConstants.magnitudeSelectorY
    property int fullViewWidth: QtConstants.fullViewInputElementWith
    property int fullViewHeight: QtConstants.fullViewInputElementWith * QtConstants.fullViewInputElementAspectRatio

    property int reducedViewX: 0
    property int reducedViewY: 0
    property int reducedViewWidth: 0
    property int reducedViewHeight: 0

    property int enlargeTime: 300
    property int bloodVolumeIndicatorReducedViewWidth: 0
    property int bloodVolumeIndicatorFullViewWidth: parent.width * 0.195

    property int unitsLabelReducedViewWidth: 0
    property int unitsLabelFullViewWidth: bloodVolumeContainer.width * 0.241
    property int unitsLabelReducedViewHeight: 0
    property int unitsLabelFullViewHeight: bloodVolumeContainer.width * 0.078

    property int buttonRadius: bloodVolumeContainer.width * 0.008
    property int operationButtonWidth: bloodVolumeContainer.width * 0.085
    property int operationButtonHeight: bloodVolumeContainer.width * 0.085
    property int sliderRectangleHeight: bloodVolumeContainer.width * 0.014
    property int sliderHandlePressed: bloodVolumeContainer.width * 0.080
    property int sliderHandleUnpressed: bloodVolumeContainer.width * 0.070

    property double maxPatientWeight: 1
    property double weightConversionFactor: 1
    property double weightToBloodVolumeConversionFactor: 1

    property string sliderColor: Storage.getAppDB(Constants.dbAppColor.bloodVolumeSliderId, "black")
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.bloodVolumeButtonId, "black")

    property bool viewGrid: false

    function getDataBaseParameters(){
        weightToBloodVolumeConversionFactor = Storage.getAppDB(Constants.dbConstants.bloodVolWeightToBloodFactorId, "")
        maxPatientWeight = Storage.getAppDB(Constants.dbConstants.bloodVolMaxPatientWeightId, "")

        if( Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsId, "*") ===
            Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsAId, "*") ){
            unitsLabel.text = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsAId, "1")
            weightConversionFactor = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.conversionFactorAId, "1")
        }
        else{
            unitsLabel.text = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsBId, "1")
            weightConversionFactor = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.conversionFactorBId, "1")
        }
    }

    function formatFractionalPart(value){

        if( Number(value) === parseInt(Number(value)) ){
            return value
        }
        else{
            return value.toFixed(2)
        }
    }

    function bloodVolumeLabelPosition(){
        var position

        position = (progressTool.height * progressTool.value) / (progressTool.maximumValue - progressTool.minimumValue)
        position = progressTool.y + progressTool.height - (position * 0.5) - (bloodVolumeLabel.height * 0.5)
        return position
    }

    function voidVolumeLabelPosition(){
        var position

        position = (progressTool.height * progressTool.value) / (progressTool.maximumValue - progressTool.minimumValue)
        position = progressTool.y  + ((progressTool.height - position) * 0.5) - (bloodVolumeLabel.height * 0.5)
        return position
    }

    function bloodVolumeValue(){ // ((slider.value * weightConversionFactor) = kg; return = cc)
        var ret = (slider.value * weightConversionFactor) * weightToBloodVolumeConversionFactor


        if(ret > progressTool.maximumValue){
            ret = progressTool.maximumValue
        }
        return ret.toFixed(2)
    }

    function patientWeightValue(volume){ //volume (cc); return (Kg)
        return Math.round(volume / weightToBloodVolumeConversionFactor)
    }

    function formatVoidVolumeLabelText(){
        if(magnitudeSelector.inputBottleVolume.conversionFactor < 1){
            return formatFractionalPart((progressTool.maximumValue - progressTool.value) * magnitudeSelector.inputBottleVolume.conversionFactor).toLocaleString().replace(".", ",")
        }
        else{
            return Math.round(formatFractionalPart((progressTool.maximumValue - progressTool.value) * magnitudeSelector.inputBottleVolume.conversionFactor))
        }
    }

    function formatBloodVolumeLabelText(){
        if(magnitudeSelector.inputBottleVolume.conversionFactor < 1){
            return formatFractionalPart(progressTool.value * magnitudeSelector.inputBottleVolume.conversionFactor ).toLocaleString().replace(".", ",")
        }
        else{
            return Math.round(formatFractionalPart(bloodVolumeValue() * magnitudeSelector.inputBottleVolume.conversionFactor))
        }
    }
    function formatMagnitudeLabel(value){
//        if( Number(value) !== parseInt(Number(value)) ){
//            if(value > 999){
//                return Math.round(value)
//            }
//            else{
//                return value.toLocaleString().replace(".", ",")
//            }
//        }
//        else{
//            return value
//        }
        return Math.round(value) // ticket #4202
    }

    states:[
        State{
            name: "viewBloodVolumeStart"
            PropertyChanges { target: bloodVolumeContainer; visible: true }
            PropertyChanges { target: bloodVolumeControlsId; visible: true }
            PropertyChanges { target: downButton; enabled: true }
            PropertyChanges { target: upButton;   enabled: true }
            PropertyChanges { target: slider;     enabled: true }
        },
        State{
            name: "noViewBloodVolume"
            PropertyChanges { target: bloodVolumeContainer; visible: false }
            PropertyChanges { target: bloodVolumeControlsId; visible: false }
            StateChangeScript {script: Therapies.completeGadgetCloseEffect()}
        },
        State{
            name: "noViewBloodVolumeQuick"
              PropertyChanges { target: bloodVolumeContainer; visible: false }
              PropertyChanges { target: bloodVolumeControlsId; visible: false }
        },
        State{
            name: "viewBloodVolumeStartPending"
        }
    ]

    z:1
    radius: width * 0.006
    x: fullViewX
    y: fullViewY
    width: fullViewWidth
    height: fullViewHeight
    state: "noviewBloodVolume"
    visible: true
    color: Storage.getAppDB(Constants.dbAppColor.bloodVolumePanelId, "black")

    onStateChanged: {
        if(state === "viewBloodVolumeStart")
        getDataBaseParameters()
        slider.value = patientWeightValue(magnitudeSelector.inputBloodVolume.magnitudeValue / magnitudeSelector.inputBloodVolume.conversionFactor) / weightConversionFactor
    }

    Item{
        id: bloodVolumeControlsId
        visible: false
        opacity: 1
        anchors.fill: parent

        Rectangle{
            id: bloodVolumeIndicator
            width: bloodVolumeIndicatorFullViewWidth//200
            height: parent.height - (parent.width * 0.04)
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: parent.width * 0.02
            color: Storage.getAppDB(Constants.dbAppColor.bloodVolumeIndicatorId, "black")

            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "pink"
                visible: viewGrid
            }

            Text {
                id: volumeLabel
                color: Storage.getAppDB(Constants.dbAppColor.bottleVolumeLabelId, "black")
                text: magnitudeSelector.inputBottleVolume.magnitudeLabel.text + " " + magnitudeSelector.inputBottleVolume.unitsLabel.text
                width: parent.width * 0.5
                height: parent.width * 0.178
                anchors.horizontalCenter:  progressBarCoverImage.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: parent.width * 0.02
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: parent.width * 0.15
                fontSizeMode: Text.Fit

                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "lightblue"
                    visible: viewGrid
                }
            }

            Text {
                id: voidVolumeLabel
                color: Storage.getAppDB(Constants.dbAppColor.bottleVoidVolumeLabelId, "black")
                text: formatVoidVolumeLabelText()
                width: parent.width * 0.4
                height: parent.width * 0.178
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.02
                y: voidVolumeLabelPosition()
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: parent.width * 0.15
                fontSizeMode: Text.Fit

                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "lightpink"
                    visible: viewGrid
                }
            }

            Text {
                id: bloodVolumeLabel
                color: Storage.getAppDB(Constants.dbAppColor.bloodVolumeLabelId, "black")
                text: formatBloodVolumeLabelText()
                width: parent.width * 0.4
                height: parent.width * 0.178
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.02
                y: bloodVolumeLabelPosition()
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: parent.width * 0.15
                fontSizeMode: Text.Fit

                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "lightgreen"
                    visible: viewGrid
                }
            }

            Rectangle{
                id: fakeRectangleForSavingEffect
                opacity: 0
                x: magnitudeSelector.x + magnitudeSelector.inputBloodVolume.x + magnitudeSelector.inputBloodVolume.magnitudeLabel.x - bloodVolumeContainer.x -bloodVolumeIndicator.x
                y: magnitudeSelector.y + magnitudeSelector.inputBloodVolume.y + magnitudeSelector.inputBloodVolume.magnitudeLabel.y - bloodVolumeContainer.y -bloodVolumeIndicator.y
                width: magnitudeSelector.inputBloodVolume.magnitudeLabel.width
                height: magnitudeSelector.inputBloodVolume.magnitudeLabel.height
                color: "transparent"
                border.color: "yellow"
            }

            Text {
                id: bloodVolumeLabelForSavingEffect
                states: [
                    State {
                        name: "saving"
                        PropertyChanges { target: bloodVolumeLabelForSavingEffect; font.pixelSize: bloodVolumeLabel.font.pixelSize * 2 }

                        PropertyChanges { target: bloodVolumeLabelForSavingEffect; opacity: 1 }
                        AnchorChanges { target: bloodVolumeLabelForSavingEffect; anchors.horizontalCenter: fakeRectangleForSavingEffect.horizontalCenter }
                        AnchorChanges { target: bloodVolumeLabelForSavingEffect; anchors.verticalCenter: fakeRectangleForSavingEffect.verticalCenter }
                    },
                    State {
                        name: "saved"
                        PropertyChanges { target: bloodVolumeLabelForSavingEffect; opacity: 0 }
                        PropertyChanges { target: bloodVolumeLabelForSavingEffect; font.pixelSize: bloodVolumeLabel.font.pixelSize }
                        AnchorChanges { target: bloodVolumeLabelForSavingEffect; anchors.horizontalCenter: bloodVolumeLabel.horizontalCenter }
                        AnchorChanges { target: bloodVolumeLabelForSavingEffect; anchors.verticalCenter: bloodVolumeLabel.verticalCenter }
                        StateChangeScript {script: magnitudeSelector.inputBloodVolume.refreshSlider()}
                    }
                ]
                transitions: [
                    Transition {
                        to: "saving"
                        SequentialAnimation{
                            ParallelAnimation{
                                AnchorAnimation {duration: 400}
                                PropertyAnimation { target: bloodVolumeLabelForSavingEffect; property: "font.pixelSize"; to: magnitudeSelector.inputBloodVolume.magnitudeLabel.font.pixelSize * 0.6; easing.type: Easing.Linear; duration: 400}
                            }
                            PropertyAnimation { target: magnitudeSelector.inputBloodVolume.magnitudeLabel; property: "text"; to: bloodVolumeLabelForSavingEffect.text}
                            PropertyAnimation { target: bloodVolumeLabelForSavingEffect; property: "state"; to: "saved"}
                        }
                    }
                ]
                opacity: 0
                width: bloodVolumeLabel.width
                height: bloodVolumeLabel.height
                anchors.horizontalCenter: bloodVolumeLabel.horizontalCenter
                anchors.verticalCenter: bloodVolumeLabel.verticalCenter
                text: bloodVolumeLabel.text
                color: bloodVolumeLabel.color
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: bloodVolumeLabel.font.pixelSize

                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "green"
                    visible: viewGrid
                }
            }

            CustomProgressTool{
                id: progressTool
                width: progressBarCoverImage.width * 0.67
                height: progressBarCoverImage.height * 0.765// 0.783
                anchors.horizontalCenter: progressBarCoverImage.horizontalCenter
                anchors.top: progressBarCoverImage.top
                anchors.topMargin: progressBarCoverImage.height * 0.071//0.165
                value: bloodVolumeValue()
                maximumValue: magnitudeSelector.inputBottleVolume.magnitudeValue / magnitudeSelector.inputBottleVolume.conversionFactor
                minimumValue: 0
                backColor: "transparent"
                mainColor: Storage.getAppDB(Constants.dbAppColor.bloodVolumeProgressBar1Id, "black")
            }

            CustomProgressTool{
                id: progressTool2
                width: progressTool.width
                height: progressTool.height
                x: progressTool.x
                y: progressTool.y
                value: progressTool.value * 0.22
                maximumValue: progressTool.maximumValue
                minimumValue: progressTool.minimumValue
                backColor: "transparent"
                mainColor: Storage.getAppDB(Constants.dbAppColor.bloodVolumeProgressBar2Id, "black")
            }

            Image {
                id: progressBarCoverImage
                source: Storage.getAppDB(Constants.dbAppIcon.voidBottleGadgetId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                height: parent.height * 0.92
                width: height * 0.5
                anchors.top: volumeLabel.bottom
                anchors.topMargin: -(parent.height * 0.035)
                anchors.left: parent.left
                anchors.leftMargin: -(parent.height * 0.04)
                z: progressTool2.z + 1

                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "green"
                    visible: viewGrid
                }
            }

            Text {
                id: alternativeVolumeLabel
                color: Storage.getAppDB(Constants.dbAppColor.bottleVolumeLabelId, "black")
                text: progressTool.maximumValue + " cc"
                width: parent.width * 0.8
                height: parent.width * 0.2
                visible: false
                anchors.centerIn: progressBarCoverImage
                anchors.horizontalCenterOffset: - progressBarCoverImage.width * 0.1
                anchors.verticalCenterOffset: - progressBarCoverImage.width * 0.2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: parent.width * 0.15
                fontSizeMode: Text.Fit
                transform: Rotation { origin.x: alternativeVolumeLabel.width * 0.5; origin.y: alternativeVolumeLabel.height * 0.5; angle: -90}

                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "pink"
                    visible: viewGrid
                }
            }
        }

        Image {
            id: mainImage
            anchors.left: bloodVolumeIndicator.right
            anchors.leftMargin: parent.width * 0.012
            anchors.top: parent.top
            anchors.topMargin: parent.width * 0.012
            width: parent.width * 0.20
            height: mainImage.width
            source: Storage.getAppDB(Constants.dbAppIcon.patientWeight1Id, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "green"
                visible: viewGrid
            }
        }

        Rectangle {
            id: cancelButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.top: parent.top
            anchors.topMargin: parent.width * 0.02
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.02

            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.backId, "")
                opacity: cancelButtonButton.down ? 0.4 : 1
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
            Button{
                id: cancelButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    //DEB->debug.log(DC.bloodVolumeLog, "cancel button clicked (blood volume)...")
                    bloodVolumeContainer.state = "noViewBloodVolume"
                    Therapies.exitBloodVolume()
                }
            }
        }

        Rectangle {
            id: saveButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width * 0.02
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.02

            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.saveId, "")
                opacity: saveButtonButton.down ? 0.4 : 1
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
            Button{
                id: saveButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    //DEB->debug.log(DC.bloodVolumeLog, "save button clicked (blood volume)...")
                    bloodVolumeLabelForSavingEffect.state = "saving"
                }
            }
        }

        Slider {
            id: slider
            from: (weightConversionFactor > 1) ? 0.1 : 1
            to: maxPatientWeight / weightConversionFactor
            value: 80 / weightConversionFactor
            stepSize: (weightConversionFactor > 1) ? 0.1 : 1
            anchors.right: upButton.left
            anchors.rightMargin: parent.width * 0.035
            anchors.left: downButton.right
            anchors.leftMargin: parent.width * 0.035
            anchors.verticalCenter: downButton.verticalCenter
            anchors.verticalCenterOffset: parent.width * 0.018
            height: sliderHandlePressed

            background: Rectangle {
                id: sliderBackgroundInactive
                x: slider.leftPadding
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                width: slider.availableWidth
                height: sliderRectangleHeight
                radius: (sliderRectangleHeight / 2) + 1
                color: Storage.getAppDB(Constants.dbAppColor.bloodVolumeBackSliderId, "black")

                Rectangle {
                    id: deactivated
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: sliderColor
                    radius: sliderRectangleHeight / 2
                }
            }
            handle: Rectangle {
                id: sliderHandle
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                width: slider.pressed ? sliderHandlePressed : sliderHandleUnpressed
                height: sliderHandle.width
                radius: (sliderHandlePressed / 2) + 1
                color: slider.pressed ?  magnitudeLabel.color : sliderColor
            }
        }

        Rectangle {
            id: downButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.top: mainImage.bottom
            anchors.topMargin: operationButtonHeight * 0.2
            anchors.left: bloodVolumeIndicator.right
            anchors.leftMargin: operationButtonHeight * 0.35

            Text {
                color: Storage.getAppDB(Constants.dbAppColor.bloodVolumeSliderId, "black")
                text: "_"
                anchors.fill: parent
                anchors.bottomMargin: operationButtonHeight * 0.45
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                font.pointSize: (operationButtonHeight) ? operationButtonHeight : 1 // avoid warning
                opacity: downButtonButton.down ? 0.4 : 1
            }
            Button{
                id: downButtonButton
                opacity: 0
                autoRepeat: true
                anchors.fill: parent
                onClicked: slider.value = slider.value - slider.stepSize
            }

        }

        Rectangle {
            id: upButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.top: downButton.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.02

            Text {
                color: Storage.getAppDB(Constants.dbAppColor.bloodVolumeSliderId, "black")
                text: "+"
                anchors.bottomMargin: operationButtonHeight * 0.08
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: (operationButtonHeight) ? operationButtonHeight : 1 // avoid warning
                opacity: upButtonButton.down ? 0.4 : 1
            }
            Button{
                id: upButtonButton
                focusPolicy: Qt.WheelFocus
                opacity: 0
                autoRepeat: true
                anchors.fill: parent
                onClicked: slider.value = slider.value + slider.stepSize
            }
        }

        Text {
            id: magnitudeLabel
            color: Storage.getAppDB(Constants.dbAppColor.bloodVolumeValueId, "black")
            text: formatMagnitudeLabel(formatFractionalPart(slider.value))
            width: slider.width * 0.75
            height: parent.width * 0.13
            anchors.bottom: mainImage.bottom
            anchors.bottomMargin: -(height * 0.2)
            anchors.horizontalCenter: slider.horizontalCenter
            anchors.horizontalCenterOffset: slider.width * 0.02
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.width * 0.16
            fontSizeMode: Text.Fit

            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "brown"
                visible: viewGrid
            }
        }

        Text {
            id: unitsLabel
            color: Storage.getAppDB(Constants.dbAppColor.bloodVolumeUnitsId, "black")
            text: "--"
            width: parent.width * 0.241
            height: parent.width * 0.078
            anchors.right: cancelButton.left
            anchors.rightMargin: parent.width * 0.02
            anchors.top: parent.top
            anchors.topMargin: parent.width * 0.02
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: parent.width * 0.05
            fontSizeMode: Text.Fit

            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "lightblue"
                visible: viewGrid
            }
        }
    }
}
