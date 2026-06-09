// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants

Rectangle {
    id: totalsBoardItem

    property alias totalsIcon: totalsIcon
    property alias iconImage: iconImage
    property alias totalsO3: totalsO3
    property alias totalsVolume: totalsVolume
    property alias totalsTime: totalsTime
    property alias totalsPressure: totalsPressure
    property alias totalsTimeSeconds: totalsTimeSeconds
    property alias errorCodeLabel: errorCodeLabel
    property alias totalsTotalConcentration: totalsTotalConcentration
    property alias totalsIpIndex: totalsIpIndex

    property int externalBorderMargin: parent.width * 0.0078
    property int cotrolsSize: parent.width * 0.14
    property int transitionDelay: 200
    readonly property int shadowSamples: 17
    readonly property int shadowRadius: 8
    readonly property int shadowButtonHorizontalOffset: 3
    readonly property int shadowButtonVerticalOffset: 3
    readonly property string shadowColor: "#70000000"

    signal accepted()

    states:[
        State{
            id: viewTotalBoardOKIcon
        },
        State{
            id: viewTotalBoardCancelledIcon
        },
        State{
            id: viewTotalBoardErrorIcon
        },
        State{
            id: viewTotalBoardOverPressureIcon
        },
        State{
            id: noViewTotalBoard
        }
    ]
    transitions:[
        Transition {
            to: "viewTotalBoardOKIcon"
            PropertyAnimation { target: totalsBoardItem; property: "visible"; to: true }
            PropertyAnimation { target: totalsIcon; property: "color"; to: Storage.getAppDB(Constants.dbAppColor.totalsBoardOKId, "black")}
            PropertyAnimation { target: iconImage; property: "source"; to: Storage.getAppDB(Constants.dbAppIcon.checkCircleId, "") }
            PropertyAnimation { target: errorCodeLabel; property: "visible"; to: false }
            SequentialAnimation{
            PropertyAnimation { target: totalsBoardItem; property: "color"; to: totalsBoardItem.color; duration: transitionDelay} // just delay
            PropertyAnimation { target: totalsBoardItem; property: "opacity"; to: 1; duration: transitionDelay}
            }
        },
        Transition {
            to: "viewTotalBoardCancelledIcon"
            PropertyAnimation { target: totalsBoardItem; property: "visible"; to: true }
            PropertyAnimation { target: totalsIcon; property: "color"; to: Storage.getAppDB(Constants.dbAppColor.totalsBoardCancelId, "black")}
            PropertyAnimation { target: iconImage; property: "source"; to: Storage.getAppDB(Constants.dbAppIcon.cancelCircleId, "") }
            PropertyAnimation { target: errorCodeLabel; property: "visible"; to: false }
            SequentialAnimation{
            PropertyAnimation { target: totalsBoardItem; property: "color"; to: totalsBoardItem.color; duration: transitionDelay} // just delay
            PropertyAnimation { target: totalsBoardItem; property: "opacity"; to: 1; duration: transitionDelay}
            }
        },
        Transition {
            to: "viewTotalBoardErrorIcon"
            PropertyAnimation { target: totalsBoardItem; property: "visible"; to: true}
            PropertyAnimation { target: totalsIcon; property: "color"; to: Storage.getAppDB(Constants.dbAppColor.totalsBoardErrorId, "black")}
            PropertyAnimation { target: iconImage; property: "source"; to: Storage.getAppDB(Constants.dbAppIcon.errorCircleId, "") }
            PropertyAnimation { target: errorCodeLabel; property: "visible"; to: true }
            SequentialAnimation{
            PropertyAnimation { target: totalsBoardItem; property: "color"; to: totalsBoardItem.color; duration: transitionDelay} // just delay
            PropertyAnimation { target: totalsBoardItem; property: "opacity"; to: 1; duration: transitionDelay}
            }
        },
        Transition {
            to: "viewTotalBoardOverPressureIcon"
            PropertyAnimation { target: totalsBoardItem; property: "visible"; to: true }
            PropertyAnimation { target: totalsIcon; property: "color"; to: Storage.getAppDB(Constants.dbAppColor.totalsBoardErrorId, "black")}
            PropertyAnimation { target: iconImage; property: "source"; to: Storage.getAppDB(Constants.dbAppIcon.overPressureId, "") }
            PropertyAnimation { target: errorCodeLabel; property: "visible"; to: false }
            SequentialAnimation{
            PropertyAnimation { target: totalsBoardItem; property: "color"; to: totalsBoardItem.color; duration: transitionDelay} // just delay
            PropertyAnimation { target: totalsBoardItem; property: "opacity"; to: 1; duration: transitionDelay}
            }
        },
        Transition {
            to: "viewTotalBoardTimeOutIcon"
            PropertyAnimation { target: totalsBoardItem; property: "visible"; to: true }
            PropertyAnimation { target: totalsIcon; property: "color"; to: Storage.getAppDB(Constants.dbAppColor.totalsBoardToutId, "black")}
            PropertyAnimation { target: iconImage; property: "source"; to: Storage.getAppDB(Constants.dbAppIcon.timeOutId, "") }
            PropertyAnimation { target: errorCodeLabel; property: "visible"; to: false }
            SequentialAnimation{
            PropertyAnimation { target: totalsBoardItem; property: "color"; to: totalsBoardItem.color; duration: transitionDelay} // just delay
            PropertyAnimation { target: totalsBoardItem; property: "opacity"; to: 1; duration: transitionDelay}
            }
        },
        Transition {
            to: "noViewTotalBoard"
            PropertyAnimation { target: totalsBoardItem; property: "visible"; to: false }
            PropertyAnimation { target: totalsBoardItem; property: "opacity"; to: 0; duration: transitionDelay * 0.3}
        }
    ]

    function totalsBoardWidth(){
        var width = (externalBorderMargin * 3) + totalsIcon.width
        var seaprators = 1

        if(totalsO3.visible){
            seaprators = seaprators + 1
            width = width + totalsO3.width
        }
        if(totalsTotalConcentration.visible){
            seaprators = seaprators + 1
            width = width + totalsTotalConcentration.width
        }
        if(totalsIpIndex.visible){
            seaprators = seaprators + 1
            width = width + totalsIpIndex.width
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
        if(totalsTimeSeconds.visible){
            seaprators = seaprators + 1
            width = width + totalsTimeSeconds.width
        }

        width = width + ((seaprators - 1) * totalsBoardRow.spacing)

        return width
    }

    function temporalDisable(miliseconds){
        totalsIcon.enabled = false
        delayedEnable.duration = miliseconds
        delayedEnable.start()
    }

    PropertyAnimation{ id: delayedEnable; target: totalsIcon; property: "enabled"; to: true; duration: 0 }

    width: totalsBoardWidth()
    height: cotrolsSize + (externalBorderMargin * 2)
    color: Storage.getAppDB(Constants.dbAppColor.totalsBoardPanelId, "black")
    radius: 4
    opacity: 0
    visible: false
    state: "noViewTotalBoard"

    Component.onCompleted: {
       visible = false              // It is important to manage visible property. if the window disapperars just
       state = "noViewTotalBoard"   // with opacity the button remains fucntional althoug the window doesn't see.
    }

    Row{
        id: totalsBoardRow
        anchors.rightMargin: externalBorderMargin
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: totalsIcon.left
        spacing:20

        TotalItem{
            id: totalsO3
            width: cotrolsSize
            height: cotrolsSize
            cumulatedLabel.text: "0"
            unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardO3UnitsId, "black")
            cumulatedLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardO3ValueId, "black")
            visible: true
            unitsLabel.text: Storage.getAppDB(Constants.dbParameter.doseId + Constants.unitsId, "*")
        }
        TotalItem{
            id: totalsTotalConcentration
            width: cotrolsSize
            height: cotrolsSize
            cumulatedLabel.text: "0"
            unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardConcentUnitsId, "black")
            cumulatedLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardConcentValueId, "black")
            visible: true
            unitsLabel.text: magnitudeSelector.inputTotalConcentration.unitsLabel.text
        }
        TotalItem{
            id: totalsIpIndex
            width: cotrolsSize
            height: cotrolsSize
            cumulatedLabel.text: "0"
            unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardIpIndexUnitsId, "black")
            cumulatedLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardIpIndexValueId, "black")
            visible: true
            unitsLabel.text: Storage.getAppDB(magnitudeSelector.inputIp.saveStamp + "_" + Constants.sliderUnitsBId , "*")
        }
        TotalItem{
            id: totalsVolume
            width: cotrolsSize
            height: cotrolsSize
            cumulatedLabel.text: "0"
            unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardVolumeUnitsId, "black")
            cumulatedLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardVolumeValueId, "black")
            visible: true
            unitsLabel.text: Storage.getAppDB(Constants.dbParameter.volumeId + Constants.unitsId, "*")
        }
        TotalItem{
            id: totalsTime
            width: cotrolsSize
            height: cotrolsSize
            unitsLabel.text: "min"
            cumulatedLabel.text: "0"
            unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardTimeUnitsId, "black")
            cumulatedLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardTimeValueId, "black")
            visible: true
        }
        TotalItem{
            id: totalsPressure
            width: cotrolsSize
            height: cotrolsSize
            cumulatedLabel.text: "0"
            unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardPressureUnitsId, "black")
            cumulatedLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardPressureValueId, "black")
            visible: true
            unitsLabel.text: Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsId, "*")
        }
        TotalItem{
            id: totalsTimeSeconds
            width: cotrolsSize
            height: cotrolsSize
            unitsLabel.text: "sec"
            cumulatedLabel.text: "0"
            unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardTSecondsUnitsId, "black")
            cumulatedLabel.color: Storage.getAppDB(Constants.dbAppColor.totalsBoardTSecondsValueId, "black")
            visible: true
        }
    }

    Rectangle{
        id: totalsIcon
        width: cotrolsSize * 0.95
        height: cotrolsSize * 0.95
        radius: parent.width * 0.029
        anchors.right: parent.right
        anchors.rightMargin: externalBorderMargin * 1.5
        anchors.verticalCenter: parent.verticalCenter
        Image{
            id: iconImage
            anchors.rightMargin: parent.width * 0.088
            anchors.leftMargin: parent.width * 0.088
            anchors.bottomMargin: parent.width * 0.088
            anchors.topMargin: parent.width * 0.088
            anchors.fill: parent
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            opacity: totalsIconButton.down ? 0.4 : 1
        }
        Label{
            id: errorCodeLabel
            width: parent.width * 0.12
            height: parent.width * 0.12
            color: Storage.getAppDB(Constants.dbAppColor.totalsBoardErrroLavelId, "black")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width * 0.058
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.093
            text: "18"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            opacity: 1
            font.pixelSize: parent.width * 0.23
            fontSizeMode: Text.Fit
        }
        Button{
            id: totalsIconButton
            anchors.fill: parent
            opacity: 0
            onClicked: {
                totalsBoardItem.accepted()
            }
        }
    }
}
