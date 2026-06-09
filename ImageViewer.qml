// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.8

import "storage.js" as Storage
import "Constants.js" as Constants

Rectangle{
    id: imageViewer

    property alias  image: image

    property int buttonRadius: 4
    property int buttonHeight: 80
    property int spaceBetweenButtons: buttonHeight * 0.2
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.imageViewerButtonId, "black")
    property bool viewGrid: false

    states: [
        State {
            name: "ShowImageViewer"
            PropertyChanges { target: imageViewer; visible: true }
            PropertyChanges { target: helpMenu; z:100 }
        },
        State {
            name: "HideImageViewer"
            PropertyChanges { target: imageViewer; visible: false }
            PropertyChanges { target: helpMenu; z:0 }
        }
    ]

    width: parent.width
    height:parent.height
    color: Storage.getAppDB(Constants.dbAppColor.imageViewerBackId, "black")
    state: "HideImageViewer"

    Rectangle{
        id: windowSimulation
        width: parent.width
        height: parent.height
        color: Storage.getAppDB(Constants.dbAppColor.imageViewerBackId, "black")
        border.color: (viewGrid) ? "red" : Storage.getAppDB(Constants.dbAppColor.imageViewerWindowId, "black")

        Image {
            id: image
            anchors.fill: parent
            anchors.margins: parent.border.width + 2
            source: ""
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
    }

    Rectangle{
        id: imageControl
        width: buttonHeight
        height: buttonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.bottom: parent.bottom
        anchors.bottomMargin: spaceBetweenButtons
        anchors.right: parent.right
        anchors.rightMargin: spaceBetweenButtons

        Image {
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.backId, "")
            opacity: imageControlButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: imageControlButton
            opacity: 0
            anchors.fill: parent
            onClicked:{
                imageViewer.state = "HideImageViewer"
            }
        }
    }
}

