// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.0 as QQC1
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Styles 1.4

import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies
import "DebugConstants.js" as DC
import "Singletons"

Rectangle{
    id: salineHemoTherapyCalculator

    property int reducedViewX: 0
    property int reducedViewY: 0
    property int reducedViewWidth: 0
    property int reducedViewHeight: 0

    property int fullViewX: QtConstants.fullViewInputElementX
    property int fullViewY: QtConstants.fullViewInputElementY + QtConstants.magnitudeSelectorY
    property int fullViewWidth: QtConstants.fullViewInputElementWith
    property int fullViewHeight: QtConstants.fullViewInputElementWith * QtConstants.fullViewInputElementAspectRatio

    property int buttonRadius: salineHemoTherapyCalculator.width * 0.008
    property int operationButtonWidth: salineHemoTherapyCalculator.width * 0.085
    property int operationButtonHeight: salineHemoTherapyCalculator.width * 0.085
    property int sliderHandlePressed: salineHemoTherapyCalculator.width * 0.080
    property int sliderHandleUnpressed: salineHemoTherapyCalculator.width * 0.070
    property int sliderRectangleHeight: salineHemoTherapyCalculator.width * 0.014

    property int framneBorderWidth: salineHemoTherapyCalculator.width * 0.0022
    property int framneBorderRadius: buttonRadius
    property int frameMargin: -salineHemoTherapyCalculator.width * 0.00977
    property string framneColor: "transparent"
    property string framneBorderColor: buttonsColor

    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcButtonId, "black")
    property string sliderColor1: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcSlider1Id, "black")
    property string pressSliderColor1: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcPressSlider1Id, "black")
    property string sliderColor2: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcSlider2Id, "black")
    property string pressSliderColor2: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcPressSlider2Id, "black")
    property string maxAllowedResultColor: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcMaxValueId, "black")

    property double maxAllowedResult: 0
    property double maxPatientWeight: 1
    property double weightConversionFactor: 1

    property bool viewGrid: false

    function resultingValue(){
        var retValue

        retValue = 4 * concentrationSlider.value * (weightSlider.value * weightConversionFactor)/ magnitudeSelector.inputSalineVolume.slider.value
        retValue = Math.round(retValue / magnitudeSelector.inputO3.conversionFactor)

        if(retValue > maxAllowedResult){
            retValue = maxAllowedResult
            resultingMagnitudeLabel.color = maxAllowedResultColor
            resultingMagnitudeLabelOpacityAnimator.running = true
        }else{
            resultingMagnitudeLabel.color = pressSliderColor1
            resultingMagnitudeLabelOpacityAnimator.running = false
            resultingMagnitudeLabel.opacity = 1
        }
        if(retValue === 0){
            retValue = 1
        }
        return retValue
    }

    function initConcentrationSliderOnStartUp(){
        var retValue

        retValue = Math.round((magnitudeSelector.inputO3.slider.value * magnitudeSelector.inputSalineVolume.slider.value) / (4 * (weightSlider.value * weightConversionFactor)))

        console.log("magnitudeSelector.inputO3.slider.value:           ", magnitudeSelector.inputO3.slider.value)
        console.log("magnitudeSelector.inputSalineVolume.slider.value: ", magnitudeSelector.inputSalineVolume.slider.value)
        console.log("weightSlider.value:                               ", weightSlider.value)
        console.log("weightConversionFactor:                           ", weightConversionFactor)
        console.log("initConcentrationSliderOnStartUp:                 ", retValue)

        return retValue
    }

    function getDataBaseParameters(){
        unitsLabel.text = magnitudeSelector.inputSalineVolume.unitsLabel.text
        maxAllowedResult = magnitudeSelector.inputO3.slider.to
        maxPatientWeight = Storage.getAppDB(Constants.dbConstants.salineHemoTherapyCalcMaxPatientWeightId, "")

        if( Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsId, "*") ===
                Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsAId, "*") ){
            weightSliderMagnitudeUnits.text = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsAId, "1")
            weightConversionFactor = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.conversionFactorAId, "1")
        }
        else{
            weightSliderMagnitudeUnits.text = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsBId, "1")
            weightConversionFactor = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.conversionFactorBId, "1")
        }
    }

    states:[
        State{
            name: "salineHemoTherapyCalculatorStart"
            PropertyChanges { target: salineHemoTherapyCalculator; visible: true }
        },
        State{
            name: "noViewalineHemoTherapyCalculator"
            PropertyChanges { target: salineHemoTherapyCalculator; visible: false }
            StateChangeScript {script: Therapies.completeGadgetCloseEffect()}
        },
        State{
            name: "noViewSalineHemoTherapyCalculatorQuick"
              PropertyChanges { target: salineHemoTherapyCalculator; visible: false }
        },
        State{
            name: "viewSalineHemoTherapyCalculatorStartPending"
        }
    ]

    z:1
    radius: width * 0.006
    x: fullViewX
    y: fullViewY
    width: fullViewWidth
    height: fullViewHeight
    state: "noViewalineHemoTherapyCalculator"
    color: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalculatorId, "black")

    onVisibleChanged: {
        if(visible){
            maxAllowedResult = magnitudeSelector.inputO3.slider.to
            concentrationSlider.value = initConcentrationSliderOnStartUp()
        }
    }

    Component.onCompleted: {
        getDataBaseParameters()
        weightSlider.value = Math.round(80 / weightConversionFactor)
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
                //DEB->debug.log(DC.syringeCalculatorLog, "cancel button clicked (saline HemoTherapy calculator calculator)...")
                salineHemoTherapyCalculator.state = "noViewalineHemoTherapyCalculator"
                Therapies.exitLaunchSalineHemoTherapyCalculator()
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
                //DEB->debug.log(DC.bloodVolumeLog, "save button clicked (saline hemo therapy calculator volume)...")
                labelForSavingEffect.state = "saving"
            }
        }

    }

    Text {
        id: unitsLabel
        color: sliderColor1
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

    Text {
        id: resultingMagnitudeLabel
        color: pressSliderColor1
        text: resultingValue()
        height: parent.width * 0.13
        anchors.top: parent.top
        anchors.topMargin: parent.width * 0.03
        anchors.left: concentrationDownButton.left
        anchors.right: concentrationUpButton.right
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: parent.width * 0.8
        fontSizeMode: Text.Fit

        OpacityAnimator {
            id: resultingMagnitudeLabelOpacityAnimator
            property int counter: 0
            target: resultingMagnitudeLabel
            from: 0.3
            to: 1
            duration: 250;
            running: false
            onFinished: {
                if(++counter === 2){
                    counter = 0
                    running = false
                }else{
                    running = true
                }
            }
            easing {
                type: Easing.InOutExpo
            }
        }

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "brown"
            visible: viewGrid
        }
    }

    //
    //  Concentation controls
    //
    Rectangle {
        id: concentrationFrame

        anchors.left: concentrationImage.left
        anchors.right: concentrationSliderMagnitudeLabel.right
        anchors.top: concentrationImage.top
        anchors.bottom: saveButton.bottom

        anchors.leftMargin: frameMargin * 0.5
        anchors.rightMargin: frameMargin
        anchors.topMargin: frameMargin

        color: framneColor
        border.color: buttonsColor
        border.width: framneBorderWidth
        radius: framneBorderRadius

    }

    Slider {
        id: concentrationSlider
        from: 1
        to: Storage.getAppDB(Constants.dbConstants.salineHemoTherapyCalcMaxO3PerKgId, "")
        value: 15
        stepSize: 1
        anchors.right: concentrationUpButton.left
        anchors.rightMargin: parent.width * 0.035
        anchors.left: concentrationDownButton.right
        anchors.leftMargin: parent.width * 0.035
        anchors.verticalCenter: concentrationDownButton.verticalCenter
        height: sliderHandlePressed

        background: Rectangle {
            id: sliderBackgroundInactive
            x: concentrationSlider.leftPadding
            y: concentrationSlider.topPadding + concentrationSlider.availableHeight / 2 - height / 2
            width: concentrationSlider.availableWidth
            height: sliderRectangleHeight
            radius: (sliderRectangleHeight / 2) + 1
            color: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcBackSliderId, "black")

            Rectangle {
                id: deactivated
                width: concentrationSlider.visualPosition * parent.width
                height: parent.height
                color: sliderColor1
                radius: sliderRectangleHeight / 2
            }
        }
        handle: Rectangle {
            id: sliderHandle
            x: concentrationSlider.leftPadding + concentrationSlider.visualPosition * (concentrationSlider.availableWidth - width)
            y: concentrationSlider.topPadding + concentrationSlider.availableHeight / 2 - height / 2
            width: concentrationSlider.pressed ? sliderHandlePressed : sliderHandleUnpressed
            height: sliderHandle.width
            radius: (sliderHandlePressed / 2) + 1
            color: concentrationSlider.pressed ?  pressSliderColor1 : sliderColor1
        }
    }

    Image {
        id: concentrationImage
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.012
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.03
        width: parent.width * 0.10
        height: concentrationImage.width
        source: Storage.getAppDB(Constants.dbAppIcon.doseTypeId, "")
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
        id: concentrationDownButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.left: concentrationImage.right
        anchors.leftMargin: operationButtonHeight * 0.35
        anchors.verticalCenter: concentrationImage.verticalCenter
        Text{
            color: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcSlider1Id, "black")
            text: "_"
            anchors.fill: parent
            anchors.bottomMargin: operationButtonHeight * 0.45
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            font.pointSize: (operationButtonHeight) ? operationButtonHeight : 1 // avoid warning
            opacity: concentrationDownButtonButton.down ? 0.4 : 1
        }
        Button{
            id: concentrationDownButtonButton
            opacity: 0
            autoRepeat: true
            anchors.fill: parent
            onClicked: concentrationSlider.value = concentrationSlider.value - concentrationSlider.stepSize
        }
    }

    Text {
        id: concentrationSliderMagnitudeLabel
        color: pressSliderColor1
        text: concentrationSlider.value
        width: concentrationDownButton.width * 1.5//2.5
        height: concentrationDownButton.height * 0.55//0.75
        anchors.bottom: concentrationDownButton.verticalCenter
        anchors.right: saveButton.left
        anchors.rightMargin: parent.width * 0.02

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: parent.height
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "brown"
            visible: viewGrid
        }
    }

    Text {
        id: concentrationSliderMagnitudeUnits
        color: sliderColor1
        text: "\u03BCg/kg"
        width: concentrationDownButton.width * 1.5//2.5
        height: concentrationDownButton.height * 0.55//0.75
        anchors.top: concentrationDownButton.verticalCenter
        anchors.right: saveButton.left
        anchors.rightMargin: parent.width * 0.02

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: parent.height
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "orange"
            visible: viewGrid
        }
    }

    Rectangle {
        id: concentrationUpButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.top: concentrationDownButton.top
        anchors.topMargin: 0
        anchors.right: concentrationSliderMagnitudeLabel.left
        anchors.rightMargin: parent.width * 0.02
        Text{
            color: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcSlider1Id, "black")
            text: "+"
            anchors.bottomMargin: operationButtonHeight * 0.08
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: (operationButtonHeight) ? operationButtonHeight : 1 // avoid warning
            opacity: concentrationUpButtonButton.down ? 0.4 : 1
        }
        Button{
            id: concentrationUpButtonButton
            opacity: 0
            autoRepeat: true
            anchors.fill: parent
            onClicked: concentrationSlider.value = concentrationSlider.value + concentrationSlider.stepSize
        }
    }

    //
    // Weight controls
    //
    Rectangle {
        id: weightFrame

        anchors.left: concentrationFrame.left
        anchors.right: concentrationFrame.right
        anchors.top: weightImage.top
        anchors.bottom: weightImage.bottom

        anchors.topMargin: frameMargin
        anchors.bottomMargin: frameMargin

        color: framneColor
        border.color: buttonsColor
        border.width: framneBorderWidth
        radius: framneBorderRadius
    }

    Slider {
        id: weightSlider
        from: 1
        to: Math.round(maxPatientWeight / weightConversionFactor)
        value: 80 / weightConversionFactor
        stepSize: 1
        anchors.right: weightUpButton.left
        anchors.rightMargin: parent.width * 0.035
        anchors.left: weightDownButton.right
        anchors.leftMargin: parent.width * 0.035
        anchors.verticalCenter: weightDownButton.verticalCenter
        height: sliderHandlePressed
        background: Rectangle {
            id: weightSliderBackgroundInactive
            x: weightSlider.leftPadding
            y: weightSlider.topPadding + weightSlider.availableHeight / 2 - height / 2
            width: weightSlider.availableWidth
            height: sliderRectangleHeight
            radius: (sliderRectangleHeight / 2) + 1
            color: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcBackSliderId, "black")

            Rectangle {
                id: weightDeactivated
                width: weightSlider.visualPosition * parent.width
                height: parent.height
                color: sliderColor2
                radius: sliderRectangleHeight / 2
            }
        }
        handle: Rectangle {
            id: weightSliderHandle
            x: weightSlider.leftPadding + weightSlider.visualPosition * (weightSlider.availableWidth - width)
            y: weightSlider.topPadding + weightSlider.availableHeight / 2 - height / 2
            width: weightSlider.pressed ? sliderHandlePressed : sliderHandleUnpressed
            height: weightSliderHandle.width
            radius: (sliderHandlePressed / 2) + 1
            color: weightSlider.pressed ?  pressSliderColor2 : sliderColor2
        }
    }

    Image {
        id: weightImage
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.012
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.17
        width: concentrationImage.width
        height: concentrationImage.height
        source: Storage.getAppDB(Constants.dbAppIcon.patientWeight2Id, "")
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "orange"
            visible: viewGrid
        }
    }

    Rectangle {
        id: weightDownButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.left: weightImage.right
        anchors.leftMargin: operationButtonHeight * 0.35
        anchors.verticalCenter: weightImage.verticalCenter
        Text{
            color: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcSlider2Id, "black")
            text: "_"
            anchors.fill: parent
            anchors.bottomMargin: operationButtonHeight * 0.45
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            font.pointSize: (operationButtonHeight) ? operationButtonHeight : 1 // avoid warning
            opacity: weightDownButtonButton.down ? 0.4 : 1
        }
        Button{
            id: weightDownButtonButton
            opacity: 0
            autoRepeat: true
            anchors.fill: parent
            onClicked: weightSlider.value = weightSlider.value - weightSlider.stepSize
        }
    }

    Text {
        id: weightSliderMagnitudeLabel
        color: pressSliderColor2
        text: weightSlider.value
        width: weightDownButton.width * 1.5//2.5
        height: weightDownButton.height * 0.55//0.75
        anchors.bottom: weightDownButton.verticalCenter
        anchors.right: saveButton.left
        anchors.rightMargin: parent.width * 0.02

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: parent.height
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "brown"
            visible: viewGrid
        }
    }

    Text {
        id: weightSliderMagnitudeUnits
        color: sliderColor2
        text: "--"
        width: weightDownButton.width * 1.5//2.5
        height: weightDownButton.height * 0.55

        anchors.top: weightDownButton.verticalCenter
        anchors.right: saveButton.left
        anchors.rightMargin: parent.width * 0.02

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: parent.height
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "orange"
            visible: viewGrid
        }
    }

    Rectangle {
        id: weightUpButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.top: weightDownButton.top
        anchors.topMargin: 0
        anchors.right: weightSliderMagnitudeLabel.left
        anchors.rightMargin: parent.width * 0.02
        Text{
            color: Storage.getAppDB(Constants.dbAppColor.salineHemoTherapyCalcSlider2Id, "black")
            text: "+"
            anchors.bottomMargin: operationButtonHeight * 0.08
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: (operationButtonHeight) ? operationButtonHeight : 1 // avoid warning
            opacity: weightUpButtonButton.down ? 0.4 : 1
        }
        Button{
            id: weightUpButtonButton
            focusPolicy: Qt.WheelFocus
            opacity: 0
            autoRepeat: true
            anchors.fill: parent
            onClicked: weightSlider.value = weightSlider.value + weightSlider.stepSize
        }
    }

