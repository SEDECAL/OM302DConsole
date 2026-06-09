// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.0 as QQC1
import QtGraphicalEffects 1.0

import QtQuick.LocalStorage 2.0
import QtQuick.Controls.Styles 1.4

import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies
import "DebugConstants.js" as DC
import "Singletons"

Rectangle{
    id: syringeCalculatorTest
    color: "#333333"

//  property alias concentrationSlider: concentrationSlider
//  property alias unitsLabel: unitsLabel
//  property alias concentrationSliderMagnitudeLabel: concentrationSliderMagnitudeLabel

    property bool viewGrid: false

    property int operationButtonWidth: syringeCalculatorTest.width * 0.085
    property int operationButtonHeight: syringeCalculatorTest.width * 0.085
    property int buttonRadius: syringeCalculatorTest.width * 0.008
    property int sliderRectangleHeight: syringeCalculatorTest.width * 0.014
    property int sliderHandlePressed: syringeCalculatorTest.width * 0.080
    property int sliderHandleUnpressed: syringeCalculatorTest.width * 0.070

    property int enlargeTime: 300

    property int reducedViewX: 0
    property int reducedViewY: 0
    property int reducedViewWidth: 0
    property int reducedViewHeight: 0

    property int unitsLabelFullViewWidth: syringeCalculatorTest.width * 0.241
    property int unitsLabelReducedViewWidth: 0
    property int unitsLabelFullViewHeight: syringeCalculatorTest.width * 0.078
    property int unitsLabelReducedViewHeight: 0

    property string buttonsColor: "#292929"
    property string sliderColor: "#0097A7"
    property string secondSliderColor: "#80DEEA"
    property string syringeTypeSliderColor: "#388E3C"
    property string syringeTypeSecondSliderColor: "#81C784"

    property int    radioButtonSelection: 0
    property int    radioButtonSize: syringeCalculatorTest.width * 0.048
    property string radioButtonColor: syringeTypeSliderColor
    property string radioButtonSelectedColor: syringeTypeSecondSliderColor
    property double improveReducedViewEffect: 1
    property string lastMagnitudeLabelText: "0"

    property double opacityOnTransition: 0
    property bool manualModeVisibility:false

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
            case 2: volume = 50;  break;
            case 3: volume = 100; break;
            }

        return value * volume
    }

    function formatManualMagnitudeLabel(value){
        var volume

            volume = syringeTypeSlider.value

        return value * volume
    }

    states:[
        State{//manualModeVisibility
            name: "viewAutomaticSyringeCalculatorTest"
            AnchorChanges { target: syringeCalculatorTest; anchors.top: fullViewTransitionDestiny.top }
            AnchorChanges { target: syringeCalculatorTest; anchors.bottom: fullViewTransitionDestiny.bottom }
            AnchorChanges { target: syringeCalculatorTest; anchors.left: fullViewTransitionDestiny.left }
            AnchorChanges { target: syringeCalculatorTest; anchors.right: fullViewTransitionDestiny.right }
        },
        State{
            name: "viewManualSyringeCalculatorTest"
            AnchorChanges { target: syringeCalculatorTest; anchors.top: fullViewTransitionDestiny.top }
            AnchorChanges { target: syringeCalculatorTest; anchors.bottom: fullViewTransitionDestiny.bottom }
            AnchorChanges { target: syringeCalculatorTest; anchors.left: fullViewTransitionDestiny.left }
            AnchorChanges { target: syringeCalculatorTest; anchors.right: fullViewTransitionDestiny.right }
        },
        State{
            name: "noViewSyringeCalculatorTest"
            AnchorChanges { target: syringeCalculatorTest; anchors.top: reducedViewTransitionDestiny.top }
            AnchorChanges { target: syringeCalculatorTest; anchors.bottom: reducedViewTransitionDestiny.bottom }
            AnchorChanges { target: syringeCalculatorTest; anchors.left: reducedViewTransitionDestiny.left }
            AnchorChanges { target: syringeCalculatorTest; anchors.right: reducedViewTransitionDestiny.right }
        }
    ]

    transitions:[
        Transition {
            to: "viewAutomaticSyringeCalculatorTest"
            SequentialAnimation{
                PropertyAnimation {target: syringeCalculatorTest; property: "manualModeVisibility"; to: false}
                AnchorAnimation {duration: enlargeTime}
                PropertyAnimation {target: syringeCalculatorTest; property: "opacityOnTransition"; to: 1; duration: enlargeTime}
            }
        },
        Transition {
            to: "viewManualSyringeCalculatorTest"
            SequentialAnimation{
                PropertyAnimation {target: syringeCalculatorTest; property: "manualModeVisibility"; to: true}
                AnchorAnimation {duration: enlargeTime}
                PropertyAnimation {target: syringeCalculatorTest; property: "opacityOnTransition"; to: 1; duration: enlargeTime}
            }
        },
        Transition {
            to: "noViewSyringeCalculatorTest"
            SequentialAnimation{
                PropertyAnimation {target: syringeCalculatorTest; property: "opacityOnTransition"; to: 0; duration: enlargeTime * 0.4}
                AnchorAnimation {duration: enlargeTime * 0.8}
            }
        }
    ]



    /*

    automaticMagnitudeLabel
    unitsLabel
    concentrationSliderMagnitudeLabel
concentrationSliderMagnitudeUnits
    syringeType

*/
    z:1
    radius: width * 0.006
