// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import QtQuick.LocalStorage 2.12

import "storage.js" as Storage
import "Constants.js" as Constants


Rectangle {
    id: pinPad

    property alias pinPadText: pinPadText

    property bool pinOk: false

    property int textFontSize: 45
    property int buttonRadius: 4
    property int buttonWidth: 80
    property int buttonHeight: 80
    property int buttonFontSize: 20
    property int spaceBetweenButtons: 15

    property string pin: Math.round((((Storage.getAppDB(Constants.dbConstants.pinCodeId, "black")) / 3) + 3) / 333)

    property double opacityOnButtonPressed: 0.4

    property color backButtonColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuButtonId, "black")
    property color labelButtonColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
    property color textFontColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")

    property variant pinPadButtonsText: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "back", "0", "clear"]

    signal pinAccepted()

    function pinPadButtonsClicked(text){
        switch (text){
        case  pinPadButtonsText[10]:
        case  pinPadButtonsText[0]:
        case  pinPadButtonsText[1]:
        case  pinPadButtonsText[2]:
        case  pinPadButtonsText[3]:
        case  pinPadButtonsText[4]:
        case  pinPadButtonsText[5]:
        case  pinPadButtonsText[6]:
        case  pinPadButtonsText[7]:
        case  pinPadButtonsText[8]:
            if(pinPadText.text.length < 4){
                pinPadText.text = pinPadText.text + text
            }
            break
        case  pinPadButtonsText[9]: pinPadText.text = pinPadText.text.substring(0, pinPadText.text.length - 1); break
        case  pinPadButtonsText[11]:
            pinPadText.text = ""
            break
        }
    }

    radius: 4
    color: Storage.getAppDB(Constants.dbAppColor.serviceMenuPinPadId, "black") //"#007395"//"#d69545"
    height: (5 * buttonHeight) + (6 * spaceBetweenButtons)
    width:(4 * buttonWidth) + (5 * spaceBetweenButtons)
    onVisibleChanged: {
        pinPadText.text = ""
        pinOk = false
    }

    MouseArea{
        // avoid click propagation on back rectangle
        anchors.fill: parent
    }

    Rectangle{
        id: pinPadTextFrame
        border.color: backButtonColor
        border.width: 2
        color: "transparent"
        radius: buttonRadius
        height: buttonHeight
        width: (buttonWidth * 3) + (spaceBetweenButtons * 2)
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: spaceBetweenButtons
        anchors.leftMargin: spaceBetweenButtons
        Text{
            id: pinPadText
            anchors.fill: parent
            anchors.margins: 7
            text: ""
            color: textFontColor
            font.pixelSize: textFontSize
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight

            Rectangle{
                anchors.fill: parent
                border.color: backButtonColor
                color: "transparent"
                visible: false
            }
        }
    }

    Grid{
        id: pinPadGrid
        anchors.top: pinPadTextFrame.bottom
        anchors.left: pinPadTextFrame.left
        anchors.topMargin: spaceBetweenButtons
        columns: 3
        spacing: spaceBetweenButtons
        Repeater{
            model: pinPadButtonsText
            Rectangle{
                height: buttonHeight
                width: buttonWidth
                color: backButtonColor
                radius: buttonRadius
                Label {
                    id: pinPadButtonLabel
                    color: labelButtonColor
                    text: modelData
                    anchors.fill: parent
                    font.pointSize: buttonFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    opacity: pinPadButton.down ? opacityOnButtonPressed : 1
                    fontSizeMode: Text.Fit
                }
                Image{
                    id: pinPadButtonImage
                    anchors.fill: parent
                    asynchronous: true                // performance improvement
                    sourceSize.width: parent.width    // performance improvement
                    sourceSize.height: parent.height  // performance improvement
                    opacity: pinPadButton.down ? opacityOnButtonPressed : 1
                }
                Button{
                    id: pinPadButton
                    anchors.fill: parent
                    opacity: 0
                    onClicked: pinPadButtonsClicked(modelData)
                }
                Component.onCompleted: {
                    if (modelData === "back"){
                        pinPadButtonImage.source = Storage.getAppDB(Constants.dbAppIcon.backPinpadId, "")
                        pinPadButtonLabel.visible = false
                        pinPadButtonImage.anchors.margins = 15
                    }
                    if (modelData === "clear"){
                        pinPadButtonImage.source = Storage.getAppDB(Constants.dbAppIcon.clearPinpadId, "")
                        pinPadButtonLabel.visible = false
                    }
                }
            }
        }
    }

    Rectangle{
        id: backButton
        height: buttonHeight
        width: buttonHeight
        color: backButtonColor
        radius: buttonRadius
        anchors.bottom: pinPadGrid.bottom
        anchors.left: pinPadGrid.right
        anchors.leftMargin: spaceBetweenButtons
        Image{
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.backId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            opacity: backButtonButton.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: backButtonButton
            anchors.fill: parent
            opacity: 0
            onClicked: pinPad.visible = false
        }
    }
    Rectangle{
        id: okButton
        height: buttonHeight
        width: buttonHeight
        color: backButtonColor
        radius: buttonRadius
        anchors.bottom: backButton.top
        anchors.left: pinPadGrid.right
        anchors.leftMargin: spaceBetweenButtons
        anchors.bottomMargin: spaceBetweenButtons
        Image{
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.doneId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            opacity: okButtonButton.down ? opacityOnButtonPressed : 1
        }
        Button{
            id: okButtonButton
            anchors.fill: parent
            opacity: 0
            onClicked: {
                if(pin === pinPadText.text){
                    pinOk = true
                    pinAccepted()
                    pinPad.visible = false
                }else{
                    pinOk = false
                }
                animateOpacity.start()
            }
        }
    }
    Rectangle{
        id: lockIndcator
        height: buttonHeight
        width: buttonHeight
        color: "transparent"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: spaceBetweenButtons
        anchors.rightMargin: spaceBetweenButtons
        border.color: "transparent"
        Image{
            id: lockImage
            anchors.fill: parent
            source: pinOk ? Storage.getAppDB(Constants.dbAppIcon.unLockId, "") : Storage.getAppDB(Constants.dbAppIcon.lockId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement

            NumberAnimation {
                id: animateOpacity
                target: lockImage
                properties: "opacity"
                from: 0
                to: 1
                loops: 1
                easing.type: Easing.OutSine
                duration: 500
            }
        }
    }
}
