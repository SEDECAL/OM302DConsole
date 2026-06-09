// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12

import "DebugConstants.js" as DC
import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies
import "Singletons"

Item {
    id: magnitudeSelectorItem

    property alias inputNormoOrHiper: inputNormoOrHiper
    property alias inputCycles: inputCycles
    property alias inputPreviousVaccumYesNo: inputPreviousVaccumYesNo
    property alias inputBottleVolume: inputBottleVolume
    property alias inputBloodVolume: inputBloodVolume
    property alias inputLiquidVolume: inputLiquidVolume
    property alias inputSalineVolume: inputSalineVolume
    property alias inputO3: inputO3
    property alias inputFlow: inputFlow
    property alias inputTime: inputTime
    property alias inputTimeVolume: inputTimeVolume
    property alias inputTotalConcentration: inputTotalConcentration
    property alias inputTherapyTime: inputTherapyTime
    property alias inputVacuumTime: inputVacuumTime
    property alias inputVolumeDose: inputVolumeDose
    property alias inputTimeDose: inputTimeDose
    property alias inputVolume: inputVolume
    property alias inputCleanTime: inputCleanTime
    property alias inputPressure: inputPressure
    property alias inputIp: inputIp
    property alias inputReinfusionTime: inputReinfusionTime
    property alias inputSalineTime: inputSalineTime
    property alias inputNormoOrHiperFake: inputNormoOrHiperFake
    property alias inputCyclesFake: inputCyclesFake
    property alias inputPreviousVaccumYesNoFake: inputPreviousVaccumYesNoFake
    property alias inputBottleVolumeFake: inputBottleVolumeFake
    property alias inputBloodVolumeFake: inputBloodVolumeFake
    property alias inputLiquidVolumeFake: inputLiquidVolumeFake
    property alias inputSalineVolumeFake: inputSalineVolumeFake
    property alias inputO3Fake: inputO3Fake
    property alias inputFlowFake: inputFlowFake
    property alias inputTimeFake: inputTimeFake
    property alias inputTimeVolumeFake: inputTimeVolumeFake
    property alias inputTotalConcentrationFake: inputTotalConcentrationFake
    property alias inputTherapyTimeFake: inputTherapyTimeFake
    property alias inputVacuumTimeFake: inputVacuumTimeFake
    property alias inputVolumeDoseFake: inputVolumeDoseFake
    property alias inputTimeDoseFake: inputTimeDoseFake
    property alias inputVolumeFake: inputVolumeFake
    property alias inputCleanTimeFake: inputCleanTimeFake
    property alias inputPressureFake: inputPressureFake
    property alias inputIpFake: inputIpFake
    property alias inputNormoOrHiperMainImage: inputNormoOrHiperMainImage
    property alias inputPreviousVaccumYesNoMainImage: inputPreviousVaccumYesNoMainImage
    property alias inputCyclesMainImage: inputCyclesMainImage
    property alias inputCyclesLabel: inputCyclesLabel
    property alias magnitudeRow: magnitudeRow
    property alias totalConcentrationLabelFake: totalConcentrationLabelFake
    property alias ipLabelFake: ipLabelFake
    property alias inputReinfusionTimeFake: inputReinfusionTimeFake
    property alias inputMultipleTotalConcentrationRepeater: inputMultipleTotalConcentrationRepeater

    property int theraphyCycles: 1
    property int maxAllowedFlow: 1
    property int maxAvailableFlow: 1
    property int maxAutohemoTherapyCycles: parseInt(Storage.getAppDB(Constants.dbDeviceLimits.maxAutohemoCyclesId, "*"))

    property double disabledOpacity: 0.4
    property double narrowMarginCoeficient: 1
    property double fullViewOffsetCorrection: 0
    property double defaultFullViewOffsetCorrection: -100

    property string theraphyPressure: "N"
    property string currentSelectedItem: ""
    property string inputPreviousVaccumYesImage: Storage.getAppDB(Constants.dbAppIcon.previousVacuumYesId, "")
    property string inputPreviousVaccumNoImage:  Storage.getAppDB(Constants.dbAppIcon.previousVacuumNoId, "")
    property string inputNormoImage: Storage.getAppDB(Constants.dbAppIcon.normobaricTherapyId, "")
    property string inputHiperImage: Storage.getAppDB(Constants.dbAppIcon.hiperbaricTherapyId, "")
    property string inputNormoHiperImage: Storage.getAppDB(Constants.dbAppIcon.normoHiperSelectorId, "")

    property variant multipleTotalConcentrationOpacityDummyModel
    property variant multipleTotalConcentrationOpacityModel: [disabledOpacity, disabledOpacity]
    property variant multipleTotalConcentrationValues: ["0", "0", "0", "0", "0"]

    property bool wizarddOn: true
    property bool previousVacuum: true
    property bool viewGrid: false

    function wizarddAnalisys() {
        if(wizarddOn){
            if( (inputO3.inspected === false) && (inputO3.visible === true) ){
                inputO3.state = "fullView"
            }
            else if( (inputFlow.inspected === false) && (inputFlow.visible === true) ){
                inputFlow.state = "fullView"
            }
            else if( (inputTime.inspected === false) && (inputTime.visible === true) ){
                inputTime.state = "fullView"
            }
            else if( (inputTimeVolume.inspected === false) && (inputTimeVolume.visible === true) ){
                inputTimeVolume.state = "fullView"
            }
        }
    }

    function closeMagnitudeSelectors(){
        inputBottleVolumeFake.state = "reducedView"
        inputBloodVolumeFake.state = "reducedView"
        inputLiquidVolume.state = "reducedView"
        inputSalineVolume.state = "reducedView"
        inputO3.state = "reducedView"
        inputFlow.state = "reducedView"
        inputTime.state = "reducedView"
        inputTimeVolume.state = "reducedView"
        inputTotalConcentration.state = "reducedView"
        inputTherapyTime.state = "reducedView"
        inputVacuumTime.state = "reducedView"
        inputVolumeDose.state = "reducedView"
        inputTimeDose.state = "reducedView"
        inputVolume.state = "reducedView"
        inputCleanTime.state = "reducedView"
        inputPressure.state = "reducedView"
        inputIp.state = "reducedView"
        inputReinfusionTime.state = "reducedView"
    }

    function updateInputMultipleTotalConcentrationSize(){
        inputMultipleTotalConcentration.height = ((magnitudeSelectorItem.height / maxAutohemoTherapyCycles) * theraphyCycles) + cyclesColumn.anchors.topMargin
    }

    function manageInputMultipleTotalConcentrationVisibility(){
        if((tabBar.selectedOption === Constants.option5_1Id) && (theraphyCycles !== 1)){
            return true
        }
        else{
            return false
        }
    }

    function updateInputMultipleTotalConcentrationAppearance(activeRow){
        var i
        var opacityLevel = (appConsole.state === Constants.CONSOLE_ST_EDITING) ? 1 : disabledOpacity

        for(i=0; i<maxAutohemoTherapyCycles; i++){
            multipleTotalConcentrationOpacityModel[i] = 0
        }
        for(i=0; i<theraphyCycles; i++){
            multipleTotalConcentrationOpacityModel[i] = opacityLevel
        }
        multipleTotalConcentrationOpacityModel[activeRow - 1] = 1
        inputMultipleTotalConcentrationRepeater.model = multipleTotalConcentrationOpacityModel
    }

    function updateInputMultipleTotalConcentrationModel(){
        inputMultipleTotalConcentrationRepeater.model = multipleTotalConcentrationOpacityDummyModel
        inputMultipleTotalConcentrationRepeater.model = multipleTotalConcentrationOpacityModel
    }

    function updateFullViewSelectors(){
        if((tabBar.selectedOption === Constants.option2Id) || (tabBar.selectedOption === Constants.option5_1Id)){

            if (inputBottleVolume.state !== "reducedView"){
                inputBottleVolume.state = "" // just update x position
                inputBottleVolume.state = "fullViewWithOffset"
            }

            if (inputBloodVolume.state !== "reducedView"){
                inputBloodVolume.state = "" // just update x position
                inputBloodVolume.state = "fullViewWithOffset"
            }

            if (inputO3.state !== "reducedView"){
                inputO3.state = "" // just update x position
                inputO3.state = "fullViewWithOffset"
            }

            if (inputSalineVolume.state !== "reducedView"){
                inputSalineVolume.state = "" // just update x position
                inputSalineVolume.state = "fullViewWithOffset"
            }

            if (inputFlow.state !== "reducedView"){
                inputFlow.state = "" // just update x position
                inputFlow.state = "fullViewWithOffset"
            }

            if (inputReinfusionTime.state !== "reducedView"){
                inputReinfusionTime.state = "" // just update x position
                inputReinfusionTime.state = "fullViewWithOffset"
            }
        }
    }

    function updateFullViewOffsetCorrection(){
        fullViewOffsetCorrection = 0

        if(tabBar.selectedOption === Constants.option2Id){
            fullViewOffsetCorrection = defaultFullViewOffsetCorrection
        }
        if((tabBar.selectedOption === Constants.option5_1Id) && (theraphyCycles !== 1)){
            fullViewOffsetCorrection = defaultFullViewOffsetCorrection
        }
    }

    function temporalDisable(miliseconds){
        magnitudeSelectorItem.enabled = false
        mainDelayedEnable.duration = miliseconds
        mainDelayedEnable.start()
    }

    onTheraphyCyclesChanged: {
        if(tabBar.selectedOption === Constants.option5_1Id){
            updateInputMultipleTotalConcentrationSize()
            updateInputMultipleTotalConcentrationAppearance(1)
            updateFullViewOffsetCorrection()
            updateFullViewSelectors()
        }
    }

    states:[
        State{
            name: "inputSelected"
            PropertyChanges { target: inputNormoOrHiper; opacity: disabledOpacity }
            PropertyChanges { target: inputPreviousVaccumYesNo; opacity: disabledOpacity }
            PropertyChanges { target: inputCycles; opacity: 1 }
            PropertyChanges { target: inputBottleVolume; opacity: (inputBottleVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputBloodVolume; opacity: (inputBloodVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputLiquidVolume; opacity: (inputLiquidVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputSalineVolume; opacity: (inputSalineVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputO3; opacity: (inputO3.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputFlow; opacity: (inputFlow.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTime; opacity: (inputTime.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTimeVolume; opacity: (inputTimeVolume.state === "fullViewDouble") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTotalConcentration; opacity: (inputTotalConcentration.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTherapyTime; opacity: (inputTherapyTime.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputVacuumTime; opacity: (inputVacuumTime.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputVolumeDose; opacity: (inputVolumeDose.state === "fullViewDouble") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTimeDose; opacity: (inputTimeDose.state === "fullViewDouble") ? 1 : disabledOpacity }
            PropertyChanges { target: inputVolume; opacity: (inputVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputCleanTime; opacity: (inputCleanTime.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputPressure; opacity: (inputPressure.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputIp; opacity: (inputIp.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: totalConcentrationLabelFake; opacity: disabledOpacity }
            PropertyChanges { target: ipLabelFake; opacity: disabledOpacity }
            PropertyChanges { target: inputReinfusionTime; opacity: (inputReinfusionTime.state === "fullView") ? 1 : disabledOpacity }

            PropertyChanges { target: inputNormoOrHiper; enabled: false }
            PropertyChanges { target: inputPreviousVaccumYesNo; enabled: false }
//          PropertyChanges { target: inputCycles; enabled: true }
            PropertyChanges { target: inputCycles; enabled: false }
            StateChangeScript{ script: inputCycles.temporalDisable(500)} // ticket #4203
            PropertyChanges { target: inputBottleVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputBloodVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputLiquidVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputSalineVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputO3; fullControlButton.visible: false }
            PropertyChanges { target: inputFlow; fullControlButton.visible: false }
            PropertyChanges { target: inputTime; fullControlButton.visible: false }
            PropertyChanges { target: inputTimeVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputTotalConcentration; fullControlButton.visible: false }
            PropertyChanges { target: inputTherapyTime; fullControlButton.visible: false }
            PropertyChanges { target: inputVacuumTime; fullControlButton.visible: false }
            PropertyChanges { target: inputVolumeDose; fullControlButton.visible: false }
            PropertyChanges { target: inputTimeDose; fullControlButton.visible: false }
            PropertyChanges { target: inputVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputCleanTime; fullControlButton.visible: false }
            PropertyChanges { target: inputPressure; fullControlButton.visible: false }
            PropertyChanges { target: inputIp; fullControlButton.visible: false }
            PropertyChanges { target: inputReinfusionTime; fullControlButton.visible: false }

            PropertyChanges { target: appToolBar; state: "justHelp" }
            PropertyChanges { target: gadgetMenu; state: "gadgetMenuDisabled" }
            PropertyChanges { target: normalizationImage; state: "normalizationImageStateDisabled" }
        },
        State{
            name: "gadgetSelected"
            PropertyChanges { target: inputNormoOrHiper; opacity: disabledOpacity }
            PropertyChanges { target: inputPreviousVaccumYesNo; opacity: disabledOpacity }
            PropertyChanges { target: inputCycles; opacity: disabledOpacity }
            PropertyChanges { target: inputBottleVolume; opacity: (inputBottleVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputBloodVolume; opacity: (inputBloodVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputLiquidVolume; opacity: (inputLiquidVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputSalineVolume; opacity: (inputSalineVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputO3; opacity: (inputO3.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputFlow; opacity: (inputFlow.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTime; opacity: (inputTime.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTimeVolume; opacity: (inputTimeVolume.state === "fullViewDouble") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTotalConcentration; opacity: (inputTotalConcentration.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTherapyTime; opacity: (inputTherapyTime.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputVacuumTime; opacity: (inputVacuumTime.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputVolumeDose; opacity: (inputVolumeDose.state === "fullViewDouble") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTimeDose; opacity: (inputTimeDose.state === "fullViewDouble") ? 1 : disabledOpacity }
            PropertyChanges { target: inputVolume; opacity: (inputVolume.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputCleanTime; opacity: (inputCleanTime.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputPressure; opacity: (inputPressure.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputIp; opacity: (inputIp.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: totalConcentrationLabelFake; opacity: disabledOpacity }
            PropertyChanges { target: ipLabelFake; opacity: disabledOpacity }
            PropertyChanges { target: inputReinfusionTime; opacity: (inputReinfusionTime.state === "fullView") ? 1 : disabledOpacity }

            PropertyChanges { target: inputNormoOrHiper; enabled: false }
            PropertyChanges { target: inputPreviousVaccumYesNo; enabled: false }
            PropertyChanges { target: inputCycles; enabled: false }
            PropertyChanges { target: inputBottleVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputBloodVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputLiquidVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputSalineVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputO3; fullControlButton.visible: false }
            PropertyChanges { target: inputFlow; fullControlButton.visible: false }
            PropertyChanges { target: inputTime; fullControlButton.visible: false }
            PropertyChanges { target: inputTimeVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputTotalConcentration; fullControlButton.visible: false }
            PropertyChanges { target: inputTherapyTime; fullControlButton.visible: false }
            PropertyChanges { target: inputVacuumTime; fullControlButton.visible: false }
            PropertyChanges { target: inputVolumeDose; fullControlButton.visible: false }
            PropertyChanges { target: inputTimeDose; fullControlButton.visible: false }
            PropertyChanges { target: inputVolume; fullControlButton.visible: false }
            PropertyChanges { target: inputCleanTime; fullControlButton.visible: false }
            PropertyChanges { target: inputPressure; fullControlButton.visible: false }
            PropertyChanges { target: inputIp; fullControlButton.visible: false }
            PropertyChanges { target: inputReinfusionTime; fullControlButton.visible: false }

            PropertyChanges { target: appToolBar; state: "justHelp" }
            PropertyChanges { target: gadgetMenu; state: "gadgetMenuDisabled" }
            PropertyChanges { target: normalizationImage; state: "normalizationImageStateDisabled" }
        },
        State{
            name: "noInputSelected"
            PropertyChanges { target: inputNormoOrHiper; opacity: 1 }
            PropertyChanges { target: inputPreviousVaccumYesNo; opacity: 1 }
            PropertyChanges { target: inputCycles; opacity: 1 }
            PropertyChanges { target: inputBottleVolume; opacity: 1 }
            PropertyChanges { target: inputBloodVolume; opacity: 1 }
            PropertyChanges { target: inputLiquidVolume; opacity: 1 }
            PropertyChanges { target: inputSalineVolume; opacity: 1 }
            PropertyChanges { target: inputO3; opacity: 1 }
            PropertyChanges { target: inputFlow; opacity: 1 }
            PropertyChanges { target: inputTime; opacity: 1 }
            PropertyChanges { target: inputTimeVolume; opacity: 1 }
            PropertyChanges { target: inputTotalConcentration; opacity: (inputTotalConcentration.enabled) ? 1: disabledOpacity }
            PropertyChanges { target: inputTherapyTime; opacity: 1 }
            PropertyChanges { target: inputVacuumTime; opacity: 1 }
            PropertyChanges { target: inputVolumeDose; opacity: 1 }
            PropertyChanges { target: inputTimeDose; opacity: 1 }
            PropertyChanges { target: inputVolume; opacity: 1 }
            PropertyChanges { target: inputCleanTime; opacity: 1 }
            PropertyChanges { target: inputPressure; opacity: 1 }
            PropertyChanges { target: inputIp; opacity: (inputIp.enabled) ? 1: disabledOpacity }
            PropertyChanges { target: totalConcentrationLabelFake; opacity: 1 }
            PropertyChanges { target: ipLabelFake; opacity: 1 }
            PropertyChanges { target: inputReinfusionTime; opacity: 1 }

            PropertyChanges { target: inputNormoOrHiper; enabled: true }
            PropertyChanges { target: inputPreviousVaccumYesNo; enabled: true }
            PropertyChanges { target: inputCycles; enabled: true }
            PropertyChanges { target: inputBottleVolume; fullControlButton.visible: true }
            PropertyChanges { target: inputBloodVolume; fullControlButton.visible: true }
            PropertyChanges { target: inputLiquidVolume; fullControlButton.visible: true }
            PropertyChanges { target: inputSalineVolume; fullControlButton.visible: true }
            PropertyChanges { target: inputO3; fullControlButton.visible: true }
            PropertyChanges { target: inputFlow; fullControlButton.visible: true }
            PropertyChanges { target: inputTime; fullControlButton.visible: true }
            PropertyChanges { target: inputTimeVolume; fullControlButton.visible: true }
            PropertyChanges { target: inputTotalConcentration; fullControlButton.visible: true }
            PropertyChanges { target: inputTherapyTime; fullControlButton.visible: true }
            PropertyChanges { target: inputVacuumTime; fullControlButton.visible: true }
            PropertyChanges { target: inputVolumeDose; fullControlButton.visible: true }
            PropertyChanges { target: inputTimeDose; fullControlButton.visible: true }
            PropertyChanges { target: inputVolume; fullControlButton.visible: true }
            PropertyChanges { target: inputCleanTime; fullControlButton.visible: true }
            PropertyChanges { target: inputPressure; fullControlButton.visible: true }
            PropertyChanges { target: inputIp; fullControlButton.visible: true }
            PropertyChanges { target: inputReinfusionTime; fullControlButton.visible: true }

            PropertyChanges { target: appToolBar; state: "settingsPlayHelp" }
            PropertyChanges { target: normalizationImage; state: "normalizationImageStateStatic" }
        },
        State{
            name: "noInputView"
            PropertyChanges { target: gadgetMenu; state: "noViewGadgetMenu" }
        }
    ]

    PropertyAnimation{ id: mainDelayedEnable; target: magnitudeSelectorItem; property: "enabled"; to: true; duration: 0 }

    state: "noInputSelected"

    Rectangle{
        anchors.fill: parent
        color: "transparent"
        border.color:  "magenta"
        visible: viewGrid
    }

    Row{
        id: magnitudeRow
        spacing: QtConstants.magnitudeSelectorRowSpacing * narrowMarginCoeficient
        height: parent.height
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 0

        add: Transition {
            NumberAnimation{duration: 2000}
        }
        Rectangle{
            id: inputNormoOrHiperFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth * 0.333
            height: 10
        }
        Rectangle{
            id: inputPreviousVaccumYesNoFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth * 0.333
            height: 10
        }
        Rectangle{
            id: inputBottleVolumeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputBloodVolumeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputVacuumTimeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputLiquidVolumeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputSalineVolumeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputO3Fake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputFlowFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputTimeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputTimeVolumeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputTotalConcentrationFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputVolumeDoseFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputTimeDoseFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputVolumeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputTherapyTimeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputCleanTimeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputPressureFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputIpFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
        Rectangle{
            id: inputReinfusionTimeFake
            opacity: 0
            visible: false
            width: QtConstants.inputElementWidth
            height: 10
        }
    }

    InputItem{
        id: inputBottleVolume
        x: magnitudeRow.x + inputBottleVolumeFake.x
        y: magnitudeRow.y + inputBottleVolumeFake.y
        initialX: magnitudeRow.x + inputBottleVolumeFake.x
        initialY: magnitudeRow.y + inputBottleVolumeFake.y
        visible: inputBottleVolumeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX + fullViewOffsetCorrection
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "ml" // "ug/Nml"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputBottleVolumeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputBottleVolumeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.voidBottleId, "")
        state:"reducedView"
        name: Constants.inputBottleVolumeSelectorId
    }

    InputItem{
        id: inputBloodVolume
        x: magnitudeRow.x + inputBloodVolumeFake.x
        y: magnitudeRow.y + inputBloodVolumeFake.y
        initialX: magnitudeRow.x + inputBloodVolumeFake.x
        initialY: magnitudeRow.y + inputBloodVolumeFake.y
        visible: inputBloodVolumeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX + fullViewOffsetCorrection
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "ml"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputBloodVolumeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputBloodVolumeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.bloodBottleId, "")
        state:"reducedView"
        name: Constants.inputBloodVolumeSelectorId
        sliderMaxDependent: true
//      sliderMaxDependentValue: inputBottleVolume.magnitudeValue // #4833
        sliderMaxDependentValue: Math.round(inputBottleVolume.magnitudeValue - Therapies.airVolumeForAutohemo())
    }

    InputItem{
        id: inputLiquidVolume
        x: magnitudeRow.x + inputLiquidVolumeFake.x
        y: magnitudeRow.y + inputLiquidVolumeFake.y
        initialX: magnitudeRow.x + inputLiquidVolumeFake.x
        initialY: magnitudeRow.y + inputLiquidVolumeFake.y
        visible: inputLiquidVolumeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "\u03BCg/Nml" // "ug/Nml"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputLiquidVolumeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputLiquidVolumeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.liquidVolumeId, "")
        state:"reducedView"
        name: Constants.inputLiquidVolumeSelectorId
    }

    InputItem{
        id: inputSalineVolume
        x: magnitudeRow.x + inputSalineVolumeFake.x
        y: magnitudeRow.y + inputSalineVolumeFake.y
        initialX: magnitudeRow.x + inputSalineVolumeFake.x
        initialY: magnitudeRow.y + inputSalineVolumeFake.y
        visible: inputSalineVolumeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX + fullViewOffsetCorrection
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "\u03BCg/Nml" // "ug/Nml"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputSalineVolumeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputSalineVolumeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.salineVolumeId, "")
        state:"reducedView"
        name: Constants.inputSalineVolumeSelectorId
    }

    InputItem{
        id: inputO3
        x: magnitudeRow.x + inputO3Fake.x
        y: magnitudeRow.y + inputO3Fake.y
        initialX: magnitudeRow.x + inputO3Fake.x
        initialY: magnitudeRow.y + inputO3Fake.y
        visible: inputO3Fake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX + fullViewOffsetCorrection
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "\u03BCg/Nml" // "ug/Nml"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputO3UnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputO3ValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.concentrationId, "")
        multilabelView: true
        multilabelMainLabel: 1
        therapyCyclesNumber: theraphyCycles
        state:"reducedView"
        name: Constants.inputO3SelectorId
    }

    InputItem{
        id: inputFlow
        x: magnitudeRow.x + inputFlowFake.x
        y: magnitudeRow.y + inputFlowFake.y
        initialX: magnitudeRow.x + inputFlowFake.x
        initialY: magnitudeRow.y + inputFlowFake.y
        visible: inputFlowFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX + fullViewOffsetCorrection
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "l/h"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputFlowUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputFlowValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.flowId, "")
        state:"reducedView"
        name: Constants.inputFlowSelectorId
        sliderMaxDependent: true
        sliderMaxDependentValue: Therapies.setMaxAllowedFlow()
    }

    InputItem{
        id: inputTime
        x: magnitudeRow.x + inputTimeFake.x
        y: magnitudeRow.y + inputTimeFake.y
        initialX: magnitudeRow.x + inputTimeFake.x
        initialY: magnitudeRow.y + inputTimeFake.y
        visible: inputTimeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "min"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTimeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTimeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.timeId, "")
        state:"reducedView"
        name: Constants.inputTimeSelectorId
    }

    InputItem{
        id: inputTotalConcentration
        x: magnitudeRow.x + inputTotalConcentrationFake.x
        y: magnitudeRow.y + inputTotalConcentrationFake.y
        initialX: magnitudeRow.x + inputTotalConcentrationFake.x
        initialY: magnitudeRow.y + inputTotalConcentrationFake.y
        visible: inputTotalConcentrationFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "\u03BCg"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTotalConcentrationUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTotalConcentrationValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.doseId, "")
        state:"reducedView"
        name: Constants.inputTotalConcentrationSelectorId
        dependentMagnitude: false
        multiRangeSlider: false
    }

    InputItem{
        id: inputTherapyTime
        x: magnitudeRow.x + inputTherapyTimeFake.x
        y: magnitudeRow.y + inputTherapyTimeFake.y
        initialX: magnitudeRow.x + inputTherapyTimeFake.x
        initialY: magnitudeRow.y + inputTherapyTimeFake.y
        visible: inputTherapyTimeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "min"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTherapyTimeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTherapyTimeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.bagTimeId, "")
        state:"reducedView"
        name: Constants.inputTherapyTimeSelectorId
    }

    InputItem{
        id: inputVacuumTime
        x: magnitudeRow.x + inputVacuumTimeFake.x
        y: magnitudeRow.y + inputVacuumTimeFake.y
        initialX: magnitudeRow.x + inputVacuumTimeFake.x
        initialY: magnitudeRow.y + inputVacuumTimeFake.y
        visible: inputVacuumTimeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "sec"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputVacuumTimeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputVacuumTimeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.vacuumTimeId, "")
        state:"reducedView"
        name: Constants.inputVacuumTimeSelectorId
    }

    InputItem{
        id: inputTimeVolume
        x: magnitudeRow.x + inputTimeVolumeFake.x
        y: magnitudeRow.y + inputTimeVolumeFake.y
        initialX: magnitudeRow.x + inputTimeVolumeFake.x
        initialY: magnitudeRow.y + inputTimeVolumeFake.y
        visible: inputTimeVolumeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: "ml"
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTimeVolumeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTimeVolumeValueId, "black")
        unitsLabel2.text: "min"
        unitsLabel2.color: Storage.getAppDB(Constants.dbAppColor.inputTimeVolumeUnits2Id, "black")
        magnitudeLabel2.color: Storage.getAppDB(Constants.dbAppColor.inputTimeVolumeValue2Id, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.volumeId, "")
        mainDoubleImage.source: Storage.getAppDB(Constants.dbAppIcon.timeId, "")
        mainCombinedImage.source: Storage.getAppDB(Constants.dbAppIcon.voulumeTimeId, "")
        state:"reducedView"
        name: Constants.inputTimeVolumeSelectorId
        doubleLabelVisible: true
        convertToTimeFlow: Math.round(inputFlow.slider.value / inputFlow.conversionFactor)
    }

    InputItem{
        id: inputVolumeDose
        x: magnitudeRow.x + inputVolumeDoseFake.x
        y: magnitudeRow.y + inputVolumeDoseFake.y
        initialX: magnitudeRow.x + inputVolumeDoseFake.x
        initialY: magnitudeRow.y + inputVolumeDoseFake.y
        visible: inputVolumeDoseFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: ""
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputVolumeDoseUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputVolumeDoseValueId, "black")
        unitsLabel2.text: "min"
        unitsLabel2.color: Storage.getAppDB(Constants.dbAppColor.inputVolumeDoseUnits2Id, "black")
        magnitudeLabel2.color: Storage.getAppDB(Constants.dbAppColor.inputVolumeDoseValue2Id, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.doseId, "")
        mainDoubleImage.source: Storage.getAppDB(Constants.dbAppIcon.volumeId, "")
        mainCombinedImage.source: Storage.getAppDB(Constants.dbAppIcon.voulumeDoseId, "")
        state:"reducedView"
        name: Constants.inputVolumeDoseSelectorId
        doubleLabelVisible: true
        convertToVolumeDose: Math.round(inputO3.slider.value / inputO3.conversionFactor)
    }

    InputItem{
        id: inputTimeDose
        x: magnitudeRow.x + inputTimeDoseFake.x
        y: magnitudeRow.y + inputTimeDoseFake.y
        initialX: magnitudeRow.x + inputTimeDoseFake.x
        initialY: magnitudeRow.y + inputTimeDoseFake.y
        visible: inputTimeDoseFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: ""
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTimeDoseUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputTimeDoseValueId, "black")
        unitsLabel2.text: "min"
        unitsLabel2.color: Storage.getAppDB(Constants.dbAppColor.inputTimeDoseUnits2Id, "black")
        magnitudeLabel2.color: Storage.getAppDB(Constants.dbAppColor.inputTimeDoseValue2Id, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.doseId, "")
        mainDoubleImage.source: Storage.getAppDB(Constants.dbAppIcon.timeId, "")
        mainCombinedImage.source: Storage.getAppDB(Constants.dbAppIcon.timeDoseId, "")
        state:"reducedView"
        name: Constants.inputTimeDoseSelectorId
        doubleLabelVisible: true
        convertToTimeDose_flow: Math.round(inputFlow.slider.value / inputFlow.conversionFactor)
        convertToTimeDose_concentration: Math.round(inputO3.slider.value / inputO3.conversionFactor)
    }

    Rectangle{
        id: inputNormoOrHiper
        property string saveStamp: ""
        property string name: Constants.inputNormoOrHiperId

        function init(){
            theraphyPressure = Storage.getAppDB(saveStamp + "_" + Constants.initValuelId , "*")
        }

        x: magnitudeRow.x + inputNormoOrHiperFake.x
        y: magnitudeRow.y + inputNormoOrHiperFake.y
        z: magnitudeSelectorItem.z + 2
        visible: inputNormoOrHiperFake.visible
        width: QtConstants.inputElementWidth * 0.333
        height: width
        color: Storage.getAppDB(Constants.dbAppColor.inputHiperNormoPanelId, "black")
        border.color: "transparent"
        radius: 4

        Image{
            id: inputNormoOrHiperMainImage
            anchors.fill: parent
            anchors.margins: parent.width * 0.05
            source: (theraphyPressure === "N") ? ((visible) ? inputNormoImage : "") : ((visible) ? inputHiperImage : "")
            opacity: inputNormoOrHiperButton.down ? disabledOpacity : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: inputNormoOrHiperButton
            opacity: 0
            anchors.fill: parent
            onClicked: (theraphyPressure === "N") ? theraphyPressure = "H" : theraphyPressure = "N"
            onPressAndHold: {
                Storage.setAppDB(inputNormoOrHiper.saveStamp + "_" + Constants.initValuelId , theraphyPressure)
                Storage.saveAppDB()
                //DEB->debug.log(DC.magnitudeSelectorLog, "Input normo or hiper saved: ", theraphyPressure)
                inputNormoOrHiperSavingEffect.startAnimation("up")
            }
        }
        SaveEffect{
            id: inputNormoOrHiperSavingEffect
            height: parent.height
            width: parent.width
            radius: parent.radius
            z: magnitudeSelectorItem.z + 2
        }
    }

    Rectangle{
        id: inputPreviousVaccumYesNo
        property string saveStamp: ""
        property string name: Constants.inputPreviousVaccumYesNoId

        function init(){
            previousVacuum = (Storage.getAppDB(saveStamp + "_" + Constants.initValuelId , "false") === "true") ? true : false
        }

        x: magnitudeRow.x + inputPreviousVaccumYesNoFake.x
        y: magnitudeRow.y + inputPreviousVaccumYesNoFake.y
        z: magnitudeSelectorItem.z + 1
        visible: inputPreviousVaccumYesNoFake.visible
        width: QtConstants.inputElementWidth * 0.333
        height: width
        color: Storage.getAppDB(Constants.dbAppColor.inputPreviousVacuumPanelId, "black")
        border.color: "transparent"
        radius: 4

        Image{
            id: inputPreviousVaccumYesNoMainImage
            anchors.fill: parent
            anchors.margins: parent.width * 0.05
            source: (previousVacuum) ? ((visible) ? inputPreviousVaccumYesImage : "") : ((visible) ? inputPreviousVaccumNoImage : "")
            opacity: inputPreviousVaccumYesNoButton.down ? disabledOpacity : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: inputPreviousVaccumYesNoButton
            opacity: 0
            anchors.fill: parent
            onClicked: previousVacuum = !previousVacuum
            onPressAndHold: {
                Storage.setAppDB(inputPreviousVaccumYesNo.saveStamp + "_" + Constants.initValuelId , (previousVacuum) ? "true" : "false")
                Storage.saveAppDB()
                //DEB->debug.log(DC.magnitudeSelectorLog, "Input previous vaccum state saved: ", previousVacuum)
                inputPreviousVaccumYesNoSavingEffect.startAnimation("up")
            }
        }
        SaveEffect{
            id: inputPreviousVaccumYesNoSavingEffect
            height: parent.height
            width: parent.width
            radius: parent.radius
        }
    }

    Rectangle{ // to keep coherence
        id: inputCyclesFake
        opacity: 0
        visible: false
        width: QtConstants.inputElementWidth * 0.333
        height: 10
    }

    Label{
        id: totalConcentrationLabelFake
        visible: false
        x: inputTotalConcentration.x + inputTotalConcentration.magnitudeLabel.x
        y: inputTotalConcentration.y + inputTotalConcentration.magnitudeLabel.y
        height: inputTotalConcentration.magnitudeLabel.height
        width: inputTotalConcentration.magnitudeLabel.width
        text: inputTotalConcentration.magnitudeLabel.text
        font.pixelSize: inputTotalConcentration.magnitudeLabel.font.pixelSize
        color: inputTotalConcentration.magnitudeLabel.color
        fontSizeMode: inputTotalConcentration.magnitudeLabel.fontSizeMode
        verticalAlignment: inputTotalConcentration.magnitudeLabel.verticalAlignment
        horizontalAlignment: inputTotalConcentration.magnitudeLabel.horizontalAlignment
    }

    Label{
        id: ipLabelFake
        visible: false
        x: inputIp.x + inputIp.magnitudeLabel.x
        y: inputIp.y + inputIp.magnitudeLabel.y
        height: inputIp.magnitudeLabel.height
        width: inputIp.magnitudeLabel.width
        text: inputIp.magnitudeLabel.text
        font.pixelSize: inputIp.magnitudeLabel.font.pixelSize
        color: inputIp.magnitudeLabel.color
        fontSizeMode: inputIp.magnitudeLabel.fontSizeMode
        verticalAlignment: inputIp.magnitudeLabel.verticalAlignment
        horizontalAlignment: inputIp.magnitudeLabel.horizontalAlignment
        z: inputIp.z + 1
    }

    InputItem{
        id: inputVolume
        x: magnitudeRow.x + inputVolumeFake.x
        y: magnitudeRow.y + inputVolumeFake.y
        initialX: magnitudeRow.x + inputVolumeFake.x
        initialY: magnitudeRow.y + inputVolumeFake.y
        visible: inputVolumeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: ""
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputVolumeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputVolumeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.volumeId, "")
        state:"reducedView"
        name: Constants.inputVolumeSelectorId
    }

    InputItem{
        id: inputCleanTime
        x: magnitudeRow.x + inputCleanTimeFake.x
        y: magnitudeRow.y + inputCleanTimeFake.y
        initialX: magnitudeRow.x + inputCleanTimeFake.x
        initialY: magnitudeRow.y + inputCleanTimeFake.y
        visible: inputCleanTimeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: ""
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputCleanTimeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputCleanTimeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.cleanTimeId, "")
        state:"reducedView"
        name: Constants.inputCleanTimeSelectorId
    }

    InputItem{
        id: inputPressure
        x: magnitudeRow.x + inputPressureFake.x
        y: magnitudeRow.y + inputPressureFake.y
        initialX: magnitudeRow.x + inputPressureFake.x
        initialY: magnitudeRow.y + inputPressureFake.y
        visible: inputPressureFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: ""
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputPressureUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputPressureValueId, "black")
        negativeMagnitude: true
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.pressureId, "")
        state:"reducedView"
        name: Constants.inputPressureSelectorId
    }

    InputItem{
        id: inputIp
        x: magnitudeRow.x + inputIpFake.x
        y: magnitudeRow.y + inputIpFake.y
        initialX: magnitudeRow.x + inputIpFake.x
        initialY: magnitudeRow.y + inputIpFake.y
        visible: inputIpFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: ""
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputIpUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputIpValueId, "black")
        negativeMagnitude: false
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.ipId, "")
        state:"reducedView"
        name: Constants.inputIpSelectorId
        dependentMagnitude: false
        multiRangeSlider: false
    }

    InputItem{
        id: inputReinfusionTime
        x: magnitudeRow.x + inputReinfusionTimeFake.x
        y: magnitudeRow.y + inputReinfusionTimeFake.y
        initialX: magnitudeRow.x + inputReinfusionTimeFake.x
        initialY: magnitudeRow.y + inputReinfusionTimeFake.y
        visible: inputReinfusionTimeFake.visible
        width: QtConstants.inputElementWidth
        fullViewWidth: QtConstants.fullViewInputElementWith
        fullViewX: QtConstants.fullViewInputElementX + fullViewOffsetCorrection
        fullViewY: QtConstants.fullViewInputElementY
        unitsLabel.text: ""
        unitsLabel.color: Storage.getAppDB(Constants.dbAppColor.inputReinfusionTimeUnitsId, "black")
        magnitudeLabel.color: Storage.getAppDB(Constants.dbAppColor.inputReinfusionTimeValueId, "black")
        mainImage.source: Storage.getAppDB(Constants.dbAppIcon.reinfusionTimeId, "")
        state:"reducedView"
        name: Constants.inputReinfusionTimeSelectorId
    }

    Item {
        id: inputSalineTime

        property string name: ""
        property string saveStamp: "_"
        property alias  magnitudeLabel:magnitudeLabel
        property alias mainImage: mainImage

        width: QtConstants.inputElementWidth
        height: magnitudeSelectorItem.height * 0.5
        visible: inputReinfusionTime.visible
        opacity: disabledOpacity

        x : magnitudeRow.x +inputPreviousVaccumYesNo.width + (3 * QtConstants.inputElementWidth) + (4 * QtConstants.magnitudeSelectorRowSpacing)
        y : magnitudeRow.y + inputReinfusionTime.initialheight_reducedView + (QtConstants.magnitudeSelectorRowSpacing * 0.5)

        Rectangle{
            anchors.fill: parent
            color: Storage.getAppDB(Constants.dbAppColor.inputCtrlPanelId, "black")
            opacity: inputReinfusionTime.opacity
            radius: inputReinfusionTime.backgroundRadius
        }

        Image{
            id: mainImage
            height: parent.height * 0.9
            width: height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: QtConstants.magnitudeSelectorRowSpacing * 0.5
            source: Storage.getAppDB(Constants.dbAppIcon.salineTimeId, "")
            asynchronous: true         // performance improvement
            sourceSize.width: width    // performance improvement
            sourceSize.height: height  // performance improvement
        }

        Text {
            id: inputSalineTimeUnits
            color: Storage.getAppDB(Constants.dbAppColor.inputReinfusionTimeUnitsId, "black")
            text: "min"
            width: parent.width * 0.5
            height: parent.width * 0.178
            anchors.right: parent.right
            anchors.rightMargin: QtConstants.magnitudeSelectorRowSpacing * 0.8
            anchors.top: parent.top
            anchors.topMargin: parent.width * 0.01
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: parent.width * 0.12
            fontSizeMode: Text.Fit
        }

        Label {
            id: magnitudeLabel
            visible: false
            text: Therapies.formatedSalineBublingTime()
            color: Storage.getAppDB(Constants.dbAppColor.inputSalineTimeUnitsId, "black")
        }

    }

    Label{
        id: inputSalineTimeLabel
        visible: inputSalineTime.visible
        anchors.right: inputSalineTime.right
        anchors.rightMargin: QtConstants.magnitudeSelectorRowSpacing * 0.8
        anchors.bottom: inputSalineTime.bottom
        width: inputReinfusionTime.magnitudeLabel.width
        font.pixelSize: inputReinfusionTime.magnitudeLabel.font.pixelSize
        text: inputSalineTime.magnitudeLabel.text
        color: inputSalineTime.magnitudeLabel.color
        fontSizeMode: Text.Fit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        onVisibleChanged: {
            height = inputReinfusionTime.magnitudeLabel.height * 0.8
        }
    }


    Rectangle{
        id: inputCycles
        property string saveStamp: ""
        property string name: Constants.inputCyclesId

        function init(){
            theraphyCycles = Storage.getAppDB(saveStamp + "_" + Constants.initValuelId , "*")
        }

        function temporalDisable(miliseconds){
                delayedEnable.duration = miliseconds
                delayedEnable.start()
        }

        PropertyAnimation{ id: delayedEnable; target: inputCycles; property: "enabled"; to: true; duration: 0 }

        z: magnitudeSelectorItem.z + 2
        anchors.left: inputNormoOrHiper.left
        anchors.bottom: inputNormoOrHiper.top
        anchors.bottomMargin: - inputBottleVolume.initialheight_reducedView
        visible: inputCyclesFake.visible
        width: inputNormoOrHiper.width + inputPreviousVaccumYesNo.width + (QtConstants.magnitudeSelectorRowSpacing * narrowMarginCoeficient)
        height: inputNormoOrHiper.height
        color: Storage.getAppDB(Constants.dbAppColor.inputCyclesPanelId, "black")
        border.color: "transparent"
        radius: 4

        Image{
            id: inputCyclesMainImage
            height: parent.height * 0.95
            width: height
            anchors.centerIn: parent
            source: Storage.getAppDB(Constants.dbAppIcon.cyclesCounterId, "")
            opacity: (minusButton.down | plusButton.down) ? disabledOpacity : 1
            asynchronous: true         // performance improvement
            sourceSize.width: width    // performance improvement
            sourceSize.height: height  // performance improvement
        }
        Label{
            id: inputCyclesLabel
            visible: inputNormoOrHiper.visible
            color: Storage.getAppDB(Constants.dbAppColor.inputCyclesLabelId, "black")
            text: theraphyCycles
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.height * 0.5
            fontSizeMode: Text.Fit
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "olive"
                visible: viewGrid
            }
        }
        Label{
            id: minusLabel
            height: parent.height
            width: (parent.width * 0.5) - anchors.leftMargin
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.03
            color:  Storage.getAppDB(Constants.dbAppColor.inputCyclesControlId, "black")
            text: "-"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.pointSize: parent.height * 0.6
            opacity: minusButton.down ? disabledOpacity : 1
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "lightBlue"
                visible: viewGrid
            }
            Button{
                id: minusButton
                opacity: 0
                anchors.fill: parent
                onClicked: (theraphyCycles > 1) ? theraphyCycles-- : theraphyCycles = theraphyCycles
                onPressAndHold: {
                    Storage.setAppDB(inputCycles.saveStamp + "_" + Constants.initValuelId , theraphyCycles)
                    Storage.saveAppDB()
                    //DEB->debug.log(DC.magnitudeSelectorLog, "Therapy cycles saved: ", theraphyCycles)
                    inputCyclesSavingEffect.startAnimation("down")
                }
            }
        }
        Label{
            id: plusLabel
            height: parent.height
            width: (parent.width * 0.5) - anchors.leftMargin
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.03
            color: Storage.getAppDB(Constants.dbAppColor.inputCyclesControlId, "black")
            text: "+"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.pointSize: parent.height * 0.3
            font.bold: true
            opacity: plusButton.down ? disabledOpacity : 1
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "lightBlue"
                visible: viewGrid
            }
            Button{
                id: plusButton
                opacity: 0
                anchors.fill: parent
                onClicked: (theraphyCycles === maxAutohemoTherapyCycles) ? theraphyCycles = theraphyCycles : theraphyCycles++
                onPressAndHold: {
                    Storage.setAppDB(inputCycles.saveStamp + "_" + Constants.initValuelId , theraphyCycles)
                    Storage.saveAppDB()
                    //DEB->debug.log(DC.magnitudeSelectorLog, "Therapy cycles saved: ", theraphyCycles)
                    inputCyclesSavingEffect.startAnimation("down")
                }
            }
        }

        Rectangle{
            id: dummyPositioningRectangle
            height: parent.height
            width: parent.width * 0.5
            x: parent.width * 0.25
            z: magnitudeSelectorItem.z + 1
            color: "transparent"
            radius: parent.radius

            SaveEffect{
                id: inputCyclesSavingEffect
                height: parent.height
                width: height
                radius: parent.radius
                blinkRecangle.x: - dummyPositioningRectangle.x
                blinkRecangle.height: inputCycles.height
                blinkRecangle.width: inputCycles.width
            }
        }
    }

    Item {
        id: inputMultipleTotalConcentration
        width: QtConstants.inputElementWidth
        height: magnitudeSelectorItem.height
        anchors.left: inputTotalConcentration.left
        anchors.top: inputTotalConcentration.bottom
        anchors.topMargin:  - parent.height * 0.02
        visible: manageInputMultipleTotalConcentrationVisibility()

        Rectangle{
            anchors.fill: parent
            color: Storage.getAppDB(Constants.dbAppColor.inputCtrlPanelId, "black")
            opacity: inputTotalConcentration.opacity
            radius: inputTotalConcentration.backgroundRadius
        }

        Column{
            id: cyclesColumn
            height: parent.height
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: magnitudeSelectorItem.height  * 0.05
            spacing: -2
            Repeater{
                id: inputMultipleTotalConcentrationRepeater
                model: multipleTotalConcentrationOpacityModel

                Row{
                    id: row
                    height: magnitudeSelectorItem.height / maxAutohemoTherapyCycles
                    width: parent.width
                    Text{
                        id: dose
                        height: parent.height
                        width: (parent.width - cycleNumber.width - cycleImg.width - separatorRect.width) * 0.85
                        text: multipleTotalConcentrationValues[index]
                        color:Storage.getAppDB(Constants.dbAppColor.inputTotalConcentrationValueId, "black")
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: parent.height
                        fontSizeMode: Text.Fit
                        opacity: modelData
                        Rectangle{
                            color:"transparent"
                            border.color: "pink"
                            anchors.fill: parent
                            visible: false
                        }
                    }
                    Rectangle{
                        id: separatorRect
                        color:"transparent"
                        height: parent.height
                        width: height * 0.1
                    }
                    Rectangle{
                        id: cycleImg
                        color:"transparent"
                        height: parent.height
                        width: height
                        Image{
                            height: parent.height * 0.8
                            width: height
                            anchors.centerIn: parent
                            source: Storage.getAppDB(Constants.dbAppIcon.cyclesCounterId, "")
                            opacity: modelData
                            asynchronous: true                // performance improvement
                            sourceSize.width: parent.width    // performance improvement
                            sourceSize.height: parent.height  // performance improvement
                        }
                    }
                    Text{
                        id: cycleNumber
                        height: parent.height
                        width: height * 0.4
                        text: index + 1
                        color: "white"
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: parent.height * 0.7
                        fontSizeMode: Text.Fit
                        opacity: modelData
                        Rectangle{
                            color:"transparent"
                            border.color: "pink"
                            anchors.fill: parent
                            visible: false
                        }
                    }
                }
            }
        }
    }
}