//    x: reducedViewX
//    y: reducedViewY
//    width: reducedViewWidth
//    height: reducedViewHeight
    state: "noViewSyringeCalculatorTest"

    anchors.top: reducedViewTransitionDestiny.top
    anchors.bottom: reducedViewTransitionDestiny.bottom
    anchors.left: reducedViewTransitionDestiny.left
    anchors.right: reducedViewTransitionDestiny.right
    visible: true

    Component.onCompleted: {
//      state= "noViewSyringeCalculatorTestStart"
    }

    Label {
        id: automaticMagnitudeLabel
        color: secondSliderColor
        text: formatAutomaticMagnitudeLabel(formatFractionalPart(concentrationSlider.value)) + " \u03BCg"
        width: parent.width
        height: parent.width * 0.13
        opacity: opacityOnTransition
        visible: !(manualModeVisibility)

        anchors.top: parent.top
        anchors.topMargin: parent.width * 0.03
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 0

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: height //parent.width * 0.8
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "brown"
            visible: viewGrid
        }
    }

    Label {
        id: manualMagnitudeLabel
        color: secondSliderColor
        text: formatManualMagnitudeLabel(formatFractionalPart(concentrationSlider.value)) + " \u03BCg"
        width: parent.width
        height: parent.width * 0.13
        opacity: opacityOnTransition
        visible: manualModeVisibility

        anchors.top: parent.top
        anchors.topMargin: parent.width * 0.03
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 0

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: height//parent.width * 0.8
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "brown"
            visible: viewGrid
        }
    }

    Label {
        id: unitsLabel
        color: secondSliderColor
//      visible: false
        text: "\u03BCg"
        width: parent.width * 0.241
        height: parent.width * 0.078
        anchors.right: cancelButton.left
        anchors.rightMargin: parent.width * 0.02
        anchors.top: parent.top
        anchors.topMargin: parent.width * 0.02
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height //parent.width * 0.05
        fontSizeMode: Text.Fit
        opacity: opacityOnTransition
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
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
        source: "Images/OZONO 01.png"
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
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
            source: "Images/ic_back_01_white_48dp.png"
            opacity: cancelButtonButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        MouseArea{
            id: cancelButtonButton
            anchors.fill: parent
            onClicked: {
                debug.log(DC.syringeCalculatorTestLog, "cancel button clicked (syringe calculator)...")
                syringeCalculatorTest.state = "noViewSyringeCalculatorTest"
            }
        }
    }

