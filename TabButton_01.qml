// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import "Configurator.js" as Configurator


// TabButton_01.qml (19/03/2018): States added.

Item
{
    signal clicked(string a)

    readonly property int shadowSamples: 17
    readonly property int shadowRadius: 8
    readonly property int shadowButtonTopOffset: -5
    readonly property int shadowButtonBottomOffset: 5
    readonly property int shadowButtonLeftOffset: -5
    readonly property int shadowButtonRightOffset: -5
    readonly property int shadowImageRightOffset: 3
    readonly property int shadowImageBottomOffset: 3
    readonly property string shadowColor: "#c0000000"

    property alias tabButtonItem: tabButtonItem
    property alias tabButtonImage: tabButtonImage
    property alias tabButton: tabButton

    property string tabButtonName: "2"

    id: tabButtonItem
    width: parent.width
    height: parent.width
    anchors.right: parent.right

    Component.onCompleted: {
        tabButtonItem.clicked.connect(Configurator.configureTherapy)
    }

    states: [
        State {
            name: "pressed"
            PropertyChanges { target: tabButtonTopShadow; visible: true}
            PropertyChanges { target: tabButtonBottomShadow; visible: true}
            PropertyChanges { target: tabButtonImageShadow; visible: true}
            PropertyChanges { target: tabButtonButton; enabled: false}
            PropertyChanges { target: tabButtonItem; z: 1}
        },
        State {
            name: "unpressed"
            PropertyChanges { target: tabButtonTopShadow; visible: false}
            PropertyChanges { target: tabButtonBottomShadow; visible: false}
            PropertyChanges { target: tabButtonImageShadow; visible: false}
            PropertyChanges { target: tabButtonButton; enabled: true}
            PropertyChanges { target: tabButtonItem; z: 0}
        }
    ]
    transitions: [
        Transition {
            to: "pressed"
            NumberAnimation { target: tabButtonItem; property: "width"; to: parent.width * 1.30; duration: 30}
        },
        Transition {
            to: "unpressed"
            NumberAnimation { target: tabButtonItem; property: "width"; to: parent.width; duration: 30}
        }
    ]

    Timer {
        id: initDelayTimer
            interval: 1; running: false; repeat: false
            onTriggered: Configurator.initTherapy()
    }
    Timer {
        id: wizardDelayTimer
            interval: 500; running: false; repeat: false
            onTriggered: Configurator.initWizard()
    }

    Rectangle {
        id: tabButton
        width: parent.width
        height: parent.height
        anchors.right: parent.right
        Image {
            id: tabButtonImage
            width: parent.height
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        DropShadow {
            id: tabButtonImageShadow
            anchors.fill: tabButtonImage
            horizontalOffset: shadowImageRightOffset
            verticalOffset: shadowImageBottomOffset
            radius: shadowRadius
            samples: shadowSamples
            color: shadowColor
            source: tabButtonImage
            visible: false
        }
        DropShadow {
            id: tabButtonImageSmallShadow
            anchors.fill: tabButtonImage
            horizontalOffset: 2
            verticalOffset: 2
            radius: shadowRadius
            samples: shadowSamples
            color: shadowColor
            source: tabButtonImage
            visible: true
        }
    }
    Button{
        id: tabButtonButton
        opacity: 0
        anchors.fill: parent
        onClicked:{
            tabButtonPressed(tabButtonItem)
            tabButtonItem.clicked(tabButtonName)
            tabButtonItem.state = "pressed"
            initDelayTimer.start()
            wizardDelayTimer.start()
        }
    }

    DropShadow {
        id: tabButtonTopShadow
        anchors.fill: tabButton
        horizontalOffset: shadowButtonLeftOffset
        verticalOffset: shadowButtonTopOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: tabButton
        visible: false
    }
    DropShadow {
        id: tabButtonBottomShadow
        anchors.fill: tabButton
        horizontalOffset: shadowButtonRightOffset
        verticalOffset: shadowButtonBottomOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: tabButton
        visible: false
    }
}
