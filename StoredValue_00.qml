// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0


Item {
    id: storedValueItem
    property alias unitsLabel: unitsLabel
    property alias valueLabel: valueLabel
    property alias ww: ww

    property var ggg: magnitudeSelector

    Label{
        id: unitsLabel
        width: parent.width
        height: parent.width * 0.5//0.4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        opacity: 1
        text: "ug/Nml"
        font.pixelSize:parent.width * 0.30//0.25
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "green"
            visible: false
        }
    }

    Label{
        id: valueLabel
        width: parent.width
        height: parent.width * 0.5//0.4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        opacity: 1
        text: "40000"
        anchors.topMargin: parent.width * 0//0.2
        anchors.top: unitsLabel.bottom
        font.pixelSize:parent.width * 0.30//0.27
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "cyan"
            visible: false
        }
    }

//******************************************************************************
// fake labels for saving effects
//******************************************************************************


    Label {
        id: ww//magnitudeLabelForSavingEffect

        states: [
            State {
                name: "saving"
                PropertyChanges { target: ww; opacity: 1 }
                PropertyChanges { target: ww; x: 0 }
                PropertyChanges { target: ww; y: 0 }
//              AnchorChanges { target: ww; anchors.horizontalCenter: storedValueItem.horizontalCenter }
//              AnchorChanges { target: ww; anchors.verticalCenter: storedValueItem.verticalCenter }
            },
            State {
                name: "saved"
                PropertyChanges { target: ww; opacity: 0 }
                PropertyChanges { target: ww; font.pixelSize: magnitudeSelector.inputO3.magnitudeLabel.font.pixelSize }
//                AnchorChanges { target: ww; anchors.horizontalCenter: magnitudeSelector.inputO3.magnitudeLabel.horizontalCenter }
//                AnchorChanges { target: ww; anchors.verticalCenter: magnitudeSelector.inputO3.magnitudeLabel.verticalCenter }
            }
        ]
        transitions: [
            Transition {
                /*
                to: "saving"
                AnchorAnimation  {duration: 400}
                PropertyAnimation { target: ww; property: "font.pixelSize"; to: 0; duration: 400}
                PropertyAnimation { target: ww; property: "state"; to: "saved"; duration: 401 }
                */
            }
        ]

        state: "saved"
        text: ggg.inputO3.magnitudeLabel.text
        visible: magnitudeSelector.inputO3.magnitudeLabel.visible
        width: magnitudeSelector.inputO3.magnitudeLabel.width
        height: magnitudeSelector.inputO3.magnitudeLabel.height
        //x: mapToItem(magnitudeSelector.inputO3,0,0).x //magnitudeSelector.inputO3.magnitudeLabel.x
     //   x: magnitudeSelector.inputO3.magnitudeLabel.mapToItem(storedValueItem, 0, 0).x
      //  y: 15
       // x: storedValueItem.mapToItem(appItem, 0, 0).x
        color: magnitudeSelector.inputO3.magnitudeLabel.color
        verticalAlignment: magnitudeSelector.inputO3.magnitudeLabel.verticalAlignment
        horizontalAlignment: magnitudeSelector.inputO3.magnitudeLabel.horizontalAlignment
        textFormat: magnitudeSelector.inputO3.magnitudeLabel.textFormat
        font.pixelSize: magnitudeSelector.inputO3.magnitudeLabel.font.pixelSize
    }

    Component.onCompleted: {
      //  ww.x= magnitudeSelector.inputO3.magnitudeLabel.mapToItem(appItem, 0, 0).x - storedValueItem.mapToItem(appItem, 0, 0).x

    }


}