//
//  Concentation controls
//
    Slider {
        id: concentrationSlider
        from: 1
        to: 80
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
            color: "#FFFFFF"

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
            color: concentrationSlider.pressed ?  secondSliderColor : sliderColor
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

        Label{
            color: "white"
            text: "_"
            anchors.fill: parent
            anchors.bottomMargin: operationButtonHeight * 0.45
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            font.pointSize: operationButtonHeight
            opacity: opacityOnTransition * (concentrationUpButtonButton.down ? 0.4 : 1)
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

        Label{
            color: "white"
            text: "+"
            anchors.bottomMargin: operationButtonHeight * 0.08
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: operationButtonHeight
            opacity: opacityOnTransition * (concentrationUpButtonButton.down ? 0.4 : 1)
        }
        Button{
            id: concentrationUpButtonButton
            focusPolicy: Qt.WheelFocus
            opacity: 0
            autoRepeat: true
            anchors.fill: parent
            onClicked: concentrationSlider.value = concentrationSlider.value + concentrationSlider.stepSize
        }
    }

    Label {
        id: concentrationSliderMagnitudeLabel
        color: secondSliderColor
        text: formatSliderLabel(formatFractionalPart(concentrationSlider.value))
        width: concentrationDownButton.width * 2.5
        height: concentrationDownButton.height * 0.55//0.75
        opacity: opacityOnTransition

        anchors.bottom: concentrationDownButton.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.02

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: height//parent.height
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "brown"
            visible: viewGrid
        }
    }

    Label {
        id: concentrationSliderMagnitudeUnits
        color: sliderColor
        text: "\u03BCg/Nml"
        width: concentrationDownButton.width * 2.5
        height: concentrationDownButton.height * 0.55//0.75
        opacity: opacityOnTransition

        anchors.top: concentrationDownButton.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.02

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: height
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "orange"
            visible: viewGrid
        }
    }

    Image {
        id: syringeImage
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.012
        anchors.bottom: concentrationImage.top
        anchors.bottomMargin: parent.width * 0.022
        width: concentrationImage.width
        height: concentrationImage.height
        source: "Images/JERINGA 04 192x192.png"
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "orange"
            visible: viewGrid
        }
    }

//
//  Syringe type controls (using slider)
//
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
        visible: manualModeVisibility

        background: Rectangle {
            id: syringeTypeSliderBackgroundInactive
            x: syringeTypeSlider.leftPadding
            y: syringeTypeSlider.topPadding + syringeTypeSlider.availableHeight / 2 - height / 2
            width: syringeTypeSlider.availableWidth
            height: sliderRectangleHeight
            radius: (sliderRectangleHeight / 2) + 1
            color: "#FFFFFF"//"#bdbebf"

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
            color: syringeTypeSlider.pressed ?  syringeTypeSecondSliderColor : syringeTypeSliderColor
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
        visible: manualModeVisibility

        Label{
            color: "white"
            text: "_"
            anchors.fill: parent
            anchors.bottomMargin: operationButtonHeight * 0.45
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            font.pointSize: operationButtonHeight
            opacity: opacityOnTransition * (syringeTypeDownButtonButton.down ? 0.4 : 1)
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
        visible: manualModeVisibility

        Label{
            color: "white"
            text: "+"
            anchors.bottomMargin: operationButtonHeight * 0.08
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: operationButtonHeight
            opacity: opacityOnTransition * (syringeTypeUpButtonButton.down ? 0.4 : 1)
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
        color: syringeTypeSecondSliderColor
        text: formatSliderLabel(formatFractionalPart(syringeTypeSlider.value))
        width: syringeTypeDownButton.width * 2.5
        height: syringeTypeDownButton.height * 0.55//0.75
        opacity: opacityOnTransition
        visible: manualModeVisibility

        anchors.bottom: syringeTypeDownButton.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.02

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: height//parent.height
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "brown"
            visible: viewGrid
        }
    }

    Label {
        id: syringeTypeSliderMagnitudeUnits
        color: syringeTypeSliderColor
        text: "cc"
        width: syringeTypeDownButton.width * 2.5
        height: syringeTypeDownButton.height * 0.55
        opacity: opacityOnTransition
        visible: manualModeVisibility

        anchors.top: syringeTypeDownButton.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.02

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: height
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "orange"
            visible: viewGrid
        }
    }

//
//  Syringe type controls (using radio buttons)
//
    GroupBox {
        id: syringeType
        anchors.left: syringeImage.right
        anchors.leftMargin: operationButtonHeight * 0.35
        anchors.verticalCenter: syringeImage.verticalCenter
        opacity: opacityOnTransition
        visible: !(manualModeVisibility)

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
                    case 2: qsTr("50 ml"); break;
                    case 3: qsTr("100 ml"); break;
                    }

                    spacing: radioButtonSize * 0.01

                    indicator: Rectangle {
                        implicitWidth: radioButtonSize
                        implicitHeight: radioButtonSize
                        radius: radioButtonSize * 0.5
                        border.width: radioButtonSize * 0.1
                        border.color: "white"
                        color: "transparent"
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            width: radioButtonSize * 0.83
                            height: width
                            radius: width * 0.5
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
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
                            color: "#00000000"
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
