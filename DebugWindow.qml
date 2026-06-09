// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12

Item{
    property double accessValidator: 10
    property color debugColor: "transparent"
    property bool showDebug: false

    height: parent.height
    width: parent.width * 0.4

    function log(){
        var i
        var paramCompound = ""

        if(arguments[0] === true)
        {
            for (i=1; i<arguments.length; i++){
                paramCompound = paramCompound + String(arguments[i])
            }
            if(textScrollView.visible){
                debugText.append(paramCompound)
            }else{
                console.log(paramCompound)
            }
        }
    }

    Rectangle{
        id: showDebugButtom
        width: parent.height * 0.1
        height: parent.height * 0.08
        x: parent.height * 0.28
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.108
        color: "transparent"
        border.color: debugColor
        z: 2
        visible: showDebug
        MouseArea{
            anchors.fill: parent
            propagateComposedEvents: true
            onClicked: {
                if(textScrollView.visible){
                    textScrollView.visible = false
                }
                else{
                    if (accessValidator === 10203040){
                        textScrollView.visible = true
                    }
                }
                accessValidator = 10
                mouse.accepted = false
            }
        }
    }

    Rectangle{
        id: showDebugButtom2
        width: parent.height * 0.1
        height: width
        color: "transparent"
        border.color: debugColor
        z: 2
        x: parent.height * 0.28
        anchors.bottom: parent.bottom
        visible: showDebug
        MouseArea{
            anchors.fill: parent
            onClicked:{
                propagateComposedEvents: true
                accessValidator = (accessValidator * 100) + 20
            }
        }
    }

    Rectangle{
        id: showDebugButtom3
        width: parent.height * 0.1
        height: width
        color: "transparent"
        border.color: debugColor
        z: 2
        x: parent.height * 0.43
        anchors.bottom: parent.bottom
        visible: showDebug
        MouseArea{
            anchors.fill: parent
            onClicked:{
                propagateComposedEvents: true
                accessValidator = (accessValidator * 100) + 30
            }
        }
    }

    Rectangle{
        id: showDebugButtom4
        width: parent.height * 0.1
        height: width
        color: "transparent"
        border.color: debugColor
        z: 2
        x: parent.height * 0.92
        anchors.bottom: parent.bottom
        visible: showDebug
        MouseArea{
            anchors.fill: parent
            onClicked:{
                propagateComposedEvents: true
                accessValidator = (accessValidator * 100) + 40
            }
        }
    }

    ScrollView {
        id: textScrollView
        anchors.fill: parent
        visible: false
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: debugColor

        }

        TextArea{
            id: debugText
            width: textScrollView.width
            text:""
            color: "white"
            wrapMode: Text.WrapAnywhere
        }
    }
}
