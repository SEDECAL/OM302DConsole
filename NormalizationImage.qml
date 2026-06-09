// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12

import "storage.js" as Storage
import "Constants.js" as Constants
import "DebugConstants.js" as DC

Rectangle{
    id: normalizationImage

    property alias normalizationGif: normalizationGif

    property double pressure: 10
    property double temperature: 30
    property double tConversionFactor
    property double tOffset
    property double pConversionFactor
    property double pOffset

    property string pUnits
    property string tUnits

    function editTemperatureValue(){
        var calculedT

        calculedT = (temperature * tConversionFactor) + tOffset
        if (calculedT !== parseInt(calculedT)){
            calculedT = calculedT.toFixed(2)
        }

        return Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "59", "") + calculedT + tUnits
    }

    function editPressureValue(){
        var calculedP

        calculedP = (pressure * pConversionFactor) + pOffset
        if (calculedP !== parseInt(calculedP)){
            calculedP = calculedP.toFixed(2)
        }
        return Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "60", "") + calculedP + " " + pUnits
    }

    states: [
        State {
            name: "normalizationImageStateAnimated"
            PropertyChanges { target: normalizationGif; currentFrame: 0 }
            PropertyChanges { target: normalizationGif; playing: true }
        },
        State {
            name: "normalizationImageStateStatic"
            PropertyChanges { target: normalizationGif; currentFrame: 0 }
            PropertyChanges { target: normalizationGif; playing: false }
        },
        State {
            name: "normalizationImageStateHide"
            PropertyChanges { target: normalizationImage; opacity: 0 }
        },
        State {
            name: "normalizationImageStateShow"
            PropertyChanges { target: normalizationGif; currentFrame: 0 }
            PropertyChanges { target: normalizationGif; playing: false }
        },
        State {
            name: "normalizationImageStateDisabled"
            PropertyChanges { target: normalizationImage; opacity: 0.2 }
            PropertyChanges { target: normalizationGif; currentFrame: 0 }
            PropertyChanges { target: normalizationGif; playing: false }
        }
    ]
    transitions: [
        Transition {
            to: "normalizationImageStateShow"
            PropertyAnimation { target: normalizationImage; property: "opacity"; to: 1; duration: 2000 }
        }
    ]

    width: height
    state: "normalizationImageStateShow"
    color: Storage.getAppDB(Constants.dbAppColor.normalizationImagePanelId, "black")

    Component.onCompleted: {
        tUnits = Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsId, "*")

        if(tUnits === Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsAId, "*")){
            tConversionFactor = parseFloat( Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.conversionFactorAId, "*"))
            tOffset = parseFloat( Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.offsetAId, "*"))
        }
        else if(tUnits === Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsBId, "*")){
            tConversionFactor = parseFloat( Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.conversionFactorBId, "*"))
            tOffset = parseFloat( Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.offsetBId, "*"))
        }

        pUnits = Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsId, "*")

        if(pUnits === Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsAId, "*")){
            pConversionFactor = parseFloat( Storage.getAppDB(Constants.dbParameter.pressureId + Constants.conversionFactorAId, "*"))
            pOffset = parseFloat( Storage.getAppDB(Constants.dbParameter.pressureId + Constants.offsetAId, "*"))
        }
        else if(pUnits === Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsBId, "*")){
            pConversionFactor = parseFloat( Storage.getAppDB(Constants.dbParameter.pressureId + Constants.conversionFactorBId, "*"))
            pOffset = parseFloat( Storage.getAppDB(Constants.dbParameter.pressureId + Constants.offsetBId, "*"))
        }
    }

    AnimatedImage {
        id: normalizationGif
        anchors.centerIn: parent
        width: parent.width * 0.85
        height: parent.height * 0.85
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.normalizationGifId, "") : "" // 12/2021
        onVisibleChanged: normalizationGif.currentFrame = 0
    }

    Text{
        id: temperatureId
        width: parent.width
        height: height * 0.2
        color: "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.bottom
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        text: editTemperatureValue()
        font.pointSize: parent.width * 0.11
    }
    Text{
        id: pressureId
        width: temperatureId.width
        height: temperatureId.height
        color: temperatureId.color
        verticalAlignment: temperatureId.verticalAlignment
        horizontalAlignment: temperatureId.horizontalAlignment
        anchors.top: temperatureId.bottom
        anchors.topMargin: parent.height * 0.18
        anchors.horizontalCenter: parent.horizontalCenter
        text: editPressureValue()
        font.pointSize: temperatureId.font.pointSize
    }

}
