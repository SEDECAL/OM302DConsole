// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Controls 1.0 as QQC1
import QtQuick.Controls.Styles 1.4

import "storage.js" as Storage
import "Constants.js" as Constants

Rectangle{
    id: helpDocViewerId

    property int buttonRadius: 4
    property int buttonHeight: 80
    property int spaceBetweenButtons: buttonHeight * 0.2
    property int maxPages: 0
    property int startPage: 0
    property string docSource: ""
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.docViewerControlsBackId, "black")
    property bool viewGrip: false

    y:0
    x:0
    width: parent.width
    height:parent.height
    color: Storage.getAppDB(Constants.dbAppColor.docViewerBackId, "black")
    state: "HideHelpDocViewer"

    states: [
        State {
            name: "ShowHelpDocViewer"
            PropertyChanges { target: helpDocViewerId; visible: true }
            PropertyChanges { target: helpMenu; z:100 }
        },
        State {
            name: "HideHelpDocViewer"
            PropertyChanges { target: helpDocViewerId; visible: false }
            PropertyChanges { target: helpMenu; z:0 }
        }
    ]

    /*
    SwipeView {
     // static loaded modules (do not erase, leave as example)
        id: viewArea

        currentIndex: 0
        height: parent.height
        width: parent.width - buttonHeight - (spaceBetweenButtons * 2)

        Repeater {
            model: doc.frameCount
            Item {
                AnimatedImage{
                    id: viewImage
                    height: parent.height
                    width: height * 210 / 297 // DIN A4 proportions
                    x: (viewArea.width - width) * 0.5
                    source: doc.source
                    paused: true
                    currentFrame: index
                }

                PinchArea {
                    id: pinchAreaId
                    anchors.fill: parent
                    pinch.maximumScale: (viewArea.width / viewImage.width) * 0.98 // 0.98 -> view a line between to maximized consecutive pages
                    pinch.minimumScale: 1
                    pinch.target: viewImage;

                    MouseArea
                    {
                        id: dragAreaId
                        anchors.fill: parent
                        drag.target: viewImage
                        drag.axis: "YAxis"
                        drag.minimumY: -viewImage.height * 0.6
                        drag.maximumY:  viewImage.height * 0.6
                    }
                }
            }
        }
        onCurrentIndexChanged: {
            console.log("swipe done, index: ", viewArea.currentIndex)
        }
    }
*/

    //  Details:
    //  This line:
    //      active:  SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
    //  Was modified in this way:
    //      active: (SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem) && (viewArea.enabled)
    //
    //  This was made to avoid in line errors (tha did not break the program flow but appears in console). Since the viewArea
    //  continued active even when it not was visible the errors happens when the name of the new source file was been composed
    //  from database information (depending of the user selection) in 'HelpMenu' 'showhelp' function.
    SwipeView {
        // dinamiacally loaded modules
        id: viewArea

        height: parent.height
        width: parent.width - buttonHeight - (spaceBetweenButtons * 2)
        currentIndex: startPage - 1

        Repeater {

            model: maxPages

            Loader{
                id: loaderId
                active: (SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem) && (viewArea.visible)
                sourceComponent: Item {

                    Image{
                        id: viewImage
                        height: parent.height
                        width: height * 210 / 297 // DIN A4 proportions
                        x: (viewArea.width - width) * 0.5
//                      source: docSource + ((index+1).toString().padStart(maxPages.toString().length, '0')) + ".png"
                        source: visible ? ( docSource + ((index+1).toString().padStart(maxPages.toString().length, '0')) + ".png" ) : "" // 12/2021
                        asynchronous: true                // performance improvement
                        sourceSize.width: parent.width    // performance improvement
                        sourceSize.height: parent.height  // performance improvement
                    }

                    PinchArea {
                        id: pinchAreaId
                        anchors.fill: parent
                        pinch.maximumScale: (viewArea.width / viewImage.width) * 0.98 // 0.98 -> view a line between to maximized consecutive pages
                        pinch.minimumScale: 1
                        pinch.target: viewImage;

                        MouseArea
                        {
                            id: dragAreaId
                            anchors.fill: parent
                            drag.target: viewImage
                            drag.axis: "YAxis"
                            drag.maximumY:  0//viewImage.height * 0.6
                            drag.minimumY: -drag.maximumY

                        }

                        onPinchUpdated: {
                            if(pinch.scale > 1){
                                // zomm activated, allow drag
                                dragAreaId.drag.maximumY = viewImage.height * 0.6 // drag activation"
                            }else if(pinch.scale < 0.4){
                                // original size reached, recover original position automatically
                                dragAreaId.drag.maximumY = 0 // drag deactivation
                                viewImage.y = 0
                            }
                        }
                    }
                    //                  Component.onCompleted:   console.log("created:", index)
                    //                  Component.onDestruction: console.log("destroyed:", index)
                }
            }
        }
        onVisibleChanged: (visible) ? currentIndex = startPage - 1 : currentIndex = currentIndex
        onCurrentIndexChanged: page.value = currentIndex + 1
    }

    Rectangle{
        id: backControlsId
        height: parent.height
        width: buttonHeight + (spaceBetweenButtons * 2)
        color: "black"
        anchors.right: parent.right
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
                helpDocViewerId.state = "HideHelpDocViewer"
            }
        }
    }

    Label{
        id: pagesLabel
        width: buttonHeight
        height: buttonHeight
        text: page.value + "/" + maxPages
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: buttonHeight * 0.3
        fontSizeMode: Text.Fit
        color: Storage.getAppDB(Constants.dbAppColor.docViewerPageInfoId, "black")
        anchors.right: parent.right
        anchors.rightMargin: spaceBetweenButtons
        anchors.top: parent.top
        anchors.topMargin: spaceBetweenButtons

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: viewGrip
        }
    }

    Slider {
        id: page
        from: 1
        to: maxPages
        stepSize: 1
        anchors.horizontalCenter: pagesLabel.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: parent.height - (2 * buttonHeight) - (4 * spaceBetweenButtons)
        rotation: 90
        height: 30

        background: Rectangle {
            id: sliderBackgroundInactive
            x: page.leftPadding
            y: page.topPadding + page.availableHeight / 2 - height / 2
            width: page.availableWidth
            height: 10
            radius: (height / 4)
            color: Storage.getAppDB(Constants.dbAppColor.docViewerBackSliderId, "black")

            Rectangle {
                id: deactivated
                width: page.visualPosition * parent.width
                height: parent.height
                color: Storage.getAppDB(Constants.dbAppColor.docViewerSliderId, "black")
                radius: height / 2
            }
            Rectangle{
                anchors.fill: parent
                color:"transparent"
                border.color: "orange"
                visible: viewGrip
            }
        }
        handle: Rectangle {
            id: sliderHandle
            x: page.leftPadding + page.visualPosition * (page.availableWidth - width)
            y: page.topPadding + page.availableHeight / 2 - height / 2
            width: page.pressed ? 60 : 50
            height: sliderHandle.width
            radius: (sliderHandle.width / 2) + 1
            color: page.pressed ?  Storage.getAppDB(Constants.dbAppColor.docViewerPressSliderId, "black") : Storage.getAppDB(Constants.dbAppColor.docViewerSliderId, "black")

        }
        onVisibleChanged: page.value = startPage

        onPressedChanged: {
            if(pressed){
                updateTimer.valueBefore = page.value
                updateTimer.running = true
            }
            else{
                viewArea.currentIndex = page.value - 1
                updateTimer.running = false
            }
        }

        Timer{
            // avoid to update SwipeView (viewArea) continuously (bad user perception)
            id: updateTimer
            property int valueBefore: 0
            interval: 400
            repeat: true
            running: false
            onTriggered: {
                if(page.value !== valueBefore){
                    valueBefore = page.value
                }
                else{
                    viewArea.currentIndex = page.value - 1
                    valueBefore = page.value
                }
            }
        }

        Rectangle{
            anchors.fill: parent
            color:"transparent"
            border.color: "pink"
            visible: viewGrip
        }
    }
}