//
//  Saving effect
//
    Rectangle{
        id: fakeRectangleForSavingEffect
        opacity: (viewGrid) ? 1 : 0
        x: magnitudeSelector.x + magnitudeSelector.inputO3.x + magnitudeSelector.inputO3.magnitudeLabel.x - salineHemoTherapyCalculator.x
        y: magnitudeSelector.y + magnitudeSelector.inputO3.y + magnitudeSelector.inputO3.magnitudeLabel.y - salineHemoTherapyCalculator.y
        width: magnitudeSelector.inputBloodVolume.magnitudeLabel.width
        height: magnitudeSelector.inputBloodVolume.magnitudeLabel.height
        color: "transparent"
        border.color: "yellow"
    }

    Text {
        id: labelForSavingEffect
        states: [
            State {
                name: "saving"
                PropertyChanges { target: labelForSavingEffect; font.pixelSize: magnitudeSelector.inputO3.magnitudeLabel.font.pixelSize }

                AnchorChanges { target: labelForSavingEffect; anchors.horizontalCenter: fakeRectangleForSavingEffect.horizontalCenter }
                AnchorChanges { target: labelForSavingEffect; anchors.verticalCenter: fakeRectangleForSavingEffect.verticalCenter }
            },
            State {
                name: "saved"
                PropertyChanges { target: labelForSavingEffect; opacity: 0}
                PropertyChanges { target: labelForSavingEffect; font.pixelSize: parent.width * 0.11 }
                AnchorChanges { target: labelForSavingEffect; anchors.horizontalCenter: resultingMagnitudeLabel.horizontalCenter }
                AnchorChanges { target: labelForSavingEffect; anchors.verticalCenter: resultingMagnitudeLabel.verticalCenter }
                StateChangeScript {script: magnitudeSelector.inputO3.refreshSlider()}
            }
        ]
        transitions: [
            Transition {
                to: "saving"
                SequentialAnimation{
                    PropertyAnimation { target: labelForSavingEffect; property: "opacity"; to:1; duration: 0}
                    ParallelAnimation{
                        AnchorAnimation {duration: 400}
                        PropertyAnimation { target: labelForSavingEffect; property: "font.pixelSize"; to: magnitudeSelector.inputO3.magnitudeLabel.font.pixelSize * 0.6; easing.type: Easing.Linear; duration: 400}
                        PropertyAnimation { target: labelForSavingEffect; property: "opacity"; to:0; duration: 400}
                    }
                    PropertyAnimation { target: magnitudeSelector.inputO3.magnitudeLabel; property: "text"; to: labelForSavingEffect.text}
                    PropertyAnimation { target: labelForSavingEffect; property: "state"; to: "saved"}
                }
            }
        ]
        opacity: 0
        width: resultingMagnitudeLabel.width
        height: resultingMagnitudeLabel.height
        anchors.horizontalCenter: resultingMagnitudeLabel.horizontalCenter
        anchors.verticalCenter: resultingMagnitudeLabel.verticalCenter
        text: resultingMagnitudeLabel.text
        color: resultingMagnitudeLabel.color
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.width * 0.11

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "blue"
            visible: viewGrid
        }
    }
}
