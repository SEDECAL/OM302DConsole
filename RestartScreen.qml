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
    id: restartScreen

    property alias titleLabel: titleLabel

    property int buttonRadius: 4
    property int buttonHeight: 80
    property int spaceBetweenButtons: 20
    property int radioButtonSelection: 0
    property int radioButtonSize: 40
    property int initialState: 0
    property int currentSelection: 0
    property int restartTimeOut: 4
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuButtonId, "black")

    property bool viewGrid: false

    width: QtConstants.serviceWindowPopUpWidth
    height: QtConstants.serviceWindowPopUpHeight
    radius: buttonRadius
    color: Storage.getAppDB(Constants.dbAppColor.serviceMenuRestartScreenId, "black")
    anchors.centerIn: parent

    Label {
        id: titleLabel
        visible: true
        color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
        text: "Reset"
        height: buttonHeight
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: spaceBetweenButtons
        anchors.leftMargin: spaceBetweenButtons
        anchors.rightMargin: spaceBetweenButtons
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pointSize: buttonHeight * 0.5
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: viewGrid
        }
    }

    Rectangle {
        id: restartControl
        color: parent.color
        border.color: "white"
        border.width: 2
        radius: buttonRadius
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: titleLabel.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: spaceBetweenButtons
        anchors.rightMargin: spaceBetweenButtons
        anchors.topMargin: spaceBetweenButtons
        anchors.bottomMargin: spaceBetweenButtons
        visible: true

        Text{
            id: resetControlText
            width: parent.width
            height: radioButtonSize * 0.85
            anchors.top: parent.top
            anchors.topMargin: spaceBetweenButtons
            text: Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "57", "")
            color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
            font.pixelSize: radioButtonSize * 0.85
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            Rectangle{
                anchors.fill: parent
                border.color: "red"
                color: "transparent"
                visible: viewGrid
            }
        }

        Rectangle{
            color: buttonsColor
            width: buttonHeight * 2
            height: buttonHeight * 2
            radius: buttonRadius * 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.doneId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
            Button{
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    //                  Qt.quit()
                    //                  Qt.exit(1)
                }
            }
        }

        AnimatedImage{
            id: restartAnimation
            width: Math.round(parent.width * 0.316)
            height: Math.round(parent.height * 0.648)
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: height * 0.18
            source: visible ? Storage.getAppDB(Constants.dbAppIcon.restartId, "") : "" //12/2021
            visible: parent.visible
            playing: visible //CB->
            asynchronous: true                // performance improvement

            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "blue"
                visible: viewGrid
            }
        }
    }
}
