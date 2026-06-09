// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4

// Progress_01.qml (22/03/2018): States included here.


Rectangle {
    id: progressRectangle
    property int viewHeight: 0
    property string backgroundColor: "white"
    property string progressColor: "black"
    property alias progressLabel: progressLabel
    property alias progressTool: progressTool
    property alias progressRectangle: progressRectangle    

    states:[
        State{
            id: viewProgress
        },
        State{
            id: hideProgress
        }
    ]
    transitions:[
        Transition {
            to: "viewProgress"
            SequentialAnimation{
                PropertyAnimation { target: progressRectangle; property: "color"; to: progressRectangle.color; duration: 100}
                PropertyAnimation { target: progressRectangle; property: "height"; to: viewHeight; duration: 150}
                ParallelAnimation{
                    PropertyAnimation { target: progressRectangle.progressLabel; property: "opacity"; to: 1; duration: 300}
                    PropertyAnimation { target: progressRectangle.progressTool; property: "opacity"; to: 1; duration: 300}
                }
            }
        },
        Transition {
            to: "noViewProgress"
            ParallelAnimation{
                PropertyAnimation { target: progressRectangle; property: "height"; to: 0; duration: 200}
                PropertyAnimation { target: progressRectangle.progressLabel; property: "opacity"; to: 0; duration: 100}
                PropertyAnimation { target: progressRectangle.progressTool; property: "opacity"; to: 0; duration: 100}
            }
        }
    ]

    // fill on declaration
//  height: 0
//  width: 0
//  color: "#00000000"
//  radius: 0
//  anchors.top: parent.bottom
//  anchors.topMargin: 0
//  anchors.horizontalCenter: parent.horizontalCenter

    Label{
        id: progressLabel
        width: parent.width
        height: parent.width / 3
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0
        text: "40000"
    }

    ProgressBar{
        id: progressTool
//      width: 50
        height: parent.height * 0.75
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: (parent.height - progressLabel.height - progressTool.height) / 2
        value: 0.40
        orientation: Qt.Vertical

        style: ProgressBarStyle {
            background: Rectangle {
                radius: 3
                color: backgroundColor
            }
            progress: Rectangle {
                color: progressColor
                radius: 3
            }
        }
    }
}




