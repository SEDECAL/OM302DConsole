.pragma library

// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.


//
// G L O B  A L S
//

// version control
var consoleSW = "V0.R0.P4"
var dataBaseVer = "V0.R0.P4" //change to P5 version directly on real DB genrated with dataBaseVer = "V0.R0.P4" -> change Pressión by Presion here:  dbLanguageTextId + spanishLanguageId + "8",  value: "Pressión" when new update needed
                             //                                                                                -> Release presure limmit has been reduced to 450 mbar in manual syringe (#4978)
// calibration parameters
var calibrationPressure = 0
var o3Sensorgain = 0
var periodIni = 0
var pressureCompensation = 0
var flowGainSector1 = 0
var flowGainSector2 = 0
var flowGainSector3 = 0
var oneMicrogramePulses = 0
var o3PulsesSector1 = 0
var o3PulsesSector2 = 0
var o3PulsesSector3 = 0

// paths
var targetPath = "file:///opt/OM302DConsole/"
// var developmentPath = "file:///your-local-build-path/"  // local development only, do not commit with a real path
var path = targetPath

// data base
var dataBaseVerId = "dataBaseVer"

// Other globals
var maxMemoryEntries = 10

//
// C O N S T A N T S
//

// Therapy IDs
var option1Id   = "option1"     // syringe
var option1_1Id = "option1_1"   // syringe
var option1_2Id = "option1_2"   // syringe manual
var option2Id   = "option2"     // saline hemo therapy
var option3Id   = "option3"     // bag
var option3_1Id = "option3_1"   // closed bag
var option3_2Id = "option3_2"   // open bag
var option4Id   = "option4"     // inssuflation
var option4_1Id = "option4_1"   // vaginal inssuflation
var option4_2Id = "option4_2"   // anal inssufaltion
var option5Id   = "option5"     // automotherapy
var option5_1Id = "option5_1"   // automotherapy (blood)
var option5_2Id = "option5_2"   // dose
var option6Id   = "option6"     // liquids ozonization
var option6_1Id = "option6_1"   // saline ozonization
var option6_2Id = "option6_2"   // water ozonization
var option6_3Id = "option6_3"   // oil ozonization
var option7Id   = "option7"     // vacuum
var option7_1Id = "option7_1"   // time vacuum
var option7_2Id = "option7_2"   // bottle vacuum
var optionId    = [option1Id, option1_1Id, option1_2Id, option2Id, option3Id, option3_1Id, option3_2Id, option4Id, option4_1Id, option4_2Id, option5Id, option5_1Id, option5_2Id, option6Id, option6_1Id, option6_2Id, option6_3Id, option7Id, option7_1Id, option7_2Id]

// Input selectors ID (standard selectors)
var inputBottleVolumeSelectorId = "inputBottleVolume"
var inputBloodVolumeSelectorId = "inputBloodVolume"
var inputLiquidVolumeSelectorId = "inputLiquidVolume"
var inputSalineVolumeSelectorId = "inputSalineVolume"
var inputO3SelectorId = "inputO3"
var inputFlowSelectorId = "inputFlow"
var inputTimeSelectorId = "inputTime"
var inputTotalConcentrationSelectorId = "inputTotalConcentration"
var inputTherapyTimeSelectorId = "inputTherapyTime"
var inputVacuumTimeSelectorId = "inputVacuumTime"
var inputVolumeSelectorId = "inputVolume"
var inputCleanTimeSelectorId = "inputCleanTime"
var inputPressureSelectorId = "inputPressure"
var inputIpSelectorId = "inputIp"
var inputReinfusionTimeSelectorId = "inputReinfusionTime"
var inputTimeVolumeSelectorId = "inputTimeVolume"
var inputVolumeDoseSelectorId = "inputVolumeDose"
var inputTimeDoseSelectorId = "inputTimeDose"
var inputSalineTimeSelectorId = "inputSalineTime"
var inputSelector = [inputBottleVolumeSelectorId, inputBloodVolumeSelectorId, inputLiquidVolumeSelectorId, inputSalineVolumeSelectorId, inputO3SelectorId, inputFlowSelectorId, inputTimeSelectorId, inputTotalConcentrationSelectorId, inputTherapyTimeSelectorId, inputVacuumTimeSelectorId, inputTimeVolumeSelectorId, inputVolumeDoseSelectorId, inputTimeDoseSelectorId, inputVolumeSelectorId, inputCleanTimeSelectorId, inputPressureSelectorId, inputIpSelectorId, inputReinfusionTimeSelectorId, inputSalineTimeSelectorId ]

// Input no standard selectors ID (no standard selectors)
var inputNormoOrHiperId = "inputNormoOrHiper"
var inputCyclesId = "inputCycles"
var inputPreviousVaccumYesNoId = "inputPreviousVaccumYesNo"
var inputRepeatCyclesId = "inputRepeatCycles"
var inputcycleValue1Id = "cycleValue1"
var inputcycleValue2Id = "cycleValue2"
var inputcycleValue3Id = "cycleValue3"
var inputcycleValue4Id = "cycleValue4"
var inputcycleValue5Id = "cycleValue5"
var inputSelectorNoStandard = [inputNormoOrHiperId, inputCyclesId, inputPreviousVaccumYesNoId, inputRepeatCyclesId, inputcycleValue1Id, inputcycleValue2Id, inputcycleValue3Id, inputcycleValue4Id, inputcycleValue5Id ]

// Fixed buttons ID
var fixedButton1Id = "fixButton1"
var fixedButton2Id = "fixButton2"
var fixedButton3Id = "fixButton3"
var fixedButton4Id = "fixButton4"
var fixedButton5Id = "fixButton5"
var fixedButtonId = [fixedButton1Id, fixedButton2Id, fixedButton3Id, fixedButton4Id, fixedButton5Id]

// Input configuration enabled ID
var configurationEnabledID = "config_enabled"

// Input range configuration enabled ID
var configureRangeEanbledID = "config_range_enabled"

// Input units configuration enabled ID
var configureUnitsEanbledID = "config_units_enabled"

// Slider units value ID
var sliderUnitsId = "slider_units"

// Slider units option A value ID
var sliderUnitsAId = "slider_units_A"

// Slider units option B value ID
var sliderUnitsBId = "slider_units_B"

// Slider values conversion factor for units A option
var unitsConversionFactorAId = "conv_factor_A"

// Slider values conversion factor for units B option
var unitsConversionFactorBId = "conv_factor_B"

// Slider init value ID
var sliderInitId = "slider_init"

// Slider max value ID
var sliderMaxId = "slider_max"

// Slider min value ID
var sliderMinId = "slider_min"

// Slider range (for configuration) max value ID
var sliderRangeMaxId = "slider_range_max"

// Slider range (for configuration) min value ID
var sliderRangeMinId = "slider_range_min"

// Slider range (for configuration) initial value ID (for special input controls without slider)
var initValuelId = "init_value"

// Different values on cycles
var diffValuesOnCyclesId = "diffValuesOnCycles"

// MemoryId
var memoryId = "mem"

// Memory repeat Id (for automotherapy only but generalized)
var memoryRepeatId = "mem_repeat"

// Memory repeat values Id (for automotherapy only but generalized)
var memoryRepeatValue1Id = "mem_repeat_value1"
var memoryRepeatValue2Id = "mem_repeat_value2"
var memoryRepeatValue3Id = "mem_repeat_value3"
var memoryRepeatValue4Id = "mem_repeat_value4"
var memoryRepeatValue5Id = "mem_repeat_value5"
var memoryRepeatValueId = [memoryRepeatValue1Id, memoryRepeatValue2Id, memoryRepeatValue3Id, memoryRepeatValue4Id, memoryRepeatValue5Id]

// Memory literal description text Id
var memoryTextId = "memText"

