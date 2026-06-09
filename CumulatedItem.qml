// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.LocalStorage 2.12

import "storage.js" as Storage
import "Constants.js" as  Constants

Rectangle {
    id: cumulatedRectangle

    property alias progressTool: progressTool
    property alias cumulatedLabel: cumulatedLabel
    property alias unitsLabel: unitsLabel

    property int cumulatedRectangleY: cumulatedRectangle.y
    property int cumulatedRectangleHeight: cumulatedRectangle.height

    property double conversionFactor: 1

    property string progressColor:""
    property string progressBackgroundColor:""

    Component.onCompleted: {
        cumulatedRectangleHeight = cumulatedRectangle.height
        cumulatedRectangleY = cumulatedRectangle.y
    }

    states:[
        State{
            id: viewCumulatedBar
            PropertyChanges { target: cumulatedRectangle; visible: true }
        },
        State{
            id: noViewCumulatedBar
            PropertyChanges { target: cumulatedRectangle; visible: false }
        }
    ]
    transitions:[
        Transition {
            to: "viewCumulatedBar"
            PropertyAnimation { target: cumulatedRectangle; property: "opacity"; to: 1}
            SequentialAnimation{
                ParallelAnimation{
                    PropertyAnimation { target: cumulatedRectangle; property: "height"; to: cumulatedRectangleHeight; duration: 150}
                    PropertyAnimation { target: cumulatedRectangle; property: "y"; to: cumulatedRectangleY; duration: 150}
                }
                ParallelAnimation{
                    PropertyAnimation { target: cumulatedLabel; property: "opacity"; to: 1; duration: 200}
                    PropertyAnimation { target: unitsLabel; property: "opacity"; to: 1; duration: 200}
                    PropertyAnimation { target: progressTool; property: "opacity"; to: 1; duration: 200}
                }
            }
        },
        Transition {
            to: "noViewCumulatedBar"
            ParallelAnimation{

                PropertyAnimation { target: cumulatedRectangle; property: "height"; to: 0; duration: 200}
                PropertyAnimation { target: cumulatedRectangle; property: "y"; to: cumulatedRectangleY + cumulatedRectangleHeight; duration: 200}

                PropertyAnimation { target: cumulatedLabel; property: "opacity"; to: 0; duration: 150}
                PropertyAnimation { target: progressTool; property: "opacity"; to: 0; duration: 75}
                PropertyAnimation { target: unitsLabel; property: "opacity"; to: 0; duration: 150}
            }
        }
    ]

    color: Storage.getAppDB(Constants.dbAppColor.cumulatedPanelId, "black")
    radius: 3
    state: "noViewCumulatedBar"
    visible:false

    Text{
        id: unitsLabel
        width: parent.width
        height: parent.width * 0.4
        color: progressColor
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        text: ""
        font.pixelSize:parent.width * 0.18//0.25
        fontSizeMode: Text.Fit
    }

    Text{
        id: cumulatedLabel
        width: parent.width
        height: parent.width * 0.4
        color: progressColor
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        text: "40000"
        font.pixelSize:parent.width * 0.20//0.27
        fontSizeMode: Text.Fit
    }

    ProgressBar{
        id: progressTool
        width: parent.width * 0.35
        height: parent.height * 0.65
        anchors.centerIn: parent
        value: 0
        maximumValue: 1
        minimumValue: 0
        orientation: Qt.Vertical

        style: ProgressBarStyle {
            background: Rectangle {
                radius: 3
                color: progressBackgroundColor
            }
            progress: Rectangle {
                color: progressColor
                radius: 3
            }
        }
    }
    MouseArea{
        anchors.fill: parent
    }
}

