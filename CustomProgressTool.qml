// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle{
    property real value
    property real maximumValue
    property real minimumValue
    property color backColor
    property color mainColor

    height: 200
    width: 100
    border.color: "transparent"
    color: backColor

    Rectangle{
        width: parent.width
        height: value * parent.height / maximumValue
        anchors.bottom: parent.bottom
        color: mainColor
        border.color: "transparent"
    }
}

