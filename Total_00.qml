// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    property alias unitsLabel: unitsLabel
    property alias cumulatedLabel: cumulatedLabel
    Label{
        id: unitsLabel
        width: parent.width
        height: parent.width * 0.4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        opacity: 1
        text: "ug/Nml"
        font.pixelSize: parent.width * 0.25
        fontSizeMode: Text.Fit
//      Rectangle{
//          anchors.fill: parent
//          color: "#00000000"
//          border.color: "green"
//      }
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
        font.pixelSize: parent.width * 0.27
        fontSizeMode: Text.Fit
//      Rectangle{
//          anchors.fill: parent
//          color: "#00000000"
//          border.color: "green"
//      }
    }
}
