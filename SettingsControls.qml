// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

Window {
    id: settingsControlsWindow
    width: 800;
    height: settingsControlsWindow.width * 0.33
    color: "#222222"
    title: qsTr("OM302D Calibration Controls")

    property string buttonsColor: "#292929"
    property int buttonRadius:settingsControlsWindow.width * 0.01
    property double magnitudeValue: Math.round((slider.position * (slider.to - slider.from)) + slider.from)

    //      flags: Qt.FramelessWindowHint | Qt.ApplicationWindow

    Slider {
        id: slider
        opacity: 1
        from: rangeSwitch.position === 1 ? 1 : 1000
        to:  rangeSwitch.position === 1 ? 1100 : 10000
        stepSize: 1
        visible: true
        height: settingsControlsWindow.width * 0.057
        anchors.top: parent.top
        anchors.topMargin: settingsControlsWindow.width * 0.14
        width: settingsControlsWindow.width * 0.78
        anchors.horizontalCenter: parent.horizontalCenter        

        background: Rectangle {
            id: sliderBackgroundInactive
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.availableWidth
            height: slider.height * 0.10
            radius: (slider.height / 2) + 1
            color: "blue"

            Rectangle {
                id: deactivated
                width: slider.visualPosition * parent.width
                height: parent.height
                color: "green"
                radius: slider.height / 2
            }
        }
        handle: Rectangle {
            id: sliderHandle
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.pressed ? slider.height * 1.2 : slider.height
            height: sliderHandle.width
            radius: slider.height//(50 / 2) + 1
            color: slider.pressed ? "#bdbebf": "#cc00bf"
        }
        onPressedChanged: {
        }
        onValueChanged: {
            consoleSocket.sendData("{SLD_SIM," + magnitudeValue + "\r")
        }
    }

    Label {
        id: magnitudeLabel
        visible: true
        color: "#FFFFFF"
        text: magnitudeValue.toLocaleString().replace(",", ".")
        width: settingsControlsWindow.width
        height: settingsControlsWindow.width * 0.072
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: settingsControlsWindow.width * 0.03

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: settingsControlsWindow.width * 0.14
    }

    Rectangle {
        id: downButton
        width: settingsControlsWindow.width * 0.087
        height: settingsControlsWindow.width * 0.087
        color: buttonsColor
        radius: buttonRadius
        anchors.bottom: slider.top
        anchors.bottomMargin: -settingsControlsWindow.width * 0.0625
        opacity: 1
        visible: true
        anchors.left: parent.left
        anchors.leftMargin: settingsControlsWindow.width * 0.0125

        Label{
            color: "#FFFFFF"
            text: "_"
            anchors.fill: parent
            anchors.bottomMargin: downButton.width * 0.45
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            font.pointSize: settingsControlsWindow.width * 0.0625
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
        width: settingsControlsWindow.width * 0.087
        height: settingsControlsWindow.width * 0.087
        color: buttonsColor
        radius: buttonRadius
        anchors.bottom: slider.top
        anchors.bottomMargin: -settingsControlsWindow.width * 0.0625
        opacity: 1
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: settingsControlsWindow.width * 0.0125

        Label{
            color: "#FFFFFF"
            text: "+"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -settingsControlsWindow.width * 0.0025
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: settingsControlsWindow.width * 0.0625
            opacity: downButtonButton.down ? 0.4 : 1
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
        width: settingsControlsWindow.width * 0.087
        height: settingsControlsWindow.width * 0.087
        color: buttonsColor
        radius: buttonRadius
        opacity: 1
        visible: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: settingsControlsWindow.width * 0.0125
        anchors.right: parent.right
        anchors.rightMargin: settingsControlsWindow.width * 0.0125
        Image{
            anchors.fill: parent
//          source: "Images/ic_done_white_48dp.png"
            source: Storage.get(Constants.dbAppIcon.doneId, "")
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
                consoleSocket.sendData("{ENT_SIM\r")
            }
        }
    }

    Rectangle {
        id: cancelButton
        width: settingsControlsWindow.width * 0.087
        height: settingsControlsWindow.width * 0.087
        color: buttonsColor
        radius: buttonRadius
        opacity: 1
        visible: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: settingsControlsWindow.width * 0.0125
        anchors.right: doneButton.left
        anchors.rightMargin: settingsControlsWindow.width * 0.0125
        Image{
            anchors.fill: parent
//          source: "Images/ic_back_01_white_48dp.png"
            source: Storage.get(Constants.dbAppIcon.backId, "")
            opacity: doneButtonButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: cancelButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked:{
                consoleSocket.sendData("{CNL_SIM\r")
            }
        }
    }

    Rectangle {
        id: closeButton
        width: settingsControlsWindow.width * 0.087 / 2
        height: settingsControlsWindow.width * 0.087 / 2
        color: buttonsColor
        radius: buttonRadius
        opacity: 1
        visible: true
        anchors.top: parent.top
        anchors.topMargin: settingsControlsWindow.width * 0.0125
        anchors.right: parent.right
        anchors.rightMargin: settingsControlsWindow.width * 0.0125
        Image{
            anchors.fill: parent
//          source: "Images/ic_clear_white_48dp.png"
            source: Storage.get(Constants.dbAppIcon.closeId, "")
            opacity: closeButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: closeButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked:{
                //consoleSocket.sendData("{CNL_SIM\r")
                settingsControlsWindow.close()

            }
        }
    }

    Switch {
        id: rangeSwitch
        text: ""
        checked: true
        opacity: 1
        visible: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: settingsControlsWindow.width * 0.0125
        anchors.left: parent.left
        anchors.leftMargin: settingsControlsWindow.width * 0.0125
    }
}
