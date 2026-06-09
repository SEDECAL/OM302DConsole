// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

import QtQuick.LocalStorage 2.0
import "storage.js" as Storage


// Input_04.qml (19/03/2018): Init function added.
//                            Rename 'input_03' by inputControl
// Input_05.qml (20/03/2018): Progress_00 item evaluation here
// Input_06.qml (21/03/2018): Branch to other input format evaluation
// Input_07.qml (22/03/2018): Input_05 evolution to include Progress_01 as a sibling of inputForm (allowing to mange opacity independly)
// Input_08.qml (22/03/2018): Save initial position each time control changes a fullView mode
// Input_09.qml (12/04/2018): Implement fixed buttons saving system
// Input_10.qml (16/04/2018): Extending label movement effect on saving actions
// Input_11.qml (16/04/2018): Restore effect


Item {
    id: inputControl

    property int tit: 0
    property int initialX: 0
    property int initialY: 0
    property int fullViewX: 0
    property int fullViewY: 0
    property int fullViewWidth: 0
    property int fullViewHeight: 0
    property bool inspected: false
    property bool doubleLabelVisible: false
    property string name: "_"
    property string saveStamp: "_"
    property string startState: "reducedView"

    signal  verificado()


    property int convertToTimeFlow: 0
    property double initialSliderValue: 0 // slider value when the input frame is maximized
    property double magnitudeValue: Math.floor((slider.position * (slider.to - slider.from)) + slider.from)

    property string buttonsColor: "#292929"
    property string fixButtonTextColor: "#FFFFFF"

    property int operationButtonWidth: fullViewWidth * 0.085//0.1
    property int operationButtonHeight: fullViewWidth * 0.085//0.1
    property int fixButtonWidth: fullViewWidth * 0.1
    property int fixButtonHeight: fullViewWidth * 0.055//0.06
    property int fixButtonMargin: fullViewWidth * 0.025//0.03
    property int externalBorderMargin: fullViewWidth * 0.02
    property int sliderMargins: fullViewWidth * 0.035//0.04
    property int sliderverticalCenterOffset: fullViewWidth * 0.018
    property int upDownButtonBottomMargin: fullViewWidth * 0.12//0.08
    property int saveButtonBottomMargin: fullViewWidth * 0.12//0.08
    property int buttonRadius: fullViewWidth * 0.008
    property int fixButtonFontSize: fullViewWidth * 0.03
    property int magnitudeTextSize: fullViewWidth * 0.16
    property int unitsTextSize: fullViewWidth * 0.03
    property int backgroundRadius: fullViewWidth * 0.006//0.003
    property int mainImageSize: fullViewWidth * 0.20 //fullViewWidth * 0.25
    property int sliderRectangleHeight: fullViewWidth * 0.014
    property int sliderHandlePressed: fullViewWidth * 0.080
    property int sliderHandleUnpressed: fullViewWidth * 0.070

    property int mainImageWith_reducedView: 0
    property int mainImageMargin_reducedView: 0
    property int magnitudeLabelFontSize_reducedView: 0
    property int magnitudeLabelFontSize2_reducedView: 0
    property int magnitudeLabelWidth_reducedView: 0
    property int magnitudeLabelHeigtht_reducedView: 0
    property int magnitudeLabelX_reducedView: 0
    property int magnitudeLabelY_reducedView: 0
    property int unitsLabelFontSize_reducedView: 0
    property int unitsLabelWidth_reducedView: 0
    property int unitsLabelHeigtht_reducedView: 0
    property int unitsLabelX_reducedView: 0
    property int unitsLabelY_reducedView: 0
    property int unitsLabel2Y_reducedView: 0
    property int initialWidth_reducedView: 0
    property int initialheight_reducedView: 0

    property int mainImageWith_fullView: fullViewWidth * 0.25
    property int mainImageMargin_fullView : fullViewWidth * 0.02

    property int magnitudeLabelFontSize_fullView: fullViewWidth * 0.16
    property int magnitudeLabelFontSize2_fullView: fullViewWidth * 0.09
    property int magnitudeLabelWidth_fullView: fullViewWidth * 0.57
    property int magnitudeLabelHeigtht_fullView: fullViewWidth * 0.13
    property int magnitudeLabelX_fullView: fullViewWidth * 0.29
    property int magnitudeLabelY_fullView: fullViewWidth * 0.14

    property int unitsLabelFontSize_fullView: fullViewWidth * 0.05
    property int unitsLabelWidth_fullView: fullViewWidth * 0.241
    property int unitsLabelHeigtht_fullView: fullViewWidth * 0.078
    property int unitsLabelX_fullView: fullViewWidth * 0.6 //0.618
    property int unitsLabel2X_fullView: fullViewWidth * 0.25 //0.618
    property int unitsLabelY_fullView: fullViewWidth * 0.02//0.031
    property int initialWidth_fullView: fullViewWidth
    property int initialheight_fullView: fullViewHeight

    property int fadeOffTime: 200
    property int appearTime: 250
    property int shrinkTime: 250
    property int enlargeTime: 250
    property double opacityOnButtonPressed: 0.4

    property alias inputControl: inputControl
    property alias slider: slider
    property alias unitsLabel: unitsLabel
    property alias unitsLabel2: unitsLabel2
    property alias magnitudeLabel: magnitudeLabel
    property alias magnitudeLabel2: magnitudeLabel2
    property alias mainImage: mainImage

    property alias fixButtonLabel_5: fixButtonLabel_5
    property alias fixButtonLabel_4: fixButtonLabel_4
    property alias fixButtonLabel_3: fixButtonLabel_3
    property alias fixButtonLabel_2: fixButtonLabel_2
    property alias fixButtonLabel_1: fixButtonLabel_1

    property alias sliderBackgroundInactive: sliderBackgroundInactive
    property alias progressIndicator: progressIndicator
    property alias inputForm: inputForm
    property alias auxRectangleForSavingEffect: auxRectangleForSavingEffect
    property alias magnitudeLabelForSavingEffect: magnitudeLabelForSavingEffect
    property alias magnitudeLabel2ForSavingEffect: magnitudeLabel2ForSavingEffect
    property alias magnitudeLabel3ForSavingEffect: magnitudeLabel3ForSavingEffect


            readonly property int shadowSamples: 17
            readonly property int shadowRadius: 8
            readonly property int shadowButtonHorizontalOffset: 3
            readonly property int shadowButtonVerticalOffset: 3
            readonly property string shadowColor: "#70000000"
            property alias fullControlButton: fullControlButton


    states:[
        State{
            id: fullView
        },
        State{
            id: reducedView
        }
    ]
    transitions: [
        Transition {
            to: "fullView"
            NumberAnimation { target: inputControl; property: "initialSliderValue"; to: slider.value}
            PropertyAnimation { target: inputControl; property: "z"; to: 1}
//          PropertyAnimation { target: fullControlButton; property: "visible"; to: false}

            ParallelAnimation{
                PropertyAnimation { target: slider; property: "visible"; to: true}
                PropertyAnimation { target: downButton; property: "visible"; to: true}
                PropertyAnimation { target: upButton; property: "visible"; to: true}
                PropertyAnimation { target: fixButton_1; property: "visible"; to: true}
                PropertyAnimation { target: fixButton_2; property: "visible"; to: true}
                PropertyAnimation { target: fixButton_3; property: "visible"; to: true}
                PropertyAnimation { target: fixButton_4; property: "visible"; to: true}
                PropertyAnimation { target: fixButton_5; property: "visible"; to: true}
                PropertyAnimation { target: doneButton; property: "visible"; to: true}
                PropertyAnimation { target: cancelButton; property: "visible"; to: true}
                PropertyAnimation { target: saveButton; property: "visible"; to: true}

                PropertyAnimation { target: slider; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: downButton; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: upButton; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: fixButton_1; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: fixButton_2; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: fixButton_3; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: fixButton_4; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: fixButton_5; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: doneButton; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: cancelButton; property: "opacity"; to: 1; duration: appearTime}
                PropertyAnimation { target: saveButton; property: "opacity"; to: 1; duration: appearTime}

                NumberAnimation{ target: inputControl; property: "x"; to: fullViewX; duration: enlargeTime}
                NumberAnimation { target: inputControl; property: "y"; to: fullViewY; duration: enlargeTime}

                PropertyAnimation { target: mainImage; property: "width"; to: mainImageWith_fullView; duration: enlargeTime}
                PropertyAnimation { target: mainImage; property: "anchors.leftMargin"; to: mainImageMargin_fullView; duration: enlargeTime}
                PropertyAnimation { target: mainImage; property: "anchors.topMargin"; to: mainImageMargin_fullView/2; duration: enlargeTime}

                PropertyAnimation { target: magnitudeLabel; property: "font.pixelSize"; to: magnitudeLabelFontSize_fullView; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel; property: "width"; to: magnitudeLabelWidth_fullView; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel; property: "height"; to: magnitudeLabelHeigtht_fullView; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel; property: "x"; to: magnitudeLabelX_fullView; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel; property: "y"; to: magnitudeLabelY_fullView; duration: enlargeTime}

                PropertyAnimation { target: magnitudeLabel3; property: "font.pixelSize"; to: magnitudeLabelFontSize2_fullView; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel3; property: "width"; to: magnitudeLabelWidth_fullView / 2; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel3; property: "height"; to: magnitudeLabelHeigtht_fullView; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel3; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView / 2); duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel3; property: "y"; to: magnitudeLabelY_fullView; duration: enlargeTime}

                PropertyAnimation { target: magnitudeLabel2; property: "font.pixelSize"; to: magnitudeLabelFontSize2_fullView; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel2; property: "width"; to: magnitudeLabelWidth_fullView / 2; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel2; property: "height"; to: magnitudeLabelHeigtht_fullView; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel2; property: "x"; to: magnitudeLabelX_fullView; duration: enlargeTime}
                PropertyAnimation { target: magnitudeLabel2; property: "y"; to: magnitudeLabelY_fullView; duration: enlargeTime}

                PropertyAnimation { target: unitsLabel; property: "font.pixelSize"; to: unitsLabelFontSize_fullView; duration: enlargeTime}
                PropertyAnimation { target: unitsLabel; property: "width"; to: unitsLabelWidth_fullView; duration: enlargeTime}
                PropertyAnimation { target: unitsLabel; property: "height"; to: unitsLabelHeigtht_fullView; duration: enlargeTime}
                PropertyAnimation { target: unitsLabel; property: "x"; to: unitsLabelX_fullView; duration: enlargeTime}
                PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_fullView; duration: enlargeTime}

                PropertyAnimation { target: unitsLabel2; property: "font.pixelSize"; to: unitsLabelFontSize_fullView; duration: enlargeTime}
                PropertyAnimation { target: unitsLabel2; property: "width"; to: unitsLabelWidth_fullView; duration: enlargeTime}
                PropertyAnimation { target: unitsLabel2; property: "height"; to: unitsLabelHeigtht_fullView; duration: enlargeTime}
                PropertyAnimation { target: unitsLabel2; property: "x"; to: unitsLabel2X_fullView; duration: enlargeTime}
                PropertyAnimation { target: unitsLabel2; property: "y"; to: unitsLabelY_fullView; duration: enlargeTime}

                PropertyAnimation { target: inputControl; property: "width"; to: fullViewWidth; duration: enlargeTime}
                PropertyAnimation { target: inputControl; property: "height"; to: fullViewHeight; duration: enlargeTime;}
            }
        },
        Transition {
            to: "reducedView"

            ParallelAnimation{
                PropertyAnimation { target: slider; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: downButton; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: upButton; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: fixButton_1; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: fixButton_2; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: fixButton_3; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: fixButton_4; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: fixButton_5; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: doneButton; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: cancelButton; property: "opacity"; to: 0; duration: fadeOffTime}
                PropertyAnimation { target: saveButton; property: "opacity"; to: 0; duration: fadeOffTime}

                PropertyAnimation { target: inputControl; property: "x"; to: initialX; duration: shrinkTime}
                PropertyAnimation { target: inputControl; property: "y"; to: initialY; duration: shrinkTime}

                PropertyAnimation { target: mainImage; property: "width"; to: mainImageWith_reducedView; duration: shrinkTime}
                PropertyAnimation { target: mainImage; property: "anchors.leftMargin"; to: mainImageMargin_reducedView; duration: shrinkTime}
                PropertyAnimation { target: mainImage; property: "anchors.topMargin"; to: mainImageMargin_reducedView; duration: shrinkTime}

                PropertyAnimation { target: magnitudeLabel; property: "font.pixelSize"; to: magnitudeLabelFontSize_reducedView; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel; property: "width"; to: magnitudeLabelWidth_reducedView; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel; property: "height"; to: magnitudeLabelHeigtht_reducedView; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel; property: "x"; to: magnitudeLabelX_reducedView; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel; property: "y"; to: magnitudeLabelY_reducedView; duration: shrinkTime}

                PropertyAnimation { target: magnitudeLabel3; property: "font.pixelSize"; to: magnitudeLabelFontSize2_reducedView; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel3; property: "width"; to: magnitudeLabelWidth_reducedView /2; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel3; property: "height"; to: magnitudeLabelHeigtht_reducedView; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel3; property: "x"; to: magnitudeLabelX_reducedView + (magnitudeLabelWidth_reducedView / 2); duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel3; property: "y"; to: magnitudeLabelY_reducedView; duration: shrinkTime}

                PropertyAnimation { target: magnitudeLabel2; property: "font.pixelSize"; to: magnitudeLabelFontSize2_reducedView; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel2; property: "width"; to: magnitudeLabelWidth_reducedView / 2; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel2; property: "height"; to: magnitudeLabelHeigtht_reducedView; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel2; property: "x"; to: magnitudeLabelX_reducedView; duration: shrinkTime}
                PropertyAnimation { target: magnitudeLabel2; property: "y"; to: magnitudeLabelY_reducedView; duration: shrinkTime}

                PropertyAnimation { target: unitsLabel; property: "font.pixelSize"; to: unitsLabelFontSize_reducedView; duration: shrinkTime}
                PropertyAnimation { target: unitsLabel; property: "width"; to: unitsLabelWidth_reducedView; duration: shrinkTime}
                PropertyAnimation { target: unitsLabel; property: "height"; to: unitsLabelHeigtht_reducedView; duration: shrinkTime}
                PropertyAnimation { target: unitsLabel; property: "x"; to: unitsLabelX_reducedView; duration: shrinkTime}
                PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_reducedView; duration: shrinkTime}

                PropertyAnimation { target: unitsLabel2; property: "font.pixelSize"; to: unitsLabelFontSize_reducedView; duration: shrinkTime}
                PropertyAnimation { target: unitsLabel2; property: "width"; to: unitsLabelWidth_reducedView; duration: shrinkTime}
                PropertyAnimation { target: unitsLabel2; property: "height"; to: unitsLabelHeigtht_reducedView; duration: shrinkTime}
                PropertyAnimation { target: unitsLabel2; property: "x"; to: unitsLabelX_reducedView; duration: shrinkTime}
                PropertyAnimation { target: unitsLabel2; property: "y"; to: unitsLabel2Y_reducedView; duration: shrinkTime}

                PropertyAnimation { target: inputControl; property: "width"; to: initialWidth_reducedView; duration: shrinkTime}
                PropertyAnimation { target: inputControl; property: "height"; to: initialheight_reducedView; duration: shrinkTime}

                PropertyAnimation { target: slider; property: "visible"; to: false}
                PropertyAnimation { target: downButton; property: "visible"; to: false}
                PropertyAnimation { target: upButton; property: "visible"; to: false}
                PropertyAnimation { target: fixButton_1; property: "visible"; to: false}
                PropertyAnimation { target: fixButton_2; property: "visible"; to: false}
                PropertyAnimation { target: fixButton_3; property: "visible"; to: false}
                PropertyAnimation { target: fixButton_4; property: "visible"; to: false}
                PropertyAnimation { target: fixButton_5; property: "visible"; to: false}
                PropertyAnimation { target: doneButton; property: "visible"; to: false}
                PropertyAnimation { target: cancelButton; property: "visible"; to: false}
                PropertyAnimation { target: saveButton; property: "visible"; to: false}
            }
