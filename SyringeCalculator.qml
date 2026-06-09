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
    id: syringeCalculator

    property alias concentrationSlider: concentrationSlider
    property alias unitsLabel: unitsLabel
    property alias concentrationSliderMagnitudeLabel: concentrationSliderMagnitudeLabel
    property alias syringeImage: syringeImage

    property int operationButtonWidth: syringeCalculator.width * 0.085
    property int operationButtonHeight: syringeCalculator.width * 0.085
    property int buttonRadius: syringeCalculator.width * 0.008
    property int sliderRectangleHeight: syringeCalculator.width * 0.014
    property int sliderHandlePressed: syringeCalculator.width * 0.080
    property int sliderHandleUnpressed: syringeCalculator.width * 0.070
    property int enlargeTime: 250
    property int shrinkTime: 150
    property int fadeOffTime: 100
    property int appearTime: 250

    property int reducedViewX: 0
    property int reducedViewY: 0
    property int reducedViewWidth: 0
    property int reducedViewHeight: 0

    property int fullViewX: QtConstants.fullViewInputElementX
    property int fullViewY: QtConstants.fullViewInputElementY + QtConstants.magnitudeSelectorY
    property int fullViewWidth: QtConstants.fullViewInputElementWith
    property int fullViewHeight: QtConstants.fullViewInputElementWith * QtConstants.fullViewInputElementAspectRatio

    property int unitsLabelFullViewWidth: syringeCalculator.width * 0.241
    property int unitsLabelReducedViewWidth: 0
    property int unitsLabelFullViewHeight: syringeCalculator.width * 0.078
    property int unitsLabelReducedViewHeight: 0
    property int radioButtonSelection: 0
    property int radioButtonSize: syringeCalculator.width * 0.044 // * 0.048

    property int framneBorderWidth: syringeCalculator.width * 0.0022
    property int framneBorderRadius: buttonRadius
    property int frameMargin: -syringeCalculator.width * 0.00977
    property string framneColor: "transparent"
    property string framneBorderColor: buttonsColor

    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorButtonId, "black")
    property string sliderColor: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorSlider1Id, "black")
    property string pressSliderColor: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorPressSlider1Id, "black")
    property string syringeTypeSliderColor: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorSlider2Id, "black")
    property string syringeTypePressSliderColor: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorPressSlider2Id, "black")
    property string radioButtonColor: syringeTypeSliderColor
    property string radioButtonSelectedColor: syringeTypePressSliderColor
    property string lastMagnitudeLabelText: "0"

    property double improveReducedViewEffect: 1

    property bool manualModeVisible: false
    property bool viewGrid: false


    function formatFractionalPart(value){

        if( Number(value) === parseInt(Number(value)) ){
            return value
        }
        else{
            return value.toFixed(2)
        }
    }

    function formatSliderLabel(value){
        if( Number(value) !== parseInt(Number(value)) ){
            if(value > 999){
                return Math.round(value)
            }
            else{
                return value.toLocaleString().replace(".", ",")
            }
        }
        else{
            return value
        }
    }

    function formatAutomaticMagnitudeLabel(value){
        var volume

        switch (radioButtonSelection){
        case 0: volume = 10;  break;
        case 1: volume = 20;  break;
        case 2: volume = 60;  break;
        case 3: volume = 100; break;
        }

        return value * volume
    }

    function formatManualMagnitudeLabel(value){
        var formatedValue

        formatedValue = (value * syringeTypeSlider.value).toLocaleString()
        formatedValue = formatedValue.replace(".", "*")
        formatedValue = formatedValue.replace(",", ".")
        formatedValue = formatedValue.replace("*", ",")
        return formatedValue
    }

    states:[
        State{
            name: "viewAutomaticSyringeCalculator"
            PropertyChanges { target: syringeCalculator; visible: true }
            PropertyChanges { target: syringeCalculatorCommonControlsId; visible: true }
            PropertyChanges { target: syringeCalculatorManualControlsId; visible: false }
            PropertyChanges { target: syringeCalculatorAutomaticControlsId; visible: true }
        },
        State{
            name: "viewManualSyringeCalculator"
            PropertyChanges { target: syringeCalculator; visible: true }
            PropertyChanges { target: syringeCalculatorCommonControlsId; visible: true }
            PropertyChanges { target: syringeCalculatorManualControlsId; visible: true }
            PropertyChanges { target: syringeCalculatorAutomaticControlsId; visible: false }
        },
        State{
            name: "noViewSyringeCalculator"
            PropertyChanges { target: syringeCalculator; visible: false }
            PropertyChanges { target: syringeCalculatorCommonControlsId;    visible: false }
            PropertyChanges { target: syringeCalculatorManualControlsId;    visible: false }
            PropertyChanges { target: syringeCalculatorAutomaticControlsId; visible: false }
            StateChangeScript {script: Therapies.completeGadgetCloseEffect()}
        },
        State{
            name: "noViewSyringeCalculatorQuick"
            PropertyChanges { target: syringeCalculator; visible: false }
            PropertyChanges { target: syringeCalculatorCommonControlsId;    visible: false }
            PropertyChanges { target: syringeCalculatorManualControlsId;    visible: false }
            PropertyChanges { target: syringeCalculatorAutomaticControlsId; visible: false }
        },
        State{
            name: "viewAutomaticSyringeCalculatorPending"
        },
        State{
            name: "viewManualSyringeCalculatorPending"
        }
    ]

    z:1
    radius: width * 0.006
    x: fullViewX
    y: fullViewY
    width: fullViewWidth
    height: fullViewHeight
    state: "noViewSyringeCalculator"
    visible: false
    color: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorPanelId, "black")

    Item{
        id: syringeCalculatorCommonControlsId
        visible: false
        opacity: 1
        anchors.fill: parent

        Rectangle {
            id: concentrationFrame

            anchors.left: concentrationImage.left
            anchors.right: concentrationSliderMagnitudeLabel.right
            anchors.top: concentrationImage.top
            anchors.bottom: concentrationImage.bottom

            anchors.leftMargin: frameMargin * 0.35
            anchors.rightMargin: frameMargin * 0.5
            anchors.topMargin: frameMargin
            anchors.bottomMargin: frameMargin

            color: framneColor
            border.color: buttonsColor
            border.width: framneBorderWidth
            radius: framneBorderRadius

        }

        Label {
            id: unitsLabel
            color: sliderColor
            text: "\u03BCg"
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

        Image {
            id: concentrationImage
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.012
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width * 0.03
            width: parent.width * 0.10
            height: concentrationImage.width
            source: Storage.getAppDB(Constants.dbAppIcon.concentrationId, "")
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
                    //DEB->debug.log(DC.syringeCalculatorLog, "cancel button clicked (syringe calculator)...")
                    syringeCalculator.state = "noViewSyringeCalculator"
                    Therapies.exitSyringeCalculator()
                }
            }
        }

        //
        //  Concentation controls
        //
        Slider {
            id: concentrationSlider
            from: 1
            to: 79
            value: 1
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
                color: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorBackSliderId, "black")

                Rectangle {
                    id: deactivated
                    width: concentrationSlider.visualPosition * parent.width
                    height: parent.height
                    color: sliderColor
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
                color: concentrationSlider.pressed ?  pressSliderColor : sliderColor
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
                color: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorSlider1Id, "black")
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
                color: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorSlider1Id, "black")
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

        Label {
            id: concentrationSliderMagnitudeLabel
            color: pressSliderColor
            text: formatSliderLabel(formatFractionalPart(concentrationSlider.value))
            width: concentrationDownButton.width * 2.5
            height: concentrationDownButton.height * 0.55
            anchors.bottom: concentrationDownButton.verticalCenter
            anchors.right: parent.right
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

        Label {
            id: concentrationSliderMagnitudeUnits
            color: sliderColor
            text: "\u03BCg/Nml"
            width: concentrationDownButton.width * 2.5
            height: concentrationDownButton.height * 0.55
            anchors.top: concentrationDownButton.verticalCenter
            anchors.right: parent.right
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
    }

    Item{
        id: syringeCalculatorManualControlsId
        visible: false //SC->
        opacity: 1 //SC->
        anchors.fill: parent
        //
        //  Syringe type controls (using slider)
        //

        Rectangle {
            id: syringeManualFrame

            anchors.left: syringeImage.left
            anchors.right: syringeTypeSliderMagnitudeLabel.right
            anchors.top: syringeImage.top
            anchors.bottom: syringeImage.bottom

            anchors.leftMargin: frameMargin * 0.35
            anchors.rightMargin: frameMargin * 0.5
            anchors.topMargin: frameMargin
            anchors.bottomMargin: frameMargin

            color: framneColor
            border.color: buttonsColor
            border.width: framneBorderWidth
            radius: framneBorderRadius

        }

        Label {
            id: manualMagnitudeLabel
            color: pressSliderColor
            text: formatManualMagnitudeLabel(formatFractionalPart(concentrationSlider.value))
            width: concentrationSlider.width
            height: parent.width * 0.13
            anchors.top: parent.top
            anchors.topMargin: parent.width * 0.03
            x: concentrationSlider.x
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.width * 0.8
            fontSizeMode: Text.Fit
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "orange"
                visible: viewGrid
            }
        }
        Image {
            id: syringeImage
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.012
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width * 0.17
            width: concentrationImage.width
            height: concentrationImage.height
            source: Storage.getAppDB(Constants.dbAppIcon.syringeTherapyId, "")
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

        Slider {
            id: syringeTypeSlider
            from: 0.5
            to: 150
            value: 1
            stepSize: 0.5
            anchors.right: syringeTypeUpButton.left
            anchors.rightMargin: parent.width * 0.035
            anchors.left: syringeTypeDownButton.right
            anchors.leftMargin: parent.width * 0.035
            anchors.verticalCenter: syringeTypeDownButton.verticalCenter
            height: sliderHandlePressed

            background: Rectangle {
                id: syringeTypeSliderBackgroundInactive
                x: syringeTypeSlider.leftPadding
                y: syringeTypeSlider.topPadding + syringeTypeSlider.availableHeight / 2 - height / 2
                width: syringeTypeSlider.availableWidth
                height: sliderRectangleHeight
                radius: (sliderRectangleHeight / 2) + 1
                color: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorBackSliderId, "black")

                Rectangle {
                    id: syringeTypeDeactivated
                    width: syringeTypeSlider.visualPosition * parent.width
                    height: parent.height
                    color: syringeTypeSliderColor
                    radius: sliderRectangleHeight / 2
                }
            }
            handle: Rectangle {
                id: syringeTypeSliderHandle
                x: syringeTypeSlider.leftPadding + syringeTypeSlider.visualPosition * (syringeTypeSlider.availableWidth - width)
                y: syringeTypeSlider.topPadding + syringeTypeSlider.availableHeight / 2 - height / 2
                width: syringeTypeSlider.pressed ? sliderHandlePressed : sliderHandleUnpressed
                height: syringeTypeSliderHandle.width
                radius: (sliderHandlePressed / 2) + 1
                color: syringeTypeSlider.pressed ?  syringeTypePressSliderColor : syringeTypeSliderColor
            }
        }

        Rectangle {
            id: syringeTypeDownButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.left: syringeImage.right
            anchors.leftMargin: operationButtonHeight * 0.35
            anchors.verticalCenter: syringeImage.verticalCenter
            Text{
                color: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorSlider2Id, "black")
                text: "_"
                anchors.fill: parent
                anchors.bottomMargin: operationButtonHeight * 0.45
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                font.pointSize: (operationButtonHeight) ? operationButtonHeight : 1 // avoid warning
                opacity: syringeTypeDownButtonButton.down ? 0.4 : 1
            }
            Button{
                id: syringeTypeDownButtonButton
                opacity: 0
                autoRepeat: true
                anchors.fill: parent
                onClicked: syringeTypeSlider.value = syringeTypeSlider.value - syringeTypeSlider.stepSize
            }
        }

        Rectangle {
            id: syringeTypeUpButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.top: syringeTypeDownButton.top
            anchors.topMargin: 0
            anchors.right: syringeTypeSliderMagnitudeLabel.left
            anchors.rightMargin: parent.width * 0.02
            Text{
                color: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorSlider2Id, "black")
                text: "+"
                anchors.bottomMargin: operationButtonHeight * 0.08
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: (operationButtonHeight) ? operationButtonHeight : 1 // avoid warning
                opacity: syringeTypeUpButtonButton.down ? 0.4 : 1
            }
            Button{
                id: syringeTypeUpButtonButton
                focusPolicy: Qt.WheelFocus
                opacity: 0
                autoRepeat: true
                anchors.fill: parent
                onClicked: syringeTypeSlider.value = syringeTypeSlider.value + syringeTypeSlider.stepSize
            }
        }

        Label {
            id: syringeTypeSliderMagnitudeLabel
            color: syringeTypePressSliderColor
            text: formatSliderLabel(formatFractionalPart(syringeTypeSlider.value))
            width: syringeTypeDownButton.width * 2.5
            height: syringeTypeDownButton.height * 0.55
            anchors.bottom: syringeTypeDownButton.verticalCenter
            anchors.right: parent.right
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

        Label {
            id: syringeTypeSliderMagnitudeUnits
            color: syringeTypeSliderColor
            text: "ml"
            width: syringeTypeDownButton.width * 2.5
            height: syringeTypeDownButton.height * 0.55
            anchors.top: syringeTypeDownButton.verticalCenter
            anchors.right: parent.right
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
    }

    Item{
        id: syringeCalculatorAutomaticControlsId
        visible: false
        opacity: 1
        anchors.fill: parent

        Rectangle {
            id: syringeAutomaticFrame
            anchors.left: syringeImageBis.left
            anchors.right: syringeType.right
            anchors.top: syringeImageBis.top
            anchors.bottom: syringeImageBis.bottom
            anchors.leftMargin: frameMargin * 0.35
            anchors.rightMargin: frameMargin * 2.2
            anchors.topMargin: frameMargin
            anchors.bottomMargin: frameMargin
            color: framneColor
            border.color: buttonsColor
            border.width: framneBorderWidth
            radius: framneBorderRadius
        }

        Label {
            id: automaticMagnitudeLabel
            color: pressSliderColor
            text: formatAutomaticMagnitudeLabel(formatFractionalPart(concentrationSlider.value))
            width: concentrationSlider.width
            height: parent.width * 0.13
            anchors.top: parent.top
            anchors.topMargin: parent.width * 0.03
            x: concentrationSlider.x
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.width * 0.8
            fontSizeMode: Text.Fit
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "purple"
                visible: viewGrid
            }
        }

        Image {
            id: syringeImageBis
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.012
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width * 0.17
            width: concentrationImage.width
            height: concentrationImage.height
            source: Storage.getAppDB(Constants.dbAppIcon.syringeTherapyId, "")
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

        //
        //  Syringe type controls (using radio buttons)
        //
        Rectangle{
            x:syringeType.x - 1
            y:syringeType.y - 1
            width: syringeType.width + 2
            height: syringeType.height + 2
            color: "transparent"
            border.color: Storage.getAppDB(Constants.dbAppColor.gadgetInOutEffectId, "black")
            border.width: 3
            z: syringeType.z +1

        }
        GroupBox {
            id: syringeType
            anchors.left: syringeImageBis.right
            anchors.leftMargin: operationButtonHeight * 0.35
            anchors.verticalCenter: syringeImageBis.verticalCenter

            Row {
                anchors.verticalCenter: parent.verticalCenter
                spacing: radioButtonSize * 0.5
                Repeater{
                    model: 4
                    RadioButton {
                        id: radioButtonId
                        text: switch (index){
                              case 0: qsTr("10 ml"); break;
                              case 1: qsTr("20 ml"); break;
                              case 2: qsTr("50/60 ml"); break;
                              case 3: qsTr("100 ml"); break;
                              }

                        spacing: radioButtonSize * 0.01

                        indicator: Rectangle {
                            implicitWidth: radioButtonSize
                            implicitHeight: radioButtonSize
                            radius: radioButtonSize * 0.5
                            border.width: radioButtonSize * 0.1
                            border.color: Storage.getAppDB(Constants.dbAppColor.syringeCalcultorRadioFrameId, "black")
                            color: "transparent"
                            anchors.verticalCenter: parent.verticalCenter

                            Rectangle {
                                width: radioButtonSize * 0.83
                                height: width
                                radius: width * 0.5
                                anchors.centerIn: parent
                                color: radioButtonSelectedColor
                                visible: radioButtonId.checked
                            }
                        }

                        contentItem: Text {
                            text: radioButtonId.text
                            font.pixelSize: radioButtonSize * 0.85
                            color: radioButtonId.checked ? radioButtonSelectedColor : radioButtonColor
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: radioButtonId.indicator.width + radioButtonId.spacing
                            Rectangle{
                                anchors.fill: parent
                                color: "transparent"
                                border.color: "lightblue"
                                visible: viewGrid
                            }
                        }

                        onCheckedChanged: {
                            if(radioButtonId.checked) {
                                radioButtonSelection = index
                            }
                        }
                        Component.onCompleted: {
                            if(index == 0){
                                radioButtonId.checked = true
                            }
                        }
                    }
                }
            }
        }
    }
}



