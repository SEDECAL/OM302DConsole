// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4
import "Configurator.js" as Configurator
// Progress_00.qml (22/03/2018): Start


Rectangle {
    id: cumulatedRectangle
    property int controlCode: 0

    signal pressedControl(real controlCode)

    function catchSignal(){
        debug.log(true, "Catched: ", controlCode)
    }

    Component.onCompleted: {
        cumulatedRectangle.pressedControl.connect(Configurator.catchSignal)
        cumulatedRectangle.pressedControl.connect(catchSignal)
    }

    states:[
        State{
            id: viewCumulatedBar
        },
        State{
            id: noViewCumulatedBar
        }
    ]
    transitions:[
        Transition {
            to: "noViewCumulatedBar"
            PropertyAnimation { target: cumulatedRectangle; property: "height"; to: cumulatedRectangle.width; duration: 0}
            PropertyAnimation { target: progressTool; property: "opacity"; to: 0; duration: 0}
            /*


            SequentialAnimation{
                PropertyAnimation { target: progressRectangle; property: "height"; to: 505; duration: 150}
                ParallelAnimation{
                    PropertyAnimation { target: progressRectangle.progressLabel; property: "opacity"; to: 1; duration: 300}
                    PropertyAnimation { target: progressRectangle.progressTool; property: "opacity"; to: 1; duration: 300}
                }
            }
            */
        },
        Transition {
            to: "viewCumulatedBar"
            /*
            ParallelAnimation{
                PropertyAnimation { target: progressRectangle; property: "height"; to: 0; duration: 200}
                PropertyAnimation { target: progressRectangle.progressLabel; property: "opacity"; to: 0; duration: 100}
                PropertyAnimation { target: progressRectangle.progressTool; property: "opacity"; to: 0; duration: 100}
            }
            */
        }
    ]


    // fill on declaration
 //   width: 100
   // height: 300
    color: "#333333"
    radius: 3
    property alias progressTool: progressTool
    property alias cumulatedLabel: cumulatedLabel
    property alias unitsLabel: unitsLabel
//  anchors.top: parent.bottom
//  anchors.topMargin: 0
//  anchors.horizontalCenter: parent.horizontalCenter

    Label{
        id: unitsLabel
        width: parent.width
        height: parent.width * 0.4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 1
        text: "min"
        font.pixelSize:parent.width * 0.29
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "green"
        }
    }

    Label{
        id: cumulatedLabel
        width: parent.width
        height: parent.width * 0.4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 1
        text: "40000"
        font.pixelSize:parent.width * 0.29
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "green"
        }
    }

    ProgressBar{
        id: progressTool
        opacity: 0.2
        width: parent.width * 0.35
        height: parent.height * 0.70
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
//        anchors.top: parent.top
  //      anchors.topMargin: (parent.height - progressLabel.height - progressTool.height) / 2
        value: 0.40
        orientation: Qt.Vertical

        style: ProgressBarStyle {
            background: Rectangle {
                radius: 3
                color: "red"//backgroundColor
            }
            progress: Rectangle {
                color: "black"//progressColor
              //radius: 3
            }
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: pressedControl(controlCode)
    }
}