//          PropertyAnimation { target: fullControlButton; property: "visible"; to: true}
            PropertyAnimation { target: inputControl; property: "z"; to: 0}
        }
    ]

    function volumeToTime(volume, flow) {
        var time
        var minutes = Math.floor((volume / ((1000 / 3600) * flow)) / 60)
        var seconds = Math.floor((volume / ((1000 / 3600) * flow)) % 60)

        time = minutes > 9 ? minutes.toString() : "0" + minutes.toString()
        time += seconds > 9 ? ":" + seconds.toString() : ":0" + seconds.toString()

        return time
    }

    function init(){
        //slider.value = Storage.get(saveStamp,slider.value)
        getStoredValues()
        inputControl.inspected = false
        inputControl.state = startState
        inputControl.fullControlButton.visible = true//false
    }

    function getStoredValues(){
        slider.value = Storage.get(saveStamp,slider.value)
//      fixButtonLabel_1.text = parseInt(Storage.get(saveStamp + "_fixButton_1", fixButtonLabel_1.text))
        fixButtonLabel_1.text = parseInt(Storage.get(saveStamp + "_fixButton_1", "-"))
        fixButtonLabel_2.text = parseInt(Storage.get(saveStamp + "_fixButton_2", "-"))
        fixButtonLabel_3.text = parseInt(Storage.get(saveStamp + "_fixButton_3", "-"))
        fixButtonLabel_4.text = parseInt(Storage.get(saveStamp + "_fixButton_4", "-"))
        fixButtonLabel_5.text = parseInt(Storage.get(saveStamp + "_fixButton_5", "-"))
    }

    function getFixButtonPressed()
    {
        if(fixButton_1Button.pressed)
            return fixButton_1
        else if(fixButton_2Button.pressed)
            return fixButton_2
        else if(fixButton_3Button.pressed)
            return fixButton_3
        else if(fixButton_4Button.pressed)
            return fixButton_4
        else if(fixButton_5Button.pressed)
            return fixButton_5
    }

    function getFixButtonPressedLabel()
    {
        if(fixButton_1Button.pressed)
            fixButtonLabel_1.text = Math.floor(slider.value)
        else if(fixButton_2Button.pressed)
            fixButtonLabel_2.text = Math.floor(slider.value)
        else if(fixButton_3Button.pressed)
            fixButtonLabel_3.text = Math.floor(slider.value)
        else if(fixButton_4Button.pressed)
            fixButtonLabel_4.text = Math.floor(slider.value)
        else if(fixButton_5Button.pressed)
            fixButtonLabel_5.text = Math.floor(slider.value)
    }

    function savingEffect(destinationObject){
        auxRectangleForSavingEffect.x = destinationObject.x
        auxRectangleForSavingEffect.y = destinationObject.y
        auxRectangleForSavingEffect.width = destinationObject.width
        auxRectangleForSavingEffect.height = destinationObject.height
        magnitudeLabelForSavingEffect.state= "saving"
        magnitudeLabel2ForSavingEffect.state= "saving"
        magnitudeLabel3ForSavingEffect.state= "saving"
    }

