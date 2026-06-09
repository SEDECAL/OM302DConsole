// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.0
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies

Rectangle {
    id: waitingRectangle

    property alias waitingProgressTool: waitingProgressTool

    property int configuredWaitingTime: 0
    property int remainingWaitingTime: 0
    property string waitingIcon: ""

    property bool viewGrid: false

    function formatTime(remaningSeconds){
        var min
        var sec
        var time

        sec =  Math.floor(remaningSeconds % 60)
        min =  Math.floor(remaningSeconds / 60)

        time = min > 9 ? min.toString() : "0" + min.toString()
        time += sec > 9 ? ":" + sec.toString() : ":0" + sec.toString()

        return time
    }

    width: 800
    height: waitingRectangle.width * 0.625
    color: "transparent"
    visible: true
    border.color: (viewGrid) ? "orange" : "transparent"

    Image {
        id: waitingImage
        visible: true
        opacity: 0.3
        width: waitingRectangle.width * 0.2
        height: waitingRectangle.width * 0.2
        anchors.centerIn: parent
        source: waitingIcon
        asynchronous: true                // performance improvement
        sourceSize.width: parent.width    // performance improvement
        sourceSize.height: parent.height  // performance improvement
    }

    BusyIndicator{
        id: waitingBussyIndicator
        width: waitingRectangle.width * 0.4375
        height: waitingRectangle.width * 0.4375
        visible: true
        opacity: 1
        anchors.centerIn: parent
        running: waitingRectangle.visible ? true : false
    }

    ProgressBar{
        id: waitingProgressTool
        opacity: 1
        width: waitingRectangle.width * 0.95
        height: waitingRectangle.width * 0.04
        anchors.bottom: parent.bottom
        anchors.bottomMargin: waitingRectangle.width * 0.0125
        anchors.horizontalCenter: parent.horizontalCenter
        value: remainingWaitingTime
        maximumValue: configuredWaitingTime
        minimumValue: 0
        orientation: Qt.Horizontal

        style: ProgressBarStyle {
            background: Rectangle {
                radius: 3
                color: "#393939"
            }
            progress: Rectangle {
                color: "#797979"
                radius: 3
            }
        }
    }
    Label {
        id: timeLabel
        visible: waitingProgressTool.visible
        color: "#FFFFFF"
        text: formatTime(remainingWaitingTime)
        width: waitingProgressTool.width * 0.18
        height: waitingProgressTool.width * 0.06
        anchors.left: waitingProgressTool.left
        anchors.bottom: waitingProgressTool.top
        anchors.bottomMargin: waitingProgressTool.width * 0.0075
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        fontSizeMode: Text.Fit
        font.pointSize: height
        Rectangle{
            anchors.fill: parent
            border.color: "orange"
            color: "transparent"
            visible: viewGrid
        }
    }

    Rectangle {
        id: increaseTimeButton
        width: waitingRectangle.width * 0.1
        height: width
        radius: 4
        anchors.bottom: timeLabel.bottom
        anchors.right: waitingProgressTool.right
        color: increaseTimeButtonButton.down ? "#303030" : "#393939"
        visible: waitingProgressTool.visible
        Image{
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.videoForwardId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            SequentialAnimation on opacity{
                loops: Animation.Infinite
                running: true
                NumberAnimation { from: 1; to: 0.1; duration: 1500 }
                NumberAnimation { from: 0.1; to: 1; duration: 600 }
            }
        }
        AbstractButton{
            id: increaseTimeButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked: Therapies.play()
        }
    }
}