// Input configuration enabled for every teraphy and selector(optionXId)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var inputCongfigEnabledBottleVolume =            [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for O3 for every therapy
var inputCongfigEnabledBloodVolume =             [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for O3 for every therapy
var inputCongfigEnabledLiquidVolume =            [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for O3 for every therapy
var inputCongfigEnabledSalineVolume =            [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for O3 for every therapy
var inputCongfigEnabledO3 =                      [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for O3 for every therapy
var inputCongfigEnabledFlow =                    [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for flow for every therapy
var inputCongfigEnabledTime =                    [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for time for every therapy
var inputCongfigEnabledTotalConcentration =      [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for total concentration for every the
var inputCongfigEnabledTherapyTime =             [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for therapy time for every therapy
var inputCongfigEnabledVacuumTime =              [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for vacuum time for every therapy
var inputCongfigEnabledVolume =                  [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for volume for every therap
var inputCongfigEnabledCleanTime =               [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for clean time for every therap
var inputCongfigEnabledPressure =                [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for pressure for every therap
var inputCongfigEnabledIp =                      [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for pressure for every therap
var inputCongfigEnabledReinfusionTime =          [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for pressure for every therap
var inputCongfigEnabledTimeVolume =              [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for time&volume for every therapy
var inputCongfigEnabledVolumeDose =              [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for volume&Dose for every therap
var inputCongfigEnabledTimeDose =                [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for time&Dose for every therap
var inputCongfigEnabledSalineTime =              [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input config enabled for saline time for every therap

// Input range configuration enabled for every teraphy and selector(optionXId)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var inputCongfigRangeEnabledBottleVolume =       [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for O3 for every therapy
var inputCongfigRangeEnabledBloodVolume =        [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for O3 for every therapy
var inputCongfigRangeEnabledLiquidVolume =       [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for O3 for every therapy
var inputCongfigRangeEnabledSalineVolume =       [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for O3 for every therapy
var inputCongfigRangeEnabledO3 =                 [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for O3 for every therapy
var inputCongfigRangeEnabledFlow =               [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for flow for every therapy
var inputCongfigRangeEnabledTime =               [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for time for every therapy
var inputCongfigRangeEnabledTotalConcentration = [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for total concentration for eve
var inputCongfigRangeEnabledTherapyTime =        [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for therapy time for every ther
var inputCongfigRangeEnabledVacuumTime =         [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for vacuum time for every thera
var inputCongfigRangeEnabledVolume =             [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for volume for every
var inputCongfigRangeEnabledCleanTime =          [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for clean time for every
var inputCongfigRangeEnabledPressure =           [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for pressure for every
var inputCongfigRangeEnabledIp =                 [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for pressure for every
var inputCongfigRangeEnabledReinfusionTime =     [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for pressure for every
var inputCongfigRangeEnabledTimeVolume =         [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for time&volume for every thera
var inputCongfigRangeEnabledVolumeDose =         [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for volume&Dose for every
var inputCongfigRangeEnabledTimeDose =           [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for time&Dose for every
var inputCongfigRangeEnabledSalineTime =         [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input range config enabled for pressure for every

// Input units configuration enabled for every teraphy and selector(optionXId)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var inputCongfigUnitsEnabledBottleVolume =       [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for O3 for every therapy
var inputCongfigUnitsEnabledBloodVolume =        [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for O3 for every therapy
var inputCongfigUnitsEnabledLiquidVolume =       [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for O3 for every therapy
var inputCongfigUnitsEnabledSalineVolume =       [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for O3 for every therapy
var inputCongfigUnitsEnabledO3 =                 [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for O3 for every therapy
var inputCongfigUnitsEnabledFlow =               [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for flow for every therapy
var inputCongfigUnitsEnabledTime =               [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for time for every therapy
var inputCongfigUnitsEnabledTotalConcentration = [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for total concentration for eve
var inputCongfigUnitsEnabledTherapyTime =        [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for therapy time for every ther
var inputCongfigUnitsEnabledVacuumTime =         [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for vacuum time for every thera
var inputCongfigUnitsEnabledVolume =             [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for volume for every
var inputCongfigUnitsEnabledCleanTime =          [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for clean time for every
var inputCongfigUnitsEnabledPressure =           [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for pressure for every
var inputCongfigUnitsEnabledIp =                 [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for pressure for every
var inputCongfigUnitsEnabledReinfusionTime =     [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for pressure for every
var inputCongfigUnitsEnabledTimeVolume =         [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for time&volume for every thera
var inputCongfigUnitsEnabledVolumeDose =         [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for volume&Dose for every
var inputCongfigUnitsEnabledTimeDose =           [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for time&Dose for every
var inputCongfigUnitsEnabledSalineTime =         [        "true",        "true",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",       "false",        "true",        "true",        "true",        "true",        "true",        "true" ] //  input units config enabled for pressure for every

// Slider units in every teraphy and selector(optionXId)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var sliderUnitsBottleVolume =                    [          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml" ] //  slider units for O3 for every therapy
var sliderUnitsBloodVolume =                     [          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml" ] //  slider units for O3 for every therapy
var sliderUnitsLiquidVolume =                    [          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml" ] //  slider units for O3 for every therapy
var sliderUnitsSalineVolume =                    [          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml" ] //  slider units for O3 for every therapy
var sliderUnitsO3 =                              [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ] //  slider units for O3 for every therapy
var sliderUnitsFlow =                            [         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ] //  slider units for flow for every therapy
var sliderUnitsTime =                            [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ] //  slider units for time for every therapy
var sliderUnitsTotalConcentration =              [     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg" ] //  slider units for total concentration for every therapy
var sliderUnitsTherapyTime =                     [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ] //  slider units for therapy time for every therapy
var sliderUnitsVacuumTime =                      [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ] //  slider units for vacuum time for every therapy
var sliderUnitsVolume =                          [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",          "ml",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ] //  slider units for volume for every therapy
var sliderUnitsCleanTime =                       [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ] //  slider units for clean time for every therapy
var sliderUnitsPressure =                        [        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar" ] //  slider option A units for pressure for every therapy
var sliderUnitsIp =                              [           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " " ] //  slider units for pressure for every therapy
var sliderUnitsReinfusionTime =                  [           " ",           " ",           " ",         "min",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " " ] //  slider units for pressure for every therapy
var sliderUnitsTimeVolume =                      [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",      "min~ml",      "min~ml",      "min~ml",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ] //  slider units for time&volume for every therapy
var sliderUnitsVolumeDose =                      [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ] //  slider units for time&volume for every therapy
var sliderUnitsTimeDose =                        [ "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg" ] //  slider units for time&Dose for every therapy
var sliderUnitsSalineTime =                      [           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " " ] //  slider units for pressure for every therapy

// Slider option A units in every teraphy and selector(optionXId)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var sliderUnitsABottleVolume =                   [          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml" ] //  slider option A units for O3 for every therapy
var sliderUnitsABloodVolume =                    [          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml" ] //  slider option A units for O3 for every therapy
var sliderUnitsALiquidVolume =                   [          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml" ] //  slider option A units for O3 for every therapy
var sliderUnitsASalineVolume =                   [          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml" ] //  slider option A units for O3 for every therapy
var sliderUnitsAO3 =                             [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ] //  slider option A units for O3 for every therapy
var sliderUnitsAFlow =                           [         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ] //  slider option A units for flow for every therapy
var sliderUnitsATime =                           [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ] //  slider option A units for time for every therapy
var sliderUnitsATotalConcentration =             [     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg" ] //  slider option A units for total concentration for every th
var sliderUnitsATherapyTime =                    [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ] //  slider option A units for therapy time for every therapy
var sliderUnitsAVacuumTime =                     [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ] //  slider option A units for vacuum time for every therapy
var sliderUnitsAVolume =                         [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",          "ml",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ] //  slider option A units for volume for every thera
var sliderUnitsACleanTime =                      [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ] //  slider option A units for clean time for every therapy
var sliderUnitsAPressure =                       [        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar",        "mbar" ] //  slider option A units for pressure for every therapy
var sliderUnitsAIp =                             [           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " " ] //  slider option A units for pressure for every therapy
var sliderUnitsAReinfusionTime =                 [           " ",           " ",           " ",         "min",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " " ] //  slider option A units for pressure for every therapy
var sliderUnitsATimeVolume =                     [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",      "min~ml",      "min~ml",      "min~ml",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ] //  slider option A units for time&volume for every therapy
var sliderUnitsAVolumeDose =                     [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ] //  slider option A units for volume&Dose for every thera
var sliderUnitsATimeDose =                       [ "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg" ] //  slider option A units for time&Dose time for every therapy
var sliderUnitsASalineTime =                     [           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " " ] //  slider option A units for pressure for every therapy

// Slider option B units in every teraphy and selector(optionXId)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var sliderUnitsBBottleVolume =                   [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ] //  slider option B units for O3 for every therapy
var sliderUnitsBBloodVolume =                    [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ] //  slider option B units for O3 for every therapy
var sliderUnitsBLiquidVolume =                   [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ] //  slider option B units for O3 for every therapy
var sliderUnitsBSalineVolume =                   [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ] //  slider option B units for O3 for every therapy
var sliderUnitsBO3 =                             [      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml" ] //  slider option B units for O3 for every therapy
var sliderUnitsBFlow =                           [       "l/min",       "l/min",       "l/min",       "l/min",         "l/h",         "l/h",         "l/h",       "l/min",       "l/min",       "l/min",       "l/min",       "l/min",       "l/min",       "l/min",       "l/min",       "l/min",       "l/min",       "l/min",       "l/min",       "l/min" ] //  slider option B units for flow for every therapy
var sliderUnitsBTime =                           [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ] //  slider option B units for time for every therapy
var sliderUnitsBTotalConcentration =             [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ] //  slider option B units for total concentration for every th
var sliderUnitsBTherapyTime =                    [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ] //  slider option B units for therapy time for every therapy
var sliderUnitsBVacuumTime =                     [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ] //  slider option B units for vacuum time for every therapy
var sliderUnitsBVolume =                         [          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml",          "ml" ] //  slider option B units for volume for every thera
var sliderUnitsBCleanTime =                      [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ] //  slider option B units for clean time for every therapy
var sliderUnitsBPressure =                       [         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi",         "Psi" ] //  slider option B units for pressure for every therapy
var sliderUnitsBIp =                             [          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP" ] //  slider option B units for pressure for every therapy
var sliderUnitsBReinfusionTime =                 [          "IP",          "IP",          "IP",         "min",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP",          "IP" ] //  slider option B units for pressure for every therapy
var sliderUnitsBTimeVolume =                     [      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",       "min~l",       "min~l",       "min~l",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml" ] //  slider option B units for time&volume for every therapy
var sliderUnitsBVolumeDose =                     [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ] //  slider option B units for volume&Dose for every thera
var sliderUnitsBTimeDose =                       [ "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg", "sec~\u03BCg" ] //  slider option B units for time&Dose time for every therapy
var sliderUnitsBSalineTime =                     [           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " ",           " " ] //  slider option A units for pressure for every therapy

// Slider conversion units factor in every teraphy and selector for A units(optionXId)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var conversionFactorABottleVolume =              [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for O3 for every therapy
var conversionFactorABloodVolume =               [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for O3 for every therapy
var conversionFactorALiquidVolume =              [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for O3 for every therapy
var conversionFactorASalineVolume =              [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for O3 for every therapy
var conversionFactorAO3 =                        [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for O3 for every therapy
var conversionFactorAFlow =                      [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for flow for every therapy
var conversionFactorATime =                      [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for time for every therapy
var conversionFactorATotalConcentration =        [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for total concentration for eve
var conversionFactorATherapyTime =               [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for therapy time for every ther
var conversionFactorAVacuumTime =                [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for vacuum time for every thera
var conversionFactorAVolume =                    [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for volume for every
var conversionFactorACleanTime =                 [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for clean time for every thera
var conversionFactorAPressure =                  [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for pressure for every thera
var conversionFactorAIp =                        [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for pressure for every thera
var conversionFactorAReinfusionTime =            [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for pressure for every thera
var conversionFactorATimeVolume =                [     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",         "1~1",         "1~1",         "1~1",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ] //  slider conversion factor A for time&volume for every thera
var conversionFactorAVolumeDose =                [         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ] //  slider conversion factor A for volume&Dose for every
var conversionFactorATimeDose =                  [         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ] //  slider conversion factor A for time&Dose for every
var conversionFactorASalineTime =                [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for pressure for every thera

// Slider conversion units factor in every teraphy and selector for B units(optionXId)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var conversionFactorBBottleVolume =              [       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ] //  slider conversion factor B for O3 for every therapy
var conversionFactorBBloodVolume =               [       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ] //  slider conversion factor B for O3 for every therapy
var conversionFactorBLiquidVolume =              [       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ] //  slider conversion factor B for O3 for every therapy
var conversionFactorBSalineVolume =              [       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ] //  slider conversion factor B for O3 for every therapy
var conversionFactorBO3 =                        [       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ] //  slider conversion factor B for O3 for every therapy
var conversionFactorBFlow =                      [    "0.016666",    "0.016666",    "0.016666",    "0.016666",           "1",           "1",           "1",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666" ] //  slider conversion factor B flow for every therapy
var conversionFactorBTime =                      [          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60" ] //  slider conversion factor B for time for every therapy
var conversionFactorBTotalConcentration =        [       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ] //  slider conversion factor B for total concentration for eve
var conversionFactorBTherapyTime =               [          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60",          "60" ] //  slider conversion factor B for therapy time for every ther
var conversionFactorBVacuumTime =                [    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666" ] //  slider conversion factor B for vacuum time for every thera
var conversionFactorBVolume =                    [        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ] //  slider conversion factor B for volume for every
var conversionFactorBCleanTime =                 [    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666" ] //  slider conversion factor B for clean time for every thera
var conversionFactorBPressure =                  [   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038",   "0.0145038" ] //  slider conversion factor B for pressure for every
var conversionFactorBIp =                        [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor B for pressure for every thera
var conversionFactorBReinfusionTime =            [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor B for pressure for every thera
var conversionFactorBTimeVolume =                [         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",     "1~0.001",     "1~0.001",     "1~0.001",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ] //  slider conversion factor B for time&volume for every thera
var conversionFactorBVolumeDose =                [         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ] //  slider conversion factor B for volume&Dose for every
var conversionFactorBTimeDose =                  [        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1",        "60~1" ] //  slider conversion factor B for time&Dose for every
var conversionFactorBSalineTime =                [           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ] //  slider conversion factor A for pressure for every thera

// Slider initial values in every teraphy and selector(optionXId) (introduce values in equipment oficial values)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var sliderInitBottleVolume =                     [           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500 ] //  slider init value for O3 for every therapy
var sliderInitBloodVolume =                      [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider init value for O3 for every therapy
var sliderInitLiquidVolume =                     [           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250,           250 ] //  slider init value for O3 for every therapy
var sliderInitSalineVolume =                     [           100,           100,           100,           200,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider init value for O3 for every therapy
var sliderInitO3 =                               [            15,            15,            15,            10,            40,            40,            40,            30,            30,            20,            15,            15,            15,             5,             5,            15,            60,            15,            15,            15 ] //  slider init value for O3 for every therapy
var sliderInitFlow =                             [            20,            20,            30,            20,            30,            30,            30,            10,            10,            10,            30,            30,            30,            20,            20,            20,            30,            30,            30,            30 ] //  slider init value for flow for every therapy
var sliderInitTime =                             [            15,            15,            15,            15,            15,            15,            15,            10,            10,            10,            15,            15,            15,            15,            15,            15,            20,            15,            15,            15 ] //  slider init value for time for every therapy
var sliderInitTotalConcentration =               [            50,            50,            50,          1500,            50,            50,            50,            50,            50,            50,             1,             1,          1500,             1,             1,             1,             1,            50,            50,            50 ] //  slider init value for total concentration for every therapy
var sliderInitTherapyTime =                      [            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20,            20 ] //  slider init value for therapy time for every therapy
var sliderInitVacuumTime =                       [            30,            30,            30,            60,            30,            30,            30,            30,            30,            30,            30,            60,            60,            30,            30,            30,            30,            30,            30,           120 ] //  slider init value for vacuum time for every therapy
var sliderInitVolume =                           [             1,             1,             1,             1,             1,             5,             1,             1,             1,           200,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider init value for volume for every therapy
var sliderInitCleanTime =                        [            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50 ] //  slider init value for clean time for every therapy
var sliderInitPressure =                         [             1,             1,             1,           700,             1,             1,             1,             1,             1,             1,           600,           600,             1,             1,             1,             1,             1,             1,             1,           600 ] //  slider init value for pressure for every therapy
var sliderInitIp =                               [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,           600,           600,             1,             1,             1,             1,             1,             1,             1,           600 ] //  slider init value for pressure for every therapy
var sliderInitReinfusionTime =                   [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,           600,           600,             1,             1,             1,             1,             1,             1,             1,           600 ] //  slider init value for pressure for every therapy
var sliderInitTimeVolume =                       [            50,            50,            50,            50,          1000,          1000,          1000,             0,          1000,          1000,            53,            53,            50,            50,            50,            50,            50,            50,            50,            51 ] //  slider init value for time&volume for every therapy
var sliderInitVolumeDose =                       [          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3000,          3001 ] //  slider init value for volume&Dose for every therapy
var sliderInitTimeDose =                         [           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           700,           701 ] //  slider init value for time&Dose for every therapy
var sliderInitSalineTime =                       [             1,             1,             1,            10,             1,             1,             1,             1,             1,             1,           600,           600,             1,             1,             1,             1,             1,             1,             1,           600 ] //  slider init value for pressure for every therapy

// Slider maximun values in every teraphy and selector(optionXId) (introduce values in equipment oficial values)
//
//                                                     option1Id    option1I_1d    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var sliderMaxBottleVolume =                      [          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000 ] //  slider max value for O3 for every therapy
var sliderMaxBloodVolume =                       [          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000 ] //  slider max value for O3 for every therapy
var sliderMaxLiquidVolume =                      [          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000 ] //  slider max value for O3 for every therapy
var sliderMaxSalineVolume =                      [          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000 ] //  slider max value for O3 for every therapy
var sliderMaxO3 =                                [            80,            80,            80,            80,            80,            80,            80,            60,            60,            60,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80 ] //  slider max value for O3 for every therapy
var sliderMaxFlow =                              [            50,            50,            50,            50,            50,            50,            50,            30,            30,            30,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50 ] //  slider max value for flow for every therapy
var sliderMaxTime =                              [            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30 ] //  slider max value for time for every therapy
var sliderMaxTotalConcentration =                [         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000 ] //  slider max value for total concentration for every therapy
var sliderMaxTherapyTime =                       [            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30 ] //  slider max value for therapy time for every therapy
var sliderMaxVacuumTime =                        [           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           120,           120,           120,           120,           120,           600,           120 ] //  slider max value for vacuum time for every therapy
var sliderMaxVolume =                            [           100,           100,           100,           100,            10,            30,            10,          1000,          1000,          1000,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider max value for volume for every therapy
var sliderMaxCleanTime =                         [           180,           180,           180,           180,           300,           180,           300,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180 ] //  slider max value for clean time for every therapy
var sliderMaxPressure =                          [           100,           100,           100,           600,           100,           100,           100,           100,           100,           100,           700,           600,           100,           100,           100,           100,           100,           100,           100,           800 ] //  slider max value for pressure for every therapy
var sliderMaxIp =                                [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           700,           700,           100,           100,           100,           100,           100,           100,           100,           800 ] //  slider max value for pressure for every therapy
var sliderMaxReinfusionTime =                    [           100,           100,           100,            30,           100,           100,           100,           100,           100,           100,           700,           700,           100,           100,           100,           100,           100,           100,           100,           800 ] //  slider max value for pressure for every therapy
var sliderMaxTimeVolume =                        [          6001,          6001,          6001,          6000,         10000,         10000,         10000,             0,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000 ] //  slider max value for timwe&volume for every therapy
var sliderMaxVolumeDose =                        [            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10 ] //  slider max value for volume&Dose for every therapy
var sliderMaxTimeDose =                          [         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000,         90000 ] //  slider max value for time&Dose for every therapy
var sliderMaxSalineTime =                        [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           700,           700,           100,           100,           100,           100,           100,           100,           100,           800 ] //  slider max value for pressure for every therapy

// Slider minimun values in every teraphy and selector(optionXId) (introduce values in equipment oficial values)
//
//                                                     option1Id    option1_1Id    option1_2Id       option2Id     option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id     option5_2Id     option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var sliderMinBottleVolume =                      [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,            20,            20,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider min value for O3 for every therapy
var sliderMinBloodVolume =                       [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider min value for O3 for every therapy
var sliderMinLiquidVolume =                      [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,            10,             1,             1,             1,             1,             1 ] //  slider min value for O3 for every therapy
var sliderMinSalineVolume =                      [             1,             1,             1,            10,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider min value for O3 for every therapy
var sliderMinO3 =                                [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider min value for O3 for every therapy
var sliderMinFlow =                              [            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10 ] //  slider min value for flow for every therapy
var sliderMinTime =                              [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider min value for time for every therapy
var sliderMinTotalConcentration =                [           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,             1,             1,           500,             1,             1,             1,             1,           500,           500,           500 ] //  slider min value for total concentration for every therapy
var sliderMinTherapyTime =                       [             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5 ] //  slider min value for therapy time for every therapy
var sliderMinVacuumTime =                        [            15,            15,            15,            15,            10,            10,            10,            15,            15,            15,             1,             1,            15,            10,            10,            10,            10,             5,             5,             5 ] //  slider min value for vacuum time for every therapy
var sliderMinVolume =                            [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider min value for volume for every therapy
var sliderMinCleanTime =                         [            15,            15,            15,            15,            10,            15,            10,            15,            15,            15,            10,            10,            15,            10,            10,            10,            10,            10,            10,            10 ] //  slider min value for clean time for every therapy
var sliderMinPressure =                          [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,           100 ] //  slider min value for pressure for every therapy
var sliderMinIp =                                [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,           100 ] //  slider min value for pressure for every therapy
var sliderMinReinfusionTime =                    [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,           100 ] //  slider min value for pressure for every therapy
var sliderMinTimeVolume =                        [            10,            10,            10,            10,          1000,          1000,          1000,             0,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10 ] //  slider min value for timwe&volume for every therapy
var sliderMinVolumeDose =                        [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider min value for volume&Dose for every therapy
var sliderMinTimeDose =                          [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider min value for time&Dose for every therapy
var sliderMinSalineTime =                        [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,           100 ] //  slider min value for pressure for every therapy

// Slider maximun range values (for configuration) in every teraphy and selector(optionXId) (introduce values in equipment oficial values)
//
//                                                     option1Id    option1_1Id    option1_2Id       option2Id     option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id     option5_2Id     option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var sliderRangeMaxBottleVolume =                 [          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000 ] //  slider range max value for O3 for every therapy
var sliderRangeMaxBloodVolume =                  [          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000 ] //  slider range max value for O3 for every therapy
var sliderRangeMaxLiquidVolume =                 [          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000 ] //  slider range max value for O3 for every therapy
var sliderRangeMaxSalineVolume =                 [          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000,          1000 ] //  slider range max value for O3 for every therapy
var sliderRangeMaxO3 =                           [            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80,            80 ] //  slider range max value for O3 for every therapy
var sliderRangeMaxFlow =                         [            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50,            50 ] //  slider range max value for flow for every therapy
var sliderRangeMaxTime =                         [            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30 ] //  slider range max value for time for every therapy
var sliderRangeMaxTotalConcentration =           [         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000,         40000 ] //  slider range max value for total concentration for every therapy
var sliderRangeMaxTherapyTime =                  [            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30,            30 ] //  slider range max value for therapy time for every therapy
var sliderRangeMaxVacuumTime =                   [           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           180,           120,           120,           120,           120,           120,           120,           120 ] //  slider range max value for vacuum time for every therapy
var sliderRangeMaxVolume =                       [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider range max value for volume for every therapy
var sliderRangeMaxCleanTime =                    [           180,           180,           180,           180,           180,           180,          1200,           180,           180,           180,           180,           180,           180,           120,           120,           120,           120,           120,           120,           120 ] //  slider range max value for clean time for every therapy
var sliderRangeMaxPressure =                     [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider range max value for pressure for every therapy
var sliderRangeMaxIp =                           [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider range max value for pressure for every therapy
var sliderRangeMaxReinfusionTime =               [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider range max value for pressure for every therapy
var sliderRangeMaxTimeVolume =                   [          6000,          6000,          6000,          6000,            50,            50,            50,             0,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000,          6000 ] //  slider range max value for timwe&volume for every therapy
var sliderRangeMaxVolumeDose =                   [            10,            10,            10,            10,         10000,         10000,         10000,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10 ] //  slider range max value for volume&Dose for every therapy
var sliderRangeMaxTimeDose =                     [            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,         40000,         40000,         40000,         40000,            10,            10,            10 ] //  slider range max value for time&Dose for every therapy
var sliderRangeMaxSalineTime =                   [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider range max value for pressure for every therapy

// Slider minimun range values (for configuration) in every teraphy and selector(optionXId) (introduce values in equipment oficial values)
//
//                                                     option1Id    option1_1Id    option1_2Id       option2Id     option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id     option5_2Id     option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var sliderRangeMinBottleVolume =                 [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider range min value for O3 for every therapy
var sliderRangeMinBloodVolume =                  [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider range min value for O3 for every therapy
var sliderRangeMinLiquidVolume =                 [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider range min value for O3 for every therapy
var sliderRangeMinSalineVolume =                 [           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100,           100 ] //  slider range min value for O3 for every therapy
var sliderRangeMinO3 =                           [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider range min value for O3 for every therapy
var sliderRangeMinFlow =                         [            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10 ] //  slider range min value for flow for every therapy
var sliderRangeMinTime =                         [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider range min value for time for every therapy
var sliderRangeMinTotalConcentration =           [           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500,           500 ] //  slider range min value for total concentration for every therapy
var sliderRangeMinTherapyTime =                  [             5,             5,             5,             5,             5,             1,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5,             5 ] //  slider range min value for therapy time for every therapy
var sliderRangeMinVacuumTime =                   [            15,            15,            15,            15,            15,            15,            15,            15,            15,            15,            15,            15,            15,            10,            10,            10,            10,            10,            10,            10 ] //  slider range min value for vacuum time for every therapy
var sliderRangeMinVolume =                       [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider range min value for volume for every therapy
var sliderRangeMinCleanTime =                    [            15,            15,            15,            15,            15,            15,             1,            15,            15,            15,            15,            15,            15,            10,            10,            10,            10,            10,            10,            10 ] //  slider range min value for clean time for every therapy
var sliderRangeMinPressure =                     [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider range min value for pressure for every therapy
var sliderRangeMinIp =                           [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider range min value for pressure for every therapy
var sliderRangeMinReinfusionTime =               [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider range min value for pressure for every therapy
var sliderRangeMinTimeVolume =                   [            10,            10,            10,            10,          1000,          1000,          1000,             0,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10,            10 ] //  slider range min value for timwe&volume for every therapy
var sliderRangeMinVolumeDose =                   [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider range min value for volume&Dose for every therapy
var sliderRangeMinTimeDose =                     [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider range min value for time&Dose for every therapy
var sliderRangeMinSalineTime =                   [             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1,             1 ] //  slider range min value for pressure for every therapy

// Slider minimun range values (for configuration) in every teraphy and selector(optionXId) (introduce values in equipment oficial values)
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var diffValuesOnCyclesBottleVolume =             [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for O3 for every therapy
var diffValuesOnCyclesBloodVolume =              [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for O3 for every therapy
var diffValuesOnCyclesLiquidVolume =             [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for O3 for every therapy
var diffValuesOnCyclesSalineVolume =             [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for O3 for every therapy
var diffValuesOnCyclesO3 =                       [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for O3 for every therapy
var diffValuesOnCyclesFlow =                     [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for flow for every therapy
var diffValuesOnCyclesTime =                     [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for time for every therapy
var diffValuesOnCyclesTotalConcentration =       [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for total concentration for every therapy
var diffValuesOnCyclesTherapyTime =              [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for therapy time for every therapy
var diffValuesOnCyclesVacuumTime =               [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for vacuum time for every therapy
var diffValuesOnCyclesVolume =                   [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for volume for every therapy
var diffValuesOnCyclesCleanTime =                [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for clean time for every therapy
var diffValuesOnCyclesPressure =                 [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for pressure for every therapy
var diffValuesOnCyclesIp =                       [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for pressure for every therapy
var diffValuesOnCyclesReinfusionTime=            [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for pressure for every therapy
var diffValuesOnCyclesTimeVolume =               [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for timwe&volume for every therapy
var diffValuesOnCyclesVolumeDose =               [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for volume&Dose for every therapy
var diffValuesOnCyclesTimeDose =                 [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for time&Dose for every therapy
var diffValuesOnCyclesSalineTime =               [       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  slider range min value for pressure for every therapy


// Initial values in every teraphy for special input selsetors
//
//                                                     option1Id    option1_1Id    option1_2Id      option2Id      option3Id    option3_1Id    option3_2Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id    option7_1Id    option7_2Id
var initNormoOrHiper =                           [           "-",           "-",           "-",           "-",           "-",           "-",           "-",           "-",           "-",           "-",           "N",           "N",           "-",           "-",           "-",           "-",           "-",           "-",           "-",           "-" ] //  init value for Normo or Hiper for every therapy
var initInputCycles =                            [             0,             0,             0,             0,             0,             0,             0,             0,             0,             0,             1,             1,             0,             0,             0,             0,             0,             0,             0,             0 ] //  init value for input cycles for every therapy
var initPreviousVaccumYesNo =                    [       "false",       "false",       "false",        "true",       "false",       "false",       "false",       "false",       "false",       "false",       "false",        "true",       "false",       "false",       "false",       "false",       "false",       "false",       "false",       "false" ] //  init value for previous vaccum yes no

// Fixed buttons values in every teraphy and selector(optionXId)
//
//
var fixedButtonBottleVolume =[
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 1   (option1ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 1_1 (option1_1ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 1_2 (option1_2ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 2   (option2ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 3   (option3ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 3_1 (option3_1ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 3_2 (option3_2ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 4   (option4ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 4_1 (option4_1ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 4_2 (option4_2ID)
/*  -->  */ [100, 250, 500, 750, 1000],   // O3 fixed buttons for teraphy 5   (option5ID)
/*  -->  */ [100, 250, 500, 750, 1000],   // O3 fixed buttons for teraphy 5_1 (option5_1ID)
/*  -->  */ [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 5_2 (option5_2ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 6   (option6ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 6_1 (option6_1ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 6_2 (option6_2ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 6_3 (option6_3ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 7   (option7ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 7_1 (option7_1ID)
            [  1,   1,   1,   1,    1],   // O3 fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonBloodVolume =[
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 1   (option1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 1_1 (option1_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 1_2 (option1_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 2   (option2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 3   (option3ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 3_1 (option3_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 3_2 (option3_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 4   (option4ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 4_1 (option4_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 4_2 (option4_2ID)
/*  -->  */ [ 50, 125, 250, 375, 500],   // O3 fixed buttons for teraphy 5   (option5ID)
/*  -->  */ [ 50, 125, 250, 375, 500],   // O3 fixed buttons for teraphy 5_1 (option5_1ID)
/*  -->  */ [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 5_2 (option5_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 6   (option6ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 6_1 (option6_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 6_2 (option6_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 6_3 (option6_3ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 7   (option7ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 7_1 (option7_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonLiquidVolume =[
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 1   (option1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 1_1 (option1_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 1_2 (option1_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 2   (option2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 3   (option3ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 3_1 (option3_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 3_2 (option3_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 4   (option4ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 4_1 (option4_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 4_2 (option4_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 5   (option5ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 5_1 (option5_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 5_2 (option5_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 6   (option6ID)
/*  -->  */ [ 50, 125, 250, 375, 500],   // O3 fixed buttons for teraphy 6_1 (option6_1ID)
/*  -->  */ [ 50, 125, 250, 375, 500],   // O3 fixed buttons for teraphy 6_2 (option6_2ID)
/*  -->  */ [ 50, 125, 250, 375, 500],   // O3 fixed buttons for teraphy 6_3 (option6_3ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 7   (option7ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 7_1 (option7_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonSalineVolume =[
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 1   (option1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 1_1 (option1_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 1_2 (option1_2ID)
            [100, 200, 300, 400, 500],   // O3 fixed buttons for teraphy 2   (option2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 3   (option3ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 3_1 (option3_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 3_2 (option3_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 4   (option4ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 4_1 (option4_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 4_2 (option4_2ID)
/*  -->  */ [ 50, 125, 250, 375, 500],   // O3 fixed buttons for teraphy 5   (option5ID)
/*  -->  */ [ 50, 125, 250, 375, 500],   // O3 fixed buttons for teraphy 5_1 (option5_1ID)
/*  -->  */ [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 5_2 (option5_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 6   (option6ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 6_1 (option6_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 6_2 (option6_2ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 6_3 (option6_3ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 7   (option7ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 7_1 (option7_1ID)
            [  1,   1,   1,   1,   1],   // O3 fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonO3 =[
            [ 1,  1,  1,  1,  1],   // O3 fixed buttons for teraphy 1   (option1ID)
/*  -->  */ [10, 20, 30, 40, 50],   // O3 fixed buttons for teraphy 1_1 (option1_1ID)
/*  -->  */ [10, 20, 30, 40, 50],   // O3 fixed buttons for teraphy 1_2 (option1_2ID)
/*  -->  */ [10, 20, 30, 40, 80],   // O3 fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // O3 fixed buttons for teraphy 3   (option3ID)
/*  -->  */ [40, 50, 60, 70, 80],   // O3 fixed buttons for teraphy 3_1 (option3_1ID)
/*  -->  */ [40, 50, 60, 70, 80],   // O3 fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // O3 fixed buttons for teraphy 4   (option4ID)
/*  -->  */ [ 5, 10, 15, 20, 30],   // O3 fixed buttons for teraphy 4_1 (option4_1ID)
/*  -->  */ [ 5, 10, 15, 20, 30],   // O3 fixed buttons for teraphy 4_2 (option4_2ID)
/*  -->  */ [ 5, 10, 15, 20, 30],   // O3 fixed buttons for teraphy 5   (option5ID)
/*  -->  */ [ 5, 10, 15, 20, 30],   // O3 fixed buttons for teraphy 5_1 (option5_1ID)
/*  -->  */ [10, 20, 30, 40, 50],   // O3 fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // O3 fixed buttons for teraphy 6   (option6ID)
/*  -->  */ [ 5, 10, 15, 20, 30],   // O3 fixed buttons for teraphy 6_1 (option6_1ID)
/*  -->  */ [ 5, 10, 15, 20, 30],   // O3 fixed buttons for teraphy 6_2 (option6_2ID)
/*  -->  */ [40, 50, 60, 70, 80],   // O3 fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // O3 fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // O3 fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // O3 fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonFlow =[
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 1_1 (option1_1ID)
/*  -->  */ [10, 20, 30, 40, 50],   // Flow fixed buttons for teraphy 1_2 (option1_2ID)
            [10, 20, 30, 40, 50],   // Flow fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 3_1 (option3_1ID)
/*  -->  */ [30, 35, 40, 45, 50],   // Flow fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 4   (option4ID)
/*  -->  */ [10, 15, 20, 25, 30],   // Flow fixed buttons for teraphy 4_1 (option4_1ID)
/*  -->  */ [10, 15, 20, 25, 30],   // Flow fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Flow fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonTime =[
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 3_1 (option3_1ID)
/*  -->  */ [ 5, 10, 15, 20, 25],   // Time fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 4   (option4ID)
/*  -->  */ [ 5, 10, 15, 20, 25],   // Time fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 6   (option6ID)
/*  -->  */ [ 5, 10, 15, 20, 25],   // Time fixed buttons for teraphy 6_1 (option6_1ID)
/*  -->  */ [ 5, 10, 15, 20, 25],   // Time fixed buttons for teraphy 6_2 (option6_2ID)
/*  -->  */ [ 5, 10, 15, 20, 25],   // Time fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Time fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonTotalConcentration =[
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 1_2 (option1_2ID)
[1000, 2000, 4000, 10000, 30000],   // Total concentration fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 4_2 (option4_2ID)
/*  -->  */ [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 5   (option5ID)
/*  -->  */ [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 5_1 (option5_1ID)
[1000, 2000, 4000, 10000, 30000],   // Total concentration fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 6   (option6ID)
/*  -->  */ [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 6_1 (option6_1ID)
/*  -->  */ [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 6_2 (option6_2ID)
/*  -->  */ [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Total concentration fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonTherapyTime =[
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 3   (option3ID)
/*  -->  */ [10, 15, 20, 25, 30],   // Therapy time fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Therapy time fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonVacuumTime =[
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3   (option3ID)
/*  -->  */ [30, 60, 90,120,150],   // Vacumm time fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7   (option7ID)
/*  -->  */ [30,120,240,360,480],   // Vacumm time fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonVolume =[
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 3   (option3ID)
/*  -->  */ [ 2,  4,  6,  8, 10],   // Volume fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 4_1 (option4_1ID)
/*  -->  */ [20,100,200,500,800],   // Volume fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Volume fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonCleanTime =[
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_1 (option3_1ID)
/*  -->  */ [30,100,150,200,250],   // Vacumm time fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonPressure =[
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_1 (option7_1ID)
       [150, 300, 450, 600, 750],   // Vacumm time fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonIp =[
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonTimeVolume =[
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Time&volume fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonVolumeDose =[
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonTimeDose =[
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Volume&Dose fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonReinfusionTime =[
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_2 (option1_2ID)
            [ 5, 10, 15, 20, 25],   // Vacumm time fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_2 (option7_2ID)
        ]

var fixedButtonSalineTime =[
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1   (option1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_1 (option1_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 1_2 (option1_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 2   (option2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3   (option3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_1 (option3_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 3_2 (option3_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4   (option4ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_1 (option4_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 4_2 (option4_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5   (option5ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_1 (option5_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 5_2 (option5_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6   (option6ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_1 (option6_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_2 (option6_2ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 6_3 (option6_3ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7   (option7ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_1 (option7_1ID)
            [ 1,  1,  1,  1,  1],   // Vacumm time fixed buttons for teraphy 7_2 (option7_2ID)
        ]

//
// APPLICATION PARAMENTERS (for totals and cumulated indicators)
//
var parameterId = "appParameter_"
var dbParameter ={
    doseId:         parameterId + "dose_",
    volumeId:       parameterId + "volume_",
    pressureId:     parameterId + "pressure_",
    temperatureId:  parameterId + "temperature_",
    personWeightId: parameterId + "personWeight_",
}
var unitsId = "units"
var unitsAId = "unitsA"
var unitsBId = "unitsB"
var conversionFactorAId = "conv_factor_A"
var conversionFactorBId = "conv_factor_B"
var offsetAId = "offset_A"
var offsetBId = "offset_B"

var dbParameterElementsInit = [
    { name: dbParameter.doseId,          units: "\u03BCg",  unitsA: "\u03BCg",  unitsB: "mg",       conv_factor_A: "1",  conv_factor_B: "0.001",     offset_A: "0", offset_B: "0"  }, // enabled: "", color: "", icon: ""}
    { name: dbParameter.volumeId,        units: "ml",       unitsA: "ml",       unitsB: "l",        conv_factor_A: "1",  conv_factor_B: "0.001",     offset_A: "0", offset_B: "0"  }, // enabled: "", color: "", icon: ""}
    { name: dbParameter.pressureId,      units: "mbar",     unitsA: "mbar",     unitsB: "Psi",      conv_factor_A: "1",  conv_factor_B: "0.0145038", offset_A: "0", offset_B: "0"  }, // enabled: "", color: "", icon: ""}
    { name: dbParameter.temperatureId,   units: "\u00B0C",  unitsA: "\u00B0C",  unitsB: "\u00B0F",  conv_factor_A: "1",  conv_factor_B: "1.8",       offset_A: "0", offset_B: "32" }, // enabled: "", color: "", icon: ""}
    { name: dbParameter.personWeightId,  units: "kg",       unitsA: "kg",       unitsB: "lb",       conv_factor_A: "1",  conv_factor_B: "0.4536",    offset_A: "0", offset_B: "0"  }, // enabled: "", color: "", icon: ""}
]

//
//  COLOR PARAMETERS
//
var appColorId = "appColor_"
var dbAppColor ={
//  BloodVolume colors
    bloodVolumePanelId:                  appColorId + "bloodVolumePanel",                  // blood volume panel color
    bloodVolumeButtonId:                 appColorId + "bloodVolumeButton",                 // blood volume button color
    bloodVolumeBackSliderId:             appColorId + "bloodVolumeBackSlider",             // blood volume back slider color
    bloodVolumeSliderId:                 appColorId + "bloodVolumeSlider",                 // blood volume slider color
    bloodVolumeIndicatorId:              appColorId + "bloodVolumeIndicator",              // blood volume indicator background color
    bottleVolumeLabelId:                 appColorId + "bottleVolumeLabel",                 // blood volume bottle volume label color
    bottleVoidVolumeLabelId:             appColorId + "bottleVoidVolumeLabel",             // blood volume bottle void volume label color
    bloodVolumeLabelId:                  appColorId + "bloodVolumeLabel",                  // blood volume blood volume label color
    bloodVolumeProgressBar1Id:           appColorId + "bloodVolumeProgressBar1",           // blood volume blood progress bar color
    bloodVolumeProgressBar2Id:           appColorId + "bloodVolumeProgressBar2",           // blood volume anticoagulant progress bar color
    bloodVolumeValueId:                  appColorId + "bloodVolumeValue",                  // blood volume value color
    bloodVolumeUnitsId:                  appColorId + "bloodVolumeUnits",                  // blood volume units color
//  BrandName colors
    brandNameTextId:                     appColorId + "brandNameText",                     // brand name text color
    brandNameSaveScreenDeviceId:         appColorId + "brandNameSaveScreenDevice",         // device color text during save screen
    brandNameSaveScreenCompanyId:        appColorId + "brandNameSaveScreenCompany",        // company color text during save screen
    brandNameSaveScreenBusinessId:       appColorId + "brandNameSaveScreenBusiness",       // business color text during save screen
//  Cumulated colors
    cumulatedPanelId:                    appColorId + "cumulatedPanel",                    // cumulated panel color
//  CumulatedBoard colors
    cumBrdPanelId:                       appColorId + "cumBrdPanel",                       // cumulated board panel color
    cumBrdCumO3ProgressId:               appColorId + "cumBrdCumO3Progress",               // cumulated board O3 progress bar color
    cumBrdCumO3ProgressBackId:           appColorId + "cumBrdCumO3ProgressBack",           // cumulated board O3 background progress bar color
    cumBrdCumVolumeProgressId:           appColorId + "cumBrdCumVolumeProgress",           // cumulated board volume progress bar color
    cumBrdCumVolumeProgressBackId:       appColorId + "cumBrdCumVolumeProgressBack",       // cumulated board volume background progress bar color
    cumBrdCumTimeSecProgressId:          appColorId + "cumBrdCumTimeSecProgress",          // cumulated board time seconds progress bar color
    cumBrdCumTimeSecProgressBackId:      appColorId + "cumBrdCumTimeSecProgressBack",      // cumulated board time seconds background progress bar color
    cumBrdCumTimeProgressId:             appColorId + "cumBrdCumTimeProgress",             // cumulated board time progress bar color
    cumBrdCumTimeProgressBackId:         appColorId + "cumBrdCumTimeProgressBack",         // cumulated board time background progress bar color
    cumBrdCumPressureProgressId:         appColorId + "cumBrdCumPressureProgress",         // cumulated board pressure progress bar color
    cumBrdCumPressureProgressBackId:     appColorId + "cumBrdCumPressureProgressBack",     // cumulated board pressure background progress bar color
    cumBrdCyclesLabelId:                 appColorId + "cumBrdCyclesLabel",                 // cumulated board cycles label color
//  DCImage colors
    dcImagePanelId:                      appColorId + "dcImagePanel",                      // cd image board panel color
//  EmergencyPauseButton colors
    emPauseButtonPanelId:                appColorId + "emPauseButtonPanel",                // emergency pause button board panel color
    emPauseButtonBlackMaskId:            appColorId + "emPauseButtonBlackMask",            // emergency pause button black mask color
    emPauseButtonButonId:                appColorId + "emPauseButtonButon",                // emergency pause button button color
//  GadgetMenu colors
    gadgetMenuPanelId:                   appColorId + "gadgetMenuPanel",                   // gadget menu board panel color
    gadgetMenuButtonId:                  appColorId + "gadgetMenuButton",                  // gadget menu button color
//  HelpMenu colors
    HelpMenuButtonId:                    appColorId + "HelpMenuButton",                    // help menu button color
//  ImageViewer colors
    imageViewerBackId:                   appColorId + "imageViewerBack",                   // image viewer back color
    imageViewerWindowId:                 appColorId + "imageViewerWindow",                 // image viewer window color
    imageViewerButtonId:                 appColorId + "imageViewerButton",                 // image viewer buttom color
//  Input colors
    inputCtrlPanelId:                    appColorId + "inputCtrlPanel",                    // input control panel color
    inputCtrlButtonId:                   appColorId + "inputCtrlButton",                   // input control button color
    inputCtrlFixButtonTextId:            appColorId + "inputCtrlFixButtonText",            // input control fix button text color
    inputCtrlBackSliderId:               appColorId + "inputCtrlBackSlider",               // input control back slider color
    inputCtrlSeqButtonLabelId:           appColorId + "inputCtrlSeqButtonLabel",           // input control sequential button label color
    inputCtrlChangeRangeLabelId:         appColorId + "inputCtrlChangeRangeLabel",         // input control change slider range button label color
//  MagnitudeSelector colors
    inputBottleVolumeUnitsId:            appColorId + "inputBottleVolumeUnits",            //
    inputBottleVolumeValueId:            appColorId + "inputBottleVolumeValue",            //
    inputBloodVolumeUnitsId:             appColorId + "inputBloodVolumeUnits",             //
    inputBloodVolumeValueId:             appColorId + "inputBloodVolumeValue",             //
    inputLiquidVolumeUnitsId:            appColorId + "inputLiquidVolumeUnits",            //
    inputLiquidVolumeValueId:            appColorId + "inputLiquidVolumeValue",            //
    inputSalineVolumeUnitsId:            appColorId + "inputSalineVolumeUnits",            //
    inputSalineVolumeValueId:            appColorId + "inputSalineVolumeValue",            //
    inputO3UnitsId:                      appColorId + "inputO3Units",                      //
    inputO3ValueId:                      appColorId + "inputO3Value",                      //
    inputFlowUnitsId:                    appColorId + "inputFlowUnits",                    //
    inputFlowValueId:                    appColorId + "inputFlowValue",                    //
    inputTimeUnitsId:                    appColorId + "inputTimeUnits",                    //
    inputTimeValueId:                    appColorId + "inputTimeValue",                    //
    inputTimeVolumeUnitsId:              appColorId + "inputTimeVolumeUnits",              //
    inputTimeVolumeValueId:              appColorId + "inputTimeVolumeValue",              //
    inputTimeVolumeUnits2Id:             appColorId + "inputTimeVolumeUnits2",             //
    inputTimeVolumeValue2Id:             appColorId + "inputTimeVolumeValue2",             //
    inputTotalConcentrationUnitsId:      appColorId + "inputTotalConcentrationUnits",      //
    inputTotalConcentrationValueId:      appColorId + "inputTotalConcentrationValue",      //
    inputTherapyTimeUnitsId:             appColorId + "inputTherapyTimeUnits",             //
    inputTherapyTimeValueId:             appColorId + "inputTherapyTimeValue",             //
    inputVacuumTimeUnitsId:              appColorId + "inputVacuumTimeUnits",              //
    inputVacuumTimeValueId:              appColorId + "inputVacuumTimeValue",              //
    inputVolumeDoseUnitsId:              appColorId + "inputVolumeDoseUnits",              //
    inputVolumeDoseValueId:              appColorId + "inputVolumeDoseValue",              //
    inputVolumeDoseUnits2Id:             appColorId + "inputVolumeDoseUnits2",             //
    inputVolumeDoseValue2Id:             appColorId + "inputVolumeDoseValue2",             //
    inputTimeDoseUnitsId:                appColorId + "inputTimeDoseUnits",                //
    inputTimeDoseValueId:                appColorId + "inputTimeDoseValue",                //
    inputTimeDoseUnits2Id:               appColorId + "inputTimeDoseUnits2",               //
    inputTimeDoseValue2Id:               appColorId + "inputTimeDoseValue2",               //
    inputVolumeUnitsId:                  appColorId + "inputVolumeUnits",                  //
    inputVolumeValueId:                  appColorId + "inputVolumeValue",                  //
    inputCleanTimeUnitsId:               appColorId + "inputCleanTimeUnits",               //
    inputCleanTimeValueId:               appColorId + "inputCleanTimeValue",               //
    inputPressureUnitsId:                appColorId + "inputPressureUnits",                //
    inputPressureValueId:                appColorId + "inputPressureValue",                //
    inputIpUnitsId:                      appColorId + "inputIpUnits",                      //
    inputIpValueId:                      appColorId + "inputIpValue",                      //
    inputReinfusionTimeUnitsId:          appColorId + "inputReinfusionTimeUnits",          //
    inputSalineTimeUnitsId:              appColorId + "inputSalineTimeUnits",              //
    inputReinfusionTimeValueId:          appColorId + "inputReinfusionTimeValue",          //
    inputCyclesPanelId:                  appColorId + "inputCyclesPanel",                  //
    inputCyclesLabelId:                  appColorId + "inputCyclesLabel",                  //
    inputCyclesControlId:                appColorId + "inputCyclesControl",                //
    inputPreviousVacuumPanelId:          appColorId + "inputPreviousVacuumPanel",          //
    inputHiperNormoPanelId:              appColorId + "inputHiperNormoPanel",              //
//  Main colors
    mainBackColorId:                     appColorId + "mainBackColor",                     // aaplication backColor
//  Memory colors
    memoryPanelId:                       appColorId + "memoryPanel",                       // memory panel color
    memoryBackId:                        appColorId + "memoryBack",                        // memory back color
    memoryExtendedValuesBorderId:        appColorId + "memoryExtendedValuesBorder",        // memory extended values label border color
    memeoryButtonId:                     appColorId + "memeoryButtonId",                   // memeory control button color
    memoryNameId:                        appColorId + "memoryName",                        // memory name text color
    memoryHighLihgtSelectionId:          appColorId + "memoryHighLihgtSelection",          // memory high light selection color
    memoryTextEditorId:                  appColorId + "memoryTextEditor",                  // memory text name editor color
    memoryTextInputId:                   appColorId + "memoryTextInput",                   // memory text input editor color
//  MemoryExclusionArea colors
    exclusionAreaPanelId:                appColorId + "exclusionAreaPanel",                // memory exclusion area panel color
//  NormalizationImage colors
    normalizationImagePanelId:           appColorId + "normalizationImagePanel",           // normalization image board panel color
//  PressureMetter
    pressureMetterPanelId:               appColorId + "pressureMetterPanel",               // pressure metter panel color
    pressureMetterGradientTopId:         appColorId + "pressureMetterGradientTop",         // pressure metter gradient top color
    pressureMetterGradientMediumId:      appColorId + "pressureMetterGradientMedium",      // pressure metter gradient medium color
    pressureMetterGradientBottomId:      appColorId + "pressureMetterGradientBottom",      // pressure metter gradient bottom color
    pressureMetterValueId:               appColorId + "pressureMetterValue",               // pressure metter value label color
    pressureMetterLabelId:               appColorId + "pressureMetterLabel",               // pressure metter units label color
//  PressureTester
    pressureTesterPanelId:               appColorId + "pressureTesterPanel",               // pressure tester panel color
    pressureTesterButtonId:              appColorId + "pressureTesterButton",              // pressure tester button color
    pressureTesterBackSliderId:          appColorId + "pressureTesterBackSlider",          // pressure tester back slider color
    pressureTesterSliderId:              appColorId + "pressureTesterSlider",              // pressure tester slider color
    pressureTesterValueId:               appColorId + "pressureTesterValue",               // pressure tester value label color
    pressureTesterError1Id:              appColorId + "pressureTesterError1",              // pressure tester error panel 1 color
    pressureTesterError2Id:              appColorId + "pressureTesterError2",              // pressure tester error panel 2 color
//  SaveScreen
    saveScreenGradientTopId:             appColorId + "saveScreenGradientTop",             // save screen gradient top color
    saveScreenGradientMediumId:          appColorId + "saveScreenGradientMedium",          // save screen metter gradient medium color
    saveScreenGradientBottomId:          appColorId + "saveScreenGradientBottom",          // save screen gradient bottom color
//  SalineHemoTherapyCalculator
    salineHemoTherapyCalculatorId:       appColorId + "salineHemoTherapyCalculator",       // saline hemotherapy calculator panel color
    salineHemoTherapyCalcButtonId:       appColorId + "salineHemoTherapyCalcButton",       // saline hemotherapy calculator button color
    salineHemoTherapyCalcSlider1Id:      appColorId + "salineHemoTherapyCalcSlider1",      // saline hemotherapy calculator slider 1 color (O3)
    salineHemoTherapyCalcPressSlider1Id: appColorId + "salineHemoTherapyCalcPressSlider1", // saline hemotherapy calculator slider 1 color when press (O3)
    salineHemoTherapyCalcSlider2Id:      appColorId + "salineHemoTherapyCalcSlider2",      // saline hemotherapy calculator slider 2 color (hieght)
    salineHemoTherapyCalcPressSlider2Id: appColorId + "salineHemoTherapyCalcPressSlider2", // saline hemotherapy calculator slider 2 color when press (hieght)
    salineHemoTherapyCalcBackSliderId:   appColorId + "salineHemoTherapyCalcBackSlider",   // syringe calculator back slider color
    salineHemoTherapyCalcMaxValueId:     appColorId + "salineHemoTherapyCalcMaxValue",     // syringe calculator max value tag color
//  SyringeCalculator
    syringeCalcultorPanelId:             appColorId + "syringeCalcultorPanel",             // syringe calculator panel color
    syringeCalcultorButtonId:            appColorId + "syringeCalcultorButton",            // syringe calculator button color
    syringeCalcultorSlider1Id:           appColorId + "syringeCalcultorSlider1",           // syringe calculator slider 1 color (O3)
    syringeCalcultorPressSlider1Id:      appColorId + "syringeCalcultorPressSlider1",      // syringe calculator slider 1 color when press (O3)
    syringeCalcultorSlider2Id:           appColorId + "syringeCalcultorSlider2",           // syringe calculator slider color 2 (volume)
    syringeCalcultorPressSlider2Id:      appColorId + "syringeCalcultorPressSlider2",      // syringe calculator slider 2 color 1 color when press (volume)
    syringeCalcultorBackSliderId:        appColorId + "syringeCalcultorBackSlider",        // syringe calculator back slider color
    syringeCalcultorRadioFrameId:        appColorId + "syringeCalcultorRadioFrame",        // syringe calculator radio button frame
//  TabBar colors
    tabBarBackId:                        appColorId + "tabBarBack",                        // tab bar back color
    tabBarOption1Id:                     appColorId + "tabBarOption1",                     // syringe theraphy icon
    tabBarOption1_1Id:                   appColorId + "tabBarOption1_1",                   // syringe submenu theraphy icon
    tabBarOption1_2Id:                   appColorId + "tabBarOption1_2",                   // syringe manual submenu theraphy icon
    tabBarOption2Id:                     appColorId + "tabBarOption2",                     // dose theraphy icon
    tabBarOption3Id:                     appColorId + "tabBarOption3",                     // bag theraphy icon
    tabBarOption3_1Id:                   appColorId + "tabBarOption3_1",                   // closed bag submenu theraphy icon
    tabBarOption3_2Id:                   appColorId + "tabBarOption3_2",                   // open bag submenu theraphy icon
    tabBarOption5Id:                     appColorId + "tabBarOption5",                     // hemoherapy theraphy icon
    tabBarOption5_1Id:                   appColorId + "tabBarOption5",                     // automotherapy (blood) theraphy icon
    tabBarOption5_2Id:                   appColorId + "tabBarOption5",                     // dose theraphy icon
    tabBarOption4Id:                     appColorId + "tabBarOption4",                     // inssuflation theraphy icon
    tabBarOption4_1Id:                   appColorId + "tabBarOption4_1",                   // vaginal inssuflation submenu theraphy icon
    tabBarOption4_2Id:                   appColorId + "tabBarOption4_2",                   // anal inssufaltion submenu theraphy icon
    tabBarOption6Id:                     appColorId + "tabBarOption6",                     // liquids ozonization theraphy icon
    tabBarOption6_1Id:                   appColorId + "tabBarOption6_1",                   // saline ozonization submenu theraphy icon
    tabBarOption6_2Id:                   appColorId + "tabBarOption6_2",                   // water ozonization submenu theraphy icon
    tabBarOption6_3Id:                   appColorId + "tabBarOption6_3",                   // oil ozonization submenu theraphy icon
    tabBarOption7Id:                     appColorId + "tabBarOption7",                     // vacuum theraphy icon
    tabBarOption7_1Id:                   appColorId + "tabBarOption7_1",                   // time vacuum submenu theraphy icon
    tabBarOption7_2Id:                   appColorId + "tabBarOption7_2",                   // bottle vacuum submenu theraphy icon
    tabBarBlinkEffect:                   appColorId + "tabBarBlinkEffect",                 // blink tabBar background effect
//  TabButton colors
    tabButtonBorderColorId:              appColorId + "tabButtonBorderColor",              // tab button border color
//  Tool_bar colors
    toolBarRectangleId:                  appColorId + "toolBarRectangle",                  // tool bar back color
    toolBarTimeLabelId:                  appColorId + "toolBarTimeLabel",                  // tool bar time color
    toolBarDateLabelId:                  appColorId + "toolBarDateLabel",                  // tool bar date color
//  TotalsBoard colors
    totalsBoardPanelId:                  appColorId + "totalsBoardPanel",                  // totals board panel color
    totalsBoardOKId:                     appColorId + "totalsBoardOK",                     // totals board therapy ok color
    totalsBoardCancelId:                 appColorId + "totalsBoardCancel",                 // totals board therapy cancel color
    totalsBoardErrorId:                  appColorId + "totalsBoardError",                  // totals board therapy error color
    totalsBoardToutId:                   appColorId + "totalsBoardTout",                   // totals board therapy time out color
    totalsBoardO3UnitsId:                appColorId + "totalsBoardO3Units",                // totals board therapy O3 units color
    totalsBoardO3ValueId:                appColorId + "totalsBoardO3value",                // totals board therapy O3 value color
    totalsBoardConcentUnitsId:           appColorId + "totalsBoardConcentUnits",           // totals board therapy concentration units color
    totalsBoardConcentValueId:           appColorId + "totalsBoardConcentValue",           // totals board therapy concentration value color
    totalsBoardIpIndexUnitsId:           appColorId + "totalsBoardIpIndexUnits",           // totals board therapy ip index units color
    totalsBoardIpIndexValueId:           appColorId + "totalsBoardIpIndexValue",           // totals board therapy ip index value color
    totalsBoardVolumeUnitsId:            appColorId + "totalsBoardVolumeUnits",            // totals board therapy volume units color
    totalsBoardVolumeValueId:            appColorId + "totalsBoardVolumeValue",            // totals board therapy volume value color
    totalsBoardTimeUnitsId:              appColorId + "totalsBoardTimeUnits",              // totals board therapy time units color
    totalsBoardTimeValueId:              appColorId + "totalsBoardTimeValue",              // totals board therapy time value color
    totalsBoardPressureUnitsId:          appColorId + "totalsBoardPressureUnits",          // totals board therapy pressure units color
    totalsBoardPressureValueId:          appColorId + "totalsBoardPressureValue",          // totals board therapy pressure value color
    totalsBoardTSecondsUnitsId:          appColorId + "totalsBoardTSecondsUnits",          // totals board therapy time seconds units color
    totalsBoardTSecondsValueId:          appColorId + "totalsBoardTSecondsValue",          // totals board therapy time seconds value color
    totalsBoardErrroLavelId:             appColorId + "totalsBoardErrroLavel",             // totals board therapy error label color
//  VideoPlayer colors
    videoPlayerBackId:                   appColorId + "videoPlayerBack",                   // video player back color
    videoPlayerWindowId:                 appColorId + "videoPlayerWindow",                 // video player window color
    videoPlayerControlsBackId:           appColorId + "videoPlayerControlsBack",           // video player controls back color
    videoPlayerDurationId:               appColorId + "videoPlayerDuration",               // video player duration color
    videoPlayerPositionId:               appColorId + "videoPlayerPosition",               // video player position color
    videoPlayerSliderId:                 appColorId + "videoPlayerSlider",                 // video player slider color  (volume)
    videoPlayerBackSliderId:             appColorId + "videoPlayerBackSlider",             // video player back slider color
    videoPlayerPressSliderId:            appColorId + "videoPlayerPressSlider",            // video player slider  color when press (volume)
//  HelpDocViewer colors
    docViewerBackId:                     appColorId + "docViewerBack",                     // doc viewer back color
    docViewerWindowId:                   appColorId + "docViewerWindow",                   // doc viewer window color
    docViewerControlsBackId:             appColorId + "docViewerControlsBack",             // doc viewer controls back color
    docViewerPageInfoId:                 appColorId + "docViewerPageInfo",                 // doc viewer duration color
    docViewerSliderId:                   appColorId + "docViewerSlider",                   // doc viewer slider color  (volume)
    docViewerBackSliderId:               appColorId + "docViewerBackSlider",               // doc viewer back slider color
    docViewerPressSliderId:              appColorId + "docViewerPressSlider",              // doc viewer slider  color when press (volume)
//  Service menu colors
    serviceMenuBackId:                   appColorId + "serviceMenuBack",                   // service menu back color
    serviceMenuPinPadId:                 appColorId + "serviceMenuPinPad",                 // service menu pin pad
    serviceMenuRestartScreenId:          appColorId + "serviceMenuRestartScreen",          // service menu restart screen
    serviceMenuChooseUnitsId:            appColorId + "serviceMenuChooseUnits",            // service menu choose units
    serviceMenuControlsId:               appColorId + "serviceMenuControls",               // service menu controls (for calibration)
    serviceMenuShowDataId:               appColorId + "serviceMenuShowData",               // service menu show data window
    serviceMenuShowDateTimeId:           appColorId + "serviceMenuShowDateTime",           // service menu show date & time window
    serviceMenuYesNoPopUpId:             appColorId + "serviceMenuYesNoPopUp",             // service menu yes/no pop up interface
    serviceMenuButtonId:                 appColorId + "serviceMenuButton",                 // service menu button color Id
    serviceMenuBackFrameId:              appColorId + "serviceMenuBackFrame",              // service menu back button color
    serviceMenuTextId:                   appColorId + "serviceMenuText",                   // service menu text color
    serviceMenuDeselectedTextId:         appColorId + "serviceMenuDeselectedText",         // service menu deselected text color
//  Start up colors
    startUpBackFrameId:                  appColorId + "startUpBackFrame",                  // start up back frame color
    startUpTextId:                       appColorId + "startUpText",                       // start up text color
    gadgetInOutEffectId:                 appColorId + "gadgetInOutEffect",                 // gadgetInOutEffect back color

}

//  Global colors
var panelColor = "#333333"
var buttonColor = "#202020"
var backColor = "#040404"
var backSliderColor = "white"
var iconsColor = "white"
var darkBlue = "#0097A7"
var lightBlue = "#80DEEA"
var darkGreen = "#388E3C"
var lightGreen = "#81C784"
var darkYellow = "#FFC131"
var lightYellow = "#FFE082"
var darkOrange = "#FF9428"
var lightOrange = "#FFBE7E"
var darkPink = "#FF3074"
var lightPink = "#FF68B4"
var darkPurple = "#73307F"
var lightPurple = "#ac65b7"
var darkViolet = "#6060C0"
var lightViolet = "#A2A2D0"
var darkOlive = "#5F9221"
var lightOlive = "#96D647"

var dbAppColorElementsInit = [
//  BloodVolume colors
    { name: dbAppColor.bloodVolumePanelId,                  value: "transparent" },
    { name: dbAppColor.bloodVolumeButtonId,                 value: buttonColor },
    { name: dbAppColor.bloodVolumeBackSliderId,             value: backSliderColor },
    { name: dbAppColor.bloodVolumeSliderId,                 value: "#CA1D24" },
    { name: dbAppColor.bloodVolumeIndicatorId,              value: buttonColor },
    { name: dbAppColor.bottleVolumeLabelId,                 value: "white" },
    { name: dbAppColor.bottleVoidVolumeLabelId,             value: "white" },
    { name: dbAppColor.bloodVolumeLabelId,                  value: "#CA1D24" },
    { name: dbAppColor.bloodVolumeProgressBar1Id,           value: "#CA1D24" },
    { name: dbAppColor.bloodVolumeProgressBar2Id,           value: "#DBD788" },
    { name: dbAppColor.bloodVolumeValueId,                  value: "#ff4d4d" },
    { name: dbAppColor.bloodVolumeUnitsId,                  value: "#CA1D24" },
//  Brand Name colors
    { name: dbAppColor.brandNameTextId,                     value: "#333333" },
    { name: dbAppColor.brandNameSaveScreenDeviceId,         value: "#5D77E5" },
    { name: dbAppColor.brandNameSaveScreenCompanyId,        value: "#4169E1" },
    { name: dbAppColor.brandNameSaveScreenBusinessId,       value: "#7485E9" },
//  Cumulated colors
    { name: dbAppColor.cumulatedPanelId,                    value: panelColor },
//  CumulatedBoard colors
    { name: dbAppColor.cumBrdPanelId,                       value: panelColor },
    { name: dbAppColor.cumBrdCumO3ProgressId,               value: darkGreen },
    { name: dbAppColor.cumBrdCumO3ProgressBackId,           value: lightGreen },
    { name: dbAppColor.cumBrdCumVolumeProgressId,           value: darkPurple },
    { name: dbAppColor.cumBrdCumVolumeProgressBackId,       value: lightPurple },
    { name: dbAppColor.cumBrdCumTimeSecProgressId,          value: darkYellow },
    { name: dbAppColor.cumBrdCumTimeSecProgressBackId,      value: lightYellow },
    { name: dbAppColor.cumBrdCumTimeProgressId,             value: darkYellow },
    { name: dbAppColor.cumBrdCumTimeProgressBackId,         value: lightYellow },
    { name: dbAppColor.cumBrdCumPressureProgressId,         value: darkOrange },
    { name: dbAppColor.cumBrdCumPressureProgressBackId,     value: lightOrange },
    { name: dbAppColor.cumBrdCyclesLabelId,                 value: iconsColor },
//  DCImage colors
    { name: dbAppColor.dcImagePanelId,                      value: "transparent" },
//  EmergencyPauseButton colors
    { name: dbAppColor.emPauseButtonPanelId,                value: "transparent" },
    { name: dbAppColor.emPauseButtonBlackMaskId,            value: "black" },
    { name: dbAppColor.emPauseButtonButonId,                value: "transparent" },
//  GadgetMenu colors
    { name: dbAppColor.gadgetMenuPanelId,                   value: "transparent" },
    { name: dbAppColor.gadgetMenuButtonId,                  value: panelColor },
//  GadgetMenu colors
    { name: dbAppColor.HelpMenuButtonId,                    value: panelColor },
//  ImageViewer colors
    { name: dbAppColor.imageViewerBackId,                   value: backColor },
    { name: dbAppColor.imageViewerWindowId,                 value: "transparent" },
    { name: dbAppColor.imageViewerButtonId,                 value: "#555555" },
//  Input colors
    { name: dbAppColor.inputCtrlPanelId,                    value: panelColor },
    { name: dbAppColor.inputCtrlButtonId,                   value: buttonColor },
    { name: dbAppColor.inputCtrlFixButtonTextId,            value: iconsColor },
    { name: dbAppColor.inputCtrlBackSliderId,               value: backSliderColor },
    { name: dbAppColor.inputCtrlSeqButtonLabelId,           value: iconsColor },
    { name: dbAppColor.inputCtrlChangeRangeLabelId,         value: iconsColor },
//  MagnitudeSelector colors
    { name: dbAppColor.inputBottleVolumeUnitsId,            value: darkPurple },
    { name: dbAppColor.inputBottleVolumeValueId,            value: lightPurple },
    { name: dbAppColor.inputBloodVolumeUnitsId,             value: darkPurple },
    { name: dbAppColor.inputBloodVolumeValueId,             value: lightPurple },
    { name: dbAppColor.inputLiquidVolumeUnitsId,            value: darkPurple },
    { name: dbAppColor.inputLiquidVolumeValueId,            value: lightPurple },
    { name: dbAppColor.inputSalineVolumeUnitsId,            value: darkPurple },
    { name: dbAppColor.inputSalineVolumeValueId,            value: lightPurple },
    { name: dbAppColor.inputO3UnitsId,                      value: darkBlue },
    { name: dbAppColor.inputO3ValueId,                      value: lightBlue },
    { name: dbAppColor.inputFlowUnitsId,                    value: darkOlive },
    { name: dbAppColor.inputFlowValueId,                    value: lightOlive },
    { name: dbAppColor.inputTimeUnitsId,                    value: darkYellow },
    { name: dbAppColor.inputTimeValueId,                    value: lightYellow },
    { name: dbAppColor.inputTimeVolumeUnitsId,              value: darkOlive },
    { name: dbAppColor.inputTimeVolumeValueId,              value: lightOlive },
    { name: dbAppColor.inputTimeVolumeUnits2Id,             value: darkPurple },
    { name: dbAppColor.inputTimeVolumeValue2Id,             value: lightPurple },
    { name: dbAppColor.inputTotalConcentrationUnitsId,      value: darkGreen },
    { name: dbAppColor.inputTotalConcentrationValueId,      value: lightGreen },
    { name: dbAppColor.inputTherapyTimeUnitsId,             value: darkYellow },
    { name: dbAppColor.inputTherapyTimeValueId,             value: lightYellow },
    { name: dbAppColor.inputVacuumTimeUnitsId,              value: darkYellow },
    { name: dbAppColor.inputVacuumTimeValueId,              value: lightYellow },
    { name: dbAppColor.inputVolumeDoseUnitsId,              value: darkOlive },
    { name: dbAppColor.inputVolumeDoseValueId,              value: lightOlive },
    { name: dbAppColor.inputVolumeDoseUnits2Id,             value: darkPurple },
    { name: dbAppColor.inputVolumeDoseValue2Id,             value: lightPurple },
    { name: dbAppColor.inputTimeDoseUnitsId,                value: darkOlive },
    { name: dbAppColor.inputTimeDoseValueId,                value: lightOlive },
    { name: dbAppColor.inputTimeDoseUnits2Id,               value: darkPurple },
    { name: dbAppColor.inputTimeDoseValue2Id,               value: lightPurple },
    { name: dbAppColor.inputVolumeUnitsId,                  value: darkPurple },
    { name: dbAppColor.inputVolumeValueId,                  value: lightPurple },
    { name: dbAppColor.inputCleanTimeUnitsId,               value: darkYellow },
    { name: dbAppColor.inputCleanTimeValueId,               value: lightYellow },
    { name: dbAppColor.inputPressureUnitsId,                value: darkOrange },
    { name: dbAppColor.inputPressureValueId,                value: lightOrange },
    { name: dbAppColor.inputIpUnitsId,                      value: "olive" },
    { name: dbAppColor.inputIpValueId,                      value: "olive" },
    { name: dbAppColor.inputReinfusionTimeUnitsId,          value: darkYellow },
    { name: dbAppColor.inputReinfusionTimeValueId,          value: lightYellow },
    { name: dbAppColor.inputSalineTimeUnitsId,              value: lightYellow },
    { name: dbAppColor.inputCyclesPanelId,                  value: panelColor},
    { name: dbAppColor.inputCyclesLabelId,                  value: iconsColor},
    { name: dbAppColor.inputCyclesControlId,                value: iconsColor},
    { name: dbAppColor.inputPreviousVacuumPanelId,          value: panelColor},
    { name: dbAppColor.inputHiperNormoPanelId,              value: panelColor},
//  Main colors
    { name: dbAppColor.mainBackColorId,                     value: backColor },
//  Memory colors
    { name: dbAppColor.memoryPanelId,                       value: "transparent" },
    { name: dbAppColor.memoryBackId,                        value: backColor },
    { name: dbAppColor.memoryExtendedValuesBorderId,        value: "white" },
    { name: dbAppColor.memeoryButtonId,                     value: buttonColor },
    { name: dbAppColor.memoryNameId,                        value: "#888888" },
    { name: dbAppColor.memoryHighLihgtSelectionId,          value: lightBlue },
    { name: dbAppColor.memoryTextEditorId,                  value: "white" },
    { name: dbAppColor.memoryTextInputId,                   value: panelColor },
//  Memory exclusion area
    { name: dbAppColor.exclusionAreaPanelId,                value: "black" },
//  NormalizationImage colors
    { name: dbAppColor.normalizationImagePanelId,           value: "transparent" },
//  PressureMetter
    { name: dbAppColor.pressureMetterPanelId,               value: panelColor },
    { name: dbAppColor.pressureMetterGradientTopId,         value: "#ff3331" },
    { name: dbAppColor.pressureMetterGradientMediumId,      value: darkGreen },
    { name: dbAppColor.pressureMetterGradientBottomId,      value: darkYellow },
    { name: dbAppColor.pressureMetterValueId,               value: "white" },
    { name: dbAppColor.pressureMetterLabelId,               value: darkGreen },
//  PressureTester
    { name: dbAppColor.pressureTesterPanelId,               value: "transparent" },
    { name: dbAppColor.pressureTesterButtonId,              value: buttonColor },
    { name: dbAppColor.pressureTesterBackSliderId,          value: backSliderColor },
    { name: dbAppColor.pressureTesterSliderId,              value: darkGreen },
    { name: dbAppColor.pressureTesterValueId,               value: lightGreen },
    { name: dbAppColor.pressureTesterError1Id,              value: "orangered" }, // unused ---> valorate delete
    { name: dbAppColor.pressureTesterError2Id,              value: "darkorange" },
//  SaveScreen
    { name: dbAppColor.saveScreenGradientTopId,             value: "#444444" },
    { name: dbAppColor.saveScreenGradientMediumId,          value: "#222222" },
    { name: dbAppColor.saveScreenGradientBottomId,          value: "#444444" },
//  SalineHemoTherapyCalculator
    { name: dbAppColor.salineHemoTherapyCalculatorId,       value: "transparent" },
    { name: dbAppColor.salineHemoTherapyCalcButtonId,       value: buttonColor },
    { name: dbAppColor.salineHemoTherapyCalcSlider1Id,      value: darkBlue },
    { name: dbAppColor.salineHemoTherapyCalcPressSlider1Id, value: lightBlue },
    { name: dbAppColor.salineHemoTherapyCalcSlider2Id,      value: darkGreen },
    { name: dbAppColor.salineHemoTherapyCalcPressSlider2Id, value: lightGreen },
    { name: dbAppColor.salineHemoTherapyCalcBackSliderId,   value: backSliderColor },
    { name: dbAppColor.salineHemoTherapyCalcMaxValueId,     value: "palevioletred" },
//  SyringeCalculator
    { name: dbAppColor.syringeCalcultorPanelId,             value: "transparent" },
    { name: dbAppColor.syringeCalcultorButtonId,            value: buttonColor },
    { name: dbAppColor.syringeCalcultorSlider1Id,           value: darkBlue },
    { name: dbAppColor.syringeCalcultorPressSlider1Id,      value: lightBlue },
    { name: dbAppColor.syringeCalcultorSlider2Id,           value: darkGreen },
    { name: dbAppColor.syringeCalcultorPressSlider2Id,      value: lightGreen },
    { name: dbAppColor.syringeCalcultorBackSliderId,        value: backSliderColor },
    { name: dbAppColor.syringeCalcultorRadioFrameId,        value: "white" },
//  TabBar colors
    { name: dbAppColor.tabBarBackId,                        value: panelColor },
    { name: dbAppColor.tabBarOption1Id,                     value: "#96d647"},
    { name: dbAppColor.tabBarOption1_1Id,                   value: "#96d647"},
    { name: dbAppColor.tabBarOption1_2Id,                   value: "#96d647"},
    { name: dbAppColor.tabBarOption2Id,                     value: "#00a199"},
    { name: dbAppColor.tabBarOption3Id,                     value: "#48c869"},
    { name: dbAppColor.tabBarOption3_1Id,                   value: "#48c869"},
    { name: dbAppColor.tabBarOption3_2Id,                   value: "#48c869"},
    { name: dbAppColor.tabBarOption4Id,                     value: "#00b686"},
    { name: dbAppColor.tabBarOption4_1Id,                   value: "#00b686"},
    { name: dbAppColor.tabBarOption4_2Id,                   value: "#00b686"},
    { name: dbAppColor.tabBarOption5Id,                     value: "#008b9e"},
    { name: dbAppColor.tabBarOption5_1Id,                   value: "#008b9e"},
    { name: dbAppColor.tabBarOption5_2Id,                   value: "#008b9e"},
    { name: dbAppColor.tabBarOption6Id,                     value: "#007395"},
    { name: dbAppColor.tabBarOption6_1Id,                   value: "#007395"},
    { name: dbAppColor.tabBarOption6_2Id,                   value: "#007395"},
    { name: dbAppColor.tabBarOption6_3Id,                   value: "#007395"},
    { name: dbAppColor.tabBarOption7Id,                     value: "#1a5c80"},
    { name: dbAppColor.tabBarOption7_1Id,                   value: "#1a5c80"},
    { name: dbAppColor.tabBarOption7_2Id,                   value: "#1a5c80"},
    { name: dbAppColor.tabBarBlinkEffect,                   value: "white"},
//  TabButton colors
    { name: dbAppColor.tabButtonBorderColorId,              value: "white" },
//  Tool_bar colors
    { name: dbAppColor.toolBarRectangleId,                  value: panelColor },
    { name: dbAppColor.toolBarTimeLabelId,                  value: "white" },
    { name: dbAppColor.toolBarDateLabelId,                  value: "white" },
//  TotalsBoard color
    { name: dbAppColor.totalsBoardPanelId,                  value: panelColor },
    { name: dbAppColor.totalsBoardOKId,                     value: "forestgreen" },
    { name: dbAppColor.totalsBoardCancelId,                 value: "orangered" },
    { name: dbAppColor.totalsBoardErrorId,                  value: "darkorange" },
    { name: dbAppColor.totalsBoardToutId,                   value: "gold" },
    { name: dbAppColor.totalsBoardO3UnitsId,                value: darkBlue },
    { name: dbAppColor.totalsBoardO3ValueId,                value: lightBlue },
    { name: dbAppColor.totalsBoardConcentUnitsId,           value: darkGreen },
    { name: dbAppColor.totalsBoardConcentValueId,           value: lightGreen },
    { name: dbAppColor.totalsBoardIpIndexUnitsId,           value: "olivedrab" },
    { name: dbAppColor.totalsBoardIpIndexValueId,           value: "olive" },
    { name: dbAppColor.totalsBoardVolumeUnitsId,            value: darkPurple },
    { name: dbAppColor.totalsBoardVolumeValueId,            value: lightPurple },
    { name: dbAppColor.totalsBoardTimeUnitsId,              value: darkYellow },
    { name: dbAppColor.totalsBoardTimeValueId,              value: lightYellow },
    { name: dbAppColor.totalsBoardPressureUnitsId,          value: darkOrange },
    { name: dbAppColor.totalsBoardPressureValueId,          value: lightOrange },
    { name: dbAppColor.totalsBoardTSecondsUnitsId,          value: darkYellow },
    { name: dbAppColor.totalsBoardTSecondsValueId,          value: lightYellow },
    { name: dbAppColor.totalsBoardErrroLavelId,             value: "white" },
//  VideoPlayer colors
    { name: dbAppColor.videoPlayerBackId,                   value: backColor },
    { name: dbAppColor.videoPlayerWindowId,                 value: "#555555" },
    { name: dbAppColor.videoPlayerControlsBackId,           value: "#555555" },
    { name: dbAppColor.videoPlayerDurationId,               value: "white" },
    { name: dbAppColor.videoPlayerPositionId,               value: "white" },
    { name: dbAppColor.videoPlayerSliderId,                 value: "white" },
    { name: dbAppColor.videoPlayerBackSliderId,             value: "#333333" },
    { name: dbAppColor.videoPlayerPressSliderId,            value: "#555555" },
//  HelpDocViewer colors
    { name: dbAppColor.docViewerBackId,                     value: backColor },
    { name: dbAppColor.docViewerWindowId,                   value: "#555555" },
    { name: dbAppColor.docViewerControlsBackId,             value: "#555555" },
    { name: dbAppColor.docViewerPageInfoId,                 value: "white" },
    { name: dbAppColor.docViewerSliderId,                   value: "white" },
    { name: dbAppColor.docViewerBackSliderId,               value: "#333333" },
    { name: dbAppColor.docViewerPressSliderId,              value: "#555555" },
//  Service menu colors
    { name: dbAppColor.serviceMenuBackId,                   value: "#1a5c80" },
    { name: dbAppColor.serviceMenuPinPadId,                 value: "#007395" },
    { name: dbAppColor.serviceMenuRestartScreenId,          value: "#007395" },
    { name: dbAppColor.serviceMenuChooseUnitsId,            value: "#007395" },
    { name: dbAppColor.serviceMenuControlsId,               value: "#007395" },
    { name: dbAppColor.serviceMenuShowDataId,               value: "#007395" },
    { name: dbAppColor.serviceMenuShowDateTimeId,           value: "#007395" },
    { name: dbAppColor.serviceMenuYesNoPopUpId,             value: "#007395" },
    { name: dbAppColor.serviceMenuButtonId,                 value: "#292929" },
    { name: dbAppColor.serviceMenuBackFrameId,              value: "#444444" },
    { name: dbAppColor.serviceMenuTextId,                   value: "white" },
    { name: dbAppColor.serviceMenuDeselectedTextId,         value: "darkgrey" },
//  Start up colors
    { name: dbAppColor.startUpBackFrameId,                  value: "#000710" },
    { name: dbAppColor.startUpTextId,                       value: "white" },
//  GadgetInOutEffect colors
    { name: dbAppColor.gadgetInOutEffectId,                 value: panelColor },
]

//
//  IMAGES PARAMETERS
//
var appIconId = "appIcon_"
var dbAppIcon ={
    option1Id:                   appIconId + "option1",                   // syringe theraphy icon
    option1_1Id:                 appIconId + "option1_1",                 // syringe submenu theraphy icon
    option1_2Id:                 appIconId + "option1_2",                 // syringe manual submenu theraphy icon
    option2Id:                   appIconId + "option2",                   // dose theraphy icon
    option3Id:                   appIconId + "option3",                   // bag theraphy icon
    option3_1Id:                 appIconId + "option3_1",                 // closed bag submenu theraphy icon
    option3_2Id:                 appIconId + "option3_2",                 // open bag submenu theraphy icon
    option5Id:                   appIconId + "option5",                   // hemotherapy theraphy icon
    option5_1Id:                 appIconId + "option5_1",                 // automotherapy (blood) theraphy icon
    option5_2Id:                 appIconId + "option5_2",                 // dose theraphy icon
    option4Id:                   appIconId + "option4",                   // inssuflation theraphy icon
    option4_1Id:                 appIconId + "option4_1",                 // vaginal inssuflation submenu theraphy icon
    option4_2Id:                 appIconId + "option4_2",                 // anal inssufaltion submenu theraphy icon
    option6Id:                   appIconId + "option6",                   // liquids ozonization theraphy icon
    option6_1Id:                 appIconId + "option6_1",                 // saline ozonization submenu theraphy icon
    option6_2Id:                 appIconId + "option6_2",                 // water ozonization submenu theraphy icon
    option6_3Id:                 appIconId + "option6_3",                 // oil ozonization submenu theraphy icon
    option7Id:                   appIconId + "option7",                   // vacuum theraphy icon
    option7_1Id:                 appIconId + "option7_1",                 // time vacuum submenu theraphy icon
    option7_2Id:                 appIconId + "option7_2",                 // bottle vacuum submenu theraphy icon
    concentrationId:             appIconId + "concentration",
    flowId:                      appIconId + "flow",
    timeId:                      appIconId + "time",
    volumeId:                    appIconId + "volume",
    voulumeTimeId:               appIconId + "voulumeTime",
    voulumeDoseId:               appIconId + "voulumeDose",
    timeDoseId:                  appIconId + "timeDose",
    doseId:                      appIconId + "dose",
    bagTimeId:                   appIconId + "bagTime",
    vacuumTimeId:                appIconId + "vacuumTime",
    parameterId:                 appIconId + "parameter",
    constantId:                  appIconId + "constant",
    configId:                    appIconId + "config",
    helpId:                      appIconId + "help",
    exitHelpId:                  appIconId + "endHelp",
    helpDocId:                   appIconId + "helpDoc",
    helpTutorialVideoId:         appIconId + "helpTutorialVideo",
    helpConnectionImgId:         appIconId + "helpConnectionImg",
    helpTherapyVideoId:          appIconId + "helpTherapyVideo",
    helpTroubleShootDocId:       appIconId + "helpTroubleShootDoc",
    helpSuggestionBubbleId:      appIconId + "helpSuggestionBubble",
    playId:                      appIconId + "play",
    pauseId:                     appIconId + "pause",
    stopId:                      appIconId + "stop",
    pressureMetterId:            appIconId + "pressureMetter",
    voidBottleId:                appIconId + "voidBottle",
    bloodBottleId:               appIconId + "bloodBottle",
    cleanTimeId:                 appIconId + "cleanTime",
    pressureId:                  appIconId + "pressure",
    ipId:                        appIconId + "ip",
    reinfusionTimeId:            appIconId + "reinfusionTime",
    salineTimeId:                appIconId + "salineTime",                // saline time icon
    liquidVolumeId:              appIconId + "liquidVolume",
    salineVolumeId:              appIconId + "salineVolume",
    voidBottleGadgetId:          appIconId + "voidBottleGadget",          // void bottle for blood volume gadget icon
    patientWeight1Id:            appIconId + "patientWeight1",            // patient weightId for blood volume gadget icon
    patientWeight2Id:            appIconId + "patientWeight2",            // patient weightId for saline hemotherapy gadgetet icon
    cyclesCounterId:             appIconId + "cyclesCounter",             // cycles counter icon
    shakeBottleGifId:            appIconId + "shakeBottleGif",            // shake bottle gif
    fillBloodBottleId:           appIconId + "fillBloodBottle",           // fill bottle gif
    emptyBloodBottleId:          appIconId + "emptyBloodBottle",          // clear out bottle gif
    fillSalineBottleId:          appIconId + "fillSalineBottle",          // fill bottle gif
    emptySalineBottleId:         appIconId + "emptySalineBottle",         // clear out bottle gif
    dcGifId:                     appIconId + "dcGif",                     // DC gif
    emergPlayPauseFrameGreenId:  appIconId + "emergPlayPauseGreenFrame",  // emergency play-pause big buttom frame icon
    emergPlayPauseFrameOrangeId: appIconId + "emergPlayPauseOrangeFrame", // emergency play-pause big buttom frame icon
    voidPlayId:                  appIconId + "voidPlay",                  // void play icon
    voidPauseId:                 appIconId + "voidPause",                 // void pause icon
    minimizeFrameGreenId:        appIconId + "minimizeFrameGreen",        // minimize emergency play-pause big buttom frame icon
    minimizeFrameOrangeId:       appIconId + "minimizeFrameOrenge",       // minimize emergency play-pause big buttom frame icon
    maximizeFramePlayId:         appIconId + "maximizeFramePlay",         // maximize emergency play-pause big buttom frame while in play mode icon
    maximizeFramePauseId:        appIconId + "maximizeFramePause",        // maximize emergency play-pause big buttom frame while in pause mode icon
    syringeCaculatorId:          appIconId + "syringeCaculator",          // syringe calculator icon
    salineHemoTherapyCalcId:     appIconId + "salineHemoTherapyCalc",     // saline hemotherapy calculator icon
    bloodCaculatorId:            appIconId + "bloodCaculator",            // blood calculator icon
    checkPressureId:             appIconId + "checkPressure",             // check pressure icon
    doneId:                      appIconId + "done",                      // done icon
    backId:                      appIconId + "back",                      // back icon
    saveId:                      appIconId + "save",                      // save icon
    closeId:                     appIconId + "close",                     // close icon
    equalCyclesId:               appIconId + "equalCycles",               // equal cycles icon
    differentCyclesId:           appIconId + "differentCycles",           // different cycles icon
    smallCyclesCounterId:        appIconId + "smallCyclesCounter",        // small cycles counter icon
    sliderRangeId:               appIconId + "sliderRange",               // slider range icon
    savingGifId:                 appIconId + "savingGif",                 // saving gif
    normalizationGifId:          appIconId + "normalizationGif",          // normalization gif
    presureAlertId:              appIconId + "presureAlert",              // presure alert icon
    pressurePointerId:           appIconId + "pressurePointer",           // presure indicator pointer icon
    pressureLimitPointer1Id:     appIconId + "pressureLimitPointer1",     // presure limit indicator pointer 1 icon
    pressureLimitPointer2Id:     appIconId + "pressureLimitPointer2",     // presure limit indicator pointer 2 icon
    overPressureId:              appIconId + "overPressure",              // over presure icon
    syringeFillGifId:            appIconId + "syringeFillGif",            // syringe fill gif
    syringeTherapyId:            appIconId + "syringeTherapy",            // syringe therapy icon
    videoPlayId:                 appIconId + "videoPlay",                 // play video icon
    videoRewindId:               appIconId + "videoRewind",               // rewind video icon
    videoPauseId:                appIconId + "videoPause",                // pause video icon
    videoForwardId:              appIconId + "videoForward",              // forward video icon
    videoCancelId:               appIconId + "videoCancel",               // cancel video icon
    yesId:                       appIconId + "yes",                       // yes icon
    noId:                        appIconId + "no",                        // no icon
    previousVacuumYesId:         appIconId + "previousVacuumYes",         // previous vacuum yes icon
    previousVacuumNoId:          appIconId + "previousVacuumNo",          // previous vacuum no icon
    normobaricTherapyId:         appIconId + "normobaricTherapy",         // normobaric therapy icon
    hiperbaricTherapyId:         appIconId + "hiperbaricTherapy",         // hiperbaric therapy icon
    normoHiperSelectorId:        appIconId + "normoHiperSelectorId",      // normobaric/hiperbaric selector icon
    keyboradId:                  appIconId + "keyborad",                  // keyboard icon
    backPinpadId:                appIconId + "backPinpad",                // back pin pad icon
    clearPinpadId:               appIconId + "clearPinpad",               // clear pin pad icon
    lockId:                      appIconId + "lock",                      // lock icon
    unLockId:                    appIconId + "unLock",                    // unlock icon
    checkCircleId:               appIconId + "checkCircle",               // check circle icon
    cancelCircleId:              appIconId + "cancelCircle",              // cancel circle icon
    errorCircleId:               appIconId + "errorCircle",               // error circle icon
    docViewerRewindId:           appIconId + "docViewerRewind",           // rewind document icon
    docViewerForwardId:          appIconId + "docViewerForward",          // forward document icon
    docViewerCancelId:           appIconId + "docViewerCancel",           // cancel document icon
    cyclesForQuestion:           appIconId + "cyclesForQuestion",         // cycles for question
    nextCycleQuestionMark:       appIconId + "nextCycleQuestionMark",     // next cycle question mark
    busyIndicator:               appIconId + "busyIndicator",             // busy indicator animation
    bloodPushId:                 appIconId + "bloodPush",                 // blood push button for autohemo
    bloodPushArrowId:            appIconId + "bloodPushArrow",            // blood push arrow for autohemo
    restartId:                   appIconId + "restart",                   // restart
    startUpAnimation1Id:         appIconId + "startUpAnimation1",         // start up resources
    startUpAnimation2Id:         appIconId + "startUpAnimation2",         // start up resources
    startUpAnimation3Id:         appIconId + "startUpAnimation3",         // start up resources
    viewStartUpInfoId:           appIconId + "viewStartUpInfo",           // start up resources
    noViewStartUpInfoId:         appIconId + "noViewStartUpInfo",         // start up resources
    skipStartUpErrorId:          appIconId + "skipStartUpError",          // start up resources
    setDateId:                   appIconId + "setDate",                   // set up date
    setTimeId:                   appIconId + "setTime",                   // set up time
    doseTypeId:                  appIconId + "doseType",                  // low, medium, high dose
    timeOutId:                   appIconId + "timeout",                   // time out icon
}

var dbAppIconElementsInit = [
    { name: dbAppIcon.option1Id,                   value: path + "ImgDB/JERINGA 04 192x192.png" },
    { name: dbAppIcon.option1_1Id,                 value: path + "ImgDB/JERINGA 06 192x192.png" },
    { name: dbAppIcon.option1_2Id,                 value: path + "ImgDB/ManualSyringe 03 192x192.png" },
    { name: dbAppIcon.option2Id,                   value: path + "ImgDB/Saline HemoTherapy  02.png" },
    { name: dbAppIcon.option3Id,                   value: path + "ImgDB/BOLSA 02 192x192.png" },
    { name: dbAppIcon.option3_1Id,                 value: path + "ImgDB/BOLSA CON ENTRADA 03 192x192.png" },
    { name: dbAppIcon.option3_2Id,                 value: path + "ImgDB/BOLSA CON ENTRADA Y SALIDA 03 192x192.png" },
    { name: dbAppIcon.option5Id,                   value: path + "ImgDB/Dose Blood 01.png" },
    { name: dbAppIcon.option5_1Id,                 value: path + "ImgDB/Autohemo Blood 01.png" },
    { name: dbAppIcon.option5_2Id,                 value: path + "ImgDB/Bottle Spoon 00.png" },
    { name: dbAppIcon.option4Id,                   value: path + "ImgDB/INSUFLACION 03 192x192.png" },
    { name: dbAppIcon.option4_1Id,                 value: path + "ImgDB/INSUFLACION VAGINAL 01 192x192.png" },
    { name: dbAppIcon.option4_2Id,                 value: path + "ImgDB/INSUFLACION RECTAL 01 192x192.png" },
    { name: dbAppIcon.option6Id,                   value: path + "ImgDB/OZONIZADO LIQUIDOS 03.png" },
    { name: dbAppIcon.option6_1Id,                 value: path + "ImgDB/OZONIZADO SALINA 03.png" },
    { name: dbAppIcon.option6_2Id,                 value: path + "ImgDB/OZONIZADO AGUA 03.png" },
    { name: dbAppIcon.option6_3Id,                 value: path + "ImgDB/OZONIZADO ACEITE 03.png" },
    { name: dbAppIcon.option7Id,                   value: path + "ImgDB/VACIO 02 192x192.png" },
    { name: dbAppIcon.option7_1Id,                 value: path + "ImgDB/VACIO TIEMPO 03 192x192.png" },
    { name: dbAppIcon.option7_2Id,                 value: path + "ImgDB/VACIO Pressure 03 192x192.png" },
    { name: dbAppIcon.concentrationId,             value: path + "ImgDB/OZONO 02.png" },
    { name: dbAppIcon.flowId,                      value: path + "ImgDB/Flow_white.png" },
    { name: dbAppIcon.timeId,                      value: path + "ImgDB/ic_schedule_white_48dp.png" },
    { name: dbAppIcon.volumeId,                    value: path + "ImgDB/MATRAZ O3 03.png" },
    { name: dbAppIcon.voulumeTimeId,               value: path + "ImgDB/VOLUMEN TIEMPO 03 192x192.png" },
    { name: dbAppIcon.voulumeDoseId,               value: path + "ImgDB/Dosis Volumen_00.png" },
    { name: dbAppIcon.timeDoseId,                  value: path + "ImgDB/Dosis tiempo_00.png" },
    { name: dbAppIcon.doseId,                      value: path + "ImgDB/spoon_04.png" },
    { name: dbAppIcon.bagTimeId,                   value: path + "ImgDB/BOLSA TIEMPO 02 192x192.png" },
    { name: dbAppIcon.vacuumTimeId,                value: path + "ImgDB/VACIO TIEMPO 02 192x192.png" },
    { name: dbAppIcon.parameterId,                 value: path + "ImgDB/Output parameters 00.png" },
    { name: dbAppIcon.constantId,                  value: path + "ImgDB/BOCADILLO 01.png" },
    { name: dbAppIcon.configId,                    value: path + "ImgDB/ic_settings_white_48dp.png" },
    { name: dbAppIcon.helpId,                      value: path + "ImgDB/ic_help_outline_white_48dp.png" },
    { name: dbAppIcon.exitHelpId,                  value: path + "ImgDB/ic_exit_help_outline_white_48dp.png" },
    { name: dbAppIcon.helpDocId,                   value: path + "ImgDB/READ MANUAL 01.png" },
    { name: dbAppIcon.helpTutorialVideoId,         value: path + "ImgDB/TOUCH 01.png" },
    { name: dbAppIcon.helpConnectionImgId,         value: path + "ImgDB/Connection 01 192x192.png" },
    { name: dbAppIcon.helpTherapyVideoId,          value: path + "ImgDB/MOVIE 01.png" },
    { name: dbAppIcon.helpTroubleShootDocId,       value: path + "ImgDB/TROUBLESHOOTING 02.png" },
    { name: dbAppIcon.helpSuggestionBubbleId,      value: path + "ImgDB/BOCADILLO 04.png" },
    { name: dbAppIcon.playId,                      value: path + "ImgDB/ic_play_circle_outline_white_48dp.png" },
    { name: dbAppIcon.pauseId,                     value: path + "ImgDB/ic_pause_circle_outline_white_48dp.png" },
    { name: dbAppIcon.stopId,                      value: path + "ImgDB/ic_stop_circle_outline_white_48dp.png" },
    { name: dbAppIcon.pressureMetterId,            value: path + "ImgDB/check_pressure_02.png" },
    { name: dbAppIcon.voidBottleId,                value: path + "ImgDB/DOSIS 04 192x192.png" },
    { name: dbAppIcon.bloodBottleId,               value: path + "ImgDB/DOSIS 06 LLENA192x192.png" },
    { name: dbAppIcon.cleanTimeId,                 value: path + "ImgDB/VACIO TIEMPO 02 192x192.png" },
    { name: dbAppIcon.pressureId,                  value: path + "ImgDB/OverPressure_01.png" },
    { name: dbAppIcon.ipId,                        value: path + "ImgDB/IpIndex_02.png" },
    { name: dbAppIcon.reinfusionTimeId,            value: path + "ImgDB/ReinfusionTime_10.png" },
    { name: dbAppIcon.salineTimeId,                value: path + "ImgDB/SalineBubling_03.png" },
    { name: dbAppIcon.liquidVolumeId,              value: path + "ImgDB/VOLUMEN 02 192x192.png" },
    { name: dbAppIcon.salineVolumeId,              value: path + "ImgDB/SalineVolume01.png" },
    { name: dbAppIcon.voidBottleGadgetId,          value: path + "ImgDB/Botella vacia 03.png" },
    { name: dbAppIcon.patientWeight1Id,            value: path + "ImgDB/Peso paciente 00.png" },
    { name: dbAppIcon.patientWeight2Id,            value: path + "ImgDB/Peso paciente 00.png" },
    { name: dbAppIcon.cyclesCounterId,             value: path + "ImgDB/Cicles_00.png" },
    { name: dbAppIcon.shakeBottleGifId,            value: path + "ImgDB/Botella vacia_02_fixSizeOpt.gif" },
    { name: dbAppIcon.fillBloodBottleId,           value: path + "ImgDB/Botella vacia_02_04_fixSizeOpt.gif" },
    { name: dbAppIcon.emptyBloodBottleId,          value: path + "ImgDB/Botella vacia_02__00_fixSizeOpt.gif" },
    { name: dbAppIcon.fillSalineBottleId,          value: path + "ImgDB/ExtraccionSalino_02.gif" },
    { name: dbAppIcon.emptySalineBottleId,         value: path + "ImgDB/Reinfusion Salino 00.gif" },
    { name: dbAppIcon.dcGifId,                     value: path + "ImgDB/DC_0_000.gif" },
    { name: dbAppIcon.emergPlayPauseFrameGreenId,  value: path + "ImgDB/MarcoPausa_04_fixSize_Green.png" },
    { name: dbAppIcon.emergPlayPauseFrameOrangeId, value: path + "ImgDB/MarcoPausa_04_fixSize_Orange.png" },
    { name: dbAppIcon.voidPlayId,                  value: path + "ImgDB/play_00_fixSize.png" },
    { name: dbAppIcon.voidPauseId,                 value: path + "ImgDB/pause_00_fixSize.png" },
    { name: dbAppIcon.minimizeFrameGreenId,        value: path + "ImgDB/Minimizar_00_Green.png" },
    { name: dbAppIcon.minimizeFrameOrangeId,       value: path + "ImgDB/Minimizar_00_Orange.png" },
    { name: dbAppIcon.maximizeFramePlayId,         value: path + "ImgDB/MaximizarPlay_00_Orange.png" },
    { name: dbAppIcon.maximizeFramePauseId,        value: path + "ImgDB/MaximizarPause_00_Green.png" },
    { name: dbAppIcon.syringeCaculatorId,          value: path + "ImgDB/Syringe calculator 00 192x192.png" },
    { name: dbAppIcon.salineHemoTherapyCalcId,     value: path + "ImgDB/Concentration Calculator 00.png" },
    { name: dbAppIcon.bloodCaculatorId,            value: path + "ImgDB/Blood Calculator 02.png" },
    { name: dbAppIcon.checkPressureId,             value: path + "ImgDB/check_pressure_02.png" },
    { name: dbAppIcon.doneId,                      value: path + "ImgDB/ic_done_white_48dp.png" },
    { name: dbAppIcon.backId,                      value: path + "ImgDB/ic_back_white_48dp_02.png" },
    { name: dbAppIcon.saveId,                      value: path + "ImgDB/ic_save_white_48dp.png" },
    { name: dbAppIcon.closeId,                     value: path + "ImgDB/ic_clear_white_48dp.png" },
    { name: dbAppIcon.equalCyclesId,               value: path + "ImgDB/CiclosEqual_001.png" },
    { name: dbAppIcon.differentCyclesId,           value: path + "ImgDB/CiclosDiferent_001.png" },
    { name: dbAppIcon.smallCyclesCounterId,        value: path + "ImgDB/Ciclos_001.png" },
    { name: dbAppIcon.sliderRangeId,               value: path + "ImgDB/sliderRange_02.png" },
    { name: dbAppIcon.savingGifId,                 value: path + "ImgDB/SAVING_0_2.gif" },
    { name: dbAppIcon.normalizationGifId,          value: path + "ImgDB/NORMALIZACION _0_002.gif" },
    { name: dbAppIcon.presureAlertId,              value: path + "ImgDB/OverPressure_01.png" },
    { name: dbAppIcon.pressurePointerId,           value: path + "ImgDB/pressure indicator_00.png" },
    { name: dbAppIcon.pressureLimitPointer1Id,     value: path + "ImgDB/pressure indicator_limit_05.png" },
    { name: dbAppIcon.pressureLimitPointer2Id,     value: path + "ImgDB/pressure indicator_limit_06.png" },
    { name: dbAppIcon.overPressureId,              value: path + "ImgDB/OverPressure_00.png" },
    { name: dbAppIcon.syringeFillGifId,            value: path + "ImgDB/JERINGA TIEMPO ANIMA 03 500x500.gif" },
    { name: dbAppIcon.syringeTherapyId,            value: path + "ImgDB/JERINGA 04 192x192.png" },
    { name: dbAppIcon.videoPlayId,                 value: path + "ImgDB/baseline_play_arrow_white_48.png" },
    { name: dbAppIcon.videoRewindId,               value: path + "ImgDB/baseline_fast_rewind_white_48.png" },
    { name: dbAppIcon.videoPauseId,                value: path + "ImgDB/baseline_pause_white_48.png" },
    { name: dbAppIcon.videoForwardId,              value: path + "ImgDB/baseline_fast_forward_white_48.png" },
    { name: dbAppIcon.videoCancelId,               value: path + "ImgDB/baseline_clear_white_48.png" },
    { name: dbAppIcon.yesId,                       value: path + "ImgDB/ic_done_white_48dp.png" },
    { name: dbAppIcon.noId,                        value: path + "ImgDB/ic_clear_white_48dp.png" },
    { name: dbAppIcon.previousVacuumYesId,         value: path + "ImgDB/VACIO 02 192x192.png" },
    { name: dbAppIcon.previousVacuumNoId,          value: path + "ImgDB/NO_VACIO 02 192x192.png" },
    { name: dbAppIcon.normobaricTherapyId,         value: path + "ImgDB/medidor presion_00.png" },
    { name: dbAppIcon.hiperbaricTherapyId,         value: path + "ImgDB/medidor presion_01.png" },
    { name: dbAppIcon.normoHiperSelectorId,        value: path + "ImgDB/medidor presion_02.png" },
    { name: dbAppIcon.keyboradId,                  value: path + "ImgDB/outline_keyboard_white_48_01.png" },
    { name: dbAppIcon.backPinpadId,                value: path + "ImgDB/ic_backspace_white_48dp.png" },
    { name: dbAppIcon.clearPinpadId,               value: path + "ImgDB/ic_clear_white_48dp.png" },
    { name: dbAppIcon.lockId,                      value: path + "ImgDB/outline_lock_white_48.png" },
    { name: dbAppIcon.unLockId,                    value: path + "ImgDB/outline_lock_open_white_48.png" },
    { name: dbAppIcon.checkCircleId,               value: path + "ImgDB/ic_check_circle_white_48dp.png" },
    { name: dbAppIcon.cancelCircleId,              value: path + "ImgDB/baseline_cancel_white_48.png" },
    { name: dbAppIcon.errorCircleId,               value: path + "ImgDB/baseline_error_white_48.png" },
    { name: dbAppIcon.docViewerRewindId,           value: path + "ImgDB/baseline_fast_rewind_white_48.png" },
    { name: dbAppIcon.docViewerForwardId,          value: path + "ImgDB/baseline_fast_forward_white_48.png" },
    { name: dbAppIcon.docViewerCancelId,           value: path + "ImgDB/baseline_clear_white_48.png" },
    { name: dbAppIcon.cyclesForQuestion,           value: path + "ImgDB/CiclesForQuestion_01.png" },
    { name: dbAppIcon.nextCycleQuestionMark,       value: path + "ImgDB/QuestionMark_01.png" },
    { name: dbAppIcon.busyIndicator,               value: path + "ImgDB/BusyIndicator01.gif" },
    { name: dbAppIcon.bloodPushId,                 value: path + "ImgDB/BLOOD PUSH 01 192x192.png" },
    { name: dbAppIcon.bloodPushArrowId,            value: path + "ImgDB/Push blood arrow 00.png" },
    { name: dbAppIcon.restartId,                   value: path + "ImgDB/Restart_00.gif" },
    { name: dbAppIcon.startUpAnimation1Id,         value: path + "ImgDB/sedecal-OM302-3-8-seg-A_Modified_B01.gif" },
    { name: dbAppIcon.startUpAnimation2Id,         value: path + "ImgDB/Sedecal-Logo_Symbol-1_00.gif" },
    { name: dbAppIcon.startUpAnimation3Id,         value: path + "ImgDB/Sedecal-Full_logo-1_00.gif" },
    { name: dbAppIcon.viewStartUpInfoId,           value: path + "ImgDB/outline_info_white_48_02.png" },
    { name: dbAppIcon.noViewStartUpInfoId,         value: path + "ImgDB/outline_no_info_white_48_02.png" },
    { name: dbAppIcon.skipStartUpErrorId,          value: path + "ImgDB/skip_error_01.png" },
    { name: dbAppIcon.setDateId,                   value: path + "ImgDB/setDate_01.png" },
    { name: dbAppIcon.setTimeId,                   value: path + "ImgDB/setTime_00.png" },
    { name: dbAppIcon.doseTypeId,                  value: path + "ImgDB/Saline gadget dose 00.png" },
    { name: dbAppIcon.timeOutId,                   value: path + "ImgDB/timeout_00.png" },
]


//
// BRAND NAME PARAMENTERS
//
var brandNameId = "appBrandName_"
var dbBrandName ={
    companyNameId:  brandNameId + "companyName",
    businessNameId: brandNameId + "businessName",
    deviceNameId:   brandNameId + "equipmentName"
}
var dbBrandNameElementsInit = [
    { name: dbBrandName.companyNameId,  value: "SEDECAL" },
    { name: dbBrandName.businessNameId, value: "--" }, // deprecated, not used here. Implemented on languages
    { name: dbBrandName.deviceNameId,   value: "OM 302" }
]

//
// DEVICE LIMITS
//
var deviceLimitsId = "applimit_"
var dbDeviceLimits ={
    overpressureSyringeId:          deviceLimitsId + "overpressureSyringe",
    overpressureManualSyringeId:    deviceLimitsId + "overpressureManualSyringe",
    overpressureDoseId:             deviceLimitsId + "overpressureDose",
    overpressureClosedBagId:        deviceLimitsId + "overpressureClosedBag",
    overpressureOpenedBagId:        deviceLimitsId + "overpressureOpenedBag",
    overpressureAutohemoId:         deviceLimitsId + "overpressureAutohemo",
    overpressureSalineHemoId:       deviceLimitsId + "overpressureSalineHemo",
    overpressureInsufflationVId:    deviceLimitsId + "overpressureInsufflationV",
    overpressureInsufflationRId:    deviceLimitsId + "overpressureInsufflationR",
    overpressureSalineId:           deviceLimitsId + "overpressureSaline",
    overpressureWaterId:            deviceLimitsId + "overpressureWater",
    overpressureOilId:              deviceLimitsId + "overpressureOil",
    overpressureVacuumId:           deviceLimitsId + "overpressureVacuum",
    overpressureBloodReinfusionId:  deviceLimitsId + "overpressureBloodReinfusion",
    overpressureSalineReinfusionId: deviceLimitsId + "overpressureSalineReinfusion",
    maxAutohemoCyclesId:            deviceLimitsId + "maxAutohemoCycles",
    pressureIdicatorDownLimitId:    deviceLimitsId + "pressureIdicatorDownLimit"
}

var deviceLimitsElementsInit = [
    { name: dbDeviceLimits.overpressureSyringeId,          value: "700" },   // mbar
    { name: dbDeviceLimits.overpressureManualSyringeId,    value: "450" },   // mbar
    { name: dbDeviceLimits.overpressureDoseId,             value: "700" },   // mbar
    { name: dbDeviceLimits.overpressureClosedBagId,        value: "200" },   // mbar
    { name: dbDeviceLimits.overpressureOpenedBagId,        value: "200" },   // mbar
//  { name: dbDeviceLimits.overpressureAutohemoId,         value: "500" },   // mbar
    { name: dbDeviceLimits.overpressureAutohemoId,         value: "700" },   // mbar  // #4833
    { name: dbDeviceLimits.overpressureSalineHemoId,       value: "500" },   // mbar
    { name: dbDeviceLimits.overpressureInsufflationVId,    value: "200" },   // mbar
    { name: dbDeviceLimits.overpressureInsufflationRId,    value: "200" },   // mbar
    { name: dbDeviceLimits.overpressureSalineId,           value: "500" },   // mbar
    { name: dbDeviceLimits.overpressureWaterId,            value: "500" },   // mbar
    { name: dbDeviceLimits.overpressureOilId,              value: "500" },   // mbar
    { name: dbDeviceLimits.overpressureVacuumId,           value: "-800" },  // mbar
    { name: dbDeviceLimits.overpressureBloodReinfusionId,  value: "200" },   // mbar
    { name: dbDeviceLimits.overpressureSalineReinfusionId, value: "200" },   // mbar
    { name: dbDeviceLimits.maxAutohemoCyclesId,            value: "5" },
    { name: dbDeviceLimits.pressureIdicatorDownLimitId,    value: "-450" },  // mbar
]

//
// DEVICE CONSTANTS
//
var constansId = "appConstant_"
var dbConstants ={
    pinCodeId:                               constansId + "pinCode",
    saveScreenTimeOutId:                     constansId + "saveScreenTimeOut",
    salineSaturationTimeFactorId:            constansId + "salineSaturationTimeFactor",
    salineFactor1Id:                         constansId + "salineFactor1",
    salineFactor2Id:                         constansId + "salineFactor2",
    waterSaturationTimeFactorId:             constansId + "waterSaturationTimeFactor",
    waterFactor1Id:                          constansId + "waterFactor1",
    waterFactor2Id:                          constansId + "waterFactor2",
    oilFactorId:                             constansId + "oilFactor",
    autohemoMixTimeId:                       constansId + "autohemoMixTime",
    autohemoHiperbaricFactorId:              constansId + "autohemoHiperbaricFactor",
    bloodVolMaxPatientWeightId:              constansId + "bloodVolMaxPatientWeight",
    bloodVolWeightToBloodFactorId:           constansId + "bloodVolWeightToBloodFactor",
    salineHemoTherapyCalcMaxPatientWeightId: constansId + "salineHemoTherapyCalcMaxPatientWeight",
    salineHemoTherapyCalcMaxO3PerKgId:       constansId + "salineHemoTherapyCalcMaxO3PerKgId",
    defaultWaitingTimeId:                    constansId + "defaultWaitingTimeId",
}

var constantsElementsInit = [
    { name: dbConstants.pinCodeId,                                value: "8508474" }, //(((pin * 333) - 3) * 3)
    { name: dbConstants.saveScreenTimeOutId,                      value: "300000" },
    { name: dbConstants.salineSaturationTimeFactorId,             value: "5" },
    { name: dbConstants.salineFactor1Id,                          value: "0.24" },
    { name: dbConstants.salineFactor2Id,                          value: "0.048" },
    { name: dbConstants.waterSaturationTimeFactorId,              value: "5" },
    { name: dbConstants.waterFactor1Id,                           value: "0.27" },
    { name: dbConstants.waterFactor2Id,                           value: "0.054" },
    { name: dbConstants.oilFactorId,                              value: "11" },
    { name: dbConstants.autohemoMixTimeId,                        value: "120" },  // seconds
    { name: dbConstants.autohemoHiperbaricFactorId,               value: "1.5" },
    { name: dbConstants.bloodVolMaxPatientWeightId,               value: "500" },
    { name: dbConstants.bloodVolWeightToBloodFactorId,            value: "1.2" },
    { name: dbConstants.salineHemoTherapyCalcMaxPatientWeightId,  value: "1000" }, // kg
    { name: dbConstants.salineHemoTherapyCalcMaxO3PerKgId,        value: "50" },
    { name: dbConstants.defaultWaitingTimeId,                     value: "10" },
]

//
//  Socket commands   // Constants.O2_PUSH_STOP
//
var GET_DATA = "{GETDAT\r"
var GET_DATA_ACK = "{@GETDAT"
var GET_VER = "{GETVER\r"
var GET_VER_ACK = "{@GETVER"
var GET_PAR = "{GETPAR\r"
var GET_PAR_ACK = "{@GETPAR"
var GET_INFO = "{GETINFO\r"
var GET_INFO_ACK = "{@GETINFO"
var SLIDER_SIM_HEAD = "{SLD_SIM,"
var CNL_SIM = "{CNL_SIM\r"
var ENT_SIM = "{ENT_SIM\r"
var STOP_ST_UP = "{ST_UP_STOP"
var SOCKET_END = "\r"
var SERVICE_START = "{SERVICE\r"
var CALIBRATE_PRESS_START = "{CALPRESS\r"
var CALIBRATE_FLOW_START = "{CALFLOW\r"
var CALIBRATE_O3_START = "{CALO3\r"
var CALIBRATE_PRESS_FACTOR_START = "{CALPFACT\r"
var CALIBRATE_PERIOD_START = "{CALPER\r"
var SAVE_PARAMETERS_START = "{SAVEPAR\r"
var LOAD_PARAMETERS_START = "{LOADPAR\r"
var GET_TEXT_ACK = "{@TEXT"
var RESET_GENERATION_TIME = "{RSTGENTIME\r"
var KEEP_ALIVE = "{ALIVE\r"
var KEEP_ALIVE_ACK = "{@ALIVE"
var SET_PERIODIC_INFO_DELAY = "{SET_P_INFO,"
var SIMULATION_ERROR ="{SIM_ERROR"
var SYRINGE_START = "{SYRSTR,"
var MANUAL_START = "{MANSTR,"
var SALINE_START = "{SALINESTR,"
var CLOSED_BAG_START = "{CBAGSTR,"
var OPEN_BAG_START = "{OBAGSTR,"
var AUTOHEMO_START = "{AUTOSTR,"
var DOSE_START = "{DOSESTR,"
var VAGINAL_INSUFF_START = "{INSSTR_V,"
var RECTAL_INSUFF_START = "{INSSTR_R,"
var O3_START = "{O3STR,"
var VACUUM_BY_TIME_START = "{TVACSTR,"
var VACUUM_BY_PRESSURE_START = "{PVACSTR,"
var O2_PUSH_START = "{STR_PUSH,"
var O2_PUSH_STOP = "{STP_PUSH\r"

//
//  Text sockets constants
//
var TS_START_UP_MSG = "Start up ->"

//
// Language database generation
//

// some language DB ientifiers (do notchange)
var dbLanguageNumberOfTextsId = "dbLang_TextsNumber"
var dbLanguageNumberOflanguagesId = "dbLang_LanguagesNumber"
var dbLanguageSelectedLanguageId = "dbLang_SelectedLanguage"
var dbLanguageId = "dblang_Id_"
var dbLanguageNameId = "dblang_Name_"
var dbLanguageTextId = "dblang_Text_"
var dbLanguageAvailableId = "dblang_Available_"
var dbLanguageKeyboardLocaleId = "dblang_KeyboardLocale_"

// language DB identifiers for each language (complete for each new language)
var spanishLanguageId   = "Esp_"
var englishLanguageId   = "Eng_"
var chineseLanguageId   = "Chi_"
var portugeseLanguageId = "Por_"
var russianLanguageId   = "Rus_"
var germanLanguageId    = "Ger_"
var italianLanguageId   = "Ita_"
var frenchLanguageId    = "Fre_"
var hindiLanguageId     = "Hin_"
var arabicLanguageId    = "Ara_"

// default language selected
var dbLanguageSelectedLanguage = 1 // 1 -> english

// name for each language in language selector (complete for each new language)
var dbLanguageFields = [
    { available: dbLanguageAvailableId + "0", available_val: "true",   name: dbLanguageNameId + "0", name_value: "Español",   id: dbLanguageId + "0", id_value: spanishLanguageId,   locale_keyboardId: dbLanguageKeyboardLocaleId + "0", locale_keyboard_val: "es_ES" },
    { available: dbLanguageAvailableId + "1", available_val: "true",   name: dbLanguageNameId + "1", name_value: "English",   id: dbLanguageId + "1", id_value: englishLanguageId,   locale_keyboardId: dbLanguageKeyboardLocaleId + "1", locale_keyboard_val: "en_GB" },
    { available: dbLanguageAvailableId + "2", available_val: "true",   name: dbLanguageNameId + "2", name_value: "中国人",     id: dbLanguageId + "2", id_value: chineseLanguageId,   locale_keyboardId: dbLanguageKeyboardLocaleId + "2", locale_keyboard_val: "zh_TW"},
    { available: dbLanguageAvailableId + "3", available_val: "true",   name: dbLanguageNameId + "3", name_value: "Portugese", id: dbLanguageId + "3", id_value: portugeseLanguageId, locale_keyboardId: dbLanguageKeyboardLocaleId + "3", locale_keyboard_val: "pt_PT" },
    { available: dbLanguageAvailableId + "4", available_val: "true",   name: dbLanguageNameId + "4", name_value: "русский",   id: dbLanguageId + "4", id_value: russianLanguageId,   locale_keyboardId: dbLanguageKeyboardLocaleId + "4", locale_keyboard_val: "ru_RU" },
    { available: dbLanguageAvailableId + "5", available_val: "true",   name: dbLanguageNameId + "5", name_value: "German",    id: dbLanguageId + "5", id_value: germanLanguageId,    locale_keyboardId: dbLanguageKeyboardLocaleId + "5", locale_keyboard_val: "de_DE" },
    { available: dbLanguageAvailableId + "6", available_val: "true",   name: dbLanguageNameId + "6", name_value: "Italian",   id: dbLanguageId + "6", id_value: italianLanguageId,   locale_keyboardId: dbLanguageKeyboardLocaleId + "6", locale_keyboard_val: "it_IT" },
    { available: dbLanguageAvailableId + "7", available_val: "true",   name: dbLanguageNameId + "7", name_value: "French",    id: dbLanguageId + "7", id_value: frenchLanguageId,    locale_keyboardId: dbLanguageKeyboardLocaleId + "7", locale_keyboard_val: "fr_FR" },
    { available: dbLanguageAvailableId + "8", available_val: "true",   name: dbLanguageNameId + "8", name_value: "हिन्दी",       id: dbLanguageId + "8", id_value: hindiLanguageId,     locale_keyboardId: dbLanguageKeyboardLocaleId + "8", locale_keyboard_val: "hi_IN" },
    { available: dbLanguageAvailableId + "9", available_val: "true",   name: dbLanguageNameId + "9", name_value: "عربي",      id: dbLanguageId + "9", id_value: arabicLanguageId,    locale_keyboardId: dbLanguageKeyboardLocaleId + "9", locale_keyboard_val: "ar_AR" },
]

// Spanish texts
var dbSpanishLanguageElementsInit = [
    { name: dbLanguageTextId + spanishLanguageId + "0",  value: "Presión & temperatura" },
    { name: dbLanguageTextId + spanishLanguageId + "1",  value: "Información del dispositivo" },
    { name: dbLanguageTextId + spanishLanguageId + "2",  value: "Ver parámetros" },
    { name: dbLanguageTextId + spanishLanguageId + "3",  value: "Cargar parámetros" },
    { name: dbLanguageTextId + spanishLanguageId + "4",  value: "Nombre del dispositivo" },
    { name: dbLanguageTextId + spanishLanguageId + "5",  value: "Resultado del arranque" },
    { name: dbLanguageTextId + spanishLanguageId + "6",  value: "Unidades & idioma" },
    { name: dbLanguageTextId + spanishLanguageId + "7",  value: "Fecha & hora" },
    { name: dbLanguageTextId + spanishLanguageId + "8",  value: "Pressión" },
    { name: dbLanguageTextId + spanishLanguageId + "9",  value: "Caudal" },
    { name: dbLanguageTextId + spanishLanguageId + "10", value: "Calibración de periodos" },
    { name: dbLanguageTextId + spanishLanguageId + "11", value: "Concentración de O3" },
    { name: dbLanguageTextId + spanishLanguageId + "12", value: "P. Factor" },
    { name: dbLanguageTextId + spanishLanguageId + "13", value: "Salvar parámetros" },
    { name: dbLanguageTextId + spanishLanguageId + "14", value: "Restablecer tiempo de generación" },
    { name: dbLanguageTextId + spanishLanguageId + "15", value: "Versiones de software: " },
    { name: dbLanguageTextId + spanishLanguageId + "16", value: "Sw de consola: " },
    { name: dbLanguageTextId + spanishLanguageId + "17", value: "Placa de control: " },
    { name: dbLanguageTextId + spanishLanguageId + "18", value: "Sw de interface:" },
    { name: dbLanguageTextId + spanishLanguageId + "19", value: "Tiempo de generación: " },
    { name: dbLanguageTextId + spanishLanguageId + "20", value: "Calibración de presión: " },
    { name: dbLanguageTextId + spanishLanguageId + "21", value: "Ganancia del sensor de O3: " },
    { name: dbLanguageTextId + spanishLanguageId + "22", value: "Periodo ini: " },
    { name: dbLanguageTextId + spanishLanguageId + "23", value: "Compensación de presión: " },
    { name: dbLanguageTextId + spanishLanguageId + "24", value: "Ganancia de caudal 1: " },
    { name: dbLanguageTextId + spanishLanguageId + "25", value: "Ganancia de caudal 2: " },
    { name: dbLanguageTextId + spanishLanguageId + "26", value: "Ganancia de caudal 3: " },
    { name: dbLanguageTextId + spanishLanguageId + "27", value: "Pulsos para 1 \u03BCg: " },
    { name: dbLanguageTextId + spanishLanguageId + "28", value: "O3 pulsos 1: " },
    { name: dbLanguageTextId + spanishLanguageId + "29", value: "O3 pulsos 2: " },
    { name: dbLanguageTextId + spanishLanguageId + "30", value: "O3 pulsos 3: " },
    { name: dbLanguageTextId + spanishLanguageId + "31", value: "Cargar parámetros" },
    { name: dbLanguageTextId + spanishLanguageId + "32", value: "Continuar?" },
    { name: dbLanguageTextId + spanishLanguageId + "33", value: "Nombre de la clínica" },
    { name: dbLanguageTextId + spanishLanguageId + "34", value: "Información de arranque" },
    { name: dbLanguageTextId + spanishLanguageId + "35", value: "Calibración de presión" },
    { name: dbLanguageTextId + spanishLanguageId + "36", value: "Calibración de caudal (paso 1)" },
    { name: dbLanguageTextId + spanishLanguageId + "37", value: "Intentar fijar 11 l/h (0,18 l/min)" },
    { name: dbLanguageTextId + spanishLanguageId + "38", value: "Medida externa (ml/min)" },
    { name: dbLanguageTextId + spanishLanguageId + "39", value: "Calibración de caudal (paso 2)" },
    { name: dbLanguageTextId + spanishLanguageId + "40", value: "Intentar fijar 21 l/h (0,35 l/min)" },
    { name: dbLanguageTextId + spanishLanguageId + "41", value: "Calibración de caudal (paso 3)" },
    { name: dbLanguageTextId + spanishLanguageId + "42", value: "Intentar fijar 44 l/h (0,66 l/min)" },
    { name: dbLanguageTextId + spanishLanguageId + "43", value: "Limpiando…" },
    { name: dbLanguageTextId + spanishLanguageId + "44", value: "Calibración de O3 (step 1)" },
    { name: dbLanguageTextId + spanishLanguageId + "45", value: "Intentar fijar 76 \u03BCg" },
    { name: dbLanguageTextId + spanishLanguageId + "46", value: "Calibración de O3 (step 2)" },
    { name: dbLanguageTextId + spanishLanguageId + "47", value: "Intentar fijar 47 \u03BCg" },
    { name: dbLanguageTextId + spanishLanguageId + "48", value: "Calibración de O3 (step 3)" },
    { name: dbLanguageTextId + spanishLanguageId + "49", value: "Intentar fijar 22 \u03BCg" },
    { name: dbLanguageTextId + spanishLanguageId + "50", value: "Calibración de O3 (step 4)" },
    { name: dbLanguageTextId + spanishLanguageId + "51", value: "Intentar fijar 1 \u03BCg" },
    { name: dbLanguageTextId + spanishLanguageId + "52", value: "Calibración del factor de compensación de presión" },
    { name: dbLanguageTextId + spanishLanguageId + "53", value: "Valor previo: " },
    { name: dbLanguageTextId + spanishLanguageId + "54", value: "Salvar parámetros" },
    { name: dbLanguageTextId + spanishLanguageId + "55", value: "Continuar?" },
    { name: dbLanguageTextId + spanishLanguageId + "56", value: "Continuar?" },
    { name: dbLanguageTextId + spanishLanguageId + "57", value: "Reiniciar por favor…" },
    { name: dbLanguageTextId + spanishLanguageId + "58", value: "Memoria" },
    { name: dbLanguageTextId + spanishLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + spanishLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + spanishLanguageId + "61", value: "Parámetros" },
    { name: dbLanguageTextId + spanishLanguageId + "62", value: "Base de datos: " },
]

// English texts
var dbEnglishLanguageElementsInit = [
    { name: dbLanguageTextId + englishLanguageId + "0",  value: "Pressure & temperature" },
    { name: dbLanguageTextId + englishLanguageId + "1",  value: "Device Information" },
    { name: dbLanguageTextId + englishLanguageId + "2",  value: "Show parameters" },
    { name: dbLanguageTextId + englishLanguageId + "3",  value: "Load parameters" },
    { name: dbLanguageTextId + englishLanguageId + "4",  value: "Device name" },
    { name: dbLanguageTextId + englishLanguageId + "5",  value: "Start up result" },
    { name: dbLanguageTextId + englishLanguageId + "6",  value: "Units & language" },
    { name: dbLanguageTextId + englishLanguageId + "7",  value: "Date & Time" },
    { name: dbLanguageTextId + englishLanguageId + "8",  value: "Pressure" },
    { name: dbLanguageTextId + englishLanguageId + "9",  value: "Flow" },
    { name: dbLanguageTextId + englishLanguageId + "10", value: "Period calibration" },
    { name: dbLanguageTextId + englishLanguageId + "11", value: "O3 concentration" },
    { name: dbLanguageTextId + englishLanguageId + "12", value: "P.Factor" },
    { name: dbLanguageTextId + englishLanguageId + "13", value: "Save parameters" },
    { name: dbLanguageTextId + englishLanguageId + "14", value: "Reset generation time" },
    { name: dbLanguageTextId + englishLanguageId + "15", value: "Software versions: " },
    { name: dbLanguageTextId + englishLanguageId + "16", value: "Console: " },
    { name: dbLanguageTextId + englishLanguageId + "17", value: "Control Board: " },
    { name: dbLanguageTextId + englishLanguageId + "18", value: "Interface sw: " },
    { name: dbLanguageTextId + englishLanguageId + "19", value: "Generation Time: " },
    { name: dbLanguageTextId + englishLanguageId + "20", value: "Calibration pressure: " },
    { name: dbLanguageTextId + englishLanguageId + "21", value: "O3 sensor gain: " },
    { name: dbLanguageTextId + englishLanguageId + "22", value: "Ini period: " },
    { name: dbLanguageTextId + englishLanguageId + "23", value: "Pressure compensation: " },
    { name: dbLanguageTextId + englishLanguageId + "24", value: "Flow gain 1: " },
    { name: dbLanguageTextId + englishLanguageId + "25", value: "Flow gain 2: " },
    { name: dbLanguageTextId + englishLanguageId + "26", value: "Flow gain 3: " },
    { name: dbLanguageTextId + englishLanguageId + "27", value: "1 \u03BCg pulses: " },
    { name: dbLanguageTextId + englishLanguageId + "28", value: "O3 pulses 1: " },
    { name: dbLanguageTextId + englishLanguageId + "29", value: "O3 pulses 2: " },
    { name: dbLanguageTextId + englishLanguageId + "30", value: "O3 pulses 3: " },
    { name: dbLanguageTextId + englishLanguageId + "31", value: "Load parameters" },
    { name: dbLanguageTextId + englishLanguageId + "32", value: "Continue?" },
    { name: dbLanguageTextId + englishLanguageId + "33", value: "Clinic Name" },
    { name: dbLanguageTextId + englishLanguageId + "34", value: "Start up info" },
    { name: dbLanguageTextId + englishLanguageId + "35", value: "Pressure calibration" },
    { name: dbLanguageTextId + englishLanguageId + "36", value: "Flow calibration (step 1)" },
    { name: dbLanguageTextId + englishLanguageId + "37", value: "Try to fix 11 l/h (0,18 l/min)" },
    { name: dbLanguageTextId + englishLanguageId + "38", value: "External measurement (ml/min)" },
    { name: dbLanguageTextId + englishLanguageId + "39", value: "Flow calibration (step 2)" },
    { name: dbLanguageTextId + englishLanguageId + "40", value: "Try to fix 21 l/h (0,35 l/min)" },
    { name: dbLanguageTextId + englishLanguageId + "41", value: "Flow calibration (step 3)" },
    { name: dbLanguageTextId + englishLanguageId + "42", value: "Try to fix 44 l/h (0,66 l/min)" },
    { name: dbLanguageTextId + englishLanguageId + "43", value: "Cleaning…" },
    { name: dbLanguageTextId + englishLanguageId + "44", value: "O3 calibration (step 1)" },
    { name: dbLanguageTextId + englishLanguageId + "45", value: "Try to fix 76 \u03BCg" },
    { name: dbLanguageTextId + englishLanguageId + "46", value: "O3 calibration (step 2)" },
    { name: dbLanguageTextId + englishLanguageId + "47", value: "Try to fix 47 \u03BCg" },
    { name: dbLanguageTextId + englishLanguageId + "48", value: "O3 calibration (step 3)" },
    { name: dbLanguageTextId + englishLanguageId + "49", value: "Try to fix 22 \u03BCg" },
    { name: dbLanguageTextId + englishLanguageId + "50", value: "O3 calibration (step 4)" },
    { name: dbLanguageTextId + englishLanguageId + "51", value: "Try to fix 1 \u03BCg" },
    { name: dbLanguageTextId + englishLanguageId + "52", value: "Pressure compensation factor calibration" },
    { name: dbLanguageTextId + englishLanguageId + "53", value: "Previous value: " },
    { name: dbLanguageTextId + englishLanguageId + "54", value: "Save parameters" },
    { name: dbLanguageTextId + englishLanguageId + "55", value: "Continue?" },
    { name: dbLanguageTextId + englishLanguageId + "56", value: "Continue?" },
    { name: dbLanguageTextId + englishLanguageId + "57", value: "Restart please…" },
    { name: dbLanguageTextId + englishLanguageId + "58", value: "Memory " },
    { name: dbLanguageTextId + englishLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + englishLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + englishLanguageId + "61", value: "Parameters " },
    { name: dbLanguageTextId + englishLanguageId + "62", value: "Database: " },
]

// Chinese texts
var dbChineseLanguageElementsInit = [
    { name: dbLanguageTextId + chineseLanguageId + "0",  value: "压力与温度" },
    { name: dbLanguageTextId + chineseLanguageId + "1",  value: "设备信息" },
    { name: dbLanguageTextId + chineseLanguageId + "2",  value: "显示参数" },
    { name: dbLanguageTextId + chineseLanguageId + "3",  value: "加载参数" },
    { name: dbLanguageTextId + chineseLanguageId + "4",  value: "设备名称" },
    { name: dbLanguageTextId + chineseLanguageId + "5",  value: "启动结果" },
    { name: dbLanguageTextId + chineseLanguageId + "6",  value: "单位和语言" },
    { name: dbLanguageTextId + chineseLanguageId + "7",  value: "约会时间" },
    { name: dbLanguageTextId + chineseLanguageId + "8",  value: "压力" },
    { name: dbLanguageTextId + chineseLanguageId + "9",  value: "流动" },
    { name: dbLanguageTextId + chineseLanguageId + "10", value: "周期校准" },
    { name: dbLanguageTextId + chineseLanguageId + "11", value: "氧气浓度" },
    { name: dbLanguageTextId + chineseLanguageId + "12", value: "P.因子" },
    { name: dbLanguageTextId + chineseLanguageId + "13", value: "保存参数" },
    { name: dbLanguageTextId + chineseLanguageId + "14", value: "重置生成时间" },
    { name: dbLanguageTextId + chineseLanguageId + "15", value: "软件版本： " },
    { name: dbLanguageTextId + chineseLanguageId + "16", value: "控制台软件： " },
    { name: dbLanguageTextId + chineseLanguageId + "17", value: "控制板： " },
    { name: dbLanguageTextId + chineseLanguageId + "18", value: "界面软件： " },
    { name: dbLanguageTextId + chineseLanguageId + "19", value: "产生时间： " },
    { name: dbLanguageTextId + chineseLanguageId + "20", value: "标定压力： " },
    { name: dbLanguageTextId + chineseLanguageId + "21", value: "O3传感器增益： " },
    { name: dbLanguageTextId + chineseLanguageId + "22", value: "初始时期： " },
    { name: dbLanguageTextId + chineseLanguageId + "23", value: "压力补偿： " },
    { name: dbLanguageTextId + chineseLanguageId + "24", value: "流量增益1： " },
    { name: dbLanguageTextId + chineseLanguageId + "25", value: "流量增益2： " },
    { name: dbLanguageTextId + chineseLanguageId + "26", value: "流量增益3： " },
    { name: dbLanguageTextId + chineseLanguageId + "27", value: "1 \u03BCg 脉冲数： " },
    { name: dbLanguageTextId + chineseLanguageId + "28", value: "O3脉冲1： " },
    { name: dbLanguageTextId + chineseLanguageId + "29", value: "O3脉冲2： " },
    { name: dbLanguageTextId + chineseLanguageId + "30", value: "O3脉冲3： " },
    { name: dbLanguageTextId + chineseLanguageId + "31", value: "加载参数" },
    { name: dbLanguageTextId + chineseLanguageId + "32", value: "继续？" },
    { name: dbLanguageTextId + chineseLanguageId + "33", value: "诊所名称" },
    { name: dbLanguageTextId + chineseLanguageId + "34", value: "启动信息" },
    { name: dbLanguageTextId + chineseLanguageId + "35", value: "压力校正" },
    { name: dbLanguageTextId + chineseLanguageId + "36", value: "流量校准（步骤1）" },
    { name: dbLanguageTextId + chineseLanguageId + "37", value: "尝试修复11 l/h （0.18 l/min）" },
    { name: dbLanguageTextId + chineseLanguageId + "38", value: "外部测量 (ml/min)" },
    { name: dbLanguageTextId + chineseLanguageId + "39", value: "流量校准（步骤2）" },
    { name: dbLanguageTextId + chineseLanguageId + "40", value: "尝试修复21 l/h （0.35 l/min）" },
    { name: dbLanguageTextId + chineseLanguageId + "41", value: "流量校准（步骤3）" },
    { name: dbLanguageTextId + chineseLanguageId + "42", value: "尝试修复44 l/h （0.66 l/min）" },
    { name: dbLanguageTextId + chineseLanguageId + "43", value: "打扫…" },
    { name: dbLanguageTextId + chineseLanguageId + "44", value: "O3校准（步骤1）" },
    { name: dbLanguageTextId + chineseLanguageId + "45", value: "尝试修复76 \u03BCg" },
    { name: dbLanguageTextId + chineseLanguageId + "46", value: "O3校准（步骤2）" },
    { name: dbLanguageTextId + chineseLanguageId + "47", value: "尝试修复47 \u03BCg" },
    { name: dbLanguageTextId + chineseLanguageId + "48", value: "O3校准（步骤3）" },
    { name: dbLanguageTextId + chineseLanguageId + "49", value: "尝试修复22 \u03BCg" },
    { name: dbLanguageTextId + chineseLanguageId + "50", value: "O3校准（步骤4）" },
    { name: dbLanguageTextId + chineseLanguageId + "51", value: "尝试修复1 \u03BCg" },
    { name: dbLanguageTextId + chineseLanguageId + "52", value: "压力补偿系数校准" },
    { name: dbLanguageTextId + chineseLanguageId + "53", value: "上一个值： " },
    { name: dbLanguageTextId + chineseLanguageId + "54", value: "保存参数" },
    { name: dbLanguageTextId + chineseLanguageId + "55", value: "继续？" },
    { name: dbLanguageTextId + chineseLanguageId + "56", value: "继续？" },
    { name: dbLanguageTextId + chineseLanguageId + "57", value: "请重新启动…" },
    { name: dbLanguageTextId + chineseLanguageId + "58", value: "记忆" },
    { name: dbLanguageTextId + chineseLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + chineseLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + chineseLanguageId + "61", value: "参数" },
    { name: dbLanguageTextId + chineseLanguageId + "62", value: "数据库: " }
]

// Portugese texts
var dbPortugeseLanguageElementsInit = [
    { name: dbLanguageTextId + portugeseLanguageId + "0",  value: "Pressão & temperatura" },
    { name: dbLanguageTextId + portugeseLanguageId + "1",  value: "Informante do dispositivo" },
    { name: dbLanguageTextId + portugeseLanguageId + "2",  value: "Mostrar parâmetros" },
    { name: dbLanguageTextId + portugeseLanguageId + "3",  value: "Parâmetros de carga" },
    { name: dbLanguageTextId + portugeseLanguageId + "4",  value: "Nome do dispositivo" },
    { name: dbLanguageTextId + portugeseLanguageId + "5",  value: "Resultado inicial" },
    { name: dbLanguageTextId + portugeseLanguageId + "6",  value: "Unidades e idioma" },
    { name: dbLanguageTextId + portugeseLanguageId + "7",  value: "Data hora" },
    { name: dbLanguageTextId + portugeseLanguageId + "8",  value: "Pressão" },
    { name: dbLanguageTextId + portugeseLanguageId + "9",  value: "Fluxo" },
    { name: dbLanguageTextId + portugeseLanguageId + "10", value: "Calibração de período" },
    { name: dbLanguageTextId + portugeseLanguageId + "11", value: "Concentração de O3" },
    { name: dbLanguageTextId + portugeseLanguageId + "12", value: "P.Factor" },
    { name: dbLanguageTextId + portugeseLanguageId + "13", value: "Salvar parâmetros" },
    { name: dbLanguageTextId + portugeseLanguageId + "14", value: "Reiniciar tempo de geração" },
    { name: dbLanguageTextId + portugeseLanguageId + "15", value: "Versões de software: " },
    { name: dbLanguageTextId + portugeseLanguageId + "16", value: "Console sw: " },
    { name: dbLanguageTextId + portugeseLanguageId + "17", value: "Painel de controle: " },
    { name: dbLanguageTextId + portugeseLanguageId + "18", value: "Interface sw: " },
    { name: dbLanguageTextId + portugeseLanguageId + "19", value: "Tempo de geração: " },
    { name: dbLanguageTextId + portugeseLanguageId + "20", value: "Pressão de calibração: " },
    { name: dbLanguageTextId + portugeseLanguageId + "21", value: "Ganho do sensor O3: " },
    { name: dbLanguageTextId + portugeseLanguageId + "22", value: "Período Ini: " },
    { name: dbLanguageTextId + portugeseLanguageId + "23", value: "Compensação de pressão: " },
    { name: dbLanguageTextId + portugeseLanguageId + "24", value: "Ganho de fluxo 1: " },
    { name: dbLanguageTextId + portugeseLanguageId + "25", value: "Ganho de fluxo 2: " },
    { name: dbLanguageTextId + portugeseLanguageId + "26", value: "Ganho de fluxo 3: " },
    { name: dbLanguageTextId + portugeseLanguageId + "27", value: "1 \u03BCg pulsos: " },
    { name: dbLanguageTextId + portugeseLanguageId + "28", value: "O3 pulsos 1: " },
    { name: dbLanguageTextId + portugeseLanguageId + "29", value: "O3 pulsos 2: " },
    { name: dbLanguageTextId + portugeseLanguageId + "30", value: "O3 pulsos 3: " },
    { name: dbLanguageTextId + portugeseLanguageId + "31", value: "Parâmetros de carga" },
    { name: dbLanguageTextId + portugeseLanguageId + "32", value: "Continuar?" },
    { name: dbLanguageTextId + portugeseLanguageId + "33", value: "Nome da Clínica" },
    { name: dbLanguageTextId + portugeseLanguageId + "34", value: "Informações de inicialização" },
    { name: dbLanguageTextId + portugeseLanguageId + "35", value: "Calibração de pressão" },
    { name: dbLanguageTextId + portugeseLanguageId + "36", value: "Calibração de fluxo (etapa 1)" },
    { name: dbLanguageTextId + portugeseLanguageId + "37", value: "Tente consertar 11 l/h (0,18 l/min)" },
    { name: dbLanguageTextId + portugeseLanguageId + "38", value: "Medição externa (ml / min)" },
    { name: dbLanguageTextId + portugeseLanguageId + "39", value: "Calibração de fluxo (etapa 2)" },
    { name: dbLanguageTextId + portugeseLanguageId + "40", value: "Tente consertar 21 l/h (0,35 l/min)" },
    { name: dbLanguageTextId + portugeseLanguageId + "41", value: "Calibração de fluxo (etapa 3)" },
    { name: dbLanguageTextId + portugeseLanguageId + "42", value: "Tente consertar 44 l/h (0,66 l/min)" },
    { name: dbLanguageTextId + portugeseLanguageId + "43", value: "Limpeza…" },
    { name: dbLanguageTextId + portugeseLanguageId + "44", value: "Calibração de O3 (etapa 1)" },
    { name: dbLanguageTextId + portugeseLanguageId + "45", value: "Tente consertar 76 \u03BCg" },
    { name: dbLanguageTextId + portugeseLanguageId + "46", value: "Calibração de O3 (etapa 2)" },
    { name: dbLanguageTextId + portugeseLanguageId + "47", value: "Tente consertar 47 \u03BCg" },
    { name: dbLanguageTextId + portugeseLanguageId + "48", value: "Calibração de O3 (etapa 3)" },
    { name: dbLanguageTextId + portugeseLanguageId + "49", value: "Tente consertar 22 \u03BCg" },
    { name: dbLanguageTextId + portugeseLanguageId + "50", value: "Calibração de O3 (etapa 4)" },
    { name: dbLanguageTextId + portugeseLanguageId + "51", value: "Tente consertar 1 \u03BCg" },
    { name: dbLanguageTextId + portugeseLanguageId + "52", value: "Calibração do fator de compensação de pressão" },
    { name: dbLanguageTextId + portugeseLanguageId + "53", value: "Valor anterior: " },
    { name: dbLanguageTextId + portugeseLanguageId + "54", value: "Salvar parâmetros" },
    { name: dbLanguageTextId + portugeseLanguageId + "55", value: "Continuar?" },
    { name: dbLanguageTextId + portugeseLanguageId + "56", value: "Continuar?" },
    { name: dbLanguageTextId + portugeseLanguageId + "57", value: "Reinicie por favor ..." },
    { name: dbLanguageTextId + portugeseLanguageId + "58", value: "Memória" },
    { name: dbLanguageTextId + portugeseLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + portugeseLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + portugeseLanguageId + "61", value: "Parâmetros" },
    { name: dbLanguageTextId + portugeseLanguageId + "62", value: "Base de dados: " }
]

// Russian texts
var dbRussianLanguageElementsInit = [
    { name: dbLanguageTextId + russianLanguageId + "0",  value: "Давление и температура" },
    { name: dbLanguageTextId + russianLanguageId + "1",  value: "Информация об устройстве" },
    { name: dbLanguageTextId + russianLanguageId + "2",  value: "Показать параметры" },
    { name: dbLanguageTextId + russianLanguageId + "3",  value: "Параметры нагрузки" },
    { name: dbLanguageTextId + russianLanguageId + "4",  value: "Имя устройства" },
    { name: dbLanguageTextId + russianLanguageId + "5",  value: "Результат запуска" },
    { name: dbLanguageTextId + russianLanguageId + "6",  value: "Единицы и язык" },
    { name: dbLanguageTextId + russianLanguageId + "7",  value: "Дата и время" },
    { name: dbLanguageTextId + russianLanguageId + "8",  value: "Давление" },
    { name: dbLanguageTextId + russianLanguageId + "9",  value: "Поток" },
    { name: dbLanguageTextId + russianLanguageId + "10", value: "Период калибровки" },
    { name: dbLanguageTextId + russianLanguageId + "11", value: "Концентрация O3" },
    { name: dbLanguageTextId + russianLanguageId + "12", value: "П. Фактор" },
    { name: dbLanguageTextId + russianLanguageId + "13", value: "Сохранить параметры" },
    { name: dbLanguageTextId + russianLanguageId + "14", value: "Сбросить время генерации" },
    { name: dbLanguageTextId + russianLanguageId + "15", value: "Программное обеспечение версий: " },
    { name: dbLanguageTextId + russianLanguageId + "16", value: "Консоль: " },
    { name: dbLanguageTextId + russianLanguageId + "17", value: "Пульт управления: " },
    { name: dbLanguageTextId + russianLanguageId + "18", value: "Плата интерфейса: " },
    { name: dbLanguageTextId + russianLanguageId + "19", value: "Время генерации: " },
    { name: dbLanguageTextId + russianLanguageId + "20", value: "Калибровочное давление: " },
    { name: dbLanguageTextId + russianLanguageId + "21", value: "Коэффициент усиления датчика O3: " },
    { name: dbLanguageTextId + russianLanguageId + "22", value: "Начальный период: " },
    { name: dbLanguageTextId + russianLanguageId + "23", value: "Компенсация давления: " },
    { name: dbLanguageTextId + russianLanguageId + "24", value: "Увеличение расхода 1: " },
    { name: dbLanguageTextId + russianLanguageId + "25", value: "Увеличение расхода 2: " },
    { name: dbLanguageTextId + russianLanguageId + "26", value: "Увеличение расхода 3: " },
    { name: dbLanguageTextId + russianLanguageId + "27", value: "1 \u03BCg импульсы: " },
    { name: dbLanguageTextId + russianLanguageId + "28", value: "O3 импульсы 1: " },
    { name: dbLanguageTextId + russianLanguageId + "29", value: "O3 импульсы 2: " },
    { name: dbLanguageTextId + russianLanguageId + "30", value: "O3 импульсы 3: " },
    { name: dbLanguageTextId + russianLanguageId + "31", value: "Параметры нагрузки" },
    { name: dbLanguageTextId + russianLanguageId + "32", value: "Продолжать?" },
    { name: dbLanguageTextId + russianLanguageId + "33", value: "Название клиники" },
    { name: dbLanguageTextId + russianLanguageId + "34", value: "Информация о запуске" },
    { name: dbLanguageTextId + russianLanguageId + "35", value: "Калибровка давления" },
    { name: dbLanguageTextId + russianLanguageId + "36", value: "Калибровка расхода (шаг 1)" },
    { name: dbLanguageTextId + russianLanguageId + "37", value: "Попробуй исправить 11 l/h (0,18 l/min)" },
    { name: dbLanguageTextId + russianLanguageId + "38", value: "Внешнее измерение (ml/min)" },
    { name: dbLanguageTextId + russianLanguageId + "39", value: "Калибровка расхода (шаг 2)" },
    { name: dbLanguageTextId + russianLanguageId + "40", value: "Попробуй исправить 21 l/h (0,35 l/min)" },
    { name: dbLanguageTextId + russianLanguageId + "41", value: "Калибровка расхода (шаг 3)" },
    { name: dbLanguageTextId + russianLanguageId + "42", value: "Попробуй исправить 44 l/h (0,66 l/min)" },
    { name: dbLanguageTextId + russianLanguageId + "43", value: "Чистка ..." },
    { name: dbLanguageTextId + russianLanguageId + "44", value: "Калибровка O3 (шаг 1)" },
    { name: dbLanguageTextId + russianLanguageId + "45", value: "Попробуй исправить 76 \u03BCg" },
    { name: dbLanguageTextId + russianLanguageId + "46", value: "Калибровка O3 (шаг 2)" },
    { name: dbLanguageTextId + russianLanguageId + "47", value: "Попробуй исправить 47 \u03BCg" },
    { name: dbLanguageTextId + russianLanguageId + "48", value: "Калибровка O3 (шаг 3)" },
    { name: dbLanguageTextId + russianLanguageId + "49", value: "Попробуй исправить 22 \u03BCg" },
    { name: dbLanguageTextId + russianLanguageId + "50", value: "Калибровка O3 (шаг 4)" },
    { name: dbLanguageTextId + russianLanguageId + "51", value: "Попробуй исправить 1 \u03BCg" },
    { name: dbLanguageTextId + russianLanguageId + "52", value: "Калибровка коэффициента компенсации давления" },
    { name: dbLanguageTextId + russianLanguageId + "53", value: "Предыдущее значение: " },
    { name: dbLanguageTextId + russianLanguageId + "54", value: "Сохранить параметры" },
    { name: dbLanguageTextId + russianLanguageId + "55", value: "Продолжать?" },
    { name: dbLanguageTextId + russianLanguageId + "56", value: "Продолжать?" },
    { name: dbLanguageTextId + russianLanguageId + "57", value: "Перезагрузите, пожалуйста…" },
    { name: dbLanguageTextId + russianLanguageId + "58", value: "объем памяти " },
    { name: dbLanguageTextId + russianLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + russianLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + russianLanguageId + "61", value: "Параметры " },
    { name: dbLanguageTextId + russianLanguageId + "62", value: "База данных: " }
]

// German texts
var dbGermanLanguageElementsInit = [
    { name: dbLanguageTextId + germanLanguageId + "0",  value: "Druck & Temperatur" },
    { name: dbLanguageTextId + germanLanguageId + "1",  value: "Geräteinformation" },
    { name: dbLanguageTextId + germanLanguageId + "2",  value: "Parameter anzeigen" },
    { name: dbLanguageTextId + germanLanguageId + "3",  value: "Parameter laden" },
    { name: dbLanguageTextId + germanLanguageId + "4",  value: "Gerätename" },
    { name: dbLanguageTextId + germanLanguageId + "5",  value: "Ergebnis starten" },
    { name: dbLanguageTextId + germanLanguageId + "6",  value: "Einheiten & Sprache" },
    { name: dbLanguageTextId + germanLanguageId + "7",  value: "Terminzeit" },
    { name: dbLanguageTextId + germanLanguageId + "8",  value: "Druck" },
    { name: dbLanguageTextId + germanLanguageId + "9",  value: "Fließen" },
    { name: dbLanguageTextId + germanLanguageId + "10", value: "Periodenkalibrierung" },
    { name: dbLanguageTextId + germanLanguageId + "11", value: "O3 Konzentration" },
    { name: dbLanguageTextId + germanLanguageId + "12", value: "P.Factor" },
    { name: dbLanguageTextId + germanLanguageId + "13", value: "Parameter speichern" },
    { name: dbLanguageTextId + germanLanguageId + "14", value: "Generierungszeit zurücksetzen" },
    { name: dbLanguageTextId + germanLanguageId + "15", value: "Softwareversionen: " },
    { name: dbLanguageTextId + germanLanguageId + "16", value: "Konsole sw: " },
    { name: dbLanguageTextId + germanLanguageId + "17", value: "Steuerplatine: " },
    { name: dbLanguageTextId + germanLanguageId + "18", value: "Schnittstelle sw: " },
    { name: dbLanguageTextId + germanLanguageId + "19", value: "Generationszeit: " },
    { name: dbLanguageTextId + germanLanguageId + "20", value: "Kalibrierdruck: " },
    { name: dbLanguageTextId + germanLanguageId + "21", value: "O3 Sensorverstärkung: " },
    { name: dbLanguageTextId + germanLanguageId + "22", value: "Ini Zeitraum: " },
    { name: dbLanguageTextId + germanLanguageId + "23", value: "Druckausgleich: " },
    { name: dbLanguageTextId + germanLanguageId + "24", value: "Durchflussverstärkung 1: " },
    { name: dbLanguageTextId + germanLanguageId + "25", value: "Durchflussverstärkung 2: " },
    { name: dbLanguageTextId + germanLanguageId + "26", value: "Durchflussverstärkung 3: " },
    { name: dbLanguageTextId + germanLanguageId + "27", value: "1 \u03BCg Impulse: " },
    { name: dbLanguageTextId + germanLanguageId + "28", value: "O3 Impulse 1: " },
    { name: dbLanguageTextId + germanLanguageId + "29", value: "O3 Impulse 2: " },
    { name: dbLanguageTextId + germanLanguageId + "30", value: "O3 Impulse 3: " },
    { name: dbLanguageTextId + germanLanguageId + "31", value: "Parameter laden" },
    { name: dbLanguageTextId + germanLanguageId + "32", value: "Fortsetzen?" },
    { name: dbLanguageTextId + germanLanguageId + "33", value: "Name der Klinik" },
    { name: dbLanguageTextId + germanLanguageId + "34", value: "Info starten" },
    { name: dbLanguageTextId + germanLanguageId + "35", value: "Druckkalibrierung" },
    { name: dbLanguageTextId + germanLanguageId + "36", value: "Durchflusskalibrierung (Schritt 1)" },
    { name: dbLanguageTextId + germanLanguageId + "37", value: "Versuchen Sie, 11 l/h (0,18 l/min) zu fixieren" },
    { name: dbLanguageTextId + germanLanguageId + "38", value: "Externe Messung (ml/min)" },
    { name: dbLanguageTextId + germanLanguageId + "39", value: "Durchflusskalibrierung (Schritt 2)" },
    { name: dbLanguageTextId + germanLanguageId + "40", value: "Versuchen Sie, 21 l/h (0,35 l/min) zu fixieren" },
    { name: dbLanguageTextId + germanLanguageId + "41", value: "Durchflusskalibrierung (Schritt 3)" },
    { name: dbLanguageTextId + germanLanguageId + "42", value: "Versuchen Sie, 44 l/h (0,66 l/min) zu fixieren" },
    { name: dbLanguageTextId + germanLanguageId + "43", value: "Reinigung…" },
    { name: dbLanguageTextId + germanLanguageId + "44", value: "O3-Kalibrierung (Schritt 1)" },
    { name: dbLanguageTextId + germanLanguageId + "45", value: "Versuchen Sie, 76 \u03BCg zu beheben" },
    { name: dbLanguageTextId + germanLanguageId + "46", value: "O3-Kalibrierung (Schritt 2)" },
    { name: dbLanguageTextId + germanLanguageId + "47", value: "Versuchen Sie, 47 \u03BCg zu beheben" },
    { name: dbLanguageTextId + germanLanguageId + "48", value: "O3-Kalibrierung (Schritt 3)" },
    { name: dbLanguageTextId + germanLanguageId + "49", value: "Versuchen Sie, 22 \u03BCg zu beheben" },
    { name: dbLanguageTextId + germanLanguageId + "50", value: "O3-Kalibrierung (Schritt 4)" },
    { name: dbLanguageTextId + germanLanguageId + "51", value: "Versuchen Sie, 1 \u03BCg zu beheben" },
    { name: dbLanguageTextId + germanLanguageId + "52", value: "Kalibrierung des Druckkompensationsfaktors" },
    { name: dbLanguageTextId + germanLanguageId + "53", value: "Vorheriger Wert: " },
    { name: dbLanguageTextId + germanLanguageId + "54", value: "Parameter speichern" },
    { name: dbLanguageTextId + germanLanguageId + "55", value: "Fortsetzen?" },
    { name: dbLanguageTextId + germanLanguageId + "56", value: "Fortsetzen?" },
    { name: dbLanguageTextId + germanLanguageId + "57", value: "Bitte neu starten ..." },
    { name: dbLanguageTextId + germanLanguageId + "58", value: "Erinnerung" },
    { name: dbLanguageTextId + germanLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + germanLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + germanLanguageId + "61", value: "Parameter" },
    { name: dbLanguageTextId + germanLanguageId + "62", value: "Datenbank: " }
]

// Italian texts
var dbItalianLanguageElementsInit = [
    { name: dbLanguageTextId + italianLanguageId + "0",  value: "Pressione & temperatura" },
    { name: dbLanguageTextId + italianLanguageId + "1",  value: "Informazioni sul dispositivo" },
    { name: dbLanguageTextId + italianLanguageId + "2",  value: "Mostra parametri" },
    { name: dbLanguageTextId + italianLanguageId + "3",  value: "Carica parametri" },
    { name: dbLanguageTextId + italianLanguageId + "4",  value: "Nome del dispositivo" },
    { name: dbLanguageTextId + italianLanguageId + "5",  value: "Risultato di avvio" },
    { name: dbLanguageTextId + italianLanguageId + "6",  value: "Unità e lingua" },
    { name: dbLanguageTextId + italianLanguageId + "7",  value: "Appuntamento" },
    { name: dbLanguageTextId + italianLanguageId + "8",  value: "Pressione" },
    { name: dbLanguageTextId + italianLanguageId + "9",  value: "Flusso" },
    { name: dbLanguageTextId + italianLanguageId + "10", value: "Calibrazione del periodo" },
    { name: dbLanguageTextId + italianLanguageId + "11", value: "Concentrazione di O3" },
    { name: dbLanguageTextId + italianLanguageId + "12", value: "P.Factor" },
    { name: dbLanguageTextId + italianLanguageId + "13", value: "Salva parametri" },
    { name: dbLanguageTextId + italianLanguageId + "14", value: "Reimposta l'ora di generazione" },
    { name: dbLanguageTextId + italianLanguageId + "15", value: "Versioni software: " },
    { name: dbLanguageTextId + italianLanguageId + "16", value: "Console sw: " },
    { name: dbLanguageTextId + italianLanguageId + "17", value: "Pannello di controllo: " },
    { name: dbLanguageTextId + italianLanguageId + "18", value: "Interfaccia sw: " },
    { name: dbLanguageTextId + italianLanguageId + "19", value: "Tempo di generazione: " },
    { name: dbLanguageTextId + italianLanguageId + "20", value: "Pressione di calibrazione: " },
    { name: dbLanguageTextId + italianLanguageId + "21", value: "Guadagno sensore O3: " },
    { name: dbLanguageTextId + italianLanguageId + "22", value: "Periodo Ini: " },
    { name: dbLanguageTextId + italianLanguageId + "23", value: "Compensazione della pressione: " },
    { name: dbLanguageTextId + italianLanguageId + "24", value: "Guadagno di flusso 1: " },
    { name: dbLanguageTextId + italianLanguageId + "25", value: "Guadagno di flusso 2: " },
    { name: dbLanguageTextId + italianLanguageId + "26", value: "Guadagno di flusso 3: " },
    { name: dbLanguageTextId + italianLanguageId + "27", value: "1 \u03BCg impulsi: " },
    { name: dbLanguageTextId + italianLanguageId + "28", value: "O3 impulsi 1: " },
    { name: dbLanguageTextId + italianLanguageId + "29", value: "O3 impulsi 2: " },
    { name: dbLanguageTextId + italianLanguageId + "30", value: "O3 impulsi 3: " },
    { name: dbLanguageTextId + italianLanguageId + "31", value: "Carica parametri" },
    { name: dbLanguageTextId + italianLanguageId + "32", value: "Continua?" },
    { name: dbLanguageTextId + italianLanguageId + "33", value: "Nome della clinica" },
    { name: dbLanguageTextId + italianLanguageId + "34", value: "Informazioni di avvio" },
    { name: dbLanguageTextId + italianLanguageId + "35", value: "Calibrazione della pressione" },
    { name: dbLanguageTextId + italianLanguageId + "36", value: "Calibrazione del flusso (fase 1)" },
    { name: dbLanguageTextId + italianLanguageId + "37", value: "Prova a fissare 11 l/h (0,18 l/min)" },
    { name: dbLanguageTextId + italianLanguageId + "38", value: "Misura esterna (ml/min)" },
    { name: dbLanguageTextId + italianLanguageId + "39", value: "Calibrazione del flusso (fase 2)" },
    { name: dbLanguageTextId + italianLanguageId + "40", value: "Prova a fissare 21 l/h (0,35 l/min)" },
    { name: dbLanguageTextId + italianLanguageId + "41", value: "Calibrazione del flusso (passaggio 3)" },
    { name: dbLanguageTextId + italianLanguageId + "42", value: "Prova a fissare 44 l/h (0,66 l/min)" },
    { name: dbLanguageTextId + italianLanguageId + "43", value: "Pulizia…" },
    { name: dbLanguageTextId + italianLanguageId + "44", value: "Calibrazione O3 (fase 1)" },
    { name: dbLanguageTextId + italianLanguageId + "45", value: "Prova a correggere 76 \u03BCg" },
    { name: dbLanguageTextId + italianLanguageId + "46", value: "Calibrazione O3 (fase 2)" },
    { name: dbLanguageTextId + italianLanguageId + "47", value: "Prova a correggere 47 \u03BCg" },
    { name: dbLanguageTextId + italianLanguageId + "48", value: "Calibrazione O3 (fase 3)" },
    { name: dbLanguageTextId + italianLanguageId + "49", value: "Prova a correggere 22 \u03BCg" },
    { name: dbLanguageTextId + italianLanguageId + "50", value: "Calibrazione O3 (fase 4)" },
    { name: dbLanguageTextId + italianLanguageId + "51", value: "Prova a correggere 1 \u03BCg" },
    { name: dbLanguageTextId + italianLanguageId + "52", value: "Calibrazione del fattore di compensazione della pressione" },
    { name: dbLanguageTextId + italianLanguageId + "53", value: "Valore precedente: " },
    { name: dbLanguageTextId + italianLanguageId + "54", value: "Salva parametri" },
    { name: dbLanguageTextId + italianLanguageId + "55", value: "Continua?" },
    { name: dbLanguageTextId + italianLanguageId + "56", value: "Continua?" },
    { name: dbLanguageTextId + italianLanguageId + "57", value: "Riavvia per favore ..." },
    { name: dbLanguageTextId + italianLanguageId + "58", value: "Memoria" },
    { name: dbLanguageTextId + italianLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + italianLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + italianLanguageId + "61", value: "Parametri" },
    { name: dbLanguageTextId + italianLanguageId + "62", value: "Banca dati: " }
]

// French texts
var dbFrenchLanguageElementsInit = [
    { name: dbLanguageTextId + frenchLanguageId + "0",  value: "Pression & température" },
    { name: dbLanguageTextId + frenchLanguageId + "1",  value: "Informantion de l'appareil" },
    { name: dbLanguageTextId + frenchLanguageId + "2",  value: "Afficher les paramètres" },
    { name: dbLanguageTextId + frenchLanguageId + "3",  value: "Paramètres de charge" },
    { name: dbLanguageTextId + frenchLanguageId + "4",  value: "Nom de l'appareil" },
    { name: dbLanguageTextId + frenchLanguageId + "5",  value: "Résultat de démarrage" },
    { name: dbLanguageTextId + frenchLanguageId + "6",  value: "Unités et langue" },
    { name: dbLanguageTextId + frenchLanguageId + "7",  value: "Date et heure" },
    { name: dbLanguageTextId + frenchLanguageId + "8",  value: "Pression" },
    { name: dbLanguageTextId + frenchLanguageId + "9",  value: "Couler" },
    { name: dbLanguageTextId + frenchLanguageId + "10", value: "Calibrage de la période" },
    { name: dbLanguageTextId + frenchLanguageId + "11", value: "Concentration d'O3" },
    { name: dbLanguageTextId + frenchLanguageId + "12", value: "P.Factor" },
    { name: dbLanguageTextId + frenchLanguageId + "13", value: "Enregistrer les paramètres" },
    { name: dbLanguageTextId + frenchLanguageId + "14", value: "Réinitialiser le temps de génération" },
    { name: dbLanguageTextId + frenchLanguageId + "15", value: "Versions logicielles: " },
    { name: dbLanguageTextId + frenchLanguageId + "16", value: "Commutateur de la console: " },
    { name: dbLanguageTextId + frenchLanguageId + "17", value: "Tableau de contrôle: " },
    { name: dbLanguageTextId + frenchLanguageId + "18", value: "Interface sw: " },
    { name: dbLanguageTextId + frenchLanguageId + "19", value: "Temps de génération: " },
    { name: dbLanguageTextId + frenchLanguageId + "20", value: "Pression d'étalonnage: " },
    { name: dbLanguageTextId + frenchLanguageId + "21", value: "Gain du capteur O3: " },
    { name: dbLanguageTextId + frenchLanguageId + "22", value: "Période ini: " },
    { name: dbLanguageTextId + frenchLanguageId + "23", value: "Compensation de pression: " },
    { name: dbLanguageTextId + frenchLanguageId + "24", value: "Gain de débit 1: " },
    { name: dbLanguageTextId + frenchLanguageId + "25", value: "Gain de débit 2: " },
    { name: dbLanguageTextId + frenchLanguageId + "26", value: "Gain de débit 3: " },
    { name: dbLanguageTextId + frenchLanguageId + "27", value: "Impulsions 1 \u03BCg: " },
    { name: dbLanguageTextId + frenchLanguageId + "28", value: "Impulsions O3 1: " },
    { name: dbLanguageTextId + frenchLanguageId + "29", value: "O3 impulsions 2: " },
    { name: dbLanguageTextId + frenchLanguageId + "30", value: "O3 impulsions 3: " },
    { name: dbLanguageTextId + frenchLanguageId + "31", value: "Paramètres de charge" },
    { name: dbLanguageTextId + frenchLanguageId + "32", value: "Continuez?" },
    { name: dbLanguageTextId + frenchLanguageId + "33", value: "Nom de la clinique" },
    { name: dbLanguageTextId + frenchLanguageId + "34", value: "Informations de démarrage" },
    { name: dbLanguageTextId + frenchLanguageId + "35", value: "Calibrage de la pression" },
    { name: dbLanguageTextId + frenchLanguageId + "36", value: "Étalonnage du débit (étape 1)" },
    { name: dbLanguageTextId + frenchLanguageId + "37", value: "Essayez de fixer 11 l/h (0,18 l/min)" },
    { name: dbLanguageTextId + frenchLanguageId + "38", value: "Mesure externe (ml/min)" },
    { name: dbLanguageTextId + frenchLanguageId + "39", value: "Étalonnage du débit (étape 2)" },
    { name: dbLanguageTextId + frenchLanguageId + "40", value: "Essayez de fixer 21 l/h (0,35 l/min)" },
    { name: dbLanguageTextId + frenchLanguageId + "41", value: "Étalonnage du débit (étape 3)" },
    { name: dbLanguageTextId + frenchLanguageId + "42", value: "Essayez de fixer 44 l/h (0,66 l/min)" },
    { name: dbLanguageTextId + frenchLanguageId + "43", value: "Nettoyage…" },
    { name: dbLanguageTextId + frenchLanguageId + "44", value: "Calibrage O3 (étape 1)" },
    { name: dbLanguageTextId + frenchLanguageId + "45", value: "Essayez de réparer 76 \u03BCg" },
    { name: dbLanguageTextId + frenchLanguageId + "46", value: "Calibrage O3 (étape 2)" },
    { name: dbLanguageTextId + frenchLanguageId + "47", value: "Essayez de réparer 47 \u03BCg" },
    { name: dbLanguageTextId + frenchLanguageId + "48", value: "Calibrage O3 (étape 3)" },
    { name: dbLanguageTextId + frenchLanguageId + "49", value: "Essayez de réparer 22 \u03BCg" },
    { name: dbLanguageTextId + frenchLanguageId + "50", value: "Calibrage O3 (étape 4)" },
    { name: dbLanguageTextId + frenchLanguageId + "51", value: "Essayez de réparer 1 \u03BCg" },
    { name: dbLanguageTextId + frenchLanguageId + "52", value: "Étalonnage du facteur de compensation de pression" },
    { name: dbLanguageTextId + frenchLanguageId + "53", value: "Valeur précédente: " },
    { name: dbLanguageTextId + frenchLanguageId + "54", value: "Enregistrer les paramètres" },
    { name: dbLanguageTextId + frenchLanguageId + "55", value: "Continuez?" },
    { name: dbLanguageTextId + frenchLanguageId + "56", value: "Continuez?" },
    { name: dbLanguageTextId + frenchLanguageId + "57", value: "Redémarrez s'il vous plaît…" },
    { name: dbLanguageTextId + frenchLanguageId + "58", value: "Mémoire" },
    { name: dbLanguageTextId + frenchLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + frenchLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + frenchLanguageId + "61", value: "Paramètres" },
    { name: dbLanguageTextId + frenchLanguageId + "62", value: "Base de données: " }
]

// Hindi texts
var dbHindiLanguageElementsInit = [
    { name: dbLanguageTextId + hindiLanguageId + "0",  value: "दबाव और तापमान" },
    { name: dbLanguageTextId + hindiLanguageId + "1",  value: "डिवाइस सूचना" },
    { name: dbLanguageTextId + hindiLanguageId + "2",  value: "पैरामीटर दिखाएं" },
    { name: dbLanguageTextId + hindiLanguageId + "3",  value: "लोड मापदंडों" },
    { name: dbLanguageTextId + hindiLanguageId + "4",  value: "यन्त्र का नाम" },
    { name: dbLanguageTextId + hindiLanguageId + "5",  value: "परिणाम शुरू करें" },
    { name: dbLanguageTextId + hindiLanguageId + "6",  value: "इकाइयाँ और भाषा" },
    { name: dbLanguageTextId + hindiLanguageId + "7",  value: "दिनांक समय" },
    { name: dbLanguageTextId + hindiLanguageId + "8",  value: "दबाव" },
    { name: dbLanguageTextId + hindiLanguageId + "9",  value: "बहे" },
    { name: dbLanguageTextId + hindiLanguageId + "10", value: "अवधि अंशांकन" },
    { name: dbLanguageTextId + hindiLanguageId + "11", value: "O3 एकाग्रता" },
    { name: dbLanguageTextId + hindiLanguageId + "12", value: "P.फ़ैक्टर" },
    { name: dbLanguageTextId + hindiLanguageId + "13", value: "पैरामीटर सहेजें" },
    { name: dbLanguageTextId + hindiLanguageId + "14", value: "पीढ़ी समय रीसेट करें" },
    { name: dbLanguageTextId + hindiLanguageId + "15", value: "सॉफ्टवेयर वेरिएशन: " },
    { name: dbLanguageTextId + hindiLanguageId + "16", value: "कंसोल स्व: " },
    { name: dbLanguageTextId + hindiLanguageId + "17", value: "नियंत्रण मंडल: " },
    { name: dbLanguageTextId + hindiLanguageId + "18", value: "इंटरफ़ेस sw: " },
    { name: dbLanguageTextId + hindiLanguageId + "19", value: "उत्पादन समय: " },
    { name: dbLanguageTextId + hindiLanguageId + "20", value: "अंशांकन दबाव: " },
    { name: dbLanguageTextId + hindiLanguageId + "21", value: "O3 सेंसर लाभ: " },
    { name: dbLanguageTextId + hindiLanguageId + "22", value: "इनी अवधि: " },
    { name: dbLanguageTextId + hindiLanguageId + "23", value: "दबाव मुआवजा: " },
    { name: dbLanguageTextId + hindiLanguageId + "24", value: "प्रवाह 1: " },
    { name: dbLanguageTextId + hindiLanguageId + "25", value: "प्रवाह लाभ 2: " },
    { name: dbLanguageTextId + hindiLanguageId + "26", value: "प्रवाह लाभ 3: " },
    { name: dbLanguageTextId + hindiLanguageId + "27", value: "1 \u03BCg दालें: " },
    { name: dbLanguageTextId + hindiLanguageId + "28", value: "O3 दालें 1: " },
    { name: dbLanguageTextId + hindiLanguageId + "29", value: "O3 दालें 2: " },
    { name: dbLanguageTextId + hindiLanguageId + "30", value: "O3 दाल 3: " },
    { name: dbLanguageTextId + hindiLanguageId + "31", value: "लोड मापदंडों" },
    { name: dbLanguageTextId + hindiLanguageId + "32", value: "जारी रखें?" },
    { name: dbLanguageTextId + hindiLanguageId + "33", value: "क्लिनिक का नाम" },
    { name: dbLanguageTextId + hindiLanguageId + "34", value: "जानकारी शुरू करें" },
    { name: dbLanguageTextId + hindiLanguageId + "35", value: "दबाव अंशांकन" },
    { name: dbLanguageTextId + hindiLanguageId + "36", value: "प्रवाह अंशांकन (चरण 1)" },
    { name: dbLanguageTextId + hindiLanguageId + "37", value: "11 l/h (0,18 l/min) ठीक करने का प्रयास करें" },
    { name: dbLanguageTextId + hindiLanguageId + "38", value: "बाहरी माप (ml/min)" },
    { name: dbLanguageTextId + hindiLanguageId + "39", value: "प्रवाह अंशांकन (चरण 2)" },
    { name: dbLanguageTextId + hindiLanguageId + "40", value: "21 l/h (0,35 l/h) ठीक करने का प्रयास करें" },
    { name: dbLanguageTextId + hindiLanguageId + "41", value: "प्रवाह अंशांकन (चरण 3)" },
    { name: dbLanguageTextId + hindiLanguageId + "42", value: "44 l/h (0,66 l/min) ठीक करने का प्रयास करें" },
    { name: dbLanguageTextId + hindiLanguageId + "43", value: "सफाई ..." },
    { name: dbLanguageTextId + hindiLanguageId + "44", value: "O3 अंशांकन (चरण 1)" },
    { name: dbLanguageTextId + hindiLanguageId + "45", value: "76 \u03BCg को ठीक करने का प्रयास करें" },
    { name: dbLanguageTextId + hindiLanguageId + "46", value: "O3 अंशांकन (चरण 2)" },
    { name: dbLanguageTextId + hindiLanguageId + "47", value: "47 \u03BCg को ठीक करने का प्रयास करें" },
    { name: dbLanguageTextId + hindiLanguageId + "48", value: "O3 अंशांकन (चरण 3)" },
    { name: dbLanguageTextId + hindiLanguageId + "49", value: "22 \u03BCg को ठीक करने का प्रयास करें" },
    { name: dbLanguageTextId + hindiLanguageId + "50", value: "O3 अंशांकन (चरण 4)" },
    { name: dbLanguageTextId + hindiLanguageId + "51", value: "1 \u03BCg को ठीक करने का प्रयास करें" },
    { name: dbLanguageTextId + hindiLanguageId + "52", value: "दबाव मुआवजा कारक अंशांकन" },
    { name: dbLanguageTextId + hindiLanguageId + "53", value: "पिछला मान: " },
    { name: dbLanguageTextId + hindiLanguageId + "54", value: "पैरामीटर सहेजें" },
    { name: dbLanguageTextId + hindiLanguageId + "55", value: "जारी रखें?" },
    { name: dbLanguageTextId + hindiLanguageId + "56", value: "जारी रखें?" },
    { name: dbLanguageTextId + hindiLanguageId + "57", value: "कृपया पुनः प्रारंभ करें ..." },
    { name: dbLanguageTextId + hindiLanguageId + "58", value: "याद" },
    { name: dbLanguageTextId + hindiLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + hindiLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + hindiLanguageId + "61", value: "मापदंडों" },
    { name: dbLanguageTextId + hindiLanguageId + "62", value: "डेटाबेस: " }
]

// Arabic texts
var dbArabicLanguageElementsInit = [
    { name: dbLanguageTextId + arabicLanguageId + "0",  value: "الضغط ودرجة الحرارة" },
    { name: dbLanguageTextId + arabicLanguageId + "1",  value: "معلومات الجهاز" },
    { name: dbLanguageTextId + arabicLanguageId + "2",  value: "إظهار المعلمات" },
    { name: dbLanguageTextId + arabicLanguageId + "3",  value: "معلمات التحميل" },
    { name: dbLanguageTextId + arabicLanguageId + "4",  value: "اسم الجهاز" },
    { name: dbLanguageTextId + arabicLanguageId + "5",  value: "نتيجة البدء" },
    { name: dbLanguageTextId + arabicLanguageId + "6",  value: "الوحدات واللغة" },
    { name: dbLanguageTextId + arabicLanguageId + "7",  value: "التاريخ والوقت" },
    { name: dbLanguageTextId + arabicLanguageId + "8",  value: "ضغط" },
    { name: dbLanguageTextId + arabicLanguageId + "9",  value: "تدفق" },
    { name: dbLanguageTextId + arabicLanguageId + "10", value: "معايرة الفترة" },
    { name: dbLanguageTextId + arabicLanguageId + "11", value: "تركيز O3" },
    { name: dbLanguageTextId + arabicLanguageId + "12", value: "P. العامل" },
    { name: dbLanguageTextId + arabicLanguageId + "13", value: "حفظ المعلمات" },
    { name: dbLanguageTextId + arabicLanguageId + "14", value: "إعادة تعيين وقت التوليد" },
    { name: dbLanguageTextId + arabicLanguageId + "15", value: "إصدارات البرنامج: " },
    { name: dbLanguageTextId + arabicLanguageId + "16", value: "وحدة التحكم sw: " },
    { name: dbLanguageTextId + arabicLanguageId + "17", value: "لوح التحكم: " },
    { name: dbLanguageTextId + arabicLanguageId + "18", value: "واجهة sw: " },
    { name: dbLanguageTextId + arabicLanguageId + "19", value: "وقت الجيل: " },
    { name: dbLanguageTextId + arabicLanguageId + "20", value: "ضغط المعايرة: " },
    { name: dbLanguageTextId + arabicLanguageId + "21", value: "كسب مستشعر O3: " },
    { name: dbLanguageTextId + arabicLanguageId + "22", value: "فترة ini: " },
    { name: dbLanguageTextId + arabicLanguageId + "23", value: "تعويض الضغط: " },
    { name: dbLanguageTextId + arabicLanguageId + "24", value: "كسب التدفق 1: " },
    { name: dbLanguageTextId + arabicLanguageId + "25", value: "كسب التدفق 2: " },
    { name: dbLanguageTextId + arabicLanguageId + "26", value: "كسب التدفق 3: " },
    { name: dbLanguageTextId + arabicLanguageId + "27", value: "1 \ u03BCg نبضات: " },
    { name: dbLanguageTextId + arabicLanguageId + "28", value: "نبضات O3 1: " },
    { name: dbLanguageTextId + arabicLanguageId + "29", value: "نبضات O3 2: " },
    { name: dbLanguageTextId + arabicLanguageId + "30", value: "نبضات O3 3: " },
    { name: dbLanguageTextId + arabicLanguageId + "31", value: "معلمات التحميل" },
    { name: dbLanguageTextId + arabicLanguageId + "32", value: "يكمل؟" },
    { name: dbLanguageTextId + arabicLanguageId + "33", value: "اسم العيادة" },
    { name: dbLanguageTextId + arabicLanguageId + "34", value: "معلومات البدء" },
    { name: dbLanguageTextId + arabicLanguageId + "35", value: "معايرة الضغط" },
    { name: dbLanguageTextId + arabicLanguageId + "36", value: "معايرة التدفق (الخطوة 1)" },
    { name: dbLanguageTextId + arabicLanguageId + "37", value: "محاولة إصلاح  11 l/h (0,18 l/min)" },
    { name: dbLanguageTextId + arabicLanguageId + "38", value: "القياس الخارج(ml/min)" },
    { name: dbLanguageTextId + arabicLanguageId + "39", value: "معايرة التدفق (الخطوة 2)" },
    { name: dbLanguageTextId + arabicLanguageId + "40", value: "محاولة إصلاح  21 l/h (0,35 l/min)" },
    { name: dbLanguageTextId + arabicLanguageId + "41", value: "معايرة التدفق (الخطوة 3)" },
    { name: dbLanguageTextId + arabicLanguageId + "42", value: "محاولة إصلاح  44 l/h (0,66 l/min)" },
    { name: dbLanguageTextId + arabicLanguageId + "43", value: "تنظيف…" },
    { name: dbLanguageTextId + arabicLanguageId + "44", value: "معايرة O3 (الخطوة 1)" },
    { name: dbLanguageTextId + arabicLanguageId + "45", value: "حاول إصلاح  76 \u03BCg" },
    { name: dbLanguageTextId + arabicLanguageId + "46", value: "معايرة O3 (الخطوة 2)" },
    { name: dbLanguageTextId + arabicLanguageId + "47", value: "حاول إصلاح  47 \u03BCg" },
    { name: dbLanguageTextId + arabicLanguageId + "48", value: "معايرة O3 (الخطوة 3)" },
    { name: dbLanguageTextId + arabicLanguageId + "49", value: "حاول إصلاح 22  \u03BCg" },
    { name: dbLanguageTextId + arabicLanguageId + "50", value: "معايرة O3 (الخطوة 4)" },
    { name: dbLanguageTextId + arabicLanguageId + "51", value: "حاول إصلاح  1 \u03BCg" },
    { name: dbLanguageTextId + arabicLanguageId + "52", value: "معايرة عامل تعويض الضغط" },
    { name: dbLanguageTextId + arabicLanguageId + "53", value: "القيمة السابقه: " },
    { name: dbLanguageTextId + arabicLanguageId + "54", value: "حفظ المعلمات" },
    { name: dbLanguageTextId + arabicLanguageId + "55", value: "يكمل؟" },
    { name: dbLanguageTextId + arabicLanguageId + "56", value: "يكمل؟" },
    { name: dbLanguageTextId + arabicLanguageId + "57", value: "أعد التشغيل من فضلك ..." },
    { name: dbLanguageTextId + arabicLanguageId + "58", value: "ذاكرة" },
    { name: dbLanguageTextId + arabicLanguageId + "59", value: "T: " },
    { name: dbLanguageTextId + arabicLanguageId + "60", value: "P: " },
    { name: dbLanguageTextId + arabicLanguageId + "61", value: "العوامل" },
    { name: dbLanguageTextId + arabicLanguageId + "62", value: "قاعدة البيانات: " }
]

//
//  HELP PARAMETERS
//
var helpMagnitudeSelectorId = "helpMagnitudeSelector"
var helpBloodVolumeGadgetId = "helpBloodVolumeGadget"
var helpAutoSyringeCalculatorId = "helpAutoSyringeCalculator"
var helpManualSyringeCalculatorId = "helpManualSyringeCalculator"
var helpPressureTesterId = "helpPressureTester"
var helpSalineCalculatorId = "helpSalineCalculator"
var helpMemoryBoardId = "helpMemoryBoard"

var helpTutorialVideoId = "_helpTutorialVideo"
var dbHelpTutorialVideoElementsInit = [
    { name: option1Id   + helpTutorialVideoId,  value: "" },
    { name: option1_1Id + helpTutorialVideoId,  value: path + "Tutorials/JeringaAuto.mp4" },
    { name: option1_2Id + helpTutorialVideoId,  value: path + "Tutorials/JeringaManual.mp4" },
    { name: option2Id   + helpTutorialVideoId,  value: path + "Tutorials/SSO3.mp4" },
    { name: option3Id   + helpTutorialVideoId,  value: "" },
    { name: option3_1Id + helpTutorialVideoId,  value: path + "Tutorials/BolsaCerrada.mp4" },
    { name: option3_2Id + helpTutorialVideoId,  value: path + "Tutorials/BolsaAbierta.mp4" },
    { name: option5Id   + helpTutorialVideoId,  value: "" },
    { name: option5_1Id + helpTutorialVideoId,  value: path + "Tutorials/Autohemoterapia.mp4" },
    { name: option5_2Id + helpTutorialVideoId,  value: path + "Tutorials/Dosis.mp4" },
    { name: option4Id   + helpTutorialVideoId,  value: "" },
    { name: option4_1Id + helpTutorialVideoId,  value: path + "Tutorials/InsuflaciónVaginal.mp4" },
    { name: option4_2Id + helpTutorialVideoId,  value: path + "Tutorials/InsuflaciónRectal.mp4" },
    { name: option6Id   + helpTutorialVideoId,  value: "" },
    { name: option6_1Id + helpTutorialVideoId,  value: path + "Tutorials/Suero.mp4" },
    { name: option6_2Id + helpTutorialVideoId,  value: path + "Tutorials/Agua.mp4" },
    { name: option6_3Id + helpTutorialVideoId,  value: path + "Tutorials/Aceite.mp4" },
    { name: option7Id   + helpTutorialVideoId,  value: "" },
    { name: option7_1Id + helpTutorialVideoId,  value: path + "Tutorials/VacíoTiempo.mp4" },
    { name: option7_2Id + helpTutorialVideoId,  value: path + "Tutorials/VacíoPresión.mp4" },

    { name:  inputBottleVolumeSelectorId +       helpTutorialVideoId,  value: path + "Videos/BottleVolume_Selector.mp4" },
    { name:  inputBloodVolumeSelectorId +        helpTutorialVideoId,  value: path + "Videos/BloodVolume_Selector.mp4" },
    { name:  inputLiquidVolumeSelectorId +       helpTutorialVideoId,  value: path + "Videos/LiquidVolume_Selector.mp4" },
    { name:  inputSalineVolumeSelectorId +       helpTutorialVideoId,  value: path + "Videos/SalineVolume_Selector.mp4" },
    { name:  inputO3SelectorId +                 helpTutorialVideoId,  value: path + "Videos/O3_Selector.mp4" },
    { name:  inputFlowSelectorId +               helpTutorialVideoId,  value: path + "Videos/Flow_selector.mp4" },
    { name:  inputTimeSelectorId +               helpTutorialVideoId,  value: path + "Videos/Time_Selector.mp4" },
    { name:  inputTotalConcentrationSelectorId + helpTutorialVideoId,  value: path + "Videos/TotalConcentration_Selector.mp4" },
    { name:  inputTherapyTimeSelectorId +        helpTutorialVideoId,  value: path + "Videos/TherapyTime_Selector.mp4" },
    { name:  inputVacuumTimeSelectorId +         helpTutorialVideoId,  value: path + "Videos/VacuumTime_Selector.mp4" },
    { name:  inputVolumeSelectorId +             helpTutorialVideoId,  value: path + "Videos/Volume_Selector.mp4" },
    { name:  inputCleanTimeSelectorId +          helpTutorialVideoId,  value: path + "Videos/CleanTime_Selector.mp4" },
    { name:  inputPressureSelectorId +           helpTutorialVideoId,  value: path + "Videos/Pressure_Selector.mp4" },
    { name:  inputIpSelectorId +                 helpTutorialVideoId,  value: path + "Videos/Pressure_Selector.mp4" },
    { name:  inputReinfusionTimeSelectorId +     helpTutorialVideoId,  value: path + "Videos/ReinfusionTime_Selector.mp4" },
    { name:  inputTimeVolumeSelectorId +         helpTutorialVideoId,  value: path + "Videos/ReinfusionTime_Selector.mp4" },
    { name:  inputVolumeDoseSelectorId +         helpTutorialVideoId,  value: path + "Videos/ReinfusionTime_Selector.mp4" },
    { name:  inputTimeDoseSelectorId +           helpTutorialVideoId,  value: path + "Videos/ReinfusionTime_Selector.mp4" },
    { name:  inputSalineTimeSelectorId +         helpTutorialVideoId,  value: path + "Videos/ReinfusionTime_Selector.mp4" },

    { name:  inputO3SelectorId + "_" + option5_1Id +   helpTutorialVideoId,  value: path + "Videos/O3MultiCycle_Selector.mp4" },
    { name:  inputTotalConcentrationSelectorId + "_" + option5_2Id +   helpTutorialVideoId,  value: path + "Videos/TotalConcentration_Selector.mp4" },

    { name: helpBloodVolumeGadgetId +       helpTutorialVideoId,  value: path + "Videos/BloodVolume_Gadget.mp4" },
    { name: helpAutoSyringeCalculatorId +   helpTutorialVideoId,  value: path + "Videos/SyringeAuto_Gadget.mp4" },
    { name: helpManualSyringeCalculatorId + helpTutorialVideoId,  value: path + "Videos/ManualSyringe_Gadget.mp4" },
    { name: helpPressureTesterId +          helpTutorialVideoId,  value: path + "Videos/Pressure_Gadget.mp4" },
    { name: helpMemoryBoardId +             helpTutorialVideoId,  value: path + "Videos/Memory_Gadget.mp4" },
    { name: helpSalineCalculatorId +        helpTutorialVideoId,  value: path + "Videos/SalineCalculator_Gadget.mp4" },
]

var helpTherapyVideoId = "_helpTherapyVideo"
var dbHelpTherapyVideoElementsInit = [
    { name: option1Id   + helpTherapyVideoId,  value: "" },
    { name: option1_1Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option1_2Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option2Id   + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option3Id   + helpTherapyVideoId,  value: "" },
    { name: option3_1Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option3_2Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option5Id   + helpTherapyVideoId,  value: "" },
    { name: option5_1Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option5_2Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option4Id   + helpTherapyVideoId,  value: "" },
    { name: option4_1Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option4_2Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option6Id   + helpTherapyVideoId,  value: "" },
    { name: option6_1Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option6_2Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option6_3Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option7Id   + helpTherapyVideoId,  value: "" },
    { name: option7_1Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
    { name: option7_2Id + helpTherapyVideoId,  value: path + "Videos/TherapyDemo.mp4" },
]

var helpConnectionImgId = "_helpConnectionImg"
var dbHelpConnectionImgElementsInit = [
    { name: option1Id   + helpConnectionImgId,  value: "" },
    { name: option1_1Id + helpConnectionImgId,  value: path + "ImgDB/JeringaN.png" },
    { name: option1_2Id + helpConnectionImgId,  value: path + "ImgDB/JeringaN.png" },
    { name: option2Id   + helpConnectionImgId,  value: path + "ImgDB/SSO3N.png" },
    { name: option3Id   + helpConnectionImgId,  value: "" },
    { name: option3_1Id + helpConnectionImgId,  value: path + "ImgDB/BolsaCrN.png" },
    { name: option3_2Id + helpConnectionImgId,  value: path + "ImgDB/BolsaAbN.png" },
    { name: option5Id   + helpConnectionImgId,  value: "" },
    { name: option5_1Id + helpConnectionImgId,  value: path + "ImgDB/AutohN.png" },
    { name: option5_2Id + helpConnectionImgId,  value: path + "ImgDB/AutohN.png" },
    { name: option4Id   + helpConnectionImgId,  value: "" },
    { name: option4_1Id + helpConnectionImgId,  value: path + "ImgDB/InsufVagN.png" },
    { name: option4_2Id + helpConnectionImgId,  value: path + "ImgDB/InsufRecN.png" },
    { name: option6Id   + helpConnectionImgId,  value: "" },
    { name: option6_1Id + helpConnectionImgId,  value: path + "ImgDB/SueroH2ON.png" },
    { name: option6_2Id + helpConnectionImgId,  value: path + "ImgDB/SueroH2ON.png" },
    { name: option6_3Id + helpConnectionImgId,  value: path + "ImgDB/AceiteN.png" },
    { name: option7Id   + helpConnectionImgId,  value: "" },
    { name: option7_1Id + helpConnectionImgId,  value: path + "ImgDB/VacíoTN.png" },
    { name: option7_2Id + helpConnectionImgId,  value: path + "ImgDB/VacíoPN.png" },
]

var helpDocId = "_helpDoc_"
var helpDocPageId = "Page"
var helpDocNumPagesId = "NumPages"
var dbHelpDocElementsInit_Esp = [ // "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-"
    { name: option1Id   + helpDocId + spanishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + spanishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + spanishLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + spanishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + spanishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + spanishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + spanishLanguageId,  value: path + "Documents/UserMan/Esp/OM-0506R0_ES_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]
var dbHelpDocElementsInit_Eng = [
    { name: option1Id   + helpDocId + englishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + englishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + englishLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + englishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + englishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + englishLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + englishLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]
var dbHelpDocElementsInit_Chi = [ //"Documents/UserMan/Chi/OM-0506R0_EN_SED OM-302 D (220523)-"
    { name: option1Id   + helpDocId + chineseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + chineseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + chineseLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + chineseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + chineseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + chineseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + chineseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]
var dbHelpDocElementsInit_Por = [ //"Documents/UserMan/Por/OM-0506R0_EN_SED OM-302 D (220523)-"
    { name: option1Id   + helpDocId + portugeseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + portugeseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + portugeseLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + portugeseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + portugeseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + portugeseLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + portugeseLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]
var dbHelpDocElementsInit_Rus = [ // "Documents/UserMan/Rus/OM-0506R0_EN_SED OM-302 D (220523)-"
    { name: option1Id   + helpDocId + russianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + russianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + russianLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + russianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + russianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + russianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + russianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]
var dbHelpDocElementsInit_Ger = [ // "Documents/UserMan/Ger/OM-0506R0_EN_SED OM-302 D (220523)-",
    { name: option1Id   + helpDocId + germanLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + germanLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + germanLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + germanLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + germanLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + germanLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + germanLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]
var dbHelpDocElementsInit_Ita = [ // "Documents/UserMan/Ita/OM-0506R0_EN_SED OM-302 D (220523)-"
    { name: option1Id   + helpDocId + italianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + italianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + italianLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + italianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + italianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + italianLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + italianLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]
var dbHelpDocElementsInit_Fre = [ // "Documents/UserMan/Fre/OM-0506R0_EN_SED OM-302 D (220523)-"
    { name: option1Id   + helpDocId + frenchLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + frenchLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + frenchLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + frenchLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + frenchLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + frenchLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + frenchLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]
var dbHelpDocElementsInit_Hin = [ // "Documents/UserMan/Hin/OM-0506R0_EN_SED OM-302 D (220523)-"
    { name: option1Id   + helpDocId + hindiLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + hindiLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + hindiLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + hindiLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + hindiLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + hindiLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + hindiLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]
var dbHelpDocElementsInit_Ara = [ // "Documents/UserMan/Hin/OM-0506R0_EN_SED OM-302 D (220523)-"
    { name: option1Id   + helpDocId + arabicLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option1_1Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "79",  num_pages: "226" },
    { name: option1_2Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "85",  num_pages: "226" },
    { name: option2Id   + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "134", num_pages: "226" },
    { name: option3Id   + helpDocId + arabicLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option3_1Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "96",  num_pages: "226" },
    { name: option3_2Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "106", num_pages: "226" },
    { name: option5Id   + helpDocId + arabicLanguageId,  value: "",                                                                  page: "",    num_pages: "226" },
    { name: option5_1Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "149", num_pages: "226" },
    { name: option5_2Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "170", num_pages: "226" },
    { name: option4Id   + helpDocId + arabicLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option4_1Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "118", num_pages: "226" },
    { name: option4_2Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "126", num_pages: "226" },
    { name: option6Id   + helpDocId + arabicLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option6_1Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "180", num_pages: "226" },
    { name: option6_2Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "188", num_pages: "226" },
    { name: option6_3Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "196", num_pages: "226" },
    { name: option7Id   + helpDocId + arabicLanguageId,  value: "",                                                                  page: "" ,   num_pages: "226" },
    { name: option7_1Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "207", num_pages: "226" },
    { name: option7_2Id + helpDocId + arabicLanguageId,  value: path + "Documents/UserMan/Eng/OM-0506R0_EN_SED OM-302 D (220523)-",  page: "212", num_pages: "226" },
]

var helpTroubleShootDocId = "_helpTroubleShootDoc_"
var helpTroubleShootDocPageId = "Page"
var helpTroubleShootDocNumPagesId = "NumPages"
var dbHelpTroubleShootDocElementsInit_Esp = [ //"Documents/TroubleShoot/Esp/Error_Esp_00-p"
    { name: option1Id   + helpTroubleShootDocId + spanishLanguageId,  value: "",                                                  page: "",  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + spanishLanguageId,  value: "",                                                  page: "" , num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + spanishLanguageId,  value: "",                                                  page: "",  num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + spanishLanguageId,  value: "",                                                  page: "" , num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + spanishLanguageId,  value: "",                                                  page: "" , num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + spanishLanguageId,  value: "",                                                  page: "",  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + spanishLanguageId,  value: path + "Documents/TroubleShoot/Esp/Error_Esp_00-p",  page: "1", num_pages: "12" },
]
var dbHelpTroubleShootDocElementsInit_Eng = [
    { name: option1Id   + helpTroubleShootDocId + englishLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + englishLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + englishLanguageId,  value: "",                                                  page: "",   num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + englishLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + englishLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + englishLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + englishLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
]
var dbHelpTroubleShootDocElementsInit_Chi = [ //  "Documents/TroubleShoot/Chi/Error_Eng_00-p",
    { name: option1Id   + helpTroubleShootDocId + chineseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + chineseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + chineseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + chineseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + chineseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + chineseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + chineseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
]
var dbHelpTroubleShootDocElementsInit_Por = [ // "Documents/TroubleShoot/Por/Error_Eng_00-p"
    { name: option1Id   + helpTroubleShootDocId + portugeseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + portugeseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + portugeseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + portugeseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + portugeseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + portugeseLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + portugeseLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
]
var dbHelpTroubleShootDocElementsInit_Rus = [ // "Documents/TroubleShoot/Rus/Error_Eng_00-p"
    { name: option1Id   + helpTroubleShootDocId + russianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + russianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + russianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + russianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + russianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + russianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + russianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
]
var dbHelpTroubleShootDocElementsInit_Ger = [ // "Documents/TroubleShoot/Ger/Error_Eng_00-p"
    { name: option1Id   + helpTroubleShootDocId + germanLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + germanLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + germanLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + germanLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + germanLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + germanLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + germanLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
]
var dbHelpTroubleShootDocElementsInit_Ita = [ // "Documents/TroubleShoot/Ita/Error_Eng_00-p"
    { name: option1Id   + helpTroubleShootDocId + italianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + italianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + italianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + italianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + italianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + italianLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + italianLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
]
var dbHelpTroubleShootDocElementsInit_Fre = [ // "Documents/TroubleShoot/Fre/Error_Eng_00-p"
    { name: option1Id   + helpTroubleShootDocId + frenchLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + frenchLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + frenchLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + frenchLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + frenchLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + frenchLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + frenchLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
]
var dbHelpTroubleShootDocElementsInit_Hin = [ // "Documents/TroubleShoot/Hin/Error_Eng_00-p"
    { name: option1Id   + helpTroubleShootDocId + hindiLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + hindiLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + hindiLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + hindiLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + hindiLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + hindiLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + hindiLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
]
var dbHelpTroubleShootDocElementsInit_Ara = [ // "Documents/TroubleShoot/Ara/Error_Eng_00-p"
    { name: option1Id   + helpTroubleShootDocId + arabicLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option1_1Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option1_2Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option2Id   + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3Id   + helpTroubleShootDocId + arabicLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option3_1Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option3_2Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5Id   + helpTroubleShootDocId + arabicLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option5_1Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option5_2Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4Id   + helpTroubleShootDocId + arabicLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option4_1Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option4_2Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6Id   + helpTroubleShootDocId + arabicLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option6_1Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_2Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option6_3Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7Id   + helpTroubleShootDocId + arabicLanguageId,  value: "",                                                  page: "" ,  num_pages: "12" },
    { name: option7_1Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
    { name: option7_2Id + helpTroubleShootDocId + arabicLanguageId,  value: path + "Documents/TroubleShoot/Eng/Error_Eng_00-p",  page: "1",  num_pages: "12" },
]


//
// Console states
//
var CONSOLE_ST_DEFAULT = ""
var CONSOLE_ST_INIT = "init"
var CONSOLE_ST_READY = "ready"
var CONSOLE_ST_ERROR = "0"
var CONSOLE_ST_EDITING = "1"
var CONSOLE_ST_SETTING = "2"
var CONSOLE_ST_GENERATING_CUM_VIEW = "3"
var CONSOLE_ST_GENERATING_CONT_VIEW = "4"
var CONSOLE_ST_COMPLETED = "5"
var CONSOLE_ST_CANCELED = "6"
var CONSOLE_ST_FLUSHING = "7"
var CONSOLE_ST_DEPRESSURING = "8"
var CONSOLE_ST_WAITING_THERAPY_TIME = "9"
var CONSOLE_ST_VACCUM = "10"
var CONSOLE_ST_OVERPRESSURE = "11"
var CONSOLE_ST_SERVICE_MENU = "12"
var CONSOLE_ST_PRESSURE_TEST = "13"
var CONSOLE_ST_PRESSURE_TEST_ERROR = "14"
var CONSOLE_ST_BLOOD_VOLUME = "15"
var CONSOLE_ST_SAVE_SCREEN = "16"
var CONSOLE_ST_START_UP = "17"
var CONSOLE_ST_START_UP_ERROR = "18"
var CONSOLE_ST_WAIT_AFTER_START_UP = "19"
var CONSOLE_ST_AUX_STATE_1 = "20"
var CONSOLE_ST_AUX_STATE_2 = "21"

var CSD = CONSOLE_ST_DEFAULT

//
// Cross state matrix
//
var stateMatrix =[
//                                                CONSOLE_ST_ERROR                 CONSOLE_ST_EDITING               CONSOLE_ST_SETTING              CONSOLE_ST_GENERATING_CUM_VIEW    CONSOLE_ST_GENERATING_CONT_VIEW  CONSOLE_ST_COMPLETED             CONSOLE_ST_CANCELED              CONSOLE_ST_FLUSHING              CONSOLE_ST_DEPRESSURING          CONSOLE_ST_WAITING_THERAPY_TIME CONSOLE_ST_VACCUM              CONSOLE_ST_OVERPRESSURE          CONSOLE_ST_SERVICE_MENU         CONSOLE_ST_PRESSURE_TEST        CONSOLE_ST_PRESSURE_TEST_ERROR  CONSOLE_ST_BLOOD_VOLUME         CONSOLE_ST_SAVE_SCREEN          CONSOLE_ST_START_UP             CONSOLE_ST_START_UP_ERROR     CONSOLE_ST_WAIT_AFTER_START_UP CONSOLE_ST_AUX_STATE_1          CONSOLE_ST_AUX_STATE_2
//                                                -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 00 */ /* STATE_INIT                        */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 01 */ /* STATE_ERROR                       */ [CSD,                             CONSOLE_ST_ERROR,/*CSD,*/        CONSOLE_ST_ERROR,               CONSOLE_ST_ERROR,                 CONSOLE_ST_ERROR,                CSD,                             CSD,                             CONSOLE_ST_ERROR,                CONSOLE_ST_ERROR,                CONSOLE_ST_ERROR,               CONSOLE_ST_ERROR,               CSD,                            CONSOLE_ST_ERROR,/*CSD,*/       CONSOLE_ST_ERROR,               CSD,                            CSD,                            CSD,                            CONSOLE_ST_START_UP_ERROR,      CSD,                            CSD,                            CONSOLE_ST_ERROR,               CSD],
/* 02 */ /* STATE_INIT_CHECK_1                */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 03 */ /* STATE_INIT_CHECK_2                */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CONSOLE_ST_START_UP,            CSD,                            CSD,                            CSD],
/* 04 */ /* STATE_INIT_CHECK_3                */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CONSOLE_ST_START_UP,            CSD,                            CSD,                            CSD],
/* 05 */ /* STATE_MAIN_MENU                   */ [CONSOLE_ST_EDITING,  /*CSD*/     CSD,                             CONSOLE_ST_EDITING,             CONSOLE_ST_COMPLETED,             CSD,                             CONSOLE_ST_EDITING,/*CSD,*/      CONSOLE_ST_EDITING,/*CSD,*/      CSD,                             CSD,                             CSD,                            CONSOLE_ST_COMPLETED,           CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CONSOLE_ST_SAVE_SCREEN,         CONSOLE_ST_SAVE_SCREEN,         CONSOLE_ST_SAVE_SCREEN,         CSD,                            CSD],
/* 06 */ /* STATE_O3_SELECTION                */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 07 */ /* STATE_FLOW_SELECTION              */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 08 */ /* STATE_TIME_SELECTION              */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 09 */ /* STATE_DOSE_SELECTION              */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 10 */ /* STATE_THERAPY_TIME_SELECTION      */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 11 */ /* STATE_VACUUM_SELECTION            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 12 */ /* STATE_VOLUME_SELECTION            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 13 */ /* STATE_VACUUM_GENERATING           */ [CSD,                             CONSOLE_ST_VACCUM,               CSD,                            CONSOLE_ST_VACCUM,                CONSOLE_ST_VACCUM,               CONSOLE_ST_VACCUM,               CSD,                             CSD,                             CSD,                             CONSOLE_ST_VACCUM,              CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 14 */ /* STATE_VACUUM_COMPLETED            */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_COMPLETED,             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CONSOLE_ST_COMPLETED,           CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 15 */ /* STATE_VACUUM_PAUSED               */ [CSD,                             CONSOLE_ST_VACCUM,               CSD,                            CSD,                              CONSOLE_ST_VACCUM,/*CSD,*/       CONSOLE_ST_VACCUM,               CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 16 */ /* STATE_VACUUM_CANCELLED            */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_CANCELED,              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CONSOLE_ST_CANCELED,            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 17 */ /* STATE_ADJUSTING                   */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CONSOLE_ST_SETTING,              CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 18 */ /* STATE_O3_GENERATING               */ [CSD,                             CSD,                             CONSOLE_ST_GENERATING_CUM_VIEW, CSD,                              CSD,                             CONSOLE_ST_GENERATING_CUM_VIEW,  CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 19 */ /* STATE_USER_CANCELLED              */ [CSD,                             CSD,                             CONSOLE_ST_CANCELED,            CONSOLE_ST_CANCELED,              CONSOLE_ST_CANCELED, /*<--*/     CSD,                             CSD,                             CONSOLE_ST_CANCELED,             CONSOLE_ST_CANCELED,             CONSOLE_ST_CANCELED,            CONSOLE_ST_CANCELED,            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 20 */ /* STATE_COMPLETED                   */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_COMPLETED,             CONSOLE_ST_COMPLETED,            CSD,                             CSD,                             CONSOLE_ST_COMPLETED,            CONSOLE_ST_COMPLETED,            CONSOLE_ST_COMPLETED,           CONSOLE_ST_COMPLETED,           CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 21 */ /* STATE_MANUAL_COMPLETED            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 22 */ /* STATE_WAITING_THERAPY_TIME        */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_WAITING_THERAPY_TIME,  CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 23 */ /* STATE_WAITING_AUTOHEMO_RESTART    */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_WAITING_THERAPY_TIME,  CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CONSOLE_ST_GENERATING_CONT_VIEW,CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 24 */ /* STATE_OVERPRESSURE                */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_OVERPRESSURE,          CONSOLE_ST_OVERPRESSURE,         CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CONSOLE_ST_COMPLETED,           CSD,                            CSD,                            CONSOLE_ST_PRESSURE_TEST_ERROR, CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 25 */ /* STATE_MANUAL_OVERPRESSURE_1       */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 26 */ /* STATE_MANUAL_OVERPRESSURE_2       */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 27 */ /* STATE_SERVICE_MENU                */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CONSOLE_ST_AUX_STATE_2,         CSD],
/* 28 */ /* STATE_SHOW_SW_VERSIONS            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 29 */ /* STATE_SHOW_TEMP_PRESS             */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 30 */ /* STATE_CONTRAST_ADJUST             */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 31 */ /* STATE_BRIGHTNESS_ADJUST           */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 32 */ /* STATE_LANGUAGE_MENU               */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 33 */ /* STATE_PASSWORD_FIRST              */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 34 */ /* STATE_PASSWORD_SECOND             */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 35 */ /* STATE_PASSWORD_THIRD              */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 36 */ /* STATE_PASSWORD_FOURTH             */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 37 */ /* STATE_PASSWORD_FIFTH              */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 38 */ /* STATE_PASSWORD_SIXTH              */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 39 */ /* STATE_CALIBRATION_MENU            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CONSOLE_ST_AUX_STATE_2,         CSD],
/* 40 */ /* STATE_SELECT_REF_PRESS            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 41 */ /* STATE_SELECT_FLOW_REFS_1          */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 42 */ /* STATE_SELECT_FLOW_REFS_1B         */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 43 */ /* STATE_SELECT_FLOW_REFS_2          */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 44 */ /* STATE_SELECT_FLOW_REFS_2B         */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 45 */ /* STATE_SELECT_FLOW_REFS_3          */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 46 */ /* STATE_SELECT_FLOW_REFS_3B         */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 47 */ /* STATE_SELECT_O3_REFS_1            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CONSOLE_ST_AUX_STATE_1,         CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CONSOLE_ST_AUX_STATE_1],//CSD],
/* 48 */ /* STATE_SELECT_O3_REFS_2            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CONSOLE_ST_AUX_STATE_2,         CSD],
/* 49 */ /* STATE_SELECT_O3_REFS_3            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 50 */ /* STATE_SELECT_O3_REFS_4            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 51 */ /* STATE_SELECT_PRESS_COMP_FACTOR    */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 52 */ /* STATE_SELECT_BASE_WIDTH           */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 53 */ /* STATE_SELECT_FLOW_COMP_FOR_PULSES */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 54 */ /* STATE_CALIBRATE_PERIOD            */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CONSOLE_ST_AUX_STATE_1,         CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 55 */ /* STATE_SAVING_PARAMETERS           */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CONSOLE_ST_AUX_STATE_1,         CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CONSOLE_ST_AUX_STATE_1],
/* 56 */ /* STATE_LOADING_PARAMETERS          */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CONSOLE_ST_AUX_STATE_1,         CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 57 */ /* STATE_SHOWING_PARAMETERS          */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 58 */ /* STATE_WARNING                     */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 59 */ /* STATE_WASHING                     */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_FLUSHING,              CONSOLE_ST_FLUSHING,             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 60 */ /* STATE_MANUAL_MODE_TIMEOUT         */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 61 */ /* STATE_KEY_MODE_TRANSITION         */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 62 */ /* STATE_ADJUST_ZERO_O3_SENSOR_1     */ [CSD,                             CONSOLE_ST_SETTING,              CSD,                            CONSOLE_ST_SETTING,               CONSOLE_ST_SETTING,              CONSOLE_ST_SETTING,              CSD,                             CSD,                             CSD,                             CONSOLE_ST_SETTING,             CONSOLE_ST_SETTING,             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 63 */ /* STATE_ADJUST_ZERO_O3_SENSOR_2     */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_SETTING,               CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CONSOLE_ST_SETTING,             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 64 */ /* STATE_ADJUST_ZERO_O3_SENSOR_3     */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_SETTING,               CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CONSOLE_ST_SETTING,             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 65 */ /* STATE_DEPRESSURING_SYRINGE        */ [CSD,                             CSD,                             CSD,                            CONSOLE_ST_DEPRESSURING,          CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 66 */ /* STATE_GENERATING_FLOW             */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD],
/* 67 */ /* STATE_WAITING_AFTER_START_UP      */ [CSD,                             CSD,                             CSD,                            CSD,                              CSD,                             CSD,                             CSD,                             CSD,                             CSD,                             CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CSD,                            CONSOLE_ST_WAIT_AFTER_START_UP, CSD,                            CSD,                            CSD,                            CSD]
]


// Data Base Log
/*
dataBaseVer "V0.R0.P0" - Initial contents for SDV verification (05/04/2021)
dataBaseVer "V0.R0.P1" - Modifications due to DV verification:
                         - New icon element added (dbAppIcon.timeOutId) (17/06/21).
                         - sliderInitVacuumTime -> option7_2Id = 120 (17/06/21).
dataBaseVer "V0.R0.P2" - Modifications due to equipment to lend (03/11/2021).
                         - Help resources

*/
