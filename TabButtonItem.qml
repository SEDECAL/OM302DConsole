// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants
import "Configurator.js" as Configurator
import "Therapies.js" as Therapies
import "DebugConstants.js" as DC

Item
{
    id: tabButtonItem

    property alias tabButtonItem: tabButtonItem
    property alias tabButtonImage: tabButtonImage
    property alias tabButtonSubmenuImage: tabButtonSubmenuImage
    property alias tabButton: tabButton

    property bool changeSizeOnClick: true
    property int distanceBetweenButtons: 1
    property double deltaSizeIncrementOnSelection: 0
    property string tabButtonName: "2"

    readonly property string shadowColor: "#c0000000"
    readonly property int buttonRadius: 4
    readonly property int shadowSamples: 17
    readonly property int shadowRadius: 8
    readonly property int shadowButtonTopOffset: -7
    readonly property int shadowButtonBottomOffset: 7
    readonly property int shadowButtonLeftOffset: -7
    readonly property int shadowButtonRightOffset: -7
    readonly property int shadowImageRightOffset: 3
    readonly property int shadowImageBottomOffset: 3
    readonly property int animationTime: 30

    function tabButtonPressedActions(){
        tabButtonPressed(tabButtonName)
        tabButtonItem.state = "pressed"
        debug.log(DC.tabBarConsoleLog, "Tab button clicked:", tabButtonName)
    }

    states: [
        State {
            name: "pressed"
            PropertyChanges { target: tabButtonItem; z: 1}
        },
        State {
            name: "pressedWithSubmenu"
            PropertyChanges { target: tabButtonItem; z: 1}
            PropertyChanges { target: tabButtonImage; visible: false}
            PropertyChanges { target: tabButtonSubmenuImage; visible: true}
            PropertyChanges { target: tabButtomSmallIcon; visible: true}
        },
        State {
            name: "unpressed"
            PropertyChanges { target: tabButtonButton; enabled: true}
            PropertyChanges { target: tabButtonItem; z: 0}
            PropertyChanges { target: tabButtonItem; x: 0}
            PropertyChanges { target: tabButtonSubmenuImage; visible: false}
            PropertyChanges { target: tabButtonImage; visible: true}
            PropertyChanges { target: tabButtomSmallIcon; visible: false}
        }
    ]
    transitions: [
        Transition {
            to: "pressed"
              NumberAnimation { target: tabButtonItem; property: "width"; to: parent.width * (deltaSizeIncrementOnSelection + 1) ; duration: (parent.width === tabButtonItem.width) ? animationTime : 0}
              NumberAnimation { target: tabButtonItem; property: "x"; to: (changeSizeOnClick) ? -(parent.width * deltaSizeIncrementOnSelection) : tabButtonItem.x; duration: (parent.width === tabButtonItem.width) ? animationTime : 0}
        },
        Transition {
            to: "unpressed"
              NumberAnimation { target: tabButtonItem; property: "width"; to: parent.width; duration: animationTime}
        }
    ]

    width: parent.width
    height: parent.width

    Rectangle {
        id: tabButton
        width: parent.width - distanceBetweenButtons
        height: parent.height - distanceBetweenButtons
        anchors.centerIn: parent
        radius: buttonRadius

        Image {
            id: tabButtonImage
            z: 1
            width: parent.height
            height: parent.height
            anchors.centerIn: parent
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            opacity: tabButtonButton.down ? 0.4 : 1
        }

        Rectangle{
            id: tabButtomSmallIcon
            z: 1
            visible: false
            color: tabButton.color
            border.color: Storage.getAppDB(Constants.dbAppColor.tabButtonBorderColorId, "black")
            border.width: tabButton.width * 0.015
            radius: tabButton.radius
            width: tabButton.height * 0.4
            height: tabButton.height * 0.4
            anchors.right: tabButton.right
            anchors.bottom: tabButton.bottom
            anchors.bottomMargin: tabButton.width * 0.02
            anchors.rightMargin: tabButton.width * 0.02
            opacity: tabButtonButton.down ? 0.4 : 1

            Image {
                id: tabButtomSmallIconImage
                z: 1
                width: parent.height * 0.9
                height: parent.height  * 0.9
                anchors.centerIn: parent
                source: tabButtonImage.source
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
        }

        Image {
            id: tabButtonSubmenuImage
            visible: false
            width: parent.height
            height: parent.height
            anchors.centerIn: parent
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            opacity: tabButtonButton.down ? 0.4 : 1
        }

        Button{
            id: tabButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked:{
                tabButtonPressedActions()
            }
        }
    }
}
