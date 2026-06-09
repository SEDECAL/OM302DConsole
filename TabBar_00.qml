// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0


Column {
    id: toolBar

    property string activeColor: "#090909"
    readonly property string activeButtonColor: "#090909"
    readonly property string inactiveButtoncolor: "#292929"


    function tabButtonPressed(a) {
        console.log("clicked:", a)
        button1.color = inactiveButtoncolor
        button2.color = inactiveButtoncolor
        button3.color = inactiveButtoncolor
        button4.color = inactiveButtoncolor
        button5.color = inactiveButtoncolor
        button6.color = inactiveButtoncolor
        imageButton1.opacity = 0.1
        imageButton2.opacity = 0.1
        imageButton3.opacity = 0.1
        imageButton4.opacity = 0.1
        imageButton5.opacity = 0.1
        imageButton6.opacity = 0.1
    }
/*

    function tabButtonPressed(a) {
        console.log("clicked:", a)
       button1.opacity = 0.5
        button2.opacity = 0.5
        button3.opacity = 0.5
        button4.opacity = 0.5
        button5.opacity = 0.5
        button6.opacity = 0.5
    }
*/
    visible: true
    width: parent.height / 6
    height: parent.height
    anchors.right: parent.right
    anchors.rightMargin: 0


    Rectangle {
        id: button1
        width: parent.width
        height: button1.width
        color: "tomato"
        radius: 3
        Image {
            id: imageButton1
            anchors.fill: parent
            source: "/Images/JERINGA 02_white.png"
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked:{
                tabButtonPressed(1)
            }
        }
    }
    Rectangle {
        id: button2
        width: parent.width
        height: button2.width
        color: "sandybrown"
        radius: 3
        Image {
            id: imageButton2
            anchors.fill: parent
            source: "/Images/O3_white.png"
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked:{
                tabButtonPressed(2)
            }
        }
    }
    Rectangle {
        id: button3
        width: parent.width
        height: button3.width
        color: "palegoldenrod"
        radius: 3
        Image {
            id: imageButton3
            anchors.fill: parent
            source: "/Images/ic_done_white_48dp.png"
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked:{
                tabButtonPressed(3)
            }
        }
    }
    Rectangle {
        id: button4
        width: parent.width
        height: button4.width
        color: "darkseagreen"
        radius: 3
        Image {
            id: imageButton4
            anchors.fill: parent
            source: "/Images/ic_pause_white_48dp.png"
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked:{
                tabButtonPressed(4)
            }
        }
    }
    Rectangle {
        id: button5
        width: parent.width
        height: button5.width
        color: "mediumturquoise"
        radius: 3
        Image {
            id: imageButton5
            anchors.fill: parent
            source: "/Images/ic_settings_white_48dp.png"
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked:{
            tabButtonPressed(5)
            }
        }
    }
    Rectangle {
        id: button6
        width: parent.width
        height: button6.width
        color: "orchid"
        radius: 3
        Image {
            id: imageButton6
            anchors.fill: parent
            source: "/Images/ic_remove_circle_outline_white_48dp.png"
        }
        Button{
            opacity: 0
            anchors.fill: parent
            onClicked:{
            tabButtonPressed(6)
            }
        }
    }
}
