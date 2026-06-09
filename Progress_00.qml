// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4

//import QtQuick.Layouts 1.1
//import QtQuick.Window 2.2


Rectangle {
    id: progressRectangle
    property string backgroundColor: "white"
    property string progressColor: "black"
    property alias progressLabel: progressLabel
    property alias progressTool: progressTool
    property alias progressRectangle: progressRectangle

    //height: 0
    width: parent.width
    color: parent.color
    radius: parent.radius
    anchors.top: parent.bottom
    anchors.topMargin: - parent.radius
    anchors.horizontalCenter: parent.horizontalCenter

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
    }

    ProgressBar{
        id: progressTool
        width: 50
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
              //radius: 3
            }
        }
    }
}