//    visible: true
//    color: "#333333"
//    radius: backgroundRadius


    Component.onCompleted: {

//      initialX = inputControl.x
//      initialY = inputControl.y

        fullViewHeight = fullViewWidth * 0.47

        mainImageWith_reducedView = inputControl.width * 0.4
        mainImageMargin_reducedView = inputControl.width * 0.012

        magnitudeLabelFontSize_reducedView = inputControl.width * 0.28 // 0.31
        magnitudeLabelFontSize2_reducedView = inputControl.width * 0.15// 0.31
        magnitudeLabelWidth_reducedView = inputControl.width * 0.95//0.92
        magnitudeLabelHeigtht_reducedView = inputControl.width * 0.28
        magnitudeLabelX_reducedView = inputControl.width * 0.03
        magnitudeLabelY_reducedView = inputControl.width * 0.43

        unitsLabelFontSize_reducedView = inputControl.width * 0.12
        unitsLabelWidth_reducedView = inputControl.width * 0.4
        unitsLabelHeigtht_reducedView = inputControl.width * 0.02
        unitsLabelX_reducedView = inputControl.width * 0.54
        unitsLabelY_reducedView = inputControl.width * 0.09
        unitsLabel2Y_reducedView = inputControl.width * 0.25

        initialWidth_reducedView = inputControl.width
        initialheight_reducedView = inputControl.width * 0.72
        inputControl.height = initialheight_reducedView
        inputControl.state = startState

        //slider.value = Storage.get(saveStamp,slider.value)
    }
    Rectangle {
        id: inputForm
        anchors.fill: parent
        visible: true
        color: "#333333"
        radius: backgroundRadius


    Behavior on opacity{
        NumberAnimation { duration: 250 }
    }
    Slider {
        id: slider
        opacity: 0
        from: 1
        to: 80
        stepSize: 1
        visible: false
        anchors.right: upButton.left
        anchors.rightMargin: sliderMargins
        anchors.left: downButton.right
        anchors.leftMargin: sliderMargins
        anchors.verticalCenter: downButton.verticalCenter
        anchors.verticalCenterOffset: sliderverticalCenterOffset
        height: sliderHandlePressed

        background: Rectangle {
            id: sliderBackgroundInactive
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.availableWidth
            height: sliderRectangleHeight
            radius: (sliderRectangleHeight / 2) + 1
            color: "#FFFFFF"//"#bdbebf"

            Rectangle {
                id: deactivated
                width: slider.visualPosition * parent.width
                height: parent.height
                color: unitsLabel.color
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
            color: slider.pressed ?  magnitudeLabel.color : unitsLabel.color
        }
        onPressedChanged: {
             console.log("slider pressed: ", 1)
        }
    }

    Rectangle {
        id: downButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: upDownButtonBottomMargin
        anchors.left: parent.left
        anchors.leftMargin: externalBorderMargin

        Label{
            color: unitsLabel.color
            text: "_"
            anchors.fill: parent
            anchors.bottomMargin: operationButtonHeight * 0.45
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            font.pointSize: operationButtonHeight
            opacity: downButtonButton.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: downButtonButton
            opacity: 0
            autoRepeat: true
            anchors.fill: parent
            onClicked: slider.value = slider.value - 1
        }

    }

    Rectangle {
        id: upButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: upDownButtonBottomMargin
        anchors.right: parent.right
        anchors.rightMargin: externalBorderMargin

        Label{
            color: unitsLabel.color
            text: "+"
            anchors.bottomMargin: operationButtonHeight * 0.08
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: operationButtonHeight
            opacity: upButtonButton.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: upButtonButton
            focusPolicy: Qt.WheelFocus
            opacity: 0
            autoRepeat: true
            anchors.fill: parent
            onClicked: slider.value = slider.value + 1
        }
    }

    Rectangle {
        id: fixButton_1
        width: fixButtonWidth
        height: fixButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.right: fixButton_2.left
        anchors.rightMargin: fixButtonMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_1
            color: fixButtonTextColor
            text: "1"
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            opacity: fixButton_1Button.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: fixButton_1Button
            opacity: 0
            anchors.fill: parent
            onClicked: {slider.value = parseInt(fixButtonLabel_1.text); magnitudeLabelForSavingEffect.state = "preRestoring"}
            onPressAndHold: {
                Storage.set(saveStamp + "_fixButton_1", slider.value)
                savingEffect(getFixButtonPressed())
////            magnitudeLabelForFixButtonSavingEffect.state= "saving"
//                magnitudeLabel2ForFixButtonSavingEffect.state= "saving"
  //              magnitudeLabel3ForFixButtonSavingEffect.state= "saving"
            }
        }
    }
    Rectangle {
        id: fixButton_2
        width: fixButtonWidth
        height: fixButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.right: fixButton_3.left
        anchors.rightMargin: fixButtonMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_2
            color: fixButtonTextColor
            text: "2"
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            opacity: fixButton_2Button.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: fixButton_2Button
            opacity: 0
            anchors.fill: parent
            onClicked: slider.value = parseInt(fixButtonLabel_2.text)
            onPressAndHold: {
                Storage.set(saveStamp + "_fixButton_2", slider.value)
                savingEffect(getFixButtonPressed())
////            magnitudeLabelForFixButtonSavingEffect.state= "saving"
//              magnitudeLabel2ForFixButtonSavingEffect.state= "saving"
//              magnitudeLabel3ForFixButtonSavingEffect.state= "saving"
            }
        }
    }
    Rectangle {
        id: fixButton_3
        width: fixButtonWidth
        height: fixButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_3
            color: fixButtonTextColor
            text: "3"
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            opacity: fixButton_3Button.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: fixButton_3Button
            opacity: 0
            anchors.fill: parent
            onClicked: slider.value = parseInt(fixButtonLabel_3.text)
            onPressAndHold: {
                Storage.set(saveStamp + "_fixButton_3", slider.value)
                savingEffect(getFixButtonPressed())
////            magnitudeLabelForFixButtonSavingEffect.state= "saving"
//              magnitudeLabel2ForFixButtonSavingEffect.state= "saving"
//              magnitudeLabel3ForFixButtonSavingEffect.state= "saving"
            }
        }
    }
    Rectangle {
        id: fixButton_4
        width: fixButtonWidth
        height: fixButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.left: fixButton_3.right
        anchors.leftMargin: fixButtonMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_4
            color: fixButtonTextColor
            text: "4"
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            opacity: fixButton_4Button.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: fixButton_4Button
            opacity: 0
            anchors.fill: parent
            onClicked: slider.value = parseInt(fixButtonLabel_4.text)
            onPressAndHold: {
                Storage.set(saveStamp + "_fixButton_4", slider.value)
                savingEffect(getFixButtonPressed())
////            magnitudeLabelForFixButtonSavingEffect.state= "saving"
//              magnitudeLabel2ForFixButtonSavingEffect.state= "saving"
//              magnitudeLabel3ForFixButtonSavingEffect.state= "saving"
            }
        }
    }
    Rectangle {
        id: fixButton_5
        width: fixButtonWidth
        height: fixButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.left: fixButton_4.right
        anchors.leftMargin: fixButtonMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_5
            color: fixButtonTextColor
            text: "5"
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            opacity: fixButton_5Button.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: fixButton_5Button
            opacity: 0
            anchors.fill: parent
            onClicked: slider.value = parseInt(fixButtonLabel_5.text);
            onPressAndHold: {
                Storage.set(saveStamp + "_fixButton_5", slider.value)
                savingEffect(getFixButtonPressed())
////            magnitudeLabelForFixButtonSavingEffect.state= "saving"
//              magnitudeLabel2ForFixButtonSavingEffect.state= "saving"
//              magnitudeLabel3ForFixButtonSavingEffect.state= "saving"
            }
        }
    }

    Rectangle {
        id: doneButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.top: parent.top
        anchors.topMargin: externalBorderMargin
        anchors.right: parent.right
        anchors.rightMargin: externalBorderMargin
        Image{
            anchors.fill: parent
            source: "Images/ic_done_white_48dp.png"
            opacity: doneButtonButton.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: doneButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked:{
                inputControl.state = "reducedView"
                inputControl.inspected = true
                inputControl.verificado()
            }
        }
    }

    Rectangle {
        id: cancelButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.top: parent.top
        anchors.topMargin: saveButtonBottomMargin
        anchors.right: parent.right
        anchors.rightMargin: externalBorderMargin
        Image{
            anchors.fill: parent
            source: "Images/ic_back_01_white_48dp.png"
            opacity: cancelButtonButton.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: cancelButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked: {
                slider.value = initialSliderValue
                inputControl.state = "reducedView"
                inputControl.inspected = true
                inputControl.verificado()
            }
        }
    }

    Rectangle {
        id: saveButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: buttonsColor
        radius: buttonRadius
        opacity: 0
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin
        anchors.right: parent.right
        anchors.rightMargin: externalBorderMargin
        Image{
            anchors.fill: parent
            source: "Images/ic_save_white_48dp.png"
            opacity: saveButtonButton.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: saveButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked: {
                savingEffect(saveButton)
//              magnitudeLabel2ForSavingEffect.state= "saving"
//              magnitudeLabel3ForSavingEffect.state= "saving"
                Storage.set(saveStamp, slider.value)
            }
        }
    }

    Image {
        id: mainImage
        anchors.left: parent.left
        anchors.leftMargin: mainImageMargin_reducedView
        anchors.top: parent.top
        anchors.topMargin: mainImageMargin_reducedView
        width: mainImageWith_reducedView
        height: mainImage.width
        source: ""
    }

    Label {
        id: magnitudeLabel
        visible: !doubleLabelVisible
        color: "#FFFFFF"
        text: magnitudeValue.toLocaleString().replace(",", ".")
        width: magnitudeLabelWidth_reducedView
        height: magnitudeLabelHeigtht_reducedView
        x: magnitudeLabelX_reducedView
        y: magnitudeLabelY_reducedView

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: magnitudeLabelFontSize_reducedView
    }

    Label {
        id: magnitudeLabel2
        visible: doubleLabelVisible
        color: "#FFFFFF"
        text: volumeToTime(magnitudeValue, convertToTimeFlow)
        width: magnitudeLabelWidth_reducedView / 2
        height: magnitudeLabelHeigtht_reducedView
        x: magnitudeLabelX_reducedView
        y: magnitudeLabelY_reducedView

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: magnitudeLabelFontSize2_reducedView
    }

    Label {
        id: magnitudeLabel3
        visible: doubleLabelVisible
        color: magnitudeLabel.color
        text: Math.floor((slider.position * (slider.to - slider.from)) + slider.from).toLocaleString().replace(",", ".")
        width: magnitudeLabelWidth_reducedView / 2
        height: magnitudeLabelHeigtht_reducedView
        x: magnitudeLabelX_reducedView + (magnitudeLabelWidth_reducedView / 2)
        y: magnitudeLabelY_reducedView

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: magnitudeLabelFontSize2_reducedView
    }

    Label {
        id: unitsLabel
        color: "#FFFFFF"
        text: ""
        width: unitsLabelWidth_reducedView
        height: unitsLabelHeigtht_reducedView
        x: unitsLabelX_reducedView
        y: unitsLabelY_reducedView
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: unitsLabelFontSize_reducedView
    }

    Label {
        id: unitsLabel2
        visible: doubleLabelVisible
        color: "#FFFFFF"
        text: "mm:ss"
        width: unitsLabelWidth_reducedView
        height: unitsLabelHeigtht_reducedView
        x: unitsLabelX_reducedView
        y: unitsLabel2Y_reducedView
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: unitsLabelFontSize_reducedView
    }

    Label {
        id: magnitudeLabelForSavingEffect

        states: [
            State {
                name: "saving"
                PropertyChanges { target: magnitudeLabelForSavingEffect; opacity: 1 }
                AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.horizontalCenter: auxRectangleForSavingEffect.horizontalCenter }
                AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.verticalCenter: auxRectangleForSavingEffect.verticalCenter }
            },
            State {
                name: "restoring"
                PropertyChanges { target: magnitudeLabelForSavingEffect; opacity: 1 }
                AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.horizontalCenter: magnitudeLabel.horizontalCenter }
                AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.verticalCenter: magnitudeLabel.verticalCenter }
            },
            State {
                name: "saved"
                PropertyChanges { target: magnitudeLabelForSavingEffect; opacity: 0 }
                PropertyChanges { target: magnitudeLabelForSavingEffect; font.pixelSize: magnitudeLabel.font.pixelSize }
                AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.horizontalCenter: magnitudeLabel.horizontalCenter }
                AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.verticalCenter: magnitudeLabel.verticalCenter }
                StateChangeScript { script: getFixButtonPressedLabel() } // no effect in save button
            },
            State {
                name: "preRestore"
                PropertyChanges { target: magnitudeLabelForSavingEffect; opacity: 0 }
                PropertyChanges { target: magnitudeLabelForSavingEffect; font.pixelSize: magnitudeLabel.font.pixelSize }
                AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.horizontalCenter: magnitudeLabel.horizontalCenter }
                AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.verticalCenter: magnitudeLabel.verticalCenter }
                StateChangeScript { script: getFixButtonPressedLabel() } // no effect in save button
            }
        ]
        transitions: [
            Transition {
                to: "preSave"
                PropertyAnimation { target: magnitudeLabelForSavingEffect; property: "color"; to: magnitudeLabelForSavingEffect.color; duration: 1}
                PropertyAnimation { target: magnitudeLabelForSavingEffect; property: "state"; to: "restoring"; duration: 1}
            },
            Transition {
                to: "saving"
                AnchorAnimation  {duration: 400}
//              PropertyAnimation { target: magnitudeLabelForSavingEffect; property: "font.pixelSize"; to: 0; duration: 400}
                PropertyAnimation { target: magnitudeLabelForSavingEffect; property: "font.pixelSize"; to: 0; easing.type: Easing.InOutBack; duration: 400}
//              PropertyAnimation { target: magnitudeLabelForSavingEffect; property: "state"; to: "saved"; duration: 401 }
            },
            Transition {
                to: "restoring"
                AnchorAnimation  {duration: 400}
                PropertyAnimation { target: magnitudeLabelForSavingEffect; property: "font.pixelSize"; to: magnitudeLabel.font.pixelSize; duration: 400}
            }
        ]

        state: "saved"
        text: magnitudeLabel.text
        visible: magnitudeLabel.visible
        width: magnitudeLabel.width
        height: magnitudeLabel.height
        x: magnitudeLabel.x
        y: magnitudeLabel.y
        color: magnitudeLabel.color
        verticalAlignment: magnitudeLabel.verticalAlignment
        horizontalAlignment: magnitudeLabel.horizontalAlignment
        textFormat: magnitudeLabel.textFormat
        font.pixelSize: magnitudeLabel.font.pixelSize
    }

    Label {
        id: magnitudeLabel2ForSavingEffect

        states: [
            State {
                name: "saving"
                PropertyChanges { target: magnitudeLabel2ForSavingEffect; opacity: 1 }
//              AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.horizontalCenter: saveButton.horizontalCenter }
//              AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.verticalCenter: saveButton.verticalCenter }
                AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.horizontalCenter: auxRectangleForSavingEffect.horizontalCenter }
                AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.verticalCenter: auxRectangleForSavingEffect.verticalCenter }
            },

            State {
                name: "saved"
                PropertyChanges { target: magnitudeLabel2ForSavingEffect; opacity: 0 }
                PropertyChanges { target: magnitudeLabel2ForSavingEffect; font.pixelSize: magnitudeLabel2.font.pixelSize }
                AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.horizontalCenter: magnitudeLabel2.horizontalCenter }
                AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.verticalCenter: magnitudeLabel2.verticalCenter }
                StateChangeScript { script: getFixButtonPressedLabel() } // no effect in save button
            }
        ]
        transitions: [
            Transition {
                to: "saving"
                AnchorAnimation  {duration: 400}
                PropertyAnimation { target: magnitudeLabel2ForSavingEffect; property: "font.pixelSize"; to: 0; duration: 400}
                PropertyAnimation { target: magnitudeLabel2ForSavingEffect; property: "state"; to: "saved"; duration: 401 }
            }
        ]

        state: "saved"
        text: magnitudeLabel2.text
        visible: magnitudeLabel2.visible
        width: magnitudeLabel2.width
        height: magnitudeLabel2.height
        x: magnitudeLabel2.x
        y: magnitudeLabel2.y
        color: magnitudeLabel2.color
        verticalAlignment: magnitudeLabel2.verticalAlignment
        horizontalAlignment: magnitudeLabel2.horizontalAlignment
        textFormat: magnitudeLabel2.textFormat
        font.pixelSize: magnitudeLabel2.font.pixelSize
    }

    Label {
        id: magnitudeLabel3ForSavingEffect

        states: [
            State {
                name: "saving"
                PropertyChanges { target: magnitudeLabel3ForSavingEffect; opacity: 1 }
//              AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.horizontalCenter: saveButton.horizontalCenter }
//              AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.verticalCenter: saveButton.verticalCenter }
                AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.horizontalCenter: auxRectangleForSavingEffect.horizontalCenter }
                AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.verticalCenter: auxRectangleForSavingEffect.verticalCenter }
                StateChangeScript { script: getFixButtonPressedLabel() } // no effect in save button
            },
            State {
                name: "saved"
                PropertyChanges { target: magnitudeLabel3ForSavingEffect; opacity: 0 }
                PropertyChanges { target: magnitudeLabel3ForSavingEffect; font.pixelSize: magnitudeLabel3.font.pixelSize }
                AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.horizontalCenter: magnitudeLabel3.horizontalCenter }
                AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.verticalCenter: magnitudeLabel3.verticalCenter }

            }
        ]
        transitions: [
            Transition {
                to: "saving"
                AnchorAnimation  {duration: 400}
                PropertyAnimation { target: magnitudeLabel3ForSavingEffect; property: "font.pixelSize"; to: 0; duration: 400}
                PropertyAnimation { target: magnitudeLabel3ForSavingEffect; property: "state"; to: "saved"; duration: 401 }
            }
        ]

        state: "saved"
        text: magnitudeLabel3.text
        visible: magnitudeLabel3.visible
        width: magnitudeLabel3.width
        height: magnitudeLabel3.height
        x: magnitudeLabel3.x
        y: magnitudeLabel3.y
        color: magnitudeLabel3.color
        verticalAlignment: magnitudeLabel3.verticalAlignment
        horizontalAlignment: magnitudeLabel3.horizontalAlignment
        textFormat: magnitudeLabel3.textFormat
        font.pixelSize: magnitudeLabel3.font.pixelSize
    }
