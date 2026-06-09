// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Styles 1.4

import "storage.js" as Storage
import "Constants.js" as Constants

Rectangle{
    id: saveEffectId

    property alias blinkRecangle: blinkRecangle

    property int easingType: Easing.InQuint
    property int animationTime: 800
    property int finalY: -20
    property int backX: 0
    property int backY: 0
    property int backHeight: 0
    property int backWidth: 0
    property double blinkTime: 200
    property double blinkOpacity: 0.2

    function startAnimation(direction){
        blinkAnimation()
        saveAnimation(direction)
    }

    function blinkAnimation(){
        saveEffectId.visible = true
        blinkRecangle.visible = true
        blinkanimationId.start()
    }

    function saveAnimation(direction){
        finalY = (direction === "up") ? -20 : 150

        saveEffectId.visible = true
        savingEffectImage.visible = true
        xAnimationId.start()
        yAnimationId.start()
        heightAnimationId.start()
        widthAnimationId.start()
    }

    visible: false
    color: "transparent"
    radius: parent.radius

    Component.onCompleted: {
        backX = x
        backY =  y
        backHeight = height
        backWidth = width
    }
    NumberAnimation {
        id: xAnimationId
        target: saveEffectId
        property: "x"
        to: 150
        duration: animationTime
        easing.type: easingType
    }
    NumberAnimation {
        id: yAnimationId
        target: saveEffectId
        property: "y"
        to: finalY
        duration: animationTime
        easing.type: easingType
    }
    NumberAnimation {
        id: heightAnimationId
        target: saveEffectId
        property: "height"
        to: 0
        duration: animationTime
        easing.type: easingType
    }
    NumberAnimation {
        id: widthAnimationId
        target: saveEffectId
        property: "width"
        to: 0
        duration: animationTime
        easing.type: easingType
        onRunningChanged: {
            if(!running){
                saveEffectId.visible = false
                savingEffectImage.visible = false
                saveEffectId.x = backX
                saveEffectId.y = backY
                saveEffectId.height = backHeight
                saveEffectId.width = backWidth
            }
        }
    }

    Image{
        id: savingEffectImage
        anchors.fill: parent
        visible: false
        source: Storage.getAppDB(Constants.dbAppIcon.saveId, "")
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
    }

    NumberAnimation {
        id: blinkanimationId
        target: blinkRecangle
        property: "opacity"
        to: 0
        duration: blinkTime
        easing.type: easingType
        onRunningChanged: {
            if(!running){
                blinkRecangle.visible = 0
                blinkRecangle.opacity = blinkOpacity
            }
        }
    }

    Rectangle{
        id: blinkRecangle
        visible: false
        color: "white"
        x: parent.x
        y: parent.y
        width: parent.width
        height: parent.height
        opacity: blinkOpacity
        radius: parent.radius
    }
}
