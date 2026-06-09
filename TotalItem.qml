// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    property alias unitsLabel: unitsLabel
    property alias cumulatedLabel: cumulatedLabel

    property bool viewGrid: false

    Label{
        id: unitsLabel
        width: parent.width
        height: parent.width * 0.4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        opacity: 1
        text: "\u03BCg/Nml"//"ug/Nml"
        font.pixelSize:parent.width * 0.25
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "green"
            visible: viewGrid
        }
    }

    Label{
        id: cumulatedLabel
        width: parent.width
        height: parent.width * 0.4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        opacity: 1
        text: "40000"
        anchors.topMargin: parent.width * 0.2
        anchors.top: unitsLabel.bottom
        font.pixelSize:parent.width * 0.27
        fontSizeMode: Text.Fit
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "green"
            visible: viewGrid
        }
    }
}
