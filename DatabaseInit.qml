// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12//2.9
import QtQuick.Controls 2.12//2.0
import QtQuick.LocalStorage 2.12//2.0
import "storage.js" as Storage
import "Constants.js" as  Constants
import "DebugConstants.js" as DC

Item {
    id: databaseInit

    property bool forceAppDataBaseInit:  false
    property bool forceLangDataBaseInit: false
    property bool forceMemDataBaseInit:  false

    TextArea{
        id: dataBaseInitText
        width: parent.width
        height: 80
        text: "Database Init: "
        color: "white"
        wrapMode: Text.WrapAnywhere
        visible: true
        z: 1
    }

    Component.onCompleted: {
//
//      Aplication database init
//
        //DEB->debug.log(DC.dataBaseInitConsoleLog, "Settings database initialization...")


        if((Storage.getAppDB("DB_INIT", "NOT_INIT") !== "INIT") || (forceAppDataBaseInit) ){

            //DEB->debug.log(DC.dataBaseInitConsoleLog, "Starting configuration database...")

            var i, j, k, l

            Storage.setAppDB(Constants.dataBaseVerId, Constants.dataBaseVer)  // register DB version

            // magnitude selector for each therapy init
            for (j = 0; j < Constants.optionId.length; j++){
                console.log("Database Init: magnitude selector for each therapy " ,j)

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.configurationEnabledID, Constants.inputCongfigEnabledBottleVolume[j])            // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.configurationEnabledID, Constants.inputCongfigEnabledBloodVolume[j])             // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.configurationEnabledID, Constants.inputCongfigEnabledLiquidVolume[j])            // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.configurationEnabledID, Constants.inputCongfigEnabledSalineVolume[j])            // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.configurationEnabledID, Constants.inputCongfigEnabledO3[j])                      // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.configurationEnabledID, Constants.inputCongfigEnabledFlow[j])                    // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.configurationEnabledID, Constants.inputCongfigEnabledTime[j])                    // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.configurationEnabledID, Constants.inputCongfigEnabledTimeVolume[j])              // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.configurationEnabledID, Constants.inputCongfigEnabledTotalConcentration[j])      // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.configurationEnabledID, Constants.inputCongfigEnabledTherapyTime[j])             // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.configurationEnabledID, Constants.inputCongfigEnabledVacuumTime[j])              // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.configurationEnabledID, Constants.inputCongfigEnabledVolumeDose[j])              // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.configurationEnabledID, Constants.inputCongfigEnabledTimeDose[j])                // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.configurationEnabledID, Constants.inputCongfigEnabledVolume[j])                  // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.configurationEnabledID, Constants.inputCongfigEnabledCleanTime[j])               // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.configurationEnabledID, Constants.inputCongfigEnabledPressure[j])                // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.configurationEnabledID, Constants.inputCongfigEnabledIp[j])                      // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.configurationEnabledID, Constants.inputCongfigEnabledReinfusionTime[j])          // enable input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.configurationEnabledID, Constants.inputCongfigEnabledSalineTime[j])              // enable input configuration

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledBottleVolume[j])       // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledBloodVolume[j])        // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledLiquidVolume[j])       // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledSalineVolume[j])       // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledO3[j])                 // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledFlow[j])               // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledTime[j])               // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledTimeVolume[j])         // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledTotalConcentration[j]) // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledTherapyTime[j])        // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledVacuumTime[j])         // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledVolumeDose[j])         // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledTimeDose[j])           // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledVolume[j])             // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledCleanTime[j])          // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledPressure[j])           // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledIp[j])                 // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledReinfusionTime[j])     // enable range input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.configureRangeEanbledID, Constants.inputCongfigRangeEnabledSalineTime[j])         // enable range input configuration

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledBottleVolume[j])       // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledBloodVolume[j])        // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledLiquidVolume[j])       // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledSalineVolume[j])       // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledO3[j])                 // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledFlow[j])               // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledTime[j])               // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledTimeVolume[j])         // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledTotalConcentration[j]) // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledTherapyTime[j])        // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledVacuumTime[j])         // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledVolumeDose[j])         // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledTimeDose[j])           // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledVolume[j])             // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledCleanTime[j])          // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledPressure[j])           // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledIp[j])                 // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledReinfusionTime[j])     // enable units input configuration
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.configureUnitsEanbledID, Constants.inputCongfigUnitsEnabledSalineTime[j])         // enable units input configuration

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.sliderUnitsId, Constants.sliderUnitsBottleVolume[j])         // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.sliderUnitsId, Constants.sliderUnitsBloodVolume[j])          // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.sliderUnitsId, Constants.sliderUnitsLiquidVolume[j])         // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.sliderUnitsId, Constants.sliderUnitsSalineVolume[j])         // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.sliderUnitsId, Constants.sliderUnitsO3[j])                   // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.sliderUnitsId, Constants.sliderUnitsFlow[j])                 // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.sliderUnitsId, Constants.sliderUnitsTime[j])                 // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.sliderUnitsId, Constants.sliderUnitsTimeVolume[j])           // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.sliderUnitsId, Constants.sliderUnitsTotalConcentration[j])   // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.sliderUnitsId, Constants.sliderUnitsTherapyTime[j])          // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.sliderUnitsId, Constants.sliderUnitsVacuumTime[j])           // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.sliderUnitsId, Constants.sliderUnitsVolumeDose[j])           // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.sliderUnitsId, Constants.sliderUnitsTimeDose[j])             // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.sliderUnitsId, Constants.sliderUnitsVolume[j])               // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.sliderUnitsId, Constants.sliderUnitsCleanTime[j])            // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.sliderUnitsId, Constants.sliderUnitsPressure[j])             // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.sliderUnitsId, Constants.sliderUnitsIp[j])                   // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.sliderUnitsId, Constants.sliderUnitsReinfusionTime[j])       // init slider units
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.sliderUnitsId, Constants.sliderUnitsSalineTime[j])           // init slider units

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.sliderUnitsAId, Constants.sliderUnitsABottleVolume[j])       // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.sliderUnitsAId, Constants.sliderUnitsABloodVolume[j])        // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.sliderUnitsAId, Constants.sliderUnitsALiquidVolume[j])       // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.sliderUnitsAId, Constants.sliderUnitsASalineVolume[j])       // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.sliderUnitsAId, Constants.sliderUnitsAO3[j])                 // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.sliderUnitsAId, Constants.sliderUnitsAFlow[j])               // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.sliderUnitsAId, Constants.sliderUnitsATime[j])               // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.sliderUnitsAId, Constants.sliderUnitsATimeVolume[j])         // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.sliderUnitsAId, Constants.sliderUnitsATotalConcentration[j]) // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.sliderUnitsAId, Constants.sliderUnitsATherapyTime[j])        // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.sliderUnitsAId, Constants.sliderUnitsAVacuumTime[j])         // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.sliderUnitsAId, Constants.sliderUnitsAVolumeDose[j])         // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.sliderUnitsAId, Constants.sliderUnitsATimeDose[j])           // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.sliderUnitsAId, Constants.sliderUnitsAVolume[j])             // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.sliderUnitsAId, Constants.sliderUnitsACleanTime[j])          // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.sliderUnitsAId, Constants.sliderUnitsAPressure[j])           // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.sliderUnitsAId, Constants.sliderUnitsAIp[j])                 // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.sliderUnitsAId, Constants.sliderUnitsAReinfusionTime[j])     // init slider units option A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.sliderUnitsAId, Constants.sliderUnitsASalineTime[j])         // init slider units option A

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.sliderUnitsBId, Constants.sliderUnitsBBottleVolume[j])       // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.sliderUnitsBId, Constants.sliderUnitsBBloodVolume[j])        // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.sliderUnitsBId, Constants.sliderUnitsBLiquidVolume[j])       // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.sliderUnitsBId, Constants.sliderUnitsBSalineVolume[j])       // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.sliderUnitsBId, Constants.sliderUnitsBO3[j])                 // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.sliderUnitsBId, Constants.sliderUnitsBFlow[j])               // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.sliderUnitsBId, Constants.sliderUnitsBTime[j])               // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.sliderUnitsBId, Constants.sliderUnitsBTimeVolume[j])         // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.sliderUnitsBId, Constants.sliderUnitsBTotalConcentration[j]) // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.sliderUnitsBId, Constants.sliderUnitsBTherapyTime[j])        // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.sliderUnitsBId, Constants.sliderUnitsBVacuumTime[j])         // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.sliderUnitsBId, Constants.sliderUnitsBVolumeDose[j])         // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.sliderUnitsBId, Constants.sliderUnitsBTimeDose[j])           // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.sliderUnitsBId, Constants.sliderUnitsBVolume[j])             // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.sliderUnitsBId, Constants.sliderUnitsBCleanTime[j])          // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.sliderUnitsBId, Constants.sliderUnitsBPressure[j])           // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.sliderUnitsBId, Constants.sliderUnitsBIp[j])                 // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.sliderUnitsBId, Constants.sliderUnitsBReinfusionTime[j])     // init slider units option B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.sliderUnitsBId, Constants.sliderUnitsBSalineTime[j])         // init slider units option B

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.unitsConversionFactorAId, Constants.conversionFactorABottleVolume[j])       // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.unitsConversionFactorAId, Constants.conversionFactorABloodVolume[j])        // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.unitsConversionFactorAId, Constants.conversionFactorALiquidVolume[j])       // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.unitsConversionFactorAId, Constants.conversionFactorASalineVolume[j])       // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.unitsConversionFactorAId, Constants.conversionFactorAO3[j])                 // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.unitsConversionFactorAId, Constants.conversionFactorAFlow[j])               // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.unitsConversionFactorAId, Constants.conversionFactorATime[j])               // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.unitsConversionFactorAId, Constants.conversionFactorATimeVolume[j])         // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.unitsConversionFactorAId, Constants.conversionFactorATotalConcentration[j]) // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.unitsConversionFactorAId, Constants.conversionFactorATherapyTime[j])        // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.unitsConversionFactorAId, Constants.conversionFactorAVacuumTime[j])         // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.unitsConversionFactorAId, Constants.conversionFactorAVolumeDose[j])         // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.unitsConversionFactorAId, Constants.conversionFactorATimeDose[j])           // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.unitsConversionFactorAId, Constants.conversionFactorAVolume[j])             // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.unitsConversionFactorAId, Constants.conversionFactorACleanTime[j])          // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.unitsConversionFactorAId, Constants.conversionFactorAPressure[j])           // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.unitsConversionFactorAId, Constants.conversionFactorAIp[j])                 // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.unitsConversionFactorAId, Constants.conversionFactorAReinfusionTime[j])     // init units conversion factor A
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.unitsConversionFactorAId, Constants.conversionFactorASalineTime[j])         // init units conversion factor A

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.unitsConversionFactorBId, Constants.conversionFactorBBottleVolume[j])       // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.unitsConversionFactorBId, Constants.conversionFactorBBloodVolume[j])        // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.unitsConversionFactorBId, Constants.conversionFactorBLiquidVolume[j])       // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.unitsConversionFactorBId, Constants.conversionFactorBSalineVolume[j])       // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.unitsConversionFactorBId, Constants.conversionFactorBO3[j])                 // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.unitsConversionFactorBId, Constants.conversionFactorBFlow[j])               // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.unitsConversionFactorBId, Constants.conversionFactorBTime[j])               // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.unitsConversionFactorBId, Constants.conversionFactorBTimeVolume[j])         // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.unitsConversionFactorBId, Constants.conversionFactorBTotalConcentration[j]) // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.unitsConversionFactorBId, Constants.conversionFactorBTherapyTime[j])        // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.unitsConversionFactorBId, Constants.conversionFactorBVacuumTime[j])         // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.unitsConversionFactorBId, Constants.conversionFactorBVolumeDose[j])         // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.unitsConversionFactorBId, Constants.conversionFactorBTimeDose[j])           // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.unitsConversionFactorBId, Constants.conversionFactorBVolume[j])             // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.unitsConversionFactorBId, Constants.conversionFactorBCleanTime[j])          // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.unitsConversionFactorBId, Constants.conversionFactorBPressure[j])           // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.unitsConversionFactorBId, Constants.conversionFactorBIp[j])                 // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.unitsConversionFactorBId, Constants.conversionFactorBTimeDose[j])           // init units conversion factor B
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.unitsConversionFactorBId, Constants.conversionFactorBSalineTime[j])         // init units conversion factor B

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.sliderInitId, Constants.sliderInitBottleVolume[j])           // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.sliderInitId, Constants.sliderInitBloodVolume[j])            // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.sliderInitId, Constants.sliderInitLiquidVolume[j])           // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.sliderInitId, Constants.sliderInitSalineVolume[j])           // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.sliderInitId, Constants.sliderInitO3[j])                     // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.sliderInitId, Constants.sliderInitFlow[j])                   // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.sliderInitId, Constants.sliderInitTime[j])                   // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.sliderInitId, Constants.sliderInitTimeVolume[j])             // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.sliderInitId, Constants.sliderInitTotalConcentration[j])     // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.sliderInitId, Constants.sliderInitTherapyTime[j])            // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.sliderInitId, Constants.sliderInitVacuumTime[j])             // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.sliderInitId, Constants.sliderInitVolumeDose[j])             // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.sliderInitId, Constants.sliderInitTimeDose[j])               // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.sliderInitId, Constants.sliderInitVolume[j])                 // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.sliderInitId, Constants.sliderInitCleanTime[j])              // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.sliderInitId, Constants.sliderInitPressure[j])               // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.sliderInitId, Constants.sliderInitIp[j])                     // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.sliderInitId, Constants.sliderInitReinfusionTime[j])         // init slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.sliderInitId, Constants.sliderInitSalineTime[j])             // init slider value

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.sliderMaxId, Constants.sliderMaxBottleVolume[j])             // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.sliderMaxId, Constants.sliderMaxBloodVolume[j])              // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.sliderMaxId, Constants.sliderMaxLiquidVolume[j])             // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.sliderMaxId, Constants.sliderMaxSalineVolume[j])             // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.sliderMaxId, Constants.sliderMaxO3[j])                       // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.sliderMaxId, Constants.sliderMaxFlow[j])                     // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.sliderMaxId, Constants.sliderMaxTime[j])                     // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.sliderMaxId, Constants.sliderMaxTimeVolume[j])               // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.sliderMaxId, Constants.sliderMaxTotalConcentration[j])       // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.sliderMaxId, Constants.sliderMaxTherapyTime[j])              // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.sliderMaxId, Constants.sliderMaxVacuumTime[j])               // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.sliderMaxId, Constants.sliderMaxVolumeDose[j])               // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.sliderMaxId, Constants.sliderMaxTimeDose[j])                 // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.sliderMaxId, Constants.sliderMaxVolume[j])                   // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.sliderMaxId, Constants.sliderMaxCleanTime[j])                // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.sliderMaxId, Constants.sliderMaxPressure[j])                 // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.sliderMaxId, Constants.sliderMaxIp[j])                       // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.sliderMaxId, Constants.sliderMaxReinfusionTime[j])           // init max slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.sliderMaxId, Constants.sliderMaxSalineTime[j])               // init max slider value

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.sliderMinId, Constants.sliderMinBottleVolume[j])             // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.sliderMinId, Constants.sliderMinBloodVolume[j])              // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.sliderMinId, Constants.sliderMinLiquidVolume[j])             // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.sliderMinId, Constants.sliderMinSalineVolume[j])             // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.sliderMinId, Constants.sliderMinO3[j])                       // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.sliderMinId, Constants.sliderMinFlow[j])                     // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.sliderMinId, Constants.sliderMinTime[j])                     // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.sliderMinId, Constants.sliderMinTimeVolume[j])               // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.sliderMinId, Constants.sliderMinTotalConcentration[j])       // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.sliderMinId, Constants.sliderMinTherapyTime[j])              // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.sliderMinId, Constants.sliderMinVacuumTime[j])               // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.sliderMinId, Constants.sliderMinVolumeDose[j])               // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.sliderMinId, Constants.sliderMinTimeDose[j])                 // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.sliderMinId, Constants.sliderMinVolume[j])                   // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.sliderMinId, Constants.sliderMinCleanTime[j])                // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.sliderMinId, Constants.sliderMinPressure[j])                 // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.sliderMinId, Constants.sliderMinIp[j])                       // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.sliderMinId, Constants.sliderMinReinfusionTime[j])           // init min slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.sliderMinId, Constants.sliderMinSalineTime[j])               // init min slider value

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.sliderRangeMaxId, Constants.sliderRangeMaxBottleVolume[j])         // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.sliderRangeMaxId, Constants.sliderRangeMaxBloodVolume[j])          // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.sliderRangeMaxId, Constants.sliderRangeMaxLiquidVolume[j])         // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.sliderRangeMaxId, Constants.sliderRangeMaxSalineVolume[j])         // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.sliderRangeMaxId, Constants.sliderRangeMaxO3[j])                   // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.sliderRangeMaxId, Constants.sliderRangeMaxFlow[j])                 // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.sliderRangeMaxId, Constants.sliderRangeMaxTime[j])                 // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.sliderRangeMaxId, Constants.sliderRangeMaxTimeVolume[j])           // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.sliderRangeMaxId, Constants.sliderRangeMaxTotalConcentration[j])   // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.sliderRangeMaxId, Constants.sliderRangeMaxTherapyTime[j])          // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.sliderRangeMaxId, Constants.sliderRangeMaxVacuumTime[j])           // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.sliderRangeMaxId, Constants.sliderRangeMaxVolumeDose[j])           // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.sliderRangeMaxId, Constants.sliderRangeMaxTimeDose[j])             // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.sliderRangeMaxId, Constants.sliderRangeMaxVolume[j])               // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.sliderRangeMaxId, Constants.sliderRangeMaxCleanTime[j])            // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.sliderRangeMaxId, Constants.sliderRangeMaxPressure[j])             // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.sliderRangeMaxId, Constants.sliderRangeMaxIp[j])                   // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.sliderRangeMaxId, Constants.sliderRangeMaxReinfusionTime[j])       // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.sliderRangeMaxId, Constants.sliderRangeMaxSalineTime[j])           // init max range slider value

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.sliderRangeMinId, Constants.sliderRangeMinBottleVolume[j])         // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.sliderRangeMinId, Constants.sliderRangeMinBloodVolume[j])          // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.sliderRangeMinId, Constants.sliderRangeMinLiquidVolume[j])         // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.sliderRangeMinId, Constants.sliderRangeMinSalineVolume[j])         // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.sliderRangeMinId, Constants.sliderRangeMinO3[j])                   // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.sliderRangeMinId, Constants.sliderRangeMinFlow[j])                 // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.sliderRangeMinId, Constants.sliderRangeMinTime[j])                 // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.sliderRangeMinId, Constants.sliderRangeMinTimeVolume[j])           // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.sliderRangeMinId, Constants.sliderRangeMinTotalConcentration[j])   // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.sliderRangeMinId, Constants.sliderRangeMinTherapyTime[j])          // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.sliderRangeMinId, Constants.sliderRangeMinVacuumTime[j])           // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.sliderRangeMinId, Constants.sliderRangeMinVolumeDose[j])           // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.sliderRangeMinId, Constants.sliderRangeMinTimeDose[j])             // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.sliderRangeMinId, Constants.sliderRangeMinVolume[j])               // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.sliderRangeMinId, Constants.sliderRangeMinCleanTime[j])            // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.sliderRangeMinId, Constants.sliderRangeMinPressure[j])             // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.sliderRangeMinId, Constants.sliderRangeMinIp[j])                   // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.sliderRangeMinId, Constants.sliderRangeMinReinfusionTime[j])       // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.sliderRangeMinId, Constants.sliderRangeMinSalineTime[j])           // init min range slider value

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesBottleVolume[j])         // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesBloodVolume[j])          // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesLiquidVolume[j])         // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesSalineVolume[j])         // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesO3[j])                   // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesFlow[j])                 // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesTime[j])                 // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesTimeVolume[j])           // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesTotalConcentration[j])   // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesTherapyTime[j])          // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesVacuumTime[j])           // init min range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesVolumeDose[j])           // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesTimeDose[j])             // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesVolume[j])               // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesCleanTime[j])            // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesPressure[j])             // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesIp[j])                   // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesReinfusionTime[j])       // init max range slider value
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +         Constants.diffValuesOnCyclesId, Constants.diffValuesOnCyclesSalineTime[j])           // init max range slider value

                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputNormoOrHiperId + "_" +            Constants.initValuelId, Constants.initNormoOrHiper[j])                          // init value (for special controls without slider)
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCyclesId + "_" +                  Constants.initValuelId, Constants.initInputCycles[j])                           // init value (for special controls without slider)
                Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPreviousVaccumYesNoId + "_" +     Constants.initValuelId, Constants.initPreviousVaccumYesNo[j])                   // init value (for special controls without slider)

                for (i = 0; i < Constants.fixedButtonId.length; i++){
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBottleVolumeSelectorId + "_" +       Constants.fixedButtonId[i], Constants.fixedButtonBottleVolume[j][i])       // O3 fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputBloodVolumeSelectorId + "_" +        Constants.fixedButtonId[i], Constants.fixedButtonBloodVolume[j][i])        // O3 fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputLiquidVolumeSelectorId + "_" +       Constants.fixedButtonId[i], Constants.fixedButtonLiquidVolume[j][i])       // O3 fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineVolumeSelectorId + "_" +       Constants.fixedButtonId[i], Constants.fixedButtonSalineVolume[j][i])       // O3 fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputO3SelectorId + "_" +                 Constants.fixedButtonId[i], Constants.fixedButtonO3[j][i])                 // O3 fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputFlowSelectorId + "_" +               Constants.fixedButtonId[i], Constants.fixedButtonFlow[j][i])               // Flow fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeSelectorId + "_" +               Constants.fixedButtonId[i], Constants.fixedButtonTime[j][i])               // Time fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeVolumeSelectorId + "_" +         Constants.fixedButtonId[i], Constants.fixedButtonTimeVolume[j][i])         // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTotalConcentrationSelectorId + "_" + Constants.fixedButtonId[i], Constants.fixedButtonTotalConcentration[j][i]) // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTherapyTimeSelectorId + "_" +        Constants.fixedButtonId[i], Constants.fixedButtonTherapyTime[j][i])        // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVacuumTimeSelectorId + "_" +         Constants.fixedButtonId[i], Constants.fixedButtonVacuumTime[j][i])         // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeDoseSelectorId + "_" +         Constants.fixedButtonId[i], Constants.fixedButtonVolumeDose[j][i])         // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputTimeDoseSelectorId + "_" +           Constants.fixedButtonId[i], Constants.fixedButtonTimeDose[j][i])           // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputVolumeSelectorId + "_" +             Constants.fixedButtonId[i], Constants.fixedButtonVolume[j][i])             // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputCleanTimeSelectorId + "_" +          Constants.fixedButtonId[i], Constants.fixedButtonCleanTime[j][i])          // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputPressureSelectorId + "_" +           Constants.fixedButtonId[i], Constants.fixedButtonPressure[j][i])           // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputIpSelectorId + "_" +                 Constants.fixedButtonId[i], Constants.fixedButtonIp[j][i])                 // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputReinfusionTimeSelectorId + "_" +     Constants.fixedButtonId[i], Constants.fixedButtonReinfusionTime[j][i])     // Time&Volume fixed button values
                    Storage.setAppDB(Constants.optionId[j] + "_" + Constants.inputSalineTimeSelectorId + "_" +        Constants.fixedButtonId[i], Constants.fixedButtonSalineTime[j][i])         // Time&Volume fixed button values
                }
            }

            // parameter init
            for(i=0; i< Constants.dbParameterElementsInit.length; i++){
                console.log("Database Init: parameter init " ,i)

                Storage.setAppDB(Constants.dbParameterElementsInit[i]["name"] + Constants.unitsId, Constants.dbParameterElementsInit[i]["units"])
                Storage.setAppDB(Constants.dbParameterElementsInit[i]["name"] + Constants.unitsAId, Constants.dbParameterElementsInit[i]["unitsA"])
                Storage.setAppDB(Constants.dbParameterElementsInit[i]["name"] + Constants.unitsBId, Constants.dbParameterElementsInit[i]["unitsB"])
                Storage.setAppDB(Constants.dbParameterElementsInit[i]["name"] + Constants.conversionFactorAId, Constants.dbParameterElementsInit[i]["conv_factor_A"])
                Storage.setAppDB(Constants.dbParameterElementsInit[i]["name"] + Constants.conversionFactorBId, Constants.dbParameterElementsInit[i]["conv_factor_B"])
                Storage.setAppDB(Constants.dbParameterElementsInit[i]["name"] + Constants.offsetAId, Constants.dbParameterElementsInit[i]["offset_A"])
                Storage.setAppDB(Constants.dbParameterElementsInit[i]["name"] + Constants.offsetBId, Constants.dbParameterElementsInit[i]["offset_B"])
            }

            // application colors init
            for (i = 0; i < Constants.dbAppColorElementsInit.length; i++){
                console.log("Database Init: application colors init " ,i)

                Storage.setAppDB(Constants.dbAppColorElementsInit[i]["name"], Constants.dbAppColorElementsInit[i]["value"])   // init colors
            }

            // application icons init
            for (i = 0; i < Constants.dbAppIconElementsInit.length; i++){
                console.log("Database Init: application icons init " ,i)

                Storage.setAppDB(Constants.dbAppIconElementsInit[i]["name"], Constants.dbAppIconElementsInit[i]["value"])   // init magnitude icons
            }

            // brand name parameters init
            for(i=0; i< Constants.dbBrandNameElementsInit.length; i++){
                console.log("Database Init: brand name parameters init " ,i)

                Storage.setAppDB(Constants.dbBrandNameElementsInit[i]["name"], Constants.dbBrandNameElementsInit[i]["value"])
            }

            // device limits init
            for(i=0; i< Constants.deviceLimitsElementsInit.length; i++){
                console.log("Database Init: device limits init " ,i)

                Storage.setAppDB(Constants.deviceLimitsElementsInit[i]["name"], Constants.deviceLimitsElementsInit[i]["value"])
            }

            // device constants
            for(i=0; i< Constants.constantsElementsInit.length; i++){
                console.log("Database Init: device constants " ,i, "-", Constants.constantsElementsInit[i]["name"], "-", Constants.constantsElementsInit[i]["value"])

                Storage.setAppDB(Constants.constantsElementsInit[i]["name"], Constants.constantsElementsInit[i]["value"])
            }

            // help tutorial video constants
            for(i=0; i< Constants.dbHelpTutorialVideoElementsInit.length; i++){
                console.log("Database Init: help tutorial video constants " ,i)

                Storage.setAppDB(Constants.dbHelpTutorialVideoElementsInit[i]["name"], Constants.dbHelpTutorialVideoElementsInit[i]["value"])
            }
            // help therapy video constants
            for(i=0; i< Constants.dbHelpTherapyVideoElementsInit.length; i++){
                console.log("Database Init: help therapy video constants " ,i)
                Storage.setAppDB(Constants.dbHelpTherapyVideoElementsInit[i]["name"], Constants.dbHelpTherapyVideoElementsInit[i]["value"])
            }
            // help connection image constants
            for(i=0; i< Constants.dbHelpConnectionImgElementsInit.length; i++){
                console.log("Database Init: help connection image constants " ,i)
                Storage.setAppDB(Constants.dbHelpConnectionImgElementsInit[i]["name"], Constants.dbHelpConnectionImgElementsInit[i]["value"])
            }

            // help docs constants
            if(Constants.dbLanguageFields[0]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Esp.length; i++){
                    console.log("Database Init: Spanish help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Esp[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Esp[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Esp[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Esp[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Esp[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Esp[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Esp[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[1]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Eng.length; i++){
                    console.log("Database Init: English help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Eng[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Eng[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Eng[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Eng[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Eng[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Eng[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Eng[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[2]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Chi.length; i++){
                    console.log("Database Init: Chinese help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Chi[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Chi[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Chi[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Chi[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Chi[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Chi[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Chi[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[3]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Por.length; i++){
                    console.log("Database Init: Portugese help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Por[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Por[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Por[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Por[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Por[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Por[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Por[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[4]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Rus.length; i++){
                    console.log("Database Init: Russian help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Rus[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Rus[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Rus[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Rus[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Rus[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Rus[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Rus[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[5]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Ger.length; i++){
                    console.log("Database Init: German help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Ger[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Ger[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Ger[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Ger[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Ger[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Ger[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Ger[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[6]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Ita.length; i++){
                    console.log("Database Init: Italian help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Ita[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Ita[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Ita[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Ita[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Ita[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Ita[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Ita[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[7]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Fre.length; i++){
                    console.log("Database Init: French help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Fre[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Fre[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Fre[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Fre[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Fre[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Fre[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Fre[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[8]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Hin.length; i++){
                    console.log("Database Init: Hindi help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Hin[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Hin[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Hin[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Hin[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Hin[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Hin[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Hin[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[9]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpDocElementsInit_Ara.length; i++){
                    console.log("Database Init: Arabian help docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Ara[i]["name"].substring(0, (Constants.dbHelpDocElementsInit_Ara[i]["name"].length - 1)), Constants.dbHelpDocElementsInit_Ara[i]["value"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Ara[i]["name"] + Constants.helpDocPageId, Constants.dbHelpDocElementsInit_Ara[i]["page"])
                    Storage.setAppDB(Constants.dbHelpDocElementsInit_Ara[i]["name"] + Constants.helpDocNumPagesId, Constants.dbHelpDocElementsInit_Ara[i]["num_pages"])
                }
            }

            // help troubleshoot docs constants
            if(Constants.dbLanguageFields[0]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Esp.length; i++){
                    console.log("Database Init: Spanish help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Esp[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Esp[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Esp[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Esp[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Esp[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Esp[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Esp[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[1]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Eng.length; i++){
                    console.log("Database Init: English help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Eng[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Eng[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Eng[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Eng[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Eng[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Eng[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Eng[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[2]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Chi.length; i++){
                    console.log("Database Init: Chinese help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Chi[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Chi[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Chi[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Chi[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Chi[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Chi[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Chi[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[3]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Por.length; i++){
                    console.log("Database Init: Portugese help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Por[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Por[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Por[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Por[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Por[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Por[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Por[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[4]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Rus.length; i++){
                    console.log("Database Init: Russian help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Rus[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Rus[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Rus[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Rus[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Rus[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Rus[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Rus[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[5]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Ger.length; i++){
                    console.log("Database Init: German help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Ger[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Ger[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Ger[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Ger[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Ger[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Ger[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Ger[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[6]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Ita.length; i++){
                    console.log("Database Init: Italian help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Ita[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Ita[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Ita[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Ita[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Ita[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Ita[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Ita[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[7]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Fre.length; i++){
                    console.log("Database Init: French help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Fre[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Fre[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Fre[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Fre[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Fre[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Fre[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Fre[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[8]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Hin.length; i++){
                    console.log("Database Init: Hindi help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Hin[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Hin[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Hin[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Hin[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Hin[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Hin[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Hin[i]["num_pages"])
                }
            }
            if(Constants.dbLanguageFields[9]["available_val"] === "true"){
                for(i=0; i< Constants.dbHelpTroubleShootDocElementsInit_Ara.length; i++){
                    console.log("Database Init: Arabian help troubleshoot docs constants " ,i)

                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Ara[i]["name"].substring(0, (Constants.dbHelpTroubleShootDocElementsInit_Ara[i]["name"].length - 1)), Constants.dbHelpTroubleShootDocElementsInit_Ara[i]["value"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Ara[i]["name"] + Constants.helpTroubleShootDocPageId, Constants.dbHelpTroubleShootDocElementsInit_Ara[i]["page"])
                    Storage.setAppDB(Constants.dbHelpTroubleShootDocElementsInit_Ara[i]["name"] + Constants.helpTroubleShootDocNumPagesId, Constants.dbHelpTroubleShootDocElementsInit_Ara[i]["num_pages"])
                }
            }

            Storage.setAppDB("DB_INIT", "INIT") // Database already initialized tag

            Storage.saveAppDB()
        }else{
            //DEB->debug.log(DC.dataBaseInitConsoleLog, "Settings database already initialized.")
        }
        //DEB->debug.log(DC.dataBaseInitConsoleLog, "Settings database start up procces finished.")


//
//      Language database init
//
        if( (Storage.getLanguageDB("DB_INIT", "NOT_INIT") !== "INIT") || (forceLangDataBaseInit) ){

            console.log("Init language data base resources...")
            console.log("Number of languages: ", Constants.dbLanguageNumberOflanguagesId, "  ", Constants.dbLanguageFields.length)
            console.log("Number of texts:     ", Constants.dbLanguageNumberOfTextsId, "      ", Constants.dbSpanishLanguageElementsInit.length)
            console.log("Selected language:   ", Constants.dbLanguageSelectedLanguageId, " ", Constants.dbLanguageSelectedLanguage)

            Storage.setLanguageDB(Constants.dataBaseVerId, Constants.dataBaseVer)  // register DB version

            Storage.setLanguageDB(Constants.dbLanguageNumberOflanguagesId, Constants.dbLanguageFields.length)
            Storage.setLanguageDB(Constants.dbLanguageNumberOfTextsId, Constants.dbSpanishLanguageElementsInit.length)
            Storage.setLanguageDB(Constants.dbLanguageSelectedLanguageId, Constants.dbLanguageSelectedLanguage)

            // available languages list (names and DB id's)
            for(i=0; i< Constants.dbLanguageFields.length; i++){
                console.log(Constants.dbLanguageFields[i]["name"], ":      ", Constants.dbLanguageFields[i]["name_value"])
                console.log(Constants.dbLanguageFields[i]["id"], ":        ", Constants.dbLanguageFields[i]["id_value"])
                console.log(Constants.dbLanguageFields[i]["available"], ": ", Constants.dbLanguageFields[i]["available_val"])
                console.log(Constants.dbLanguageFields[i]["locale_keyboardId"], ": ", Constants.dbLanguageFields[i]["locale_keyboard_val"])

                Storage.setLanguageDB(Constants.dbLanguageFields[i]["name"], Constants.dbLanguageFields[i]["name_value"])
                Storage.setLanguageDB(Constants.dbLanguageFields[i]["id"], Constants.dbLanguageFields[i]["id_value"])
                Storage.setLanguageDB(Constants.dbLanguageFields[i]["available"], Constants.dbLanguageFields[i]["available_val"])
                Storage.setLanguageDB(Constants.dbLanguageFields[i]["locale_keyboardId"], Constants.dbLanguageFields[i]["locale_keyboard_val"])
            }

            // Spanish texts DB init
            if(Constants.dbLanguageFields[0]["available_val"] === "true"){
                for(i=0; i< Constants.dbSpanishLanguageElementsInit.length; i++){
                    console.log(Constants.dbSpanishLanguageElementsInit[i]["name"], " - ", Constants.dbSpanishLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbSpanishLanguageElementsInit[i]["name"], Constants.dbSpanishLanguageElementsInit[i]["value"])
                }
            }

            // English texts DB init
            if(Constants.dbLanguageFields[1]["available_val"] === "true"){
                for(i=0; i< Constants.dbEnglishLanguageElementsInit.length; i++){
                    console.log(Constants.dbEnglishLanguageElementsInit[i]["name"], " - ", Constants.dbEnglishLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbEnglishLanguageElementsInit[i]["name"], Constants.dbEnglishLanguageElementsInit[i]["value"])
                }
            }

            // Chinese texts DB init
            if(Constants.dbLanguageFields[2]["available_val"] === "true"){
                for(i=0; i< Constants.dbChineseLanguageElementsInit.length; i++){
                    console.log(Constants.dbChineseLanguageElementsInit[i]["name"], " - ", Constants.dbChineseLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbChineseLanguageElementsInit[i]["name"], Constants.dbChineseLanguageElementsInit[i]["value"])
                }
            }

            // Portugese texts DB init
            if(Constants.dbLanguageFields[3]["available_val"] === "true"){
                for(i=0; i< Constants.dbPortugeseLanguageElementsInit.length; i++){
                    console.log(Constants.dbPortugeseLanguageElementsInit[i]["name"], " - ", Constants.dbPortugeseLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbPortugeseLanguageElementsInit[i]["name"], Constants.dbPortugeseLanguageElementsInit[i]["value"])
                }
            }

            // Russian texts DB init
            if(Constants.dbLanguageFields[4]["available_val"] === "true"){
                for(i=0; i< Constants.dbRussianLanguageElementsInit.length; i++){
                    console.log(Constants.dbRussianLanguageElementsInit[i]["name"], " - ", Constants.dbRussianLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbRussianLanguageElementsInit[i]["name"], Constants.dbRussianLanguageElementsInit[i]["value"])
                }
            }

            // German texts DB init
            if(Constants.dbLanguageFields[5]["available_val"] === "true"){
                for(i=0; i< Constants.dbGermanLanguageElementsInit.length; i++){
                    console.log(Constants.dbGermanLanguageElementsInit[i]["name"], " - ", Constants.dbGermanLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbGermanLanguageElementsInit[i]["name"], Constants.dbGermanLanguageElementsInit[i]["value"])
                }
            }

            // Italian texts DB init
            if(Constants.dbLanguageFields[6]["available_val"] === "true"){
                for(i=0; i< Constants.dbItalianLanguageElementsInit.length; i++){
                    console.log(Constants.dbItalianLanguageElementsInit[i]["name"], " - ", Constants.dbItalianLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbItalianLanguageElementsInit[i]["name"], Constants.dbItalianLanguageElementsInit[i]["value"])
                }
            }

            // French texts DB init
            if(Constants.dbLanguageFields[7]["available_val"] === "true"){
                for(i=0; i< Constants.dbFrenchLanguageElementsInit.length; i++){
                    console.log(Constants.dbFrenchLanguageElementsInit[i]["name"], " - ", Constants.dbFrenchLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbFrenchLanguageElementsInit[i]["name"], Constants.dbFrenchLanguageElementsInit[i]["value"])
                }
            }

            // Hindi texts DB init
            if(Constants.dbLanguageFields[8]["available_val"] === "true"){
                for(i=0; i< Constants.dbHindiLanguageElementsInit.length; i++){
                    console.log(Constants.dbHindiLanguageElementsInit[i]["name"], " - ", Constants.dbHindiLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbHindiLanguageElementsInit[i]["name"], Constants.dbHindiLanguageElementsInit[i]["value"])
                }
            }

            // Arabic texts DB init
            if(Constants.dbLanguageFields[9]["available_val"] === "true"){
                for(i=0; i< Constants.dbArabicLanguageElementsInit.length; i++){
                    console.log(Constants.dbArabicLanguageElementsInit[i]["name"], " - ", Constants.dbArabicLanguageElementsInit[i]["value"])
                    Storage.setLanguageDB(Constants.dbArabicLanguageElementsInit[i]["name"], Constants.dbArabicLanguageElementsInit[i]["value"])
                }
            }

            Storage.setLanguageDB("DB_INIT", "INIT") // Database already initialized tag

            Storage.saveLanguageDB()

//            Test data base settings
//            var num = Storage.getLanguageDB(Constants.dbLanguageSelectedLanguageId, "")
//            var id  = Storage.getLanguageDB(Constants.dbLanguageId + num , "")
//            console.log("DB selected language:   ", Storage.getLanguageDB(Constants.dbLanguageSelectedLanguageId, ""))
//            console.log("DB language name:       ", Storage.getLanguageDB(Constants.dbLanguageNameId + num, ""))
//            console.log("DB Number of languages: ", Storage.getLanguageDB(Constants.dbLanguageNumberOflanguagesId, ""))
//            console.log("DB Number of texts:     ", Storage.getLanguageDB(Constants.dbLanguageNumberOfTextsId, ""))
//            console.log("DB Text_0 :             ", Storage.getLanguageDB(Constants.dbLanguageTextId + id + "0", ""))
        }


//
//      Memory database init
//
        //DEB->debug.log(DC.dataBaseInitConsoleLog, "Memory database initialization...")

        if((Storage.getMemDB("DB_INIT", "NOT_INIT") !== "INIT") || (forceMemDataBaseInit) ){

            //DEB->debug.log(DC.dataBaseInitConsoleLog, "Starting memory database...")

            Storage.setMemDB(Constants.dataBaseVerId, Constants.dataBaseVer)  // register DB version

            // magnitude selector for each therapy init

            for (i = 0; i < Constants.optionId.length; i++){

                console.log("Database Init: memory database initialization " ,i)

                for (j = 0; j < Constants.inputSelector.length; j++){

                    for (k = 0; k < Constants.maxMemoryEntries; k++){
                        Storage.setMemDB(Constants.optionId[i] + "_" + Constants.inputSelector[j] + "_" + Constants.memoryId + k, "-")
                        console.log("Storage.setMemDB(Constants.optionId[i] + _ + Constants.inputSelector[j] + _ + Constants.memoryId + k, -): ", Constants.optionId[i] + "_" + Constants.inputSelector[j] + "_" + Constants.memoryId + k)


                        if(Constants.inputSelector[j] === Constants.inputO3SelectorId){

                            Storage.setMemDB(Constants.optionId[i] + "_" + Constants.inputSelector[j] + "_" + Constants.memoryRepeatId + k, "-")
                            console.log("Storage.setMemDB(Constants.optionId[i] + _ + Constants.inputSelector[j] + _ + Constants.memoryRepeatId + k, -): ", Constants.optionId[i] + "_" + Constants.inputSelector[j] + "_" + Constants.memoryRepeatId + k)

                            for (l = 0; l < Constants.memoryRepeatValueId.length; l++){
                                Storage.setMemDB(Constants.optionId[i] + "_" + Constants.inputSelector[j] + "_" + Constants.memoryRepeatValueId[l] + "_" + k, "-")
                                console.log("Storage.setMemDB(Constants.optionId[i] + _ + Constants.inputSelector[j] + _ + Constants.memoryRepeatValueId[l] + _ + k, -): ", Constants.optionId[i] + "_" + Constants.inputSelector[j] + "_" + Constants.memoryRepeatValueId[l] + "_" + k)
                            }

                        }
                    }
                }
                for (j = 0; j < Constants.inputSelectorNoStandard.length; j++){

                    for (k = 0; k < Constants.maxMemoryEntries; k++){
                        Storage.setMemDB(Constants.optionId[i] + "_" + Constants.inputSelectorNoStandard[j] + "_" + Constants.memoryId + k, "-")
                    }
                }

                // default name form memory board entries in each therapy in each lenguage
                var lenguageId = Storage.getLanguageDB(Constants.dbLanguageId + Number(Storage.getLanguageDB(Constants.dbLanguageSelectedLanguageId, "")) , "")

                for (j = 0; j < Constants.maxMemoryEntries; j++){
                    Storage.setMemDB(Constants.optionId[i] + "_" + Constants.memoryTextId + j, Storage.getLanguageDB(Constants.dbLanguageTextId + lenguageId + "58", "") + (j + 1))
                }
            }

            Storage.setMemDB("DB_INIT", "INIT") // Database already initialized tag

            Storage.saveMemDB()
        }else{
            //DEB->debug.log(DC.dataBaseInitConsoleLog, "Memory database already initialized.")
        }

        //DEB->debug.log(DC.dataBaseInitConsoleLog, "Memory database start up procces finished.")
    }
}
