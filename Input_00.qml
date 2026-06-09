// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle {
    property int initialX: 0
    property int initialY: 0
    property int fullViewX: 0
    property int fullViewY: 0
    property int fullViewWidth: 0
    property int fullViewHeight: 0

    property int operationButtonWidth: fullViewWidth * 0.1
    property int operationButtonHeight: fullViewWidth * 0.1
    property int fixButtonWidth: fullViewWidth * 0.1
    property int fixButtonHeight: fullViewWidth * 0.06
    property int fixButtonMargin: fullViewWidth * 0.03
    property int externalBorderMargin: fullViewWidth * 0.02
    property int sliderMargins: fullViewWidth * 0.04
    property int upDownButtonBottomMargin: fullViewWidth * 0.08
    property int buttonRadius: fullViewWidth * 0.008
    property int fixButtonFontSize: fullViewWidth * 0.03
    property int magnitudeTextSize: fullViewWidth * 0.16
    property int unitsTextSize: fullViewWidth * 0.03
    property int backgroundRadius: fullViewWidth * 0
    property int mainImageSize: fullViewWidth * 0.25

    property string backgroundColor: "#333333"
    property string upDownButtonColor: "#292929"
    property string fixButtonColor: "#292929"
    property string doneButtonColor: "#292929"
    property string cancelButtonColor: "#292929"
    property string fixButtonTextColor: "#e7e9ea"
    property string magnitudeTextColor: "#FFFFFF"
    property string unitsTextColor: "#FFFFFF"
    property string unitsText: "#FFFFFF"
    property string fixButtonText_1: "20"
    property string fixButtonText_2: "30"
    property string fixButtonText_3: "40"
    property string fixButtonText_4: "50"
    property string fixButtonText_5: "60"
    property string mainImageSource: "Images/O3_white.png"

    property int mainImageWith_reducedView: 0
    property int mainImageMargin_reducedView: 0
    property int magnitudeLabelFontSize_reducedView: 0
    property int magnitudeLabelWidth_reducedView: 0
    property int magnitudeLabelHeigtht_reducedView: 0
    property int magnitudeLabelX_reducedView: 0
    property int magnitudeLabelY_reducedView: 0
    property int unitsLabelFontSize_reducedView: 0
    property int unitsLabelWidth_reducedView: 0
    property int unitsLabelHeigtht_reducedView: 0
    property int unitsLabelX_reducedView: 0
    property int unitsLabelY_reducedView: 0
    property int initialWidth_reducedView: 0
    property int initialheight_reducedView: 0

    property int mainImageWith_fullView: fullViewWidth * 0.25
    property int mainImageMargin_fullView : fullViewWidth * 0.02

    property int magnitudeLabelFontSize_fullView: fullViewWidth * 0.16
    property int magnitudeLabelWidth_fullView: fullViewWidth * 0.57
    property int magnitudeLabelHeigtht_fullView: fullViewWidth * 0.13
    property int magnitudeLabelX_fullView: fullViewWidth * 0.29
    property int magnitudeLabelY_fullView: fullViewWidth * 0.14

    property int unitsLabelFontSize_fullView: fullViewWidth * 0.05
    property int unitsLabelWidth_fullView: fullViewWidth * 0.241
    property int unitsLabelHeigtht_fullView: fullViewWidth * 0.078
    property int unitsLabelX_fullView: fullViewWidth * 0.618
    property int unitsLabelY_fullView: fullViewWidth * 0.031
    property int initialWidth_fullView: fullViewWidth
    property int initialheight_fullView: fullViewHeight

    property int fadeOffTime: 200
    property int appearTime: 125
    property int shrinkTime: 250
    property int enlargeTime: 250



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
            SequentialAnimation{
                PropertyAnimation { target: fullControlButton; property: "visible"; to: false}

                ParallelAnimation{
                    PropertyAnimation { target: input_00; property: "x"; to: fullViewX; duration: enlargeTime}
                    PropertyAnimation { target: input_00; property: "y"; to: fullViewY; duration: enlargeTime}

                    PropertyAnimation { target: mainImage; property: "width"; to: mainImageWith_fullView; duration: enlargeTime}
                    PropertyAnimation { target: mainImage; property: "anchors.leftMargin"; to: mainImageMargin_fullView; duration: enlargeTime}
                    PropertyAnimation { target: mainImage; property: "anchors.topMargin"; to: mainImageMargin_fullView; duration: enlargeTime}

                    PropertyAnimation { target: magnitudeLabel; property: "font.pixelSize"; to: magnitudeLabelFontSize_fullView; duration: enlargeTime}
                    PropertyAnimation { target: magnitudeLabel; property: "width"; to: magnitudeLabelWidth_fullView; duration: enlargeTime}
                    PropertyAnimation { target: magnitudeLabel; property: "height"; to: magnitudeLabelHeigtht_fullView; duration: enlargeTime}
                    PropertyAnimation { target: magnitudeLabel; property: "x"; to: magnitudeLabelX_fullView; duration: enlargeTime}
                    PropertyAnimation { target: magnitudeLabel; property: "y"; to: magnitudeLabelY_fullView; duration: enlargeTime}

                    PropertyAnimation { target: unitsLabel; property: "font.pixelSize"; to: unitsLabelFontSize_fullView; duration: enlargeTime}
                    PropertyAnimation { target: unitsLabel; property: "width"; to: unitsLabelWidth_fullView; duration: enlargeTime}
                    PropertyAnimation { target: unitsLabel; property: "height"; to: unitsLabelHeigtht_fullView; duration: enlargeTime}
                    PropertyAnimation { target: unitsLabel; property: "x"; to: unitsLabelX_fullView; duration: enlargeTime}
                    PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_fullView; duration: enlargeTime}

                    PropertyAnimation { target: input_00; property: "width"; to: fullViewWidth; duration: enlargeTime}
                    PropertyAnimation { target: input_00; property: "height"; to: fullViewHeight; duration: enlargeTime}
                }
                ParallelAnimation{
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
                }
            }
        },
        Transition {
            to: "reducedView"
            SequentialAnimation{
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
                }
                ParallelAnimation{
                    PropertyAnimation { target: input_00; property: "x"; to: initialX; duration: enlargeTime}
                    PropertyAnimation { target: input_00; property: "y"; to: initialY; duration: enlargeTime}

                    PropertyAnimation { target: mainImage; property: "width"; to: mainImageWith_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: mainImage; property: "anchors.leftMargin"; to: mainImageMargin_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: mainImage; property: "anchors.topMargin"; to: mainImageMargin_reducedView; duration: shrinkTime}

                    PropertyAnimation { target: magnitudeLabel; property: "font.pixelSize"; to: magnitudeLabelFontSize_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: magnitudeLabel; property: "width"; to: magnitudeLabelWidth_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: magnitudeLabel; property: "height"; to: magnitudeLabelHeigtht_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: magnitudeLabel; property: "x"; to: magnitudeLabelX_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: magnitudeLabel; property: "y"; to: magnitudeLabelY_reducedView; duration: shrinkTime}

                    PropertyAnimation { target: unitsLabel; property: "font.pixelSize"; to: unitsLabelFontSize_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: unitsLabel; property: "width"; to: unitsLabelWidth_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: unitsLabel; property: "height"; to: unitsLabelHeigtht_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: unitsLabel; property: "x"; to: unitsLabelX_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_reducedView; duration: shrinkTime}

                    PropertyAnimation { target: input_00; property: "width"; to: initialWidth_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: input_00; property: "height"; to: initialheight_reducedView; duration: shrinkTime}
                }

                PropertyAnimation { target: fullControlButton; property: "visible"; to: true}
            }
        }
    ]

    id: input_00
    visible: true
    color: backgroundColor
    radius: backgroundRadius
    property alias input_00: input_00

    Component.onCompleted: {

        initialX = input_00.x
        initialY = input_00.y

        fullViewHeight = fullViewWidth * 0.47

        mainImageWith_reducedView = input_00.width * 0.4
        mainImageMargin_reducedView = input_00.width * 0.012

        magnitudeLabelFontSize_reducedView = input_00.width * 0.32
        magnitudeLabelWidth_reducedView = input_00.width * 0.92
        magnitudeLabelHeigtht_reducedView = input_00.width * 0.28
        magnitudeLabelX_reducedView = input_00.width * 0.04
        magnitudeLabelY_reducedView = input_00.width * 0.44

        unitsLabelFontSize_reducedView = input_00.width * 0.12
        unitsLabelWidth_reducedView = input_00.width * 0.4
        unitsLabelHeigtht_reducedView = input_00.width * 0.02
        unitsLabelX_reducedView = input_00.width * 0.54
        unitsLabelY_reducedView = input_00.width * 0.06
        initialWidth_reducedView = input_00.width
        initialheight_reducedView = input_00.height

        console.log("fullViewWidth: ", input_00.fullViewWidth)
        console.log("fullViewHeight: ", input_00.fullViewHeight)
    }

    Slider {
        id: slider
        opacity: 0
        from: 1
        to: 80
        stepSize: 1
        anchors.right: upButton.left
        anchors.rightMargin: sliderMargins
        anchors.left: downButton.right
        anchors.leftMargin: sliderMargins
        anchors.verticalCenter: downButton.verticalCenter
        value: 15

        background: Rectangle {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
//            implicitWidth: 200
//            implicitHeight: 4
            width: slider.availableWidth
            height: 8
            radius: 4
            color: "#bdbebf"

            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
/*                color: "#21be2b"*/
                color: "#0097A7"
                radius: 4
            }
        }
        handle: Rectangle {
            id: sliderHandle
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
//            implicitWidth: 26
//            implicitHeight: 26
            width: slider.pressed ? 60 : 50
            height: sliderHandle.width
            radius: 33
            color: slider.pressed ? "#80DEEA": "#0097A7"
            border.color: slider.pressed ? "#0097A7" : "#80DEEA"
            //border.color: "#0097A7"
        }
    }

    Rectangle {
        id: downButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: upDownButtonColor
        radius: buttonRadius
        opacity: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: upDownButtonBottomMargin
        anchors.left: parent.left
        anchors.leftMargin: externalBorderMargin

        Image{
            anchors.fill: parent
            source: "Images/ic_substract_white_48dp.png"
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
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
        color: upDownButtonColor
        radius: buttonRadius
        opacity: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: upDownButtonBottomMargin
        anchors.right: parent.right
        anchors.rightMargin: externalBorderMargin

        Image{
            anchors.fill: parent
            source: "Images/ic_add_white_48dp.png"
            asynchronous: true
        }
        Button{
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
        color: fixButtonColor
        radius: buttonRadius
        opacity: 0
        anchors.right: fixButton_2.left
        anchors.rightMargin: fixButtonMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_1
            color: fixButtonTextColor
            text: fixButtonText_1
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked: slider.value = parseInt(fixButtonLabel_1.text)
        }
    }
    Rectangle {
        id: fixButton_2
        width: fixButtonWidth
        height: fixButtonHeight
        color: fixButtonColor
        radius: buttonRadius
        opacity: 0
        anchors.right: fixButton_3.left
        anchors.rightMargin: fixButtonMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_2
            color: fixButtonTextColor
            text: fixButtonText_2
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked: slider.value = parseInt(fixButtonLabel_2.text)
        }
    }
    Rectangle {
        id: fixButton_3
        width: fixButtonWidth
        height: fixButtonHeight
        color: fixButtonColor
        radius: buttonRadius
        opacity: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_3
            color: fixButtonTextColor
            text: fixButtonText_3
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked: slider.value = parseInt(fixButtonLabel_3.text)
        }
    }
    Rectangle {
        id: fixButton_4
        width: fixButtonWidth
        height: fixButtonHeight
        color: fixButtonColor
        radius: buttonRadius
        opacity: 0
        anchors.left: fixButton_3.right
        anchors.leftMargin: fixButtonMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_4
            color: fixButtonTextColor
            text: fixButtonText_4
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked: slider.value = parseInt(fixButtonLabel_4.text)
        }
    }
    Rectangle {
        id: fixButton_5
        width: fixButtonWidth
        height: fixButtonHeight
        color: fixButtonColor
        radius: buttonRadius
        opacity: 0
        anchors.left: fixButton_4.right
        anchors.leftMargin: fixButtonMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin

        Label {
            id: fixButtonLabel_5
            color: fixButtonTextColor
            text: fixButtonText_5
            anchors.fill: parent
            font.pointSize: fixButtonFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked: slider.value = parseInt(fixButtonLabel_5.text)
        }
    }

    Rectangle {
        id: doneButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: doneButtonColor
        radius: buttonRadius
        opacity: 0
        anchors.top: parent.top
        anchors.topMargin: externalBorderMargin
        anchors.right: parent.right
        anchors.rightMargin: externalBorderMargin
        Image{
            anchors.fill: parent
            source: "Images/ic_done_white_48dp.png"
            asynchronous: true
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked: input_00.state = "reducedView"
        }
    }

    Rectangle {
        id: cancelButton
        width: operationButtonWidth
        height: operationButtonHeight
        color: cancelButtonColor
        radius: buttonRadius
        opacity: 0
        anchors.top: doneButton.bottom
        anchors.topMargin: externalBorderMargin
        anchors.right: parent.right
        anchors.rightMargin: externalBorderMargin
        Image{
            anchors.fill: parent
            source: "Images/ic_clear_white_48dp.png"
            asynchronous: true
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked: input_00.state = "reducedView"
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
        source: mainImageSource
    }

    Label {
        id: magnitudeLabel
        color: magnitudeTextColor
        text: Math.floor((slider.position * (slider.to - slider.from)) + slider.from)
        width: magnitudeLabelWidth_reducedView
        height: magnitudeLabelHeigtht_reducedView
        x: magnitudeLabelX_reducedView
        y: magnitudeLabelY_reducedView
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: magnitudeLabelFontSize_reducedView
    }

    Label {
        id: unitsLabel
        color: unitsTextColor
        text: unitsText
        width: unitsLabelWidth_reducedView
        height: unitsLabelHeigtht_reducedView
        x: unitsLabelX_reducedView
        y: unitsLabelY_reducedView
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: unitsLabelFontSize_reducedView
    }

    Button{
        id: fullControlButton
        visible: true
        anchors.fill: parent
        opacity: 0
        onClicked: input_00.state = "fullView"
    }

}