/*
    Label {
        id: magnitudeLabelForFixButtonSavingEffect

        states: [
            State {
                name: "saving"
                PropertyChanges { target: magnitudeLabelForFixButtonSavingEffect; opacity: 1 }
                AnchorChanges { target: magnitudeLabelForFixButtonSavingEffect; anchors.horizontalCenter: getFixButtonPressed().horizontalCenter }
                AnchorChanges { target: magnitudeLabelForFixButtonSavingEffect; anchors.verticalCenter: getFixButtonPressed().verticalCenter }
            },
            State {
                name: "saved"
                PropertyChanges { target: magnitudeLabelForFixButtonSavingEffect; opacity: 0 }
                PropertyChanges { target: magnitudeLabelForFixButtonSavingEffect; font.pixelSize: magnitudeLabel.font.pixelSize }
                AnchorChanges { target: magnitudeLabelForFixButtonSavingEffect; anchors.horizontalCenter: magnitudeLabel.horizontalCenter }
                AnchorChanges { target: magnitudeLabelForFixButtonSavingEffect; anchors.verticalCenter: magnitudeLabel.verticalCenter }
                StateChangeScript { script: getFixButtonPressedLabel() }
            }
        ]
        transitions: [
            Transition {
                to: "saving"
                AnchorAnimation  {duration: 400}
                PropertyAnimation { target: magnitudeLabelForFixButtonSavingEffect; property: "font.pixelSize"; to: 0; duration: 400}
                PropertyAnimation { target: magnitudeLabelForFixButtonSavingEffect; property: "state"; to: "saved"; duration: 401 }
            }
        ]

        state: "saved"
        text: magnitudeLabel.text
        visible: magnitudeLabel.visible
        width: magnitudeLabel.width
        height: magnitudeLabel.height
        x: magnitudeLabel.x
        y: magnitudeLabel.y
        color: magnitudeLabel.color
        verticalAlignment: magnitudeLabel.verticalAlignment
        horizontalAlignment: magnitudeLabel.horizontalAlignment
        textFormat: magnitudeLabel.textFormat
        font.pixelSize: magnitudeLabel.font.pixelSize
    }
*/
    /*
    Label {
        id: magnitudeLabel2ForFixButtonSavingEffect

        states: [
            State {
                name: "saving"
                PropertyChanges { target: magnitudeLabel2ForFixButtonSavingEffect; opacity: 1 }
                AnchorChanges { target: magnitudeLabel2ForFixButtonSavingEffect; anchors.horizontalCenter: getFixButtonPressed().horizontalCenter }
                AnchorChanges { target: magnitudeLabel2ForFixButtonSavingEffect; anchors.verticalCenter: getFixButtonPressed().verticalCenter }
            },
            State {
                name: "saved"
                PropertyChanges { target: magnitudeLabel2ForFixButtonSavingEffect; opacity: 0 }
                PropertyChanges { target: magnitudeLabel2ForFixButtonSavingEffect; font.pixelSize: magnitudeLabel2.font.pixelSize }
                AnchorChanges { target: magnitudeLabel2ForFixButtonSavingEffect; anchors.horizontalCenter: magnitudeLabel2.horizontalCenter }
                AnchorChanges { target: magnitudeLabel2ForFixButtonSavingEffect; anchors.verticalCenter: magnitudeLabel2.verticalCenter }
                StateChangeScript { script: getFixButtonPressedLabel() }
            }
        ]
        transitions: [
            Transition {
                to: "saving"
                AnchorAnimation  {duration: 400}
                PropertyAnimation { target: magnitudeLabel2ForFixButtonSavingEffect; property: "font.pixelSize"; to: 0; duration: 400}
                PropertyAnimation { target: magnitudeLabel2ForFixButtonSavingEffect; property: "state"; to: "saved"; duration: 401 }
            }
        ]

        state: "saved"
        text: magnitudeLabel2.text
        visible: magnitudeLabel2.visible
        width: magnitudeLabel2.width
        height: magnitudeLabel2.height
        x: magnitudeLabel2.x
        y: magnitudeLabel2.y
        color: magnitudeLabel2.color
        verticalAlignment: magnitudeLabel2.verticalAlignment
        horizontalAlignment: magnitudeLabel2.horizontalAlignment
        textFormat: magnitudeLabel2.textFormat
        font.pixelSize: magnitudeLabel2.font.pixelSize
    }
*/
    /*
    Label {
        id: magnitudeLabel3ForFixButtonSavingEffect

        states: [
            State {
                name: "saving"
                PropertyChanges { target: magnitudeLabel3ForFixButtonSavingEffect; opacity: 1 }
                AnchorChanges { target: magnitudeLabel3ForFixButtonSavingEffect; anchors.horizontalCenter: getFixButtonPressed().horizontalCenter }
                AnchorChanges { target: magnitudeLabel3ForFixButtonSavingEffect; anchors.verticalCenter: getFixButtonPressed().verticalCenter }
            },
            State {
                name: "saved"
                PropertyChanges { target: magnitudeLabel3ForFixButtonSavingEffect; opacity: 0 }
                PropertyChanges { target: magnitudeLabel3ForFixButtonSavingEffect; font.pixelSize: magnitudeLabel3.font.pixelSize }
                AnchorChanges { target: magnitudeLabel3ForFixButtonSavingEffect; anchors.horizontalCenter: magnitudeLabel3.horizontalCenter }
                AnchorChanges { target: magnitudeLabel3ForFixButtonSavingEffect; anchors.verticalCenter: magnitudeLabel3.verticalCenter }
                StateChangeScript { script: getFixButtonPressedLabel() }
            }
        ]
        transitions: [
            Transition {
                to: "saving"
                AnchorAnimation  {duration: 400}
                PropertyAnimation { target: magnitudeLabel3ForFixButtonSavingEffect; property: "font.pixelSize"; to: 0; duration: 400}
                PropertyAnimation { target: magnitudeLabel3ForFixButtonSavingEffect; property: "state"; to: "saved"; duration: 401 }
            }
        ]

        state: "saved"
        text: magnitudeLabel3.text
        visible: magnitudeLabel3.visible
        width: magnitudeLabel3.width
        height: magnitudeLabel3.height
        x: magnitudeLabel3.x
        y: magnitudeLabel3.y
        color: magnitudeLabel3.color
        verticalAlignment: magnitudeLabel3.verticalAlignment
        horizontalAlignment: magnitudeLabel3.horizontalAlignment
        textFormat: magnitudeLabel3.textFormat
        font.pixelSize: magnitudeLabel3.font.pixelSize
    }
*/
    Button{
        id: fullControlButton
        visible: true
        anchors.fill: parent
        opacity: 0
        onClicked: {
            initialSliderValue = slider.value
            inputControl.state = "fullView"
        }
    }
    Rectangle{
        id: auxRectangleForSavingEffect
        opacity: 0
        height: 50
        width: 50
    }
