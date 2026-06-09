// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
//
Item
{
    property int page: -1
    signal clicked()

    readonly property int shadowSamples: 17
    readonly property int shadowRadius: 8
    readonly property int shadowButtonTopOffset: -5
    readonly property int shadowButtonBottomOffset: 5
    readonly property int shadowButtonLeftOffset: -5
    readonly property int shadowButtonRightOffset: -5
    readonly property int shadowImageRightOffset: 3
    readonly property int shadowImageBottomOffset: 3
    readonly property string shadowColor: "#c0000000"

    property alias tabButtonImage: tabButtonImage
    property alias tabButton: tabButton
    property alias tabButtonTopShadow: tabButtonTopShadow
    property alias tabButtonBottomShadow: tabButtonBottomShadow
    property alias tabButtonImageShadow: tabButtonImageShadow
    property alias tabButtonButton: tabButtonButton



    id: tabButtonEnclosure
    width: parent.width
    height: parent.width
    anchors.right: parent.right

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
            tabButtonPressed(tabButtonEnclosure)
            tabButtonTopShadow.visible = true
            tabButtonBottomShadow.visible = true
            tabButtonImageShadow.visible = true
            tabButtonEnclosure.z = 1
            tabButtonEnclosure.clicked()
            tabButtonButton.enabled = false
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
