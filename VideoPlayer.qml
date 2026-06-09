// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Controls 1.0 as QQC1
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.12
import "storage.js" as Storage
import "Constants.js" as Constants
import "Singletons"

Rectangle{
    id: videoPlayer

    property alias video: video
    property alias windowSimulation: windowSimulation

    function translateMilisecondsToTimeFormat(s){
        var ms = s % 1000;
        s = (s - ms) / 1000;
        var secs = s % 60;
        s = (s - secs) / 60;
        var mins = s % 60;
        var hrs = (s - mins) / 60;

        var retStr = (hrs) ? ((hrs > 9) ? hrs : "0" + hrs + ":") : ""
        retStr = retStr + ((mins > 9) ? mins.toString() : "0" + mins.toString()) + ":" + ((secs > 9) ? secs.toString() : "0" + secs.toString())

        return retStr
    }

    states: [
        State {
            name: "ShowVideoPlayer"
            PropertyChanges { target: videoPlayer; visible: true }
            PropertyChanges { target: helpMenu; z:100 }
        },
        State {
            name: "HideVideoPlayer"
            PropertyChanges { target: videoPlayer; visible: false }
            PropertyChanges { target: helpMenu; z:0 }
        }
    ]
    transitions:[
        Transition {
            to: "ShowVideoPlayer"
            ScriptAction{script: video.play()}
        }
    ]

    y:0
    x:0
    width: parent.width
    height:parent.height
    state: "HideVideoPlayer"
    color: Storage.getAppDB(Constants.dbAppColor.videoPlayerBackId, "black")

    Rectangle{
        id: windowSimulation
        width: parent.width * 0.890625
        height: parent.height * 0.9
        color: Storage.getAppDB(Constants.dbAppColor.videoPlayerBackId, "black")
        border.color: Storage.getAppDB(Constants.dbAppColor.videoPlayerWindowId, "black")
        border.width: 4
        radius: 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15

        Video {
            id: video
            x: parent.border.width
            y: parent.border.width
            width: parent.width - (parent.border.width * 2)
            height: parent.height - (parent.border.width * 2)
            source: ""
            focus: true
            Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
            Keys.onLeftPressed: video.seek(video.position - 5000)
            Keys.onRightPressed: video.seek(video.position + 5000)
        }
    }
    Rectangle{
        id: videoControls
        width: (playId.width * 5) + (rowControls.spacing * 6)
        height: playId.height + (rowControls.spacing * 2) + windowSimulation.border.width
        color: Storage.getAppDB(Constants.dbAppColor.videoPlayerControlsBackId, "black")
        anchors.top: windowSimulation.bottom
        anchors.right: windowSimulation.right
        anchors.topMargin: - windowSimulation.border.width
        radius: windowSimulation.radius
        border.color: "transparent"

        Row{
            id: rowControls
            height: 40
            spacing: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: spacing
            anchors.horizontalCenter: parent.horizontalCenter
            z: 1
            Rectangle{
                id: rewindId
                width: 40
                height: 40
                color: "transparent"
                Button{
                    id: rewindButtonId
                    opacity: 0
                    autoRepeat: true
                    onClicked: {
                        video.seek(video.position - 5000)
                    }
                }
                Image {
                    anchors.fill: parent
                    source: Storage.getAppDB(Constants.dbAppIcon.videoRewindId, "")
                    asynchronous: true                // performance improvement
                    sourceSize.width: parent.width    // performance improvement
                    sourceSize.height: parent.height  // performance improvement
                    opacity: rewindButtonId.down ? 0.4 : 1
                }
            }
            Rectangle{
                id: playId
                width: 40
                height: 40
                color: "transparent"
                Button{
                    id: playButtonId
                    opacity: 0
                    anchors.fill: parent
                    onClicked: video.play()
                }
                Image {
                    anchors.fill: parent
                    source: Storage.getAppDB(Constants.dbAppIcon.videoPlayId, "")
                    asynchronous: true                // performance improvement
                    sourceSize.width: parent.width    // performance improvement
                    sourceSize.height: parent.height  // performance improvement
                    opacity: playButtonId.down ? 0.4 : 1
                }
            }
            Rectangle{
                id: pauseId
                width: 40
                height: 40
                color: "transparent"
                Button{
                    id: pauseButtonId
                    opacity: 0
                    anchors.fill: parent
                    onClicked:{
                        video.pause()
                    }
                }
                Image {
                    anchors.fill: parent
                    source: Storage.getAppDB(Constants.dbAppIcon.videoPauseId, "")
                    asynchronous: true                // performance improvement
                    sourceSize.width: parent.width    // performance improvement
                    sourceSize.height: parent.height  // performance improvement
                    opacity: pauseButtonId.down ? 0.4 : 1
                }
            }
            Rectangle{
                id: fastForwardId
                width: 40
                height: 40
                color: "transparent"
                Button{
                    id: fastForwarButtondId
                    opacity: 0
                    autoRepeat: true
                    anchors.fill: parent
                    onClicked: {
                        if(video.position < video.duration){
                            video.seek(video.position + 5000)
                        }
                    }
                }
                Image {
                    anchors.fill: parent
                    source: Storage.getAppDB(Constants.dbAppIcon.videoForwardId, "")
                    asynchronous: true                // performance improvement
                    sourceSize.width: parent.width    // performance improvement
                    sourceSize.height: parent.height  // performance improvement
                    opacity: fastForwarButtondId.down ? 0.4 : 1
                }
            }
            Rectangle{
                id: stopId
                width: 40
                height: 40
                color: "transparent"
                Button{
                    id: stopButtondId
                    opacity: 0
                    anchors.fill: parent
                    onClicked:{
                        video.stop()
                        videoPlayer.state = "HideVideoPlayer"
                        video.source = "" // 12/2021
                    }
                }
                Image {
                    anchors.fill: parent
                    source: Storage.getAppDB(Constants.dbAppIcon.videoCancelId, "")
                    asynchronous: true                // performance improvement
                    sourceSize.width: parent.width    // performance improvement
                    sourceSize.height: parent.height  // performance improvement
                    opacity: stopButtondId.down ? 0.4 : 1
                }
            }
        }
    }

    Label{
        id: videoDurationLabel
        text: translateMilisecondsToTimeFormat(video.duration)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 20
        fontSizeMode: Text.Fit
        color: Storage.getAppDB(Constants.dbAppColor.videoPlayerDurationId, "black")
        anchors.right: videoControls.left
        anchors.rightMargin: 10
        anchors.verticalCenter: videoControls.verticalCenter

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: false
        }
    }

    Label{
        id: videoPositionLabel
        text: translateMilisecondsToTimeFormat(video.position)
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 20
        fontSizeMode: Text.Fit
        color: Storage.getAppDB(Constants.dbAppColor.videoPlayerPositionId, "black")
        width: videoDurationLabel.width
        anchors.left: windowSimulation.left
        anchors.verticalCenter: videoControls.verticalCenter

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: false
        }
    }

    Slider {
        id: slider

        from: 0
        to: video.duration
        stepSize: 1
        anchors.left: videoPositionLabel.right
        anchors.leftMargin: 10
        anchors.right: videoDurationLabel.left
        anchors.rightMargin: 10
        anchors.verticalCenter: videoPositionLabel.verticalCenter

        height: 30
        value: video.position

        background: Rectangle {
            id: sliderBackgroundInactive
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.availableWidth
            height: 6
            radius: (height / 4)
            color: Storage.getAppDB(Constants.dbAppColor.videoPlayerBackSliderId, "black")

            Rectangle {
                id: deactivated
                width: slider.visualPosition * parent.width
                height: parent.height
                color: Storage.getAppDB(Constants.dbAppColor.videoPlayerSliderId, "black")
                radius: height / 2
            }
        }
        handle: Rectangle {
            id: sliderHandle
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.pressed ? 35 : 30
            height: sliderHandle.width
            radius: (sliderHandle.width / 2) + 1
            color: slider.pressed ?  Storage.getAppDB(Constants.dbAppColor.videoPlayerPressSliderId, "black") : Storage.getAppDB(Constants.dbAppColor.videoPlayerSliderId, "black")
        }

        onMoved: video.seek(slider.value)
        onPressedChanged: (pressed) ? video.pause() : video.play()

        Rectangle{
            anchors.fill: parent
            color:"transparent"
            border.color: "pink"
            visible: false
        }
    }
}

