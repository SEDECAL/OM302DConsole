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
    id: containerRectangle

    property alias pressureMetter: pressureMetter
    property alias errorCodeLabel: errorCodeLabel
    property alias slider: slider
    property alias unitsLabel: unitsLabel

    property int toutTime: 120 // seconds
    property int toutCounter: toutTime
    property int operationButtonWidth: containerRectangle.width * 0.085
    property int operationButtonHeight: containerRectangle.width * 0.085
    property int buttonRadius: containerRectangle.width * 0.008
    property int sliderRectangleHeight: containerRectangle.width * 0.014
    property int sliderHandlePressed: containerRectangle.width * 0.080
    property int sliderHandleUnpressed: containerRectangle.width * 0.070
    property int enlargeTime: 200
    property int shrinkTime: 150
    property int fadeOffTime: 100
    property int appearTime: 250
    property int fullViewX: QtConstants.fullViewInputElementX
    property int fullViewY: QtConstants.fullViewInputElementY + QtConstants.magnitudeSelectorY
    property int fullViewWidth: QtConstants.fullViewInputElementWith
    property int fullViewHeight: QtConstants.fullViewInputElementWith * QtConstants.fullViewInputElementAspectRatio
    property int reducedViewX: 0
    property int reducedViewY: 0
    property int reducedViewWidth: 0
    property int reducedViewHeight: 0
    property int stopButtonFullViewWidth: appToolBar.height
    property int stopButtonFullViewHeight: appToolBar.height
    property int playButtonFullViewWidth: appToolBar.height
    property int playButtonFullViewHeight: appToolBar.height
    property int stopButtonReducedViewWidth: 0
    property int stopButtonReducedViewHeight: 0
    property int playButtonReducedViewWidth: 0
    property int playButtonReducedViewHeight: 0
    property int pressureMetterFullViewWidth: 200
    property int pressureMetterReducedViewWidth: 0
    property int unitsLabelFullViewWidth: containerRectangle.width * 0.241
    property int unitsLabelReducedViewWidth: 0
    property int unitsLabelFullViewHeight: containerRectangle.width * 0.078
    property int unitsLabelReducedViewHeight: 0

    property double disabledOpacity: 0.4
    property double conversionFactor: 1

    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.pressureTesterButtonId, "black")
    property string sliderColor: Storage.getAppDB(Constants.dbAppColor.pressureTesterSliderId, "black")

    property bool fixedFlow: false
    property bool viewGrid: false

    signal playClicked()
    signal stopClicked()

    function formatFractionalPart(value){

        if( Number(value) === parseInt(Number(value)) ){
            return value
        }
        else{
            return value.toFixed(setNumberOfDecimalDigits(conversionFactor))
        }
    }

    function setNumberOfDecimalDigits(conversionFactor){ // set number of decimal digits dependig on conversion factor
        var digits = 0

        if(conversionFactor > 1){
            digits = 2
        }
        else{
            do{
                digits = digits + 1
                conversionFactor = conversionFactor * 10
            } while(conversionFactor < 1)

            if(digits < 2){
                digits = 2
            }
        }
        return digits
    }

    states:[
        State{
            name: "viewPressureTesterStart"
            PropertyChanges { target: containerRectangle; visible: true }
            PropertyChanges { target: errorImage; visible: false }
            PropertyChanges { target: playButton; visible: true }
            PropertyChanges { target: stopButton; visible: true }
            PropertyChanges { target: downButton; visible: true }
            PropertyChanges { target: upButton;   visible: true }
            PropertyChanges { target: slider;     visible: true }
            PropertyChanges { target: playButton; enabled: true }
            PropertyChanges { target: stopButton; enabled: true }
            PropertyChanges { target: downButton; enabled: true & (!fixedFlow) }
            PropertyChanges { target: upButton;   enabled: true & (!fixedFlow) }
            PropertyChanges { target: slider;     enabled: true & (!fixedFlow) }
            PropertyChanges { target: playButton; opacity: 1 }
            PropertyChanges { target: stopButton; opacity: disabledOpacity }
            PropertyChanges { target: pressureTesterBussyIndicator; running: false }
            PropertyChanges { target: pressureTesterBussyIndicator; visible: false }
        },
        State{
            name: "viewPressureTester"
            PropertyChanges { target: containerRectangle; visible: true }
            PropertyChanges { target: errorImage; visible: false }
            PropertyChanges { target: playButton; visible: true }
            PropertyChanges { target: stopButton; visible: true }
            PropertyChanges { target: downButton; visible: true }
            PropertyChanges { target: upButton;   visible: true }
            PropertyChanges { target: slider;     visible: true }
            PropertyChanges { target: playButton; enabled: true }
            PropertyChanges { target: stopButton; enabled: true }
            PropertyChanges { target: downButton; enabled: true & (!fixedFlow) }
            PropertyChanges { target: upButton;   enabled: true & (!fixedFlow) }
            PropertyChanges { target: slider;     enabled: true & (!fixedFlow) }
            PropertyChanges { target: playButton; opacity: 1 }
            PropertyChanges { target: stopButton; opacity: disabledOpacity }
            PropertyChanges { target: pressureTesterBussyIndicator; running: false }
            PropertyChanges { target: pressureTesterBussyIndicator; visible: false }
        },
        State{
            name: "viewPressureTesterStoped"    // no initPressureTester when stop button pressed
            PropertyChanges { target: containerRectangle; visible: true }
            PropertyChanges { target: errorImage; visible: false }
            PropertyChanges { target: playButton; visible: true }
            PropertyChanges { target: stopButton; visible: true }
            PropertyChanges { target: downButton; visible: true }
            PropertyChanges { target: upButton;   visible: true }
            PropertyChanges { target: slider;     visible: true }
            PropertyChanges { target: playButton; enabled: true }
            PropertyChanges { target: stopButton; enabled: true }
            PropertyChanges { target: downButton; enabled: true & (!fixedFlow) }
            PropertyChanges { target: upButton;   enabled: true & (!fixedFlow) }
            PropertyChanges { target: slider;     enabled: true & (!fixedFlow) }
            PropertyChanges { target: playButton; opacity: 1 }
            PropertyChanges { target: stopButton; opacity: disabledOpacity }
            PropertyChanges { target: pressureTesterBussyIndicator; running: false }
            PropertyChanges { target: pressureTesterBussyIndicator; visible: false }
            PropertyChanges { target: toutTimer;  running: false }
        },
        State{
            name: "viewPressureTesterPlaying"
            PropertyChanges { target: containerRectangle; visible: true }
            PropertyChanges { target: errorImage; visible: false }
            PropertyChanges { target: playButton; visible: true }
            PropertyChanges { target: stopButton; visible: true }
            PropertyChanges { target: downButton; visible: true }
            PropertyChanges { target: upButton;   visible: true }
            PropertyChanges { target: slider;     visible: true }
            PropertyChanges { target: playButton; enabled: false }
            PropertyChanges { target: stopButton; enabled: true }
            PropertyChanges { target: downButton; enabled: false }
            PropertyChanges { target: upButton;   enabled: false }
            PropertyChanges { target: slider;     enabled: false }
            PropertyChanges { target: playButton; opacity: disabledOpacity }
            PropertyChanges { target: stopButton; opacity: 1 }
            PropertyChanges { target: upButton;   opacity: disabledOpacity }
            PropertyChanges { target: downButton; opacity: disabledOpacity }
            PropertyChanges { target: slider;     opacity: disabledOpacity }
            PropertyChanges { target: pressureTesterBussyIndicator; running: true }
            PropertyChanges { target: pressureTesterBussyIndicator; visible: true }
        },
        State{
            name: "viewPressureTesterError"
            PropertyChanges { target: containerRectangle; visible: true }
            PropertyChanges { target: errorImage; visible: true }
            PropertyChanges { target: playButton; visible: true }
            PropertyChanges { target: stopButton; visible: true }
            PropertyChanges { target: downButton; visible: true }
            PropertyChanges { target: upButton;   visible: true }
            PropertyChanges { target: slider;     visible: true }
            PropertyChanges { target: playButton; enabled: false }
            PropertyChanges { target: stopButton; enabled: false }
            PropertyChanges { target: downButton; enabled: false }
            PropertyChanges { target: upButton;   enabled: false }
            PropertyChanges { target: slider;     enabled: false }
            PropertyChanges { target: playButton; opacity: disabledOpacity }
            PropertyChanges { target: stopButton; opacity: disabledOpacity }
            PropertyChanges { target: downButton; opacity: disabledOpacity }
            PropertyChanges { target: upButton;   opacity: disabledOpacity }
            PropertyChanges { target: slider;     opacity: disabledOpacity }
            PropertyChanges { target: pressureTesterBussyIndicator; running: false }
            PropertyChanges { target: pressureTesterBussyIndicator; visible: false }
            PropertyChanges { target: toutTimer;  running: false }
        },
        State{
            name: "noViewPressureTester"
            PropertyChanges { target: containerRectangle; visible: false }
            PropertyChanges { target: errorImage; visible: false }
            PropertyChanges { target: playButton; visible: false }
            PropertyChanges { target: stopButton; visible: false }
            PropertyChanges { target: downButton; visible: false }
            PropertyChanges { target: upButton;   visible: false }
            PropertyChanges { target: slider;     visible: false }
            PropertyChanges { target: pressureTesterBussyIndicator; visible: false }
            PropertyChanges { target: toutTimer;  running: false }
            StateChangeScript {script: Therapies.completeGadgetCloseEffect()}
        },
        State{
            name: "noViewPressureTesterQuick"
            PropertyChanges { target: containerRectangle; visible: false }
            PropertyChanges { target: errorImage; visible: false }
            PropertyChanges { target: playButton; visible: false }
            PropertyChanges { target: stopButton; visible: false }
            PropertyChanges { target: downButton; visible: false }
            PropertyChanges { target: upButton;   visible: false }
            PropertyChanges { target: slider;     visible: false }
            PropertyChanges { target: pressureTesterBussyIndicator; visible: false }
            PropertyChanges { target: toutTimer;  running: false }
        },
        State{
            name: "viewPressureTesterStartPending"
        }
    ]

    z:1
    radius: width * 0.006
    x: fullViewX
    y: fullViewY
    width: fullViewWidth
    height: fullViewHeight
    visible: false
    state: "noViewPressureTester"
    color: Storage.getAppDB(Constants.dbAppColor.pressureTesterPanelId, "black")

    onVisibleChanged: {
        if(visible){
            pressureMetter.indicatorsImage = Storage.getAppDB(Constants.dbAppIcon.pressureLimitPointer2Id, "")
        }
    }

    Component.onCompleted: {
        containerRectangle.playClicked.connect(Therapies.playPressureTester)
        containerRectangle.stopClicked.connect(Therapies.stopPressureTester)
    }

    PressureMetter{
        id: pressureMetter
        width: pressureMetterFullViewWidth//0//200
        height: parent.height - (parent.width * 0.04)
        unitsLabel.text: "mbar"
        unitsLabel.opacity: 1
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: parent.width * 0.02
        controlColor: buttonsColor
        visible: true
        state: "quickViewPressureMetter"
        scaleRectangle.height: parent.height * 0.7 // walk around

        Component.onCompleted: {
            if(Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsId) === Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsAId, "*")){
                pressureMetter.unitsLabel.text = Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsAId, "*")
            }
            else if(Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsId) === Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsBId, "*")){
                pressureMetter.unitsLabel.text = Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsBId, "*")
            }
        }
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "pink"
            visible: viewGrid
        }
    }

    Image {
        id: mainImage
        anchors.left: pressureMetter.right
        anchors.leftMargin: parent.width * 0.012
        anchors.top: parent.top
        anchors.topMargin: parent.width * 0.012
        width: parent.width * 0.20
        height: mainImage.width
        source: Storage.getAppDB(Constants.dbAppIcon.flowId, "")
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        visible: false
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "olive"
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
                toutTimer.running = false
                Therapies.exitPressureTester()
                //DEB->debug.log(DC.pressureTesterLog, "cancel button clicked (pressure tester)...")
                containerRectangle.stopClicked()
                appConsole.state = Constants.CONSOLE_ST_EDITING
                gadgetMenu.state = "gadgetMenuEnabled" //  not include it in main "Constants.CONSOLE_ST_EDITING" to avoid show gadget menu on start up
                containerRectangle.state = "noViewPressureTester"
            }
        }
    }

    Slider {
        id: slider
        from: 1
        to: 50
        value: 30
        stepSize: 1
        anchors.right: upButton.left
        anchors.rightMargin: parent.width * 0.035
        anchors.left: downButton.right
        anchors.leftMargin: parent.width * 0.035
        anchors.verticalCenter: downButton.verticalCenter
        anchors.verticalCenterOffset: parent.width * 0.018
        height: sliderHandlePressed
        opacity: (!fixedFlow) ? 1 : 0.4

        background: Rectangle {
            id: sliderBackgroundInactive
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.availableWidth
            height: sliderRectangleHeight
            radius: (sliderRectangleHeight / 2) + 1
            color: Storage.getAppDB(Constants.dbAppColor.pressureTesterBackSliderId, "black")

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
        onPressedChanged: {
            //DEB->debug.log(DC.pressureTesterLog, "slider pressed: ", 1)
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
        anchors.left: pressureMetter.right
        anchors.leftMargin: operationButtonHeight * 0.35
        opacity: (!fixedFlow) ? 1 : 0.4

        Label{
            color: sliderColor
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
        opacity: (!fixedFlow) ? 1 : 0.4

        Label{
            color: sliderColor
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

    Label {
        id: magnitudeLabel
        color: Storage.getAppDB(Constants.dbAppColor.pressureTesterValueId, "black")
        text: formatFractionalPart(slider.value).toLocaleString().replace(",", ".")
        width: slider.width
        height: parent.width * 0.13

        anchors.left: slider.left
        anchors.bottom: mainImage.bottom
        anchors.bottomMargin: -(height * 0.1)

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: parent.width * 0.16
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "brown"
            visible: viewGrid
        }
    }

    Image{
        id: playButton
        width: playButtonFullViewWidth
        height: playButtonFullViewHeight
        anchors.left: slider.left
        anchors.leftMargin: slider.width * 0.28
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.02
        source: Storage.getAppDB(Constants.dbAppIcon.playId, "")
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        visible: false
        Button{
            id: playActuator
            opacity: 0
            anchors.fill: parent
            onDownChanged: {
                if(down){
                    playButton.opacity = 0.4
                }
            }
            onClicked: {
                //DEB->debug.log(DC.pressureTesterLog, "play button clicked (pressure tester)...")
                containerRectangle.playClicked()
                appConsole.state = Constants.CONSOLE_ST_PRESSURE_TEST
                containerRectangle.state = "viewPressureTesterPlaying"
                toutTimer.running = true
            }
        }
    }

    Image{
        id: stopButton
        width: stopButtonFullViewWidth
        height: stopButtonFullViewHeight
        anchors.right: slider.right
        anchors.rightMargin: slider.width * 0.28
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.02
        source: Storage.getAppDB(Constants.dbAppIcon.stopId, "")
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
        visible: false
        Button{
            id: stopActuator
            opacity: 0
            anchors.fill: parent
            onDownChanged: {
                if(down){
                    stopButton.opacity = 0.4
                }
            }
            onClicked: {
                //DEB->debug.log(DC.pressureTesterLog, "stop button clicked (pressure tester)...")
                containerRectangle.stopClicked()
                containerRectangle.state = "viewPressureTesterStoped"
                toutTimer.running = false
            }
        }
    }

    Timer {
        id: toutTimer
        interval: 1000
        repeat: true
        onTriggered: {
            toutCounter = toutCounter - 1

            if(!toutCounter){
                running = false
                containerRectangle.stopClicked()
                containerRectangle.state = "viewPressureTesterStoped"
            }
        }
        onRunningChanged: {
            if(toutTimer.running){
                toutCounter = toutTime
            }
        }
    }

    ProgressBar{
        id: progressTimeOutTool
        height: pressureMetter.height * 0.05
        width: pressureMetter.width * 0.9
        anchors.left: pressureMetter.left
        anchors.leftMargin: (pressureMetter.width - width) * 0.5
        anchors.bottom: pressureMetter.bottom
        anchors.bottomMargin: pressureMetter.height * 0.007
        visible: pressureTesterBussyIndicator.visible//true
        from: toutTime
        to: 0
        value: toutCounter
    }


    Label {
        id: unitsLabel
        color: sliderColor
        text: "l/min"
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
            color: "#00000000"
            border.color: "lightblue"
            visible: viewGrid
        }
    }

    BusyIndicator {
        id: pressureTesterBussyIndicator
        width: pressureMetter.width * 0.29
        height: width
        visible: false
        running: false
        anchors.left: pressureMetter.left
        anchors.bottom: pressureMetter.bottom
        anchors.bottomMargin: height * 0.40

        contentItem: Item {
            implicitWidth: parent.width
            implicitHeight: parent.height

            Item {
                id: item
                x: 0
                y: 0
                width: parent.width
                height: parent.height

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 250
                    }
                }

                RotationAnimator {
                    target: item
                    running: pressureTesterBussyIndicator.visible && pressureTesterBussyIndicator.running
                    from: 0
                    to: 360
                    loops: Animation.Infinite
                    duration: 2250
                }

                Repeater {
                    id: repeater
                    model: 7

                    Rectangle {
                        x: item.width / 2 - width / 2
                        y: item.height / 2 - height / 2
                        implicitWidth: 10
                        implicitHeight: 10
                        radius: 5
                        color: "grey" //"#21be2b"
                        transform: [
                            Translate {
                                y: -Math.min(item.width, item.height) * 0.5 + 5
                            },
                            Rotation {
                                angle: index / repeater.count * 360
                                origin.x: 5
                                origin.y: 5
                            }
                        ]
                    }
                }
            }
        }
    }

    Rectangle {
        id: errorImage
        states:[
            State{
                name: "errorImageNoBlink"
                PropertyChanges { target: errorImage; opacity: 1 }
            },
            State{
                name: "errorImageBlink"
            }
        ]
        transitions:[
            Transition {
                to: "errorImageBlink"
                SequentialAnimation{
                    PropertyAnimation { target: errorImage; property: "opacity"; to: 0.2; duration: 500 }
                    PropertyAnimation { target: errorImage; property: "opacity"; to: 1; duration: 2000 }
                    PropertyAnimation { target: errorImageTimer; property: "interval"; to: 5000 }
                    PropertyAnimation { target: errorImage; property: "state"; to: "errorImageNoBlink" }
                }
            }
        ]

        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.02
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.02
        width: appToolBar.height
        height: appToolBar.height
        color: Storage.getAppDB(Constants.dbAppColor.pressureTesterError2Id, "black")
        radius: 5
        Image {
            anchors.centerIn: parent
            width: parent.width * 0.85
            height: parent.height * 0.85
            source: Storage.getAppDB(Constants.dbAppIcon.overPressureId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }

        Label{
            id: errorCodeLabel
            width: parent.width * 0.12
            height: parent.width * 0.12
            color: "white"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width * 0.058
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.093
            text: "18"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            opacity: 1
            font.pixelSize: parent.width * 0.23
            fontSizeMode: Text.Fit
            visible: false // (errorCodeLabel.text === "0") ? false : true // #4304 ticket (09/06/2021)
        }

        Button{
            id: errorImageButton
            focusPolicy: Qt.WheelFocus
            opacity: 0
            autoRepeat: true
            anchors.fill: parent
            onClicked: {
                consoleSocket.sendData(Constants.CNL_SIM)               // cancel error
                appConsole.state = Constants.CONSOLE_ST_PRESSURE_TEST   // recover pressure tester state after error
                containerRectangle.state = "viewPressureTester"
            }
        }
        Timer{
            id: errorImageTimer
            interval: 1000
            repeat: true
            running: errorImage.visible
            onTriggered: errorImage.state = "errorImageBlink";
        }
        onVisibleChanged: errorImageTimer.interval = 1000
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "green"
            visible: viewGrid
        }
    }
}

