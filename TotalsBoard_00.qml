// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: totalsBoardItem

    property int operationButtonWidth: 50//86
    property int operationButtonHeight: 50//86//fullViewWidth * 0.085//0.1
    property string buttonsColor: "#292929"
    property int buttonRadius: 5//fullViewWidth * 0.008
    property int externalBorderMargin: 10//20//fullViewWidth * 0.02
    property int totalsSize: 90//150

    readonly property int shadowSamples: 17
    readonly property int shadowRadius: 8
    readonly property int shadowButtonHorizontalOffset: 3
    readonly property int shadowButtonVerticalOffset: 3
    readonly property string shadowColor: "#70000000"

    property alias totalsIcon: totalsIcon

    signal accepted()

    states:[
        State{
            id: viewTotalBoard
        },
        State{
            id: noViewTotalBoard
        }
    ]
    transitions:[
        Transition {
            to: "viewTotalBoard"
            SequentialAnimation{
                PropertyAnimation { target: totalsBoardItem; property: "color"; to: totalsBoardItem.color; duration: 200} // just delay
                PropertyAnimation { target: totalsBoardItem; property: "opacity"; to: 1; duration: 200}
            }
        },
        Transition {
            to: "noViewTotalBoard"
            PropertyAnimation { target: totalsBoardItem; property: "opacity"; to: 0; duration: 200}
        }
    ]

    function totalsBoardWidth(){
        var width = (externalBorderMargin * 3) + totalsIcon.width + operationButtonWidth
        var seaprators = 1

        if(totalsO3.visible){
            seaprators = seaprators + 1
            width = width + totalsO3.width
        }
        if(totalsVolume.visible){
            seaprators = seaprators + 1
            width = width + totalsVolume.width
        }
        if(totalsTime.visible){
            seaprators = seaprators + 1
            width = width + totalsTime.width
        }
        if(totalsPressure.visible){
            seaprators = seaprators + 1
            width = width + totalsPressure.width
        }

        width = width + ((seaprators - 1) * totalsBoardRow.spacing)

        return width
    }

    x: 100
    y: 400
    width: totalsBoardWidth()
    height: 200
    color: "#333333"
    radius: 4
    opacity: 0

    Rectangle{
        id: totalsIcon
//      color: "#FFB300"
        color: "#388E3C"
        width: totalsSize
        height: totalsSize
        radius: 5
        anchors.left: parent.left
        anchors.leftMargin: externalBorderMargin
        anchors.verticalCenter: parent.verticalCenter
        Image{
            anchors.fill: parent
//          source: "Images/ic_warning_white_48dp.png"
            source: "Images/ic_check_circle_white_48dp.png"
        }
    }

    Row{
        id: totalsBoardRow
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: operationButtonWidth + (externalBorderMargin * 2)
        spacing:30
        //height: parent.height

        Total_00{
            id: totalsO3
            width: totalsSize
            height: totalsSize
            unitsLabel.text: "ug/Nml"
            cumulatedLabel.text: "800"
            unitsLabel.color: "#0097A7"
            cumulatedLabel.color: "#80DEEA"
        }
        Total_00{
            id: totalsVolume
            width: totalsSize
            height: totalsSize
            unitsLabel.text: "l/h"
            cumulatedLabel.text: "53"
            unitsLabel.color: "#388E3C"
            cumulatedLabel.color: "#81C784"
        }
        Total_00{
            id: totalsTime
            width: totalsSize
            height: totalsSize
            unitsLabel.text: "min"
            cumulatedLabel.text: "02:34"
            unitsLabel.color: "#FFB300"
            cumulatedLabel.color: "#FFE082"
        }
        Total_00{
            id: totalsPressure
            width: totalsSize
            height: totalsSize
            unitsLabel.text: "ml"
            cumulatedLabel.text: "5326"
            unitsLabel.color: "#AFB42B"
            cumulatedLabel.color: "#DCE775"
        }
    }
    Rectangle {
        id: cancelButton
        width: operationButtonWidth
        height: operationButtonHeight
        radius: buttonRadius
        anchors.bottom: parent.bottom
        anchors.bottomMargin: externalBorderMargin
        opacity: 1
        visible: true
        color: buttonsColor
        anchors.right: parent.right
        anchors.rightMargin: externalBorderMargin
        Image{
            anchors.fill: parent
            source: "Images/ic_back_01_white_48dp.png"
            opacity: cancelButtonButton.down ? 0.4 : 1
        }
        Button{
            id: cancelButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked: {
                accepted()
            }
        }
    }

    DropShadow {
        id: cancelButtonShadow
        anchors.fill: cancelButton
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: cancelButton
        opacity: cancelButton.opacity
        visible: cancelButton.visible
    }

    DropShadow {
        id: totalsIconShadow
        anchors.fill: totalsIcon
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: totalsIcon
       // opacity: totalsIcon.opacity
        visible: totalsIcon.visible
    }
}
