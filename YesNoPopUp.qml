// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants
import "Singletons"

Rectangle {
    id: yesNoPopUp

    property alias titleLabel: titleLabel

    property int buttonRadius: 4
    property int buttonHeight: 80
    property int spaceBetweenButtons: 20
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuButtonId, "black")

    property bool viewGrid: false

    signal no()
    signal yes()

    width: QtConstants.serviceWindowPopUpWidth * 0.5
    height: QtConstants.serviceWindowPopUpHeight
    radius: buttonRadius
    color: Storage.getAppDB(Constants.dbAppColor.serviceMenuYesNoPopUpId, "black")

    Label {
        id: titleLabel
        visible: true
        color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
        text: "Tittle"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: noButton.top
        anchors.topMargin: spaceBetweenButtons
        anchors.leftMargin: spaceBetweenButtons
        anchors.rightMargin: spaceBetweenButtons
        anchors.bottomMargin: spaceBetweenButtons
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.Fit
        font.pointSize: buttonHeight * 0.5
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: viewGrid
        }
    }
    Rectangle {
        id: noButton
        width: buttonHeight
        height: buttonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.bottom: parent.bottom
        anchors.bottomMargin: spaceBetweenButtons
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: spaceBetweenButtons * 0.5
        Image{
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.noId, "")
            opacity: noButtonButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: noButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked: {
                yesNoPopUp.visible = false
                no()
            }
        }
    }
    Rectangle {
        id: yesButton
        width: buttonHeight
        height: buttonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.bottom: parent.bottom
        anchors.bottomMargin: spaceBetweenButtons
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: spaceBetweenButtons * 0.5
        Image{
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.yesId, "")
            opacity: yesButtonButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: yesButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked: {
                yesNoPopUp.visible = false
                yes()
            }
        }
    }
}