/*
//  Shadows
    readonly property int shadowSamples: 17
    readonly property int shadowRadius: 8
    readonly property int shadowButtonHorizontalOffset: 3
    readonly property int shadowButtonVerticalOffset: 3
    readonly property string shadowColor: "#70000000"
*/

    DropShadow {
        id: downButtonShadow
        anchors.fill: downButton
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: downButton
        opacity: downButton.opacity
        visible: downButton.visible
    }

    DropShadow {
        id: upButtonShadow
        anchors.fill: upButton
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: upButton
        opacity: upButton.opacity
        visible: upButton.visible
    }

    DropShadow {
        id: doneButtonShadow
        anchors.fill: doneButton
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: doneButton
        opacity: doneButton.opacity
        visible: doneButton.visible
    }

    DropShadow {
        id: cancelButtonShadow
        anchors.fill: cancelButton
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: cancelButton
        opacity: cancelButton.opacity
        visible: cancelButton.visible
    }

    DropShadow {
        id: saveButtonShadow
        anchors.fill: saveButton
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: saveButton
        opacity: saveButton.opacity
        visible: saveButton.visible
    }

    DropShadow {
        id: fixButton_1Shadow
        anchors.fill: fixButton_1
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: fixButton_1
        opacity: fixButton_1.opacity
        visible: fixButton_1.visible
    }

    DropShadow {
        id: fixButton_2Shadow
        anchors.fill: fixButton_2
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: fixButton_2
        opacity: fixButton_2.opacity
        visible: fixButton_2.visible
    }

    DropShadow {
        id: fixButton_3Shadow
        anchors.fill: fixButton_3
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: fixButton_3
        opacity: fixButton_3.opacity
        visible: fixButton_3.visible
    }

    DropShadow {
        id: fixButton_4Shadow
        anchors.fill: fixButton_4
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: fixButton_4
        opacity: fixButton_4.opacity
        visible: fixButton_4.visible
    }

    DropShadow {
        id: fixButton_5Shadow
        anchors.fill: fixButton_5
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: fixButton_5
        opacity: fixButton_5.opacity
        visible: fixButton_5.visible
    }

    /*
    DropShadow {
        id: slider_Shadow
        anchors.fill: slider
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: slider
        visible: slider.visible
    }
*/


}

    Progress_01{
        id: progressIndicator

        width: inputForm.width
        radius: inputForm.radius
        anchors.top: inputForm.bottom
        anchors.topMargin: inputForm.radius * 2
        anchors.horizontalCenter: inputForm.horizontalCenter
        progressLabel.color: magnitudeLabel.color
        progressLabel.text: "40000"
        progressLabel.font.pixelSize: magnitudeLabelFontSize_reducedView
        backgroundColor: magnitudeLabel.color
        progressColor: unitsLabel.color
        progressTool.width: 50
        color: inputForm.color
    }
}
