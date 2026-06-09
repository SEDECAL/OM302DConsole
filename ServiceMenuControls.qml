// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants
import "DebugConstants.js" as DC
import "Singletons"

Rectangle {
    id: serviceMenuControls

    property alias slider: slider
    property alias messageText: messageText
    property alias magnitudeLabel: magnitudeLabel
    property alias rangeMinLabel: rangeMinLabel
    property alias rangeMaxLabel: rangeMaxLabel
    property alias upButton: upButton
    property alias downButton: downButton
    property alias doneButton: doneButton
    property alias bussyIndicator: bussyIndicator
    property alias cancelButton: cancelButton

    property int buttonRadius: 4
    property int buttonHeight: 80
    property int spaceBetweenButtons: 20
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuButtonId, "black")

    property double sliderDebiation: 0
    property double magnitudeValue: Math.round((slider.position * (slider.to - slider.from)) + slider.from)

    property bool viewGrid: falsez

    signal cancelled()
    signal accepted()

    width: QtConstants.serviceWindowPopUpWidth
    height: QtConstants.serviceWindowPopUpHeight
    radius: buttonRadius
    color: Storage.getAppDB(Constants.dbAppColor.serviceMenuControlsId, "black")

    Slider {
        id: slider
        opacity: 1
        from: 0
        to:  10
        stepSize: 1
        visible: true
        height: buttonHeight * 0.5
        anchors.verticalCenter: upButton.verticalCenter
        anchors.right: upButton.left
        anchors.left: downButton.right

        background: Rectangle {
            id: sliderBackgroundInactive
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.availableWidth
            height: slider.height * 0.10
            radius: (slider.height / 2) + 1
            color: "#555555"

            Rectangle {
                id: deactivated
                width: slider.visualPosition * parent.width
                height: parent.height
                color: "white"
                radius: slider.height / 2
            }
        }

        handle: Rectangle {
            id: sliderHandle
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.pressed ? slider.height * 1.2 : slider.height
            height: sliderHandle.width
            radius: slider.height
            color: slider.pressed ? "#bdbebf": "white"
        }

        onPressedChanged: {
        }

        onValueChanged: {
            consoleSocket.sendData(Constants.SLIDER_SIM_HEAD + parseInt(magnitudeValue + sliderDebiation) + Constants.SOCKET_END)
        }

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: viewGrid
        }
    }

    Text {
        id: messageText
        visible: true
        color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
        text: "description here"
        anchors.top: parent.top
        anchors.topMargin: spaceBetweenButtons
        anchors.bottom: magnitudeLabel.top
        anchors.bottomMargin: spaceBetweenButtons
        anchors.left: parent.left
        anchors.leftMargin: spaceBetweenButtons
        anchors.right: parent.right
        anchors.rightMargin: spaceBetweenButtons
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: magnitudeLabel.height * 0.5
        fontSizeMode: Text.Fit

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: viewGrid
        }
    }

    Label {
        id: magnitudeLabel
        visible: true
        color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
        text: magnitudeValue.toLocaleString().replace(",", ".")
        width: buttonHeight
        height: buttonHeight
        anchors.horizontalCenter: slider.horizontalCenter
        anchors.bottom: slider.top
        anchors.bottomMargin: spaceBetweenButtons
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: magnitudeLabel.height * 0.8
    }

    Rectangle {
        id: downButton
        width: buttonHeight
        height: buttonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.verticalCenter: upButton.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: spaceBetweenButtons

        Label{
            color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
            text: "_"
            anchors.fill: parent
            anchors.bottomMargin: downButton.width * 0.45
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            font.pointSize: downButton.height * 0.8
            opacity: downButtonButton.down ? 0.4 : 1
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
        width: buttonHeight
        height: buttonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.horizontalCenter: doneButton.horizontalCenter
        anchors.bottom: doneButton.top
        anchors.bottomMargin: spaceBetweenButtons

        Label{
            color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
            text: "+"
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: upButton.height * 0.8
            opacity: upButtonButton.down ? 0.4 : 1
        }
        Button{
            id: upButtonButton
            opacity: 0
            autoRepeat: true
            anchors.fill: parent
            onClicked: slider.value = slider.value + 1
        }
    }

    Rectangle {
        id: doneButton
        width: buttonHeight
        height: buttonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.bottom: parent.bottom
        anchors.bottomMargin: spaceBetweenButtons
        anchors.right: parent.right
        anchors.rightMargin: spaceBetweenButtons

        Image{
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.doneId, "")
            opacity: doneButtonButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: doneButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked:{
                consoleSocket.sendData(Constants.ENT_SIM)
                serviceMenuControls.visible = false
                updateCalibrationParametersWithDelayTimer.start()
                accepted()
            }
        }
    }

    Rectangle {
        id: cancelButton
        width: buttonHeight
        height: buttonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.verticalCenter: doneButton.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: spaceBetweenButtons

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
            onClicked:{
                consoleSocket.sendData(Constants.CNL_SIM)
                serviceMenuControls.visible = false
                cancelled()
            }
        }
    }

    Label {
        id: rangeMinLabel
        visible: true
        color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"
        text: slider.from.toLocaleString().replace(",", ".")
        width: buttonHeight
        height: buttonHeight * 0.4
        anchors.horizontalCenter: downButton.horizontalCenter
        anchors.bottom: downButton.top
        anchors.bottomMargin: spaceBetweenButtons
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: height * 0.7
    }

    Label {
        id: rangeMaxLabel
        visible: true
        color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"
        text: slider.to.toLocaleString().replace(",", ".")
        width: buttonHeight
        height: buttonHeight * 0.4
        anchors.horizontalCenter: upButton.horizontalCenter
        anchors.bottom: upButton.top
        anchors.bottomMargin: spaceBetweenButtons
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: height * 0.7
    }

    BusyIndicator{
        id: bussyIndicator
        width: height
        height: parent.height * 0.35
        visible: true
        anchors.centerIn: parent
        anchors.verticalCenterOffset: parent.height * 0.2
        running: true
    }

    Switch {
        id: rangeSwitch
        text: ""
        checked: true
        opacity: 1
        visible: false
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    Timer{
        id: updateCalibrationParametersWithDelayTimer
        interval: 500
        repeat: false
        running: false
        onTriggered: consoleSocket.sendData(Constants.GET_PAR)
    }
}
