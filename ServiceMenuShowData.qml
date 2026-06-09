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
    id: serviceMenuShowData

    property alias titleLabel: titleLabel
    property alias dataLabel: dataLabel
    property alias scrollDataLabel: scrollDataLabel

    property int buttonRadius: 4
    property int buttonHeight: 80
    property int spaceBetweenButtons: 20
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuButtonId, "black")
    property bool viewGrid: false

    width: QtConstants.serviceWindowPopUpWidth
    height: QtConstants.serviceWindowPopUpHeight
    radius: buttonRadius
    color: Storage.getAppDB(Constants.dbAppColor.serviceMenuShowDataId, "black")

    Label {
        id: titleLabel
        visible: true
        color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
        text: "Tittle"
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

    Rectangle{
        color: "transparent"
        border.color: "white"
        border.width: 2
        radius: buttonRadius
        anchors.right: cancelButton.left
        anchors.left: parent.left
        anchors.top: titleLabel.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: spaceBetweenButtons
        anchors.rightMargin: spaceBetweenButtons
        anchors.topMargin: spaceBetweenButtons
        anchors.bottomMargin: spaceBetweenButtons

        Text {
            id: dataLabel
            visible: true
            color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"
            text: ""
            anchors.fill: parent
            anchors.margins: spaceBetweenButtons
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft
            font.pointSize: buttonHeight * 0.4
            fontSizeMode: Text.Fit
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "red"
                visible: viewGrid
            }
        }

        Flickable {
            //          id: flickable
            anchors.fill: parent
            contentWidth: scrollDataLabel.width
            contentHeight: scrollDataLabel.height
            flickableDirection: Flickable.VerticalFlick

            TextArea.flickable:
                TextArea {
                id: scrollDataLabel
                color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                font.pointSize: buttonHeight * 0.2
                text: ""
                wrapMode: Text.WordWrap
            }
            ScrollBar.vertical: ScrollBar { }
        }

    }

    Rectangle {
        id: cancelButton
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
                serviceMenuShowData.visible = false
                dataLabel.visible = true
                scrollDataLabel.visible = false
                dataLabel.text = ""
                scrollDataLabel.text = ""
            }
        }
    }
}
