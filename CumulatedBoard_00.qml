// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.0

Item {
    height: parent.height
    property alias cumulatedPresure: cumulatedPresure
    property alias cumulatedTime: cumulatedTime
    property alias cumulatedVolume: cumulatedVolume
    property alias cumulatedO3: cumulatedO3

    Row{
        spacing:30
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Cumulated_00{
            id: cumulatedO3
            x:150
            width: 200
            height: parent.height
            controlCode: 1
            unitsLabel.text:controlCode
            visible: true
            Component.onCompleted: {
                state="noViewCumulatedBar"
            }
        }
        Cumulated_00{
            id: cumulatedVolume
            x:150
            width: 200
            height: parent.height
            controlCode: 2
            unitsLabel.text:controlCode
            visible: true
            Component.onCompleted: {
                state="noViewCumulatedBar"
            }
        }
        Cumulated_00{
            id: cumulatedTime
            x:150
            width: 200
            height: parent.height
            controlCode: 3
            unitsLabel.text:controlCode
            visible: true
            Component.onCompleted: {
                state="noViewCumulatedBar"
            }
        }
        Cumulated_00{
            id: cumulatedPresure
            x:150
            width: 200
            height: parent.height
            controlCode: 4
            unitsLabel.text:controlCode
            visible: true
            Component.onCompleted: {
                state="noViewCumulatedBar"
            }
        }

    }

}
