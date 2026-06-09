// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

Qt.include("Constants.js")
Qt.include("Storaje.js")
Qt.include("Configurator.js")
Qt.include("DebugConstants.js")

var maxAvailableFlow = 1

function settings(state){
    if(state === "start"){
        appConsole.state = Constants.CONSOLE_ST_DEFAULT
        createConfigurationWindow()
        gadgetMenu.state = "noViewGadgetMenu"
    }
    else if(state === "stop")
    {
        appConsole.state = Constants.CONSOLE_ST_READY
    }
}

function stop(){
    consoleSocket.sendData(Constants.CNL_SIM)
    if(tabBar.selectedOption === option7Id){
        consoleSocket.sendData(Constants.CNL_SIM) // skip cleaning
    }
}

function pause(){
    consoleSocket.sendData(Constants.ENT_SIM)
    if( (tabBar.selectedOption == option4_1Id) || (tabBar.selectedOption == option4_2Id) ){
        emergencyPauseButton.frameImage.state = "playView"
    }else{
        appToolBar.state = "playStop"
    }
}

function settings(){
    consoleSocket.sendData(Constants.GET_INFO)
    appConsole.state = Constants.CONSOLE_ST_SERVICE_MENU
}

function help(){
    normalizationImage.state = "normalizationImageStateHide"

    appHelpMenu.alternativeHelpVideoTutorialFile = ""

    switch(magnitudeSelector.state){
        case "noInputSelected": appHelpMenu.state = "ShowHelp"
                                break
        case "inputSelected":   appHelpMenu.state = "ShowJustVideoTurorialHelp"
                                appHelpMenu.alternativeHelpVideoTutorialFile = magnitudeSelector.currentSelectedItem + Constants.helpTutorialVideoId

                                if((magnitudeSelector.currentSelectedItem === Constants.inputO3SelectorId) && (tabBar.selectedOption === option5_1Id))
                                {
                                    appHelpMenu.alternativeHelpVideoTutorialFile = magnitudeSelector.currentSelectedItem + "_" + tabBar.selectedOption + Constants.helpTutorialVideoId; break
                                }
                                if((magnitudeSelector.currentSelectedItem === Constants.inputTotalConcentrationSelectorId) && (tabBar.selectedOption === option5_2Id))
                                {
                                    appHelpMenu.alternativeHelpVideoTutorialFile = magnitudeSelector.currentSelectedItem + "_" + tabBar.selectedOption + Constants.helpTutorialVideoId; break
                                }
                                break
        case "gadgetSelected":  if(bloodVolume.state === "viewBloodVolumeStart"){
                                    appHelpMenu.state = "ShowJustVideoTurorialHelp"
                                    appHelpMenu.alternativeHelpVideoTutorialFile = Constants.helpBloodVolumeGadgetId + Constants.helpTutorialVideoId
                                }
                                else if(syringeCalculator.state === "viewAutomaticSyringeCalculator"){
                                    appHelpMenu.state = "ShowJustVideoTurorialHelp"
                                    appHelpMenu.alternativeHelpVideoTutorialFile = Constants.helpAutoSyringeCalculatorId + Constants.helpTutorialVideoId
                                }
                                else if(syringeCalculator.state === "viewManualSyringeCalculator"){
                                    appHelpMenu.state = "ShowJustVideoTurorialHelp"
                                    appHelpMenu.alternativeHelpVideoTutorialFile = Constants.helpManualSyringeCalculatorId + Constants.helpTutorialVideoId
                                }
                                else if(pressureTester.state === "viewPressureTesterStart"){
                                    appHelpMenu.state = "ShowJustVideoTurorialHelp"
                                    appHelpMenu.alternativeHelpVideoTutorialFile = Constants.helpPressureTesterId + Constants.helpTutorialVideoId
                                }
                                else if(memoryBoard.state === "memoryStart"){
                                    appHelpMenu.state = "ShowJustVideoTurorialHelp"
                                    appHelpMenu.alternativeHelpVideoTutorialFile = Constants.helpMemoryBoardId + Constants.helpTutorialVideoId
                                }
                                else if(salineHemoTherapyCalculator.state === "salineHemoTherapyCalculatorStart"){
                                    appHelpMenu.state = "ShowJustVideoTurorialHelp"
                                    appHelpMenu.alternativeHelpVideoTutorialFile = Constants.helpSalineCalculatorId + Constants.helpTutorialVideoId
                                }
                                break
    }
}

function closeHelp(){
    normalizationImage.state = "normalizationImageStateShow"
}

function noInputSelected(){
    magnitudeSelector.state = "noInputSelected"
    tabBar.state = "tabBarEabled"
    appHelpMenu.state = "HideHelp"
    tabBar.temporalDisable(300) // ticket #4122 solved (07/05/21)
    magnitudeSelector.currentSelectedItem = ""
    appToolBar.temporalDisable(300) // ticket #4313 solved (10/06/21)
}

function inputSelected(inputSelectedName){
    appHelpMenu.state = "HideHelp"
    magnitudeSelector.state = "inputSelected"
    tabBar.state = "tabBarDisabled"
    magnitudeSelector.currentSelectedItem = inputSelectedName
}

function noGadgetSelected(){
    magnitudeSelector.state = "noInputSelected"
    tabBar.state = "tabBarEabled"
    appHelpMenu.state = "HideHelp"
}

function gadgetSelected(){
    appHelpMenu.state = "HideHelp"
    magnitudeSelector.state = "gadgetSelected"
    tabBar.state = "tabBarDisabled"
}

function completeGadgetOpenEffect(){
    if(syringeCalculator.state === "viewAutomaticSyringeCalculatorPending"){
        syringeCalculator.state = "viewAutomaticSyringeCalculator"
    }
    if(syringeCalculator.state === "viewManualSyringeCalculatorPending"){
        syringeCalculator.state = "viewManualSyringeCalculator"
    }
    if(pressureTester.state === "viewPressureTesterStartPending"){
        pressureTester.state = "viewPressureTesterStart"
    }
    if(bloodVolume.state === "viewBloodVolumeStartPending"){
        bloodVolume.state = "viewBloodVolumeStart"
    }
    if(memoryBoard.state === "memoryStartPending"){
        memoryBoard.state = "memoryStart"
    }
    if(salineHemoTherapyCalculator.state === "viewSalineHemoTherapyCalculatorStartPending"){
        salineHemoTherapyCalculator.state = "salineHemoTherapyCalculatorStart"
    }
}

function completeGadgetCloseEffect(){
    gadgetInOutEffect.state = "noGadgetVisible"
}

function closeGadgets(){
    syringeCalculator.state = "noViewSyringeCalculatorQuick"
    pressureTester.state = "noViewPressureTesterQuick"
    memoryBoard.state = "noViewMemoryQuick"
    bloodVolume.state = "noViewBloodVolumeQuick"
    salineHemoTherapyCalculator.state = "noViewSalineHemoTherapyCalculatorQuick"
    completeGadgetCloseEffect()
}

function launchPressureTester(){
    var limitPressure = assignPressureTesterLimit()

    if(tabBar.selectedOption != ""){
        if(magnitudeSelector.inputFlow.visible){
            pressureTester.fixedFlow = false
            pressureTester.slider.to = magnitudeSelector.inputFlow.slider.to
            pressureTester.slider.from = magnitudeSelector.inputFlow.slider.from
        }
        else{
            pressureTester.fixedFlow = true
            pressureTester.slider.to = magnitudeSelector.inputFlow.slider.value + 1
            pressureTester.slider.from = magnitudeSelector.inputFlow.slider.value - 1
        }
        pressureTester.slider.value = magnitudeSelector.inputFlow.slider.value
        pressureTester.unitsLabel.text = magnitudeSelector.inputFlow.unitsLabel.text
        pressureTester.conversionFactor = magnitudeSelector.inputFlow.conversionFactor
    }


    gadgetInOutEffect.x = gadgetMenu.testPressureButtonCenterX
    gadgetInOutEffect.y = gadgetMenu.testPressureButtonTopY
    gadgetInOutEffect.reducedViewX= gadgetMenu.testPressureButtonCenterX
    gadgetInOutEffect.reducedViewY= gadgetMenu.testPressureButtonTopY
    gadgetInOutEffect.state = "gadgetVisible"

    appConsole.state = Constants.CONSOLE_ST_PRESSURE_TEST
    pressureTester.state = "viewPressureTesterStartPending"
    gadgetSelected()

    setPressureTesterIndicatorLimits((applicationWindow.atmosphericPressure + parseInt(limitPressure)) * cumulatedBoard.pressureIndicator.conversionFactor,
                                     (applicationWindow.atmosphericPressure - parseInt(limitPressure)) * cumulatedBoard.pressureIndicator.conversionFactor)
}


function exitPressureTester(){
    noGadgetSelected()
}

function launchBloodVolume(){
    gadgetInOutEffect.x = gadgetMenu.testBloodVolumeButtonCenterX
    gadgetInOutEffect.y = gadgetMenu.testBloodVolumeButtonTopY
    gadgetInOutEffect.reducedViewX= gadgetMenu.testBloodVolumeButtonCenterX
    gadgetInOutEffect.reducedViewY= gadgetMenu.testBloodVolumeButtonTopY
    gadgetInOutEffect.state = "gadgetVisible"

    bloodVolume.state = "viewBloodVolumeStartPending"
    gadgetSelected()
}

function exitBloodVolume(){
    noGadgetSelected()
}

function launchMemory(){
    memoryBoard.updateVisibleMemoryItems()

    gadgetInOutEffect.x = gadgetMenu.memoryButtonCenterX
    gadgetInOutEffect.y = gadgetMenu.memoryButtonTopY
    gadgetInOutEffect.reducedViewX= gadgetMenu.memoryButtonCenterX
    gadgetInOutEffect.reducedViewY= gadgetMenu.memoryButtonTopY
    gadgetInOutEffect.state = "gadgetVisible"

    memoryBoard.state = "memoryStartPending"
    gadgetSelected()
}

function extiMemory(){
    noGadgetSelected()
}

function launchSyringeCalculator(){
    syringeCalculator.concentrationSlider.to = magnitudeSelector.inputO3.slider.to
    syringeCalculator.concentrationSlider.value = magnitudeSelector.inputO3.slider.value

    gadgetInOutEffect.x = gadgetMenu.syringeCalculatorButtonCenterX
    gadgetInOutEffect.y = gadgetMenu.syringeCalculatorButtonTopY
    gadgetInOutEffect.reducedViewX= gadgetMenu.syringeCalculatorButtonCenterX
    gadgetInOutEffect.reducedViewY= gadgetMenu.syringeCalculatorButtonTopY
    gadgetInOutEffect.state = "gadgetVisible"

    if(tabBar.selectedOption === option1_1Id){
        syringeCalculator.state = "viewAutomaticSyringeCalculatorPending"
    }
    else{
        syringeCalculator.state = "viewManualSyringeCalculatorPending"
    }

    gadgetSelected()
}

function exitSyringeCalculator(){
    noGadgetSelected()
}

function launchSalineHemoTherapyCalculator(){
    gadgetInOutEffect.x = gadgetMenu.salineHemoTherapyCalculatorButtonCenterX
    gadgetInOutEffect.y = gadgetMenu.salineHemoTherapyCalculatorButtonTopY
    gadgetInOutEffect.reducedViewX= gadgetMenu.salineHemoTherapyCalculatorButtonCenterX
    gadgetInOutEffect.reducedViewY= gadgetMenu.salineHemoTherapyCalculatorButtonTopY
    gadgetInOutEffect.state = "gadgetVisible"

    salineHemoTherapyCalculator.state = "viewSalineHemoTherapyCalculatorStartPending"
    gadgetSelected()
}

function exitLaunchSalineHemoTherapyCalculator(){
    noGadgetSelected()
}

function play(){
    var command = ""
    var backSting = ""

    applicationWindow.periodicInfoDelay = applicationWindow.quickRequestDataTime
    tabBar.enabled = false                  // quick tabBar disble, ticket #4129 solved (11/05/21)
    totalsBoard.temporalDisable(2000)       // quick totalsBoard disble, ticket #4129 solved (11/05/21)
    gadgetMenu.temporalDisable(1000)        // quick gadgetMenuId disble, ticket #4232 solved (31/05/21)
//  magnitudeSelector.temporalDisable(1000) // quick magnitudeSelector disble, ticket #4232 solved (31/05/21)
    magnitudeSelector.enabled = false       // quick magnitudeSelector disble, ticket #4232 solved (31/05/21)
    totalsBoard.state = "noViewTotalBoard"  // quick totalsBoard dissapear, ticket #4309 (09/06/21)

    if( (appConsole.state === Constants.CONSOLE_ST_GENERATING_CUM_VIEW) || (appConsole.state === Constants.CONSOLE_ST_GENERATING_CONT_VIEW) ){
        // leave pause state
        if(tabBar.selectedOption == option1_2Id) {
            appToolBar.state = "playStop"
        }
        else if(tabBar.selectedOption == option3_1Id) {
            consoleSocket.sendData(Constants.ENT_SIM)
            appToolBar.state = "playStop"
        }
        else if(tabBar.selectedOption == option3_2Id) {
            consoleSocket.sendData(Constants.ENT_SIM)
            appToolBar.state = "playStop"
        }
        else if(tabBar.selectedOption == option5_1Id) {

            if((cumulatedBoard.nextCycleConfirmation.visible) || (parseInt(cumulatedBoard.cyclesLabel.text.substring(0, 1), 10) === magnitudeSelector.theraphyCycles)){
                consoleSocket.sendData(Constants.ENT_SIM)
                appToolBar.state = "justPlay"
            }
            else{
                cumulatedBoard.removingBloodImage.visible = false
                cumulatedBoard.nextCycleConfirmation.visible = true
            }
        }
        else if( (tabBar.selectedOption == option4_1Id) || (tabBar.selectedOption == option4_2Id) ){
            emergencyPauseButton.frameImage.state = "pauseView"
            consoleSocket.sendData(Constants.ENT_SIM)
        }
        else{
            consoleSocket.sendData(Constants.ENT_SIM)
            appToolBar.state = "pauseStop"
        }

    }
    else if(appConsole.state === Constants.CONSOLE_ST_FLUSHING){
        consoleSocket.sendData(Constants.ENT_SIM)
    }
    else if(appConsole.state === Constants.CONSOLE_ST_VACCUM){

        if(tabBar.selectedOption == option3_1Id) {
            appToolBar.state = "justStop"
        }
        else if(tabBar.selectedOption == option3_2Id) {
            appToolBar.state = "justStop"
        }
        else if(tabBar.selectedOption == option5_1Id) {
            appToolBar.state = "playStop"
            if(cumulatedBoard.addingBloodImage.state === "noViewAddingBlood"){
                hideCumulatedBoard()
                cumulatedBoard.addingBloodImage.state = "viewAddingBlood"
                cumulatedBoard.cyclesCounter.visible = true
            }
        }
        else if(tabBar.selectedOption == option2Id) {
            appToolBar.state = "playStop"
            if(cumulatedBoard.addingSalineImage.state === "noViewAddingSaline"){
                hideCumulatedBoard()
                cumulatedBoard.addingSalineImage.state = "viewAddingSaline"
                cumulatedBoard.cyclesCounter.visible = true
            }
        }
        else{
            appToolBar.state = "pauseStop"
        }
        consoleSocket.sendData(Constants.ENT_SIM)
    }
    else if(appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME){

        consoleSocket.sendData(Constants.ENT_SIM)
        appToolBar.state = "justStop"

        if( (tabBar.selectedOption === option5_1Id) &&
            (appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME) &&
            (magnitudeSelector.theraphyPressure === "H") ) {
            cumulatedBoard.pressureIndicator.state = "simulateDepressure"
        }
    }
    else{

        switch(tabBar.selectedOption){
        case option1_1Id:
            command = Constants.SYRINGE_START + (magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                              + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + "\r"
            configureCumulatedBoard(0, 0, 0, 0, 0, 0, 0, 0) // just to initialize pressure metter
            break;
        case option1_2Id:
            command = Constants.MANUAL_START  + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                              + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                              + Storage.getAppDB(Constants.dbDeviceLimits.overpressureManualSyringeId, "*") + "\r"

            //DEB->debug.log(DC.therapiesLog, "Storage.getAppDB(Constants.dbDeviceLimits.overpressureManualSyringeId, *): ", Storage.getAppDB(Constants.dbDeviceLimits.overpressureManualSyringeId, "*"))
            //DEB->debug.log(DC.therapiesLog, "Constants.dbDeviceLimits.overpressureManualSyringeId: ", Constants.dbDeviceLimits.overpressureManualSyringeId)
            configureCumulatedBoard( 0, 0, 0, 0, 0, 0, 0, 0) // just to initialize pressure metter
            break;
        case option2Id:
            command = Constants.SALINE_START  + Math.round(magnitudeSelector.inputSalineVolume.slider.value / magnitudeSelector.inputSalineVolume.conversionFactor) + ","
                                              + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                              + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                              + salineBublingTimeSeconds() + ","
                                              + ((magnitudeSelector.previousVacuum) ? Math.round(magnitudeSelector.inputVacuumTime.slider.value  / magnitudeSelector.inputVacuumTime.conversionFactor) : "0") + ","
                                              + Math.round(magnitudeSelector.inputPressure.slider.value  / magnitudeSelector.inputPressure.conversionFactor) + ","
                                              + Math.round(magnitudeSelector.inputReinfusionTime.slider.value / magnitudeSelector.inputReinfusionTime.conversionFactor) + ","
                                              + Storage.getAppDB(Constants.dbDeviceLimits.overpressureSalineHemoId, "*") + ","
                                              + Storage.getAppDB(Constants.dbDeviceLimits.overpressureSalineReinfusionId, "*") + "\r"

            configureCumulatedBoard( Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor),                  // O3
                                     Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor),              // flow
                                     0,                                                                                                                // time
                                     0,                                                                                                                // dose
                                     0,                                                                                                                // volume
                                     Math.round(magnitudeSelector.inputVacuumTime.slider.value  / magnitudeSelector.inputVacuumTime.conversionFactor), // vacuumTime
                                     0,                                                                                                                // therapyTime
                                     Math.round(magnitudeSelector.inputPressure.slider.value  / magnitudeSelector.inputPressure.conversionFactor))     // vacuumPressure
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = salineBublingTimeSeconds()
            break;
        case option3_1Id:
            command = Constants.CLOSED_BAG_START  + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                                  + Math.round(magnitudeSelector.inputTherapyTime.slider.value / magnitudeSelector.inputTherapyTime.conversionFactor) + ","
                                                  + Math.round(magnitudeSelector.inputVacuumTime.slider.value  / magnitudeSelector.inputVacuumTime.conversionFactor) + ","
                                                  + 1000 * Math.round(magnitudeSelector.inputVolume.slider.value / magnitudeSelector.inputVolume.conversionFactor) + ","
                                                  + Storage.getAppDB(Constants.dbDeviceLimits.overpressureClosedBagId, "*") + "\r"
            configureCumulatedBoard( Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor),
                                     0,
                                     0,
                                     0,
  //                                 Math.round(magnitudeSelector.inputTimeVolume.slider.value / magnitudeSelector.inputTimeVolume.conversionFactor),
                                     Math.round(magnitudeSelector.inputVolume.slider.value / magnitudeSelector.inputVolume.conversionFactor),
                                     Math.round(magnitudeSelector.inputVacuumTime.slider.value / magnitudeSelector.inputVacuumTime.conversionFactor),
                                     Math.round(magnitudeSelector.inputTherapyTime.slider.value / magnitudeSelector.inputTherapyTime.conversionFactor),
                                     0)
            break;
        case option3_2Id:
            command = Constants.OPEN_BAG_START  + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                                + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                                + Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor) + ","
                                                + Math.round(magnitudeSelector.inputCleanTime.slider.value / magnitudeSelector.inputCleanTime.conversionFactor) + ","
                                                + Storage.getAppDB(Constants.dbDeviceLimits.overpressureOpenedBagId, "*") + "\r"
            configureCumulatedBoard( Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor),
                                     Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor),
                                     Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor),
                                     0,
                                     0,
                                     Math.round(magnitudeSelector.inputCleanTime.slider.value / magnitudeSelector.inputCleanTime.conversionFactor),
                                     0,
                                     0)
            break;
        case option5_1Id: // #4833
            var hiperbaricFactor = Storage.getAppDB(Constants.dbConstants.autohemoHiperbaricFactorId, "1")

            if(magnitudeSelector.inputO3.differentValuesOnCycles.activated === false){
                backSting = magnitudeSelector.inputO3.fixButtonLabel_1.text
                magnitudeSelector.inputO3.fixButtonLabel_1.text = magnitudeSelector.inputO3.slider.value
            }

            command = Constants.AUTOHEMO_START  + magnitudeSelector.theraphyPressure + ","
                                                + magnitudeSelector.theraphyCycles + ","
                                                + Math.round(magnitudeSelector.inputBottleVolume.slider.value / magnitudeSelector.inputBottleVolume.conversionFactor) + ","
                                                + Math.round(magnitudeSelector.inputBloodVolume.slider.value / magnitudeSelector.inputBloodVolume.conversionFactor) + ","
                                                + Math.round(magnitudeSelector.inputO3.fixButtonLabel_1.text / magnitudeSelector.inputO3.conversionFactor) + ","
                                                + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                                + Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor) + ","
                                                + ((magnitudeSelector.previousVacuum) ? Math.round(magnitudeSelector.inputVacuumTime.slider.value  / magnitudeSelector.inputVacuumTime.conversionFactor) : "0") + ","
                                                + Math.round(magnitudeSelector.inputPressure.slider.value  / magnitudeSelector.inputPressure.conversionFactor) + ","
                                                + Math.round(autoHemoDose() / magnitudeSelector.inputTotalConcentration.conversionFactor) + ","
                                                + Storage.getAppDB(Constants.dbConstants.autohemoMixTimeId, "") + ","
                                                + Storage.getAppDB(Constants.dbDeviceLimits.overpressureAutohemoId, "*") + ","
                                                + Storage.getAppDB(Constants.dbDeviceLimits.overpressureBloodReinfusionId, "*") + ","
                                                + Math.round( (magnitudeSelector.inputO3.differentValuesOnCycles.activated ? magnitudeSelector.inputO3.fixButtonLabel_1.text : magnitudeSelector.inputO3.fixButtonLabel_1.text ) / magnitudeSelector.inputO3.conversionFactor ) + ","
                                                + Math.round( (magnitudeSelector.inputO3.differentValuesOnCycles.activated ? magnitudeSelector.inputO3.fixButtonLabel_2.text : magnitudeSelector.inputO3.fixButtonLabel_1.text ) / magnitudeSelector.inputO3.conversionFactor ) + ","
                                                + Math.round( (magnitudeSelector.inputO3.differentValuesOnCycles.activated ? magnitudeSelector.inputO3.fixButtonLabel_3.text : magnitudeSelector.inputO3.fixButtonLabel_1.text ) / magnitudeSelector.inputO3.conversionFactor ) + ","
                                                + Math.round( (magnitudeSelector.inputO3.differentValuesOnCycles.activated ? magnitudeSelector.inputO3.fixButtonLabel_4.text : magnitudeSelector.inputO3.fixButtonLabel_1.text ) / magnitudeSelector.inputO3.conversionFactor ) + ","
                                                + Math.round( (magnitudeSelector.inputO3.differentValuesOnCycles.activated ? magnitudeSelector.inputO3.fixButtonLabel_5.text : magnitudeSelector.inputO3.fixButtonLabel_1.text ) / magnitudeSelector.inputO3.conversionFactor ) + ","

                                                + Math.round( magnitudeSelector.multipleTotalConcentrationValues[0] * ( magnitudeSelector.theraphyPressure === "N" ? hiperbaricFactor : 1 )) + ","
                                                + Math.round( magnitudeSelector.multipleTotalConcentrationValues[1] * ( magnitudeSelector.theraphyPressure === "N" ? hiperbaricFactor : 1 )) + ","
                                                + Math.round( magnitudeSelector.multipleTotalConcentrationValues[2] * ( magnitudeSelector.theraphyPressure === "N" ? hiperbaricFactor : 1 )) + ","
                                                + Math.round( magnitudeSelector.multipleTotalConcentrationValues[3] * ( magnitudeSelector.theraphyPressure === "N" ? hiperbaricFactor : 1 )) + ","
                                                + Math.round( magnitudeSelector.multipleTotalConcentrationValues[4] * ( magnitudeSelector.theraphyPressure === "N" ? hiperbaricFactor : 1 )) + "\r"

            configureCumulatedBoard( Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor),                  // O3
                                     Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor),              // flow
                                     0,                                                                                                                // time
                                     magnitudeSelector.multipleTotalConcentrationValues[0],                                                            // dose
                                     0,                                                                                                                // volume
                                     Math.round(magnitudeSelector.inputVacuumTime.slider.value  / magnitudeSelector.inputVacuumTime.conversionFactor), // vacuumTime
                                     Storage.getAppDB(Constants.dbConstants.autohemoMixTimeId, ""),                                                    // therapyTime
                                     Math.round(magnitudeSelector.inputPressure.slider.value  / magnitudeSelector.inputPressure.conversionFactor))     // vacuumPressure

            if(magnitudeSelector.inputO3.differentValuesOnCycles.activated === false){
                magnitudeSelector.inputO3.fixButtonLabel_1.text = backSting
            }
            break;

        case option5_2Id:
            command = Constants.DOSE_START  + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                            + Math.round(magnitudeSelector.inputTotalConcentration.slider.value / magnitudeSelector.inputTotalConcentration.conversionFactor) + ","
                                            + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                            + Storage.getAppDB(Constants.dbDeviceLimits.overpressureDoseId, "*") + "\r"
            configureCumulatedBoard( Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor),
                                     Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor),
                                     0,
                                     Math.round(Number(magnitudeSelector.inputTotalConcentration.magnitudeLabel.text.replace(".", "")) / magnitudeSelector.inputTotalConcentration.conversionFactor),  // dose
                                     0,
                                     0,
                                     0)
            break;
        case option4_1Id:
            command = Constants.VAGINAL_INSUFF_START + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                                     + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                                     + Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor) + ","
                                                     + Storage.getAppDB(Constants.dbDeviceLimits.overpressureInsufflationVId, "*") + "\r"
            configureCumulatedBoard( Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor),
                                     Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor),
                                     Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor),
                                     0,
                                     0,
                                     0,
                                     0,
                                     0)
            break;
        case option4_2Id:
            command = Constants.RECTAL_INSUFF_START + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                                    + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                                    + Math.round(magnitudeSelector.inputVolume.slider.value / magnitudeSelector.inputVolume.conversionFactor) + ","
                                                    + Storage.getAppDB(Constants.dbDeviceLimits.overpressureInsufflationRId, "*") + "\r"
            configureCumulatedBoard( Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor),
                                     Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor),
                                     0,
                                     0,
                                     Math.round(magnitudeSelector.inputVolume.slider.value / magnitudeSelector.inputVolume.conversionFactor),
                                     0,
                                     0,
                                     0)
            break;
        case option6_1Id:            
            command = Constants.O3_START    + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                            + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                            + Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor) + ","
                                            + 0 + ","
                                            + Storage.getAppDB(Constants.dbDeviceLimits.overpressureSalineId, "*") + "\r"
            configureCumulatedBoard( 0,
                                     0,
                                     Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor),
                                     0,
                                     0,
                                     0,
                                     0,
                                     0)
            break;
        case option6_2Id:
            command = Constants.O3_START   + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                           + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                           + Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor) + ","
                                           + 0 + ","
                                           + Storage.getAppDB(Constants.dbDeviceLimits.overpressureWaterId, "*") + "\r"
            configureCumulatedBoard( 0,
                                     0,
                                     Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor),
                                     0,
                                     0,
                                     0,
                                     0,
                                     0)
            break;
        case option6_3Id:
            command = Constants.O3_START    + Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) + ","
                                            + Math.round(magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) + ","
                                            + Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor) + ","
                                            + 0 + ","
                                            + Storage.getAppDB(Constants.dbDeviceLimits.overpressureOilId, "*") + "\r"
            configureCumulatedBoard( 0,
                                     0,
                                     Math.round(magnitudeSelector.inputTime.slider.value / magnitudeSelector.inputTime.conversionFactor),
                                     0,
                                     0,
                                     0,
                                     0,
                                     0)
            break;
        case option7_1Id:
            command = Constants.VACUUM_BY_TIME_START  + Math.round(magnitudeSelector.inputVacuumTime.slider.value  / magnitudeSelector.inputVacuumTime.conversionFactor) + ","
                                                      + Storage.getAppDB(Constants.dbDeviceLimits.overpressureVacuumId, "*") + "\r"
            configureCumulatedBoard( 0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     Math.round(magnitudeSelector.inputVacuumTime.slider.value / magnitudeSelector.inputVacuumTime.conversionFactor),
                                     0,
                                     0)
            break;
        case option7_2Id:
            command = Constants.VACUUM_BY_PRESSURE_START + Math.round(magnitudeSelector.inputVacuumTime.slider.value  / magnitudeSelector.inputVacuumTime.conversionFactor) + ","
                                                         + Math.round(magnitudeSelector.inputPressure.slider.value  / magnitudeSelector.inputPressure.conversionFactor) * (-1) + "\r"
            configureCumulatedBoard( 0,
                                     0,
                                     0,
                                     Math.round(magnitudeSelector.inputTimeDose.slider.value / magnitudeSelector.inputTimeDose.conversionFactor),
                                     0,
                                     Math.round(magnitudeSelector.inputVacuumTime.slider.value / magnitudeSelector.inputVacuumTime.conversionFactor),
                                     0,
                                     Math.round(magnitudeSelector.inputPressure.slider.value / magnitudeSelector.inputPressure.conversionFactor))
            break;
        }
        consoleSocket.sendData(command)
    }
    saveScreenTimer.restart()
}

function playPressed(){
    if(tabBar.selectedOption == option1_2Id) {
        if( (appConsole.state === Constants.CONSOLE_ST_GENERATING_CUM_VIEW) || (appConsole.state === Constants.CONSOLE_ST_GENERATING_CONT_VIEW) ){
            consoleSocket.sendData(Constants.ENT_SIM)
            cumulatedBoard.syringeAnimation.syringeGif.paused = false
        }
    }
}

function playReleased(){
    if(tabBar.selectedOption == option1_2Id) {
        if( (appConsole.state === Constants.CONSOLE_ST_GENERATING_CUM_VIEW) || (appConsole.state === Constants.CONSOLE_ST_GENERATING_CONT_VIEW) ){
            consoleSocket.sendData(Constants.ENT_SIM)
            cumulatedBoard.syringeAnimation.syringeGif.paused = true
        }
    }
}

function setPressureTesterIndicatorLimits(maxValue, minValue){
    var range = maxValue - minValue

    pressureTester.pressureMetter.progressTool.maximumValue = (range / 0.80) + minValue  // practical value to get desired effect on color gradient scale
    pressureTester.pressureMetter.progressTool.minimumValue =  minValue
}

function setPressureMetterIndicatorLimits(maxValue, minValue){
    var range = maxValue - minValue

    cumulatedBoard.pressureIndicator.progressTool.maximumValue = (range / 0.80) + minValue  // practical value to get desired effect on color gradient scale
    cumulatedBoard.pressureIndicator.progressTool.minimumValue =  minValue
}

function configureCumulatedBoard(O3, flow, time, dose, volume, vacuumTime, therapyTime, vacuumPressure){
    //
    // The units in the parameter received are passed already converted to oficial internal equipment units.
    //
    //    O3: ug/Nml
    //    flow: l/h
    //    time: min
    //    dose: ug
    //    volume: ml (insuflation)
    //    vacuumTime: sec
    //    therapyTime: min
    //    volume: l (bag and liquid ozonization)
    //    vacuumPressure: mbar
    //
    // Sea level:                       1 atm -->     1.01325 bar -->    1013,25 mbar --> 760 mmHg(Torr) -->      14,6959 psi
    // Wenquan, China (5000 m):  0,526316 atm --> 0,533289687 bar --> 533,289687 mbar --> 400 mmhg(Torr) --> 7,7347129759 psi
    //
    var limitPressure

    switch(tabBar.selectedOption){
        case option1_1Id:
            cumulatedBoard.syringeAnimation.syringeGif.paused = false
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureSyringeId, "*")
            break;
        case option1_2Id:
            cumulatedBoard.syringeAnimation.syringeGif.paused = true
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureManualSyringeId, "*")
            break;
        case option2Id: // O3: ug/ml - flow: l/h - time: min
            cumulatedBoard.cumulatedO3.progressTool.maximumValue = dose  * cumulatedBoard.cumulatedO3.conversionFactor
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = therapyTime
            cumulatedBoard.cumulatedTimeSeconds.progressTool.maximumValue = vacuumTime // sec
            cumulatedBoard.cumulatedPressure.progressTool.maximumValue = vacuumPressure // mbar
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureSalineHemoId, "*")
            break;
        case option3_1Id: // O3: ug/ml - volume: l - vacuumTime: s - therapyTime: min
            cumulatedBoard.cumulatedO3.progressTool.maximumValue = O3 * (volume * 1000) * cumulatedBoard.cumulatedO3.conversionFactor     // -> volume * 1000 since the parameter is defined as l
            cumulatedBoard.cumulatedVolume.progressTool.maximumValue = (volume * 1000)  * cumulatedBoard.cumulatedVolume.conversionFactor // -> volume * 1000 since the parameter is defined as l
            cumulatedBoard.cumulatedTimeSeconds.progressTool.maximumValue = vacuumTime // sec
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = therapyTime * 60  // sec
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureClosedBagId, "*")
            break;
        case option3_2Id: // O3: ug/ml - volume: l - vacuumTime: s - therapyTime: min
            cumulatedBoard.cumulatedO3.progressTool.maximumValue = Math.round(flow * 1000 * time * O3/ 60) * cumulatedBoard.cumulatedO3.conversionFactor
            cumulatedBoard.cumulatedVolume.progressTool.maximumValue = Math.round(flow * 1000 * time / 60) * cumulatedBoard.cumulatedVolume.conversionFactor
            cumulatedBoard.cumulatedTimeSeconds.progressTool.maximumValue = vacuumTime // sec
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = time * 60  // sec
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureOpenedBagId, "*")
            break;
        case option5_1Id: // O3: ug/ml - flow: l/h - dose: ug
            cumulatedBoard.cumulatedO3.progressTool.maximumValue = dose
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = therapyTime
            cumulatedBoard.cumulatedTimeSeconds.progressTool.maximumValue = vacuumTime // sec
            cumulatedBoard.cumulatedPressure.progressTool.maximumValue = vacuumPressure // mbar
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureAutohemoId, "*")
            break;
        case option5_2Id: // O3: ug/ml - flow: l/h - time: min
            cumulatedBoard.cumulatedO3.progressTool.maximumValue = dose  * cumulatedBoard.cumulatedO3.conversionFactor
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureDoseId, "*")
            break;
        case option4_1Id: // O3: ug/ml - flow: l/h - volume: ml
            cumulatedBoard.cumulatedO3.progressTool.maximumValue = O3 * volume * cumulatedBoard.cumulatedO3.conversionFactor
            cumulatedBoard.cumulatedVolume.progressTool.maximumValue = volume * cumulatedBoard.cumulatedVolume.conversionFactor
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = time * 60 // sec
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureInsufflationVId, "*")
            break;
        case option4_2Id: // O3: ug/ml - flow: l/h - volume: ml
            cumulatedBoard.cumulatedO3.progressTool.maximumValue = O3 * volume * cumulatedBoard.cumulatedO3.conversionFactor
            cumulatedBoard.cumulatedVolume.progressTool.maximumValue = volume * cumulatedBoard.cumulatedVolume.conversionFactor
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = Math.round( volume / (flow * 1000 / 3600) ) // sec
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureInsufflationRId, "*")
            break;
        case option6_1Id: // O3: ug/ml - volume: l
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = time * 60                             // sec
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureSalineId, "*")
            break;
        case option6_2Id: // O3: ug/ml - volume: l
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = time * 60                             // sec
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureWaterId, "*")
            break;
        case option6_3Id: // O3: ug/ml - volume: l
            cumulatedBoard.cumulatedTime.progressTool.maximumValue = time * 60                             // sec
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureOilId, "*")
            break;
        case option7_1Id: // vacuumTime: sec
            cumulatedBoard.cumulatedTimeSeconds.progressTool.maximumValue = vacuumTime // sec
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureVacuumId, "*")
            break;
        case option7_2Id: // vacuumPressure: mbar
            cumulatedBoard.cumulatedPressure.progressTool.maximumValue = vacuumPressure // mbar
            limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureVacuumId, "*")
            break;
    }

    setPressureMetterIndicatorLimits((applicationWindow.atmosphericPressure + parseInt(limitPressure)) * cumulatedBoard.pressureIndicator.conversionFactor,
                                     (applicationWindow.atmosphericPressure - parseInt(limitPressure)) * cumulatedBoard.pressureIndicator.conversionFactor)
}

function resolvePressureMetterIndicatorLimits(){
    var limitPressure

    switch(tabBar.selectedOption){
        case option1_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureSyringeId, "*"); break;
        case option1_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureManualSyringeId, "*"); break;
        case option2Id:   limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureSalineHemoId, "*"); break;
        case option3_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureClosedBagId, "*"); break;
        case option3_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureOpenedBagId, "*"); break;
        case option5_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureAutohemoId, "*"); break;
        case option5_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureDoseId, "*"); break;
        case option4_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureInsufflationVId, "*"); break;
        case option4_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureInsufflationRId, "*"); break;
        case option6_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureSalineId, "*"); break;
        case option6_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureWaterId, "*"); break;
        case option6_3Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureOilId, "*"); break;
        case option7_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureVacuumId, "*"); break;
        case option7_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureVacuumId, "*"); break;
    }

    setPressureMetterIndicatorLimits((applicationWindow.atmosphericPressure + parseInt(limitPressure)) * cumulatedBoard.pressureIndicator.conversionFactor,
                                     (applicationWindow.atmosphericPressure - parseInt(limitPressure)) * cumulatedBoard.pressureIndicator.conversionFactor)
}

function assignPressureTesterLimit(){
    var limitPressure = ""

    switch(tabBar.selectedOption){
        case option1_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureManualSyringeId, "*"); break;
        case option2Id:   limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureSalineHemoId, "*"); break;
        case option3_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureClosedBagId, "*"); break;
        case option3_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureOpenedBagId, "*"); break;
        case option5_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureAutohemoId, "*"); break;
        case option5_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureDoseId, "*"); break;
        case option4_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureInsufflationVId, "*"); break;
        case option4_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureInsufflationRId, "*"); break;
        case option6_1Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureSalineId, "*"); break;
        case option6_2Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureWaterId, "*"); break;
        case option6_3Id: limitPressure = Storage.getAppDB(Constants.dbDeviceLimits.overpressureOilId, "*"); break;
    }

    return limitPressure
}

function playPressureTester(){
    var limitPressure = assignPressureTesterLimit()

    applicationWindow.periodicInfoDelay = applicationWindow.quickRequestDataTime
    consoleSocket.sendData(Constants.O3_START + 0 + ","
                                              + pressureTester.slider.value + ","
                                              + pressureTester.toutTime / 60 + ","
                                              + 0 + ","
                                              + limitPressure + "\r")
}

function stopPressureTester(){
    applicationWindow.periodicInfoDelay = applicationWindow.slowRequestDataTime
    consoleSocket.sendData(Constants.CNL_SIM) // stop flow generation (by menans of O3=0 ozone genration)
    consoleSocket.sendData(Constants.CNL_SIM) // stop clean after O3 generation
    consoleSocket.sendData(Constants.CNL_SIM) // stop the fan noise (lead main board to repose state)
}

function startBloodPush(){
      consoleSocket.sendData(Constants.O2_PUSH_START + Storage.getAppDB(Constants.dbDeviceLimits.overpressureBloodReinfusionId, "*") + "\r")
}

function stopBloodPush(){
    consoleSocket.sendData(Constants.O2_PUSH_STOP)
}

function manageSocketConnection(){
    requestDataTimer.running = true
    socketConnectionTimer.running = false
}
function manageSocketDisconnection(){
    requestDataTimer.running = false
    socketConnectionTimer.running = true
}

/*
    Cancelling autohemo therapy when setting for second, third or fourth cicle returns
    console to editing state without passing through cancelled state. This patch solves it.
*/
function autoHemoSpecialCasePatch(currentConsoleState, therapyState, newState){
    if(tabBar.selectedOption === option5_1Id){
        if((currentConsoleState === Constants.CONSOLE_ST_SETTING) && (therapyState === 5)){
            if(cumulatedBoard.cyclesLabel.text.substring(0,1) !== "1"){
                newState = Constants.CONSOLE_ST_CANCELED
            }
        }
    }
    return newState
}

function manageTerapyState(therapyState, errorCode){
    var currentConsoleState = appConsole.state
    var newState = stateMatrix[therapyState][appConsole.state]

    if( (newState !== CONSOLE_ST_DEFAULT) && (newState !== appConsole.state) ){
        appConsole.stateBefore = appConsole.state
        appConsole.state = newState
    }
    debug.log(socketDecodeConsoleLog, "state to manage: ", therapyState, ":", currentConsoleState, " -> ", appConsole.state)
}

function manageDeviceInfo(deviceInfo)
{
    debug.log(socketDecodeConsoleLog, "device info to manage: ", deviceInfo)
    applicationWindow.generationTime = deviceInfo
}

function manageErrorState(errorState){
    debug.log(socketDecodeConsoleLog, "error to manage: ", errorState)
    if(errorState !== 0){ // ticket #4227
        totalsBoard.errorCodeLabel.text = errorState
        pressureTester.errorCodeLabel.text = errorState
        startUp.erroId.text = errorState
    }

    // show configuration menu option at the beggining of start up
    if( (startUp.skipInitButton.pendingToShow) && (errorState === 0) ){
        startUp.skipInitButton.visible = true
    }
}

function manageTimeState(minutes, seconds){
    var elapsedMinutes
    var elapsedSeconds
    var elapsedDecimalMinutes

    elapsedMinutes = Math.floor(( (magnitudeSelector.inputTime.slider.value * 60) - (minutes * 60) - seconds ) / 60)
    elapsedSeconds = ( (magnitudeSelector.inputTime.slider.value * 60) - (minutes * 60) - seconds ) % 60
    elapsedDecimalMinutes = elapsedMinutes + (elapsedSeconds / 60)

    if(tabBar.selectedOption === option4_2Id){
        elapsedSeconds = parseInt(magnitudeSelector.inputTimeVolume.magnitudeLabel2.text.substring(0, 2), 10) * 60
        elapsedSeconds = elapsedSeconds + parseInt(magnitudeSelector.inputTimeVolume.magnitudeLabel2.text.substring(3, 6), 10)
        elapsedMinutes = Math.floor(( elapsedSeconds - (minutes * 60) - seconds ) / 60)
        elapsedSeconds = ( elapsedSeconds - (minutes * 60) - seconds ) % 60
    }

    debug.log(socketDecodeConsoleLog, "time to manage: ", minutes, ":", seconds)
    cumulatedBoard.cumulatedTime.cumulatedLabel.text = (minutes > 9 ? minutes : "0" + minutes) + ":" + (seconds > 9 ? seconds : "0" + seconds)
    cumulatedBoard.cumulatedTime.progressTool.value = (minutes * 60) + seconds

    if(appConsole.state !== Constants.CONSOLE_ST_OVERPRESSURE){
        totalsBoard.totalsTime.cumulatedLabel.text = (elapsedMinutes > 9 ? elapsedMinutes : "0" + elapsedMinutes) + ":" + (elapsedSeconds > 9 ? elapsedSeconds : "0" + elapsedSeconds)
    }

    if( ( (tabBar.selectedOption === option6_1Id) || (tabBar.selectedOption === option6_2Id) || (tabBar.selectedOption === option6_3Id) ) ){

        if (appConsole.state === Constants.CONSOLE_ST_GENERATING_CUM_VIEW){
            switch(tabBar.selectedOption){
            case option6_1Id:
                totalsBoard.totalsTotalConcentration.cumulatedLabel.text = salineDose(elapsedDecimalMinutes)
                break;
            case option6_2Id:
                totalsBoard.totalsTotalConcentration.cumulatedLabel.text = distilledWaterDose(elapsedDecimalMinutes)
                break;
            case option6_3Id:
                totalsBoard.totalsTotalConcentration.cumulatedLabel.text = oilDose(elapsedDecimalMinutes)
                break;
            }

//            if(parseFloat(totalsBoard.totalsTotalConcentration.cumulatedLabel.text) > 10){  // keep decimal notation only bellow 10 units
//                totalsBoard.totalsTotalConcentration.cumulatedLabel.text = Math.round(parseFloat(totalsBoard.totalsTotalConcentration.cumulatedLabel.text))
//            }
//            else{
//                totalsBoard.totalsTotalConcentration.cumulatedLabel.text = formatFractional(parseFloat(totalsBoard.totalsTotalConcentration.cumulatedLabel.text))
//            }

            totalsBoard.totalsTotalConcentration.cumulatedLabel.text = Math.round(parseFloat(totalsBoard.totalsTotalConcentration.cumulatedLabel.text)) // #4338


            if(tabBar.selectedOption === option6_3Id){
                totalsBoard.totalsIpIndex.cumulatedLabel.text = totalsBoard.totalsTotalConcentration.cumulatedLabel.text
            }

        }
        else if (appConsole.state === Constants.CONSOLE_ST_SETTING){
            totalsBoard.totalsTotalConcentration.cumulatedLabel.text = "0"
            totalsBoard.totalsIpIndex.cumulatedLabel.text = "0"
        }
    }
}

function manageTherapyTimeState(seconds){
    var elapsedMinutes
    var elapsedSeconds

    elapsedMinutes = Math.floor(seconds / 60)
    elapsedSeconds = seconds % 60
    debug.log(socketDecodeConsoleLog, "therapy time to manage: ", seconds)

    if (tabBar.selectedOption === option3_1Id){
        cumulatedBoard.cumulatedTime.cumulatedLabel.text = (elapsedMinutes > 9 ? elapsedMinutes : "0" + elapsedMinutes) + ":" + (elapsedSeconds > 9 ? elapsedSeconds : "0" + elapsedSeconds)
        cumulatedBoard.cumulatedTime.progressTool.value = seconds
    }

    if (tabBar.selectedOption === option5_1Id){
        cumulatedBoard.cumulatedTime.cumulatedLabel.text = (elapsedMinutes > 9 ? elapsedMinutes : "0" + elapsedMinutes) + ":" + (elapsedSeconds > 9 ? elapsedSeconds : "0" + elapsedSeconds)
        cumulatedBoard.cumulatedTime.progressTool.value = seconds

        if( (tabBar.selectedOption === option5_1Id) &&
            (appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME) &&
            (magnitudeSelector.theraphyPressure === "H") &&
            (seconds === 1) ) {
            cumulatedBoard.pressureIndicator.state = "simulateDepressure"
        }
    }
}

function manageMeanFlowState(meanFlow){
    debug.log(socketDecodeConsoleLog, "flow to manage: ", meanFlow)
}

function manageMeanO3State(meanO3){
    debug.log(socketDecodeConsoleLog, "O3 to manage: ", meanO3)
}

function formatFractional(number){
    if (number !== parseInt(number)){
        return number.toFixed(2)
    }
    else{
        return number
    }
}

function manageTotalDoseState(totalDose){
    debug.log(socketDecodeConsoleLog, "total dose to manage: ", totalDose)

    if( (tabBar.selectedOption === option5_1Id) && (magnitudeSelector.theraphyPressure === "N") ) { // #4833
        var hiperbaricFactor = Storage.getAppDB(Constants.dbConstants.autohemoHiperbaricFactorId, "1")
        totalDose = Math.round(totalDose / hiperbaricFactor)
    }

    cumulatedBoard.cumulatedO3.cumulatedLabel.text = formatFractional(totalDose * cumulatedBoard.cumulatedO3.conversionFactor)
    cumulatedBoard.cumulatedO3.progressTool.value = formatFractional(totalDose * cumulatedBoard.cumulatedO3.conversionFactor)
    totalsBoard.totalsO3.cumulatedLabel.text = formatFractional(totalDose * cumulatedBoard.cumulatedO3.conversionFactor)

    if(tabBar.selectedOption === option1_1Id){
        if (appConsole.state === CONSOLE_ST_CANCELED){
            totalsBoard.totalsO3.cumulatedLabel.text = "--"
        }
    }

    if(tabBar.selectedOption === option2Id){
//      if(totalsBoard.state != "noViewTotalBoard"){
//          totalsBoard.totalsO3.cumulatedLabel.text = salineHemoDose()
//      }
        if(totalsBoard.state === "viewTotalBoardOKIcon"){
            totalsBoard.totalsO3.cumulatedLabel.text = salineHemoDose()
        }
        else{
            totalsBoard.totalsO3.cumulatedLabel.text = "--"
        }
    }

    //#4833 (code commented)
//    if(tabBar.selectedOption === option5_1Id){
//        if (appConsole.state === CONSOLE_ST_CANCELED){
//            totalsBoard.totalsO3.cumulatedLabel.text = "--"
//        }
//        else{
//            totalsBoard.totalsO3.cumulatedLabel.text = magnitudeSelector.inputTotalConcentration.magnitudeLabel.text
//        }
//    }
    //#4833
}

function manageOutputVolumeState(outputVol){
    debug.log(socketDecodeConsoleLog, "output volume to manage: ", outputVol)
    cumulatedBoard.cumulatedVolume.cumulatedLabel.text = formatFractional(outputVol * cumulatedBoard.cumulatedVolume.conversionFactor)
    cumulatedBoard.cumulatedVolume.progressTool.value = formatFractional(outputVol * cumulatedBoard.cumulatedVolume.conversionFactor)
    totalsBoard.totalsVolume.cumulatedLabel.text = formatFractional(outputVol * cumulatedBoard.cumulatedVolume.conversionFactor)
}

function computeVaccum(pressure, atmosphericPressure){
    var vacuum = 0

    if((atmosphericPressure - pressure) > 5){
        vacuum = atmosphericPressure - pressure
    }
    return vacuum
}

function managePressureState(pressure, atmosphericPressure){
    var totalsPressureCumulatedLabelText = formatFractional((pressure - atmosphericPressure) * cumulatedBoard.cumulatedPressure.conversionFactor)

    debug.log(socketDecodeConsoleLog, "pressure to manage: ", pressure)
    debug.log(socketDecodeConsoleLog, "atmospheric pressure to manage: ", atmosphericPressure)

//  update cumulated board resources
    cumulatedBoard.cumulatedPressure.progressTool.value = formatFractional(computeVaccum(pressure, atmosphericPressure) * cumulatedBoard.cumulatedPressure.conversionFactor)
    cumulatedBoard.pressureIndicator.cumulatedLabel.text = formatFractional(pressure * cumulatedBoard.pressureIndicator.conversionFactor)
    cumulatedBoard.pushBloodPressureIndicator.progressTool.value = formatFractional(pressure * cumulatedBoard.pressureIndicator.conversionFactor)

    if(formatFractional(computeVaccum(pressure, atmosphericPressure) * cumulatedBoard.cumulatedPressure.conversionFactor)){
        cumulatedBoard.cumulatedPressure.cumulatedLabel.text = "-" + formatFractional(computeVaccum(pressure, atmosphericPressure) * cumulatedBoard.cumulatedPressure.conversionFactor)
    }
    else{
        cumulatedBoard.cumulatedPressure.cumulatedLabel.text = "0"
    }

//    if(!( (tabBar.selectedOption === option5_1Id) && (appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME) && (cumulatedBoard.pressureIndicator.state === "simulateDepressure") )){
//        cumulatedBoard.pressureIndicator.progressTool.value = formatFractional(pressure * cumulatedBoard.pressureIndicator.conversionFactor)
//    }
    if(!( (tabBar.selectedOption === option5_1Id) && (appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME) && (magnitudeSelector.theraphyPressure === "H") )){
        if(!( (tabBar.selectedOption === option5_1Id) && (appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME) && (cumulatedBoard.pressureIndicator.state === "simulateDepressure") )){
            cumulatedBoard.pressureIndicator.progressTool.value = formatFractional(pressure * cumulatedBoard.pressureIndicator.conversionFactor)
        }
    }

//  update pressure tester
    pressureTester.pressureMetter.progressTool.value = formatFractional(pressure * cumulatedBoard.pressureIndicator.conversionFactor)

//  update current pressure in normalization gadget
    if(computeVaccum(pressure, atmosphericPressure) === 0){ // trac #3684
        normalizationImage.pressure = formatFractional(pressure * cumulatedBoard.pressureIndicator.conversionFactor)
    }
    else{
        normalizationImage.pressure = "-" + formatFractional(computeVaccum(pressure, atmosphericPressure) * cumulatedBoard.cumulatedPressure.conversionFactor)
    }

    saveScreen.saveScreenNormalizationImage.pressure = normalizationImage.pressure

//  update current pressure in totalsBoard
    if( (appConsole.state !== Constants.CONSOLE_ST_CANCELED) && (appConsole.state !== Constants.CONSOLE_ST_COMPLETED) ){ // trac #3683
        totalsBoard.totalsPressure.cumulatedLabel.text = totalsPressureCumulatedLabelText
    }
    else if( (appConsole.state === Constants.CONSOLE_ST_COMPLETED) && (totalsPressureCumulatedLabelText < totalsBoard.totalsPressure.cumulatedLabel.text) ){ // trac #3685
        totalsBoard.totalsPressure.cumulatedLabel.text = totalsPressureCumulatedLabelText
    }

//  keep atmospheric pressure updated
    applicationWindow.atmosphericPressure = atmosphericPressure

    if(applicationWindow.atmPressForAutohemo === -65535){ // #4833
        applicationWindow.atmPressForAutohemo = atmosphericPressure
    }
}

function manageTemperatureState(temperature){
    debug.log(socketDecodeConsoleLog, "temperature to manage: ", temperature)
    normalizationImage.temperature = formatFractional(temperature / 128)
    saveScreen.saveScreenNormalizationImage.temperature = formatFractional(temperature / 128)
}

function manageVacuumTimeState(time){
    debug.log(socketDecodeConsoleLog, "vacuum time to manage: ", time)
    cumulatedBoard.cumulatedTimeSeconds.cumulatedLabel.text = time
    cumulatedBoard.cumulatedTimeSeconds.progressTool.value = time
    totalsBoard.totalsTimeSeconds.cumulatedLabel.text = magnitudeSelector.inputVacuumTime.slider.value - time

    if((tabBar.selectedOption === option5_1Id) && (appConsole.state === CONSOLE_ST_VACCUM) && (!time)){
        if(cumulatedBoard.addingBloodImage.state === "noViewAddingBlood"){
            Configurator.hideCumulatedBoard()
            cumulatedBoard.addingBloodImage.state = "viewAddingBlood"
            cumulatedBoard.cyclesCounter.visible = true
            appToolBar.state = "playStop"
        }
    }
    if((tabBar.selectedOption === option2Id) && (appConsole.state === CONSOLE_ST_VACCUM) && (!time)){
        if(cumulatedBoard.addingSalineImage.state === "noViewAddingSaline"){
            Configurator.hideCumulatedBoard()
            cumulatedBoard.addingSalineImage.state = "viewAddingSaline"
            cumulatedBoard.cyclesCounter.visible = true
            appToolBar.state = "playStop"
        }
    }
}

function manageAutoHemoCycles(cycles){
    debug.log(socketDecodeConsoleLog, "autohemo cycles to manage: ", cycles)

    if(cycles){
        if(tabBar.selectedOption === option2Id){
            cumulatedBoard.cyclesLabel.text = (2 - cycles + 1) + "/" + 2
        }
        else{
            cumulatedBoard.cyclesLabel.text = (magnitudeSelector.theraphyCycles - cycles + 1) + "/" + magnitudeSelector.theraphyCycles

            if( (appConsole.state === Constants.CONSOLE_ST_SETTING) && (tabBar.selectedOption === option5_1Id) ) { // #4833
                cumulatedBoard.cumulatedO3.progressTool.maximumValue = magnitudeSelector.multipleTotalConcentrationValues[ magnitudeSelector.theraphyCycles - cycles ];
            }
        }
        magnitudeSelector.updateInputMultipleTotalConcentrationAppearance((magnitudeSelector.theraphyCycles - cycles + 1))

        if(appConsole.state === Constants.CONSOLE_ST_EDITING){
            magnitudeSelector.inputO3.multilabelMainLabel = 1
        }
        else if(appConsole.state !== Constants.CONSOLE_ST_ERROR){
            magnitudeSelector.inputO3.multilabelMainLabel = (magnitudeSelector.theraphyCycles - cycles + 1)

            if(magnitudeSelector.inputO3.differentValuesOnCycles.activated === true){
                switch((magnitudeSelector.theraphyCycles - cycles + 1)){
                case 1: magnitudeSelector.inputO3.slider.value = magnitudeSelector.inputO3.fixButtonLabel_1.text; break;
                case 2: magnitudeSelector.inputO3.slider.value = magnitudeSelector.inputO3.fixButtonLabel_2.text; break;
                case 3: magnitudeSelector.inputO3.slider.value = magnitudeSelector.inputO3.fixButtonLabel_3.text; break;
                case 4: magnitudeSelector.inputO3.slider.value = magnitudeSelector.inputO3.fixButtonLabel_4.text; break;
                case 5: magnitudeSelector.inputO3.slider.value = magnitudeSelector.inputO3.fixButtonLabel_5.text; break;
                }
            }
        }
    }
}

function manageConfiguredFlushingTime(time){
    debug.log(socketDecodeConsoleLog, "configured flushing time to manage: ", time)
    waitingBoard.configuredWaitingTime = time
    waitingBoard.waitingProgressTool.maximumValue = time
}

function manageRemainingFlushingTime(time){
    debug.log(socketDecodeConsoleLog, "remaining flushing time to manage: ", time)
    waitingBoard.remainingWaitingTime = time
    waitingBoard.waitingProgressTool.value = time
}

function manageOverpressureDuringTherapy(state){
    debug.log(socketDecodeConsoleLog, "overpressure during therapy: ", state)

    if((tabBar.selectedOption === option5_1Id) && (appConsole.state === CONSOLE_ST_VACCUM) && (state)){
        if(cumulatedBoard.addingBloodImage.state === "noViewAddingBlood"){
            Configurator.hideCumulatedBoard()
            cumulatedBoard.addingBloodImage.state = "viewAddingBlood"
            cumulatedBoard.cyclesCounter.visible = true
            appToolBar.state = "playStop"
        }
    }
    if((tabBar.selectedOption === option2Id) && (appConsole.state === CONSOLE_ST_VACCUM) && (state)){
        if(cumulatedBoard.addingSalineImage.state === "noViewAddingSaline"){
            Configurator.hideCumulatedBoard()
            cumulatedBoard.addingSalineImage.state = "viewAddingSaline"
            cumulatedBoard.cyclesCounter.visible = true
            appToolBar.state = "playStop"
        }
    }
    else if((tabBar.selectedOption === option4_1Id) || (tabBar.selectedOption === option4_2Id)){
        cumulatedBoard.pressureIndicator.overpressureAlertState = state
        if(state){
            emergencyPauseButton.frameImage.state = "playView"
        }
    }
    else{
        cumulatedBoard.pressureIndicator.overpressureAlertState = state
    }
}

function manageInsufflationState(state){
//  GUI play/pause button update mixed with socket therapy state update to solve ticket #4085

    if((tabBar.selectedOption === option4_1Id) || (tabBar.selectedOption === option4_2Id)){
        if( (appConsole.state === Constants.CONSOLE_ST_GENERATING_CUM_VIEW) || (appConsole.state === Constants.CONSOLE_ST_GENERATING_CONT_VIEW) ){

            if(!emergencyPauseButton.frameImage.delayRefresh){ // avoid rebounds while state is changing (to solve ticket #4085)
                emergencyPauseButton.frameImage.state = state ? "pauseView" : "playView"
            }else{
                emergencyPauseButton.frameImage.delayRefresh = false
            }
        }
    }
}

function manageSoftwareVersions(versionInfo){
    debug.log(socketDecodeConsoleLog, "software version to manage: ", versionInfo)
    applicationWindow.controlBoardSW = versionInfo.substring(15, 23)
    applicationWindow.interfaceSW = versionInfo.substring(2, 10)
}

function toSigned(value){
    return (value > 32767) ? (value - 65536) : value
}

function manageCalibrationParameters(parametersInfo){
    debug.log(socketDecodeConsoleLog, "parameters to manage: ", parametersInfo)
    Constants.calibrationPressure = toSigned(parseInt(parametersInfo.substring(0, 4), 16))
    Constants.o3Sensorgain = toSigned(parseInt(parametersInfo.substring(5, 9), 16))
    Constants.periodIni = toSigned(parseInt(parametersInfo.substring(10, 14), 16))
    Constants.pressureCompensation = toSigned(parseInt(parametersInfo.substring(15, 19), 16))
    Constants.flowGainSector1 = toSigned(parseInt(parametersInfo.substring(20, 24), 16))
    Constants.flowGainSector2 = toSigned(parseInt(parametersInfo.substring(25, 39), 16))
    Constants.flowGainSector3 = toSigned(parseInt(parametersInfo.substring(30, 34), 16))
    Constants.oneMicrogramePulses = toSigned(parseInt(parametersInfo.substring(35, 39), 16))
    Constants.o3PulsesSector1 = toSigned(parseInt(parametersInfo.substring(40, 44), 16))
    Constants.o3PulsesSector2 = toSigned(parseInt(parametersInfo.substring(45, 49), 16))
    Constants.o3PulsesSector3 = toSigned(parseInt(parametersInfo.substring(50, 54), 16))
}

function manageMaxAvailableFlow(flow){
    magnitudeSelector.maxAvailableFlow = flow
    debug.log(socketDecodeConsoleLog, "available flow to manage: ", flow)
}

//function manageTextInfo(text){
//    var index = 0

//    debug.log(socketDecodeConsoleLog, "text to manage: ", text)

//    if ((index = text.indexOf(TS_START_UP_MSG)) >= 0){
//        startUp.startUpHiddenText.append(text.substring(index + TS_START_UP_MSG.length, text.length - 1))
//        if(text.substring(index + TS_START_UP_MSG.length, index + TS_START_UP_MSG.length + 1) === "#"){
//            startUp.scrollStartUpText.append(text.substring(index + TS_START_UP_MSG.length + 1, text.length - 1))
//            console.log("startUp.scrollStartUpText", startUp.scrollStartUpText.text)
//        }
//        if(text.substring(index + TS_START_UP_MSG.length, index + TS_START_UP_MSG.length + 1) === "@"){
//            startUp.scrollStartUpText.append(text.substring(index + TS_START_UP_MSG.length + 1, text.length - 1))
//            startUp.launchLogoAnimation()
//        }
//    }
//}

//function manageTextInfo(text){
//    var index = 0

//    debug.log(socketDecodeConsoleLog, "text to manage: ", text)
//    startUp.viewStartUpButton.enabled = true

//    text = text.replace("{@","")      // #4332
//    text = text.replace("TEXT,","")   // #4332
//    text = text.replace("\r\r","\r")  // #4332

//    if ((index = text.indexOf(TS_START_UP_MSG)) >= 0){

//        startUp.startUpHiddenText.append(text.substring(index + TS_START_UP_MSG.length, text.length - 1))
//        if(text.substring(index + TS_START_UP_MSG.length, index + TS_START_UP_MSG.length + 1) === "#"){
//            startUp.scrollStartUpText.append(text.substring(index + TS_START_UP_MSG.length + 1, text.length - 1))
//            console.log("startUp.scrollStartUpText", startUp.scrollStartUpText.text)
//        }
//        if(text.substring(index + TS_START_UP_MSG.length, index + TS_START_UP_MSG.length + 1) === "@"){
//            startUp.scrollStartUpText.append(text.substring(index + TS_START_UP_MSG.length + 1, text.length - 1))
//            startUp.launchLogoAnimation()
//        }
//    }
//}

function manageTextInfo(text){
    var index = 0

    debug.log(socketDecodeConsoleLog, "text to manage: ", text)
    startUp.viewStartUpButton.enabled = true

    text = text.replace("{@","")      // #4332
    text = text.replace("TEXT,","")   // #4332
    text = text.replace("\r\r","\r")  // #4332

    if ((index = text.indexOf(TS_START_UP_MSG)) >= 0){

        startUp.startUpHiddenText.append(text.substring(index + TS_START_UP_MSG.length, text.length - 1))
        if(text.substring(index + TS_START_UP_MSG.length, index + TS_START_UP_MSG.length + 1) === "#"){
            startUp.scrollStartUpText.append( text.substring(index + TS_START_UP_MSG.length + 1, text.length - 1).replace(TS_START_UP_MSG + "#", "").replace("{@","") ) // #4332 (replace(TS_START_UP_MSG + "#", "").replace("{@","") added )
            console.log("startUp.scrollStartUpText", startUp.scrollStartUpText.text)
        }
        if(text.substring(index + TS_START_UP_MSG.length, index + TS_START_UP_MSG.length + 1) === "@"){
            startUp.scrollStartUpText.append( text.substring(index + TS_START_UP_MSG.length + 1, text.length - 1).replace(TS_START_UP_MSG + "@", "").replace("{@","") ) // #4332 (replace(TS_START_UP_MSG + "#", "").replace("{@","")  added )
            startUp.launchLogoAnimation()
        }
    }
}



function setMaxAllowedFlow(){
    var maxAllowedFlow = 50 // l/h
    var maxAvailableFlow = magnitudeSelector.maxAvailableFlow // l/h

    if(applicationWindow.skipStartUp){
        maxAvailableFlow = 50 // l/h /* patch for stand alone test (without interface software)
    }

    /* Set max allowed flow according to next rule
     *
     *   (F - l/h)
     *    |      .
     * 50 +* * * *
     *    |      .  *
     *    |      .     *
     *    |      .        *
     *    |      .           *
     *    |      .              *
     * 30 +........................*..
     *    |      .                 .
     *    |______._________________.____ (C - ug/Nml)
     *          60                80
     */

    if(maxAvailableFlow > (magnitudeSelector.inputFlow.sliderMaxNotDependentValue / magnitudeSelector.inputFlow.conversionFactor)) // l/h
    {
        maxAvailableFlow = magnitudeSelector.inputFlow.sliderMaxNotDependentValue  / magnitudeSelector.inputFlow.conversionFactor  // l/h
    }

    if ( (110 - Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor)) < maxAllowedFlow  )
    {
      maxAllowedFlow = 110 - Math.round(magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor);  // l/h
      /* If we are in Syringe mode, flow is not configurable but defaulted to 30l/h*/
      /* Time is neither configured because syringe filling completion is detected by pressure value */
    }

    if(maxAvailableFlow < maxAllowedFlow )  // l/h
    {
      maxAllowedFlow = maxAvailableFlow     // l/h
    }

    maxAllowedFlow = maxAllowedFlow * magnitudeSelector.inputFlow.conversionFactor  // current units
    return maxAllowedFlow
}

function airVolumeForAutohemo(hFactor){
    var va      // air volume
    var pf      // final pressure
    var vacPress = Math.round(magnitudeSelector.inputPressure.slider.value  / magnitudeSelector.inputPressure.conversionFactor)
    var hiperbaricFactor = arguments.length ? hFactor : Storage.getAppDB(Constants.dbConstants.autohemoHiperbaricFactorId, "1")

    pf = applicationWindow.atmPressForAutohemo * hiperbaricFactor

    va = ( (applicationWindow.atmPressForAutohemo - vacPress) * (magnitudeSelector.inputBottleVolume.magnitudeValue / magnitudeSelector.inputBottleVolume.conversionFactor)) / pf

    return va
}

function globalAutoHemoDose(){ // #4833
    var dose
    var va      // air volume
    var vd      // volumen disponible
    var hiperbaricFactor = Storage.getAppDB(Constants.dbConstants.autohemoHiperbaricFactorId, "1")

    va = airVolumeForAutohemo(hiperbaricFactor, "1")

    vd = (magnitudeSelector.inputBottleVolume.magnitudeValue / magnitudeSelector.inputBottleVolume.conversionFactor) - (magnitudeSelector.inputBloodVolume.magnitudeValue / magnitudeSelector.inputBloodVolume.conversionFactor) - va

    dose = vd * (magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) * magnitudeSelector.theraphyCycles
    dose = dose * magnitudeSelector.inputTotalConcentration.conversionFactor

    if(dose < 0){
        dose = 0
    }

    if(magnitudeSelector.theraphyPressure === "H"){
        dose = dose * hiperbaricFactor
    }

    for (var i = 1; i <= magnitudeSelector.theraphyCycles; i++){
        magnitudeSelector.multipleTotalConcentrationValues[i-1]= Math.round(dose / magnitudeSelector.theraphyCycles)
    }
    magnitudeSelector.updateInputMultipleTotalConcentrationModel()

    return Math.round(dose)
}

function singleValueAautoHemoDose(concentration){ // #4833
    var dose
    var va     // air volume
    var vd     // volumen disponible
    var hiperbaricFactor = Storage.getAppDB(Constants.dbConstants.autohemoHiperbaricFactorId, "1")

    va = airVolumeForAutohemo(hiperbaricFactor, "1")

    vd = (magnitudeSelector.inputBottleVolume.magnitudeValue / magnitudeSelector.inputBottleVolume.conversionFactor) - (magnitudeSelector.inputBloodVolume.magnitudeValue / magnitudeSelector.inputBloodVolume.conversionFactor) - va

    dose = vd * concentration
    dose = dose * magnitudeSelector.inputTotalConcentration.conversionFactor

    if(dose < 0){
        dose = 0
    }

    if(magnitudeSelector.theraphyPressure === "H"){
        dose = dose * hiperbaricFactor
    }

    return Math.round(dose)
}

function iterativeAutoHemoDose(){
    var i
    var totalDose = 0
    var value

    for (i=1; i <= magnitudeSelector.theraphyCycles; i++){
        switch (i){
        case 1: value = singleValueAautoHemoDose(magnitudeSelector.inputO3.fixButtonLabel_1.text / magnitudeSelector.inputO3.conversionFactor);
                break
        case 2: value = singleValueAautoHemoDose(magnitudeSelector.inputO3.fixButtonLabel_2.text / magnitudeSelector.inputO3.conversionFactor);
                break
        case 3: value = singleValueAautoHemoDose(magnitudeSelector.inputO3.fixButtonLabel_3.text / magnitudeSelector.inputO3.conversionFactor);
                break
        case 4: value = singleValueAautoHemoDose(magnitudeSelector.inputO3.fixButtonLabel_4.text / magnitudeSelector.inputO3.conversionFactor);
                break
        case 5: value = singleValueAautoHemoDose(magnitudeSelector.inputO3.fixButtonLabel_5.text / magnitudeSelector.inputO3.conversionFactor);
                break
        }
        magnitudeSelector.multipleTotalConcentrationValues[i-1] = value
        totalDose = totalDose + value
    }
    magnitudeSelector.updateInputMultipleTotalConcentrationModel()

    return totalDose
}

function salineHemoDose(){
    var saturationResult

    saturationResult = Storage.getAppDB(Constants.dbConstants.salineFactor1Id, "") * (magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) * (magnitudeSelector.inputSalineVolume.slider.value / magnitudeSelector.inputSalineVolume.conversionFactor)
    saturationResult = saturationResult * magnitudeSelector.inputLiquidVolume.conversionFactor

    return formatFractional(saturationResult)
}

//function salineBublingTime(){
//    var flow = (magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) / 60
//    var volume = (magnitudeSelector.inputSalineVolume.slider.value / magnitudeSelector.inputSalineVolume.conversionFactor) / 1000
//    var time = (5 * volume / flow)

//    return time
//}

function salineBublingTime(){
    var flow = (magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) / 60
    var volume = (magnitudeSelector.inputSalineVolume.slider.value / magnitudeSelector.inputSalineVolume.conversionFactor) / 1000
    var time = Storage.getAppDB(Constants.dbConstants.salineSaturationTimeFactorId, "") * (volume / flow)

    return time
}
function salineBublingTimeAlternative(storage){
    var flow = (magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) / 60
    var volume = (magnitudeSelector.inputSalineVolume.slider.value / magnitudeSelector.inputSalineVolume.conversionFactor) / 1000
    var time = storage * (volume / flow)

    return time
}

function salineBublingTimeSeconds(){
    return Math.round(salineBublingTime() * 60)
}

function formatedSalineBublingTime(){
//  var time = salineBublingTime()
    var time = salineBublingTimeAlternative(Storage.getAppDB(Constants.dbConstants.salineSaturationTimeFactorId, "")) // Avoid error in inputSalineTime.magnitudeLabel.text binding
    var min = parseInt(time)
    var sec = parseInt((time - min) * 60)
    var ret = parseInt(time)

    if(sec){
        ret = ret + ":"
        if(sec < 10){
            ret = ret + "0"
        }
        ret = ret + sec
    }

    return ret
}

function autoHemoDose(){

    if(magnitudeSelector.inputO3.differentValuesOnCycles.activated){
        return iterativeAutoHemoDose()
    }
    else{
        return globalAutoHemoDose()
    }
}

function salineDose(time){ //minutes
    var saturationTime  // ts = 5 * water volume / gas flow
    var saturationResult
    var convertedFlow = (magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) * (1000 / 60)

//  units -> time (min)
//           volume (ml)
//           flow (ml/min)
//           concentration (ug/ml)

//    O3a = 0,24 * Cg0 * Va         -> t >= ts.
//    O3a = 0,048 * Cg0 * Fg * t    -> t < ts.

    saturationTime = Storage.getAppDB(Constants.dbConstants.salineSaturationTimeFactorId, "") * ( (magnitudeSelector.inputLiquidVolume.magnitudeValue / magnitudeSelector.inputLiquidVolume.conversionFactor) / convertedFlow )

    if(saturationTime > (time / magnitudeSelector.inputTime.conversionFactor)){
      saturationResult = Storage.getAppDB(Constants.dbConstants.salineFactor2Id, "") * (magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) * convertedFlow * (time / magnitudeSelector.inputTime.conversionFactor)
    }
    else{
        saturationResult = Storage.getAppDB(Constants.dbConstants.salineFactor1Id, "") * (magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) * (magnitudeSelector.inputLiquidVolume.slider.value / magnitudeSelector.inputLiquidVolume.conversionFactor)
    }

    saturationResult = saturationResult * magnitudeSelector.inputLiquidVolume.conversionFactor

    return saturationResult
}

function distilledWaterDose(time){
    var saturationTime  // ts = 5 * water volume / gas flow
    var saturationResult
    var convertedFlow = (magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) * (1000 / 60)

//  units -> time (min)
//           volume (ml)
//           flow (ml/min)
//           concentration (ug/ml)

//    O3a = 0,27 * Cg0 * Va         -> t >= ts.
//    O3a = 0,054 * Cg0 * Fg * t    -> t < ts.

    saturationTime = Storage.getAppDB(Constants.dbConstants.waterSaturationTimeFactorId, "") * ( (magnitudeSelector.inputLiquidVolume.magnitudeValue / magnitudeSelector.inputLiquidVolume.conversionFactor) / convertedFlow )

    if(saturationTime > (time / magnitudeSelector.inputTime.conversionFactor)){
        saturationResult = Storage.getAppDB(Constants.dbConstants.waterFactor2Id, "") * (magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) * convertedFlow * (time / magnitudeSelector.inputTime.conversionFactor)
    }
    else{
        saturationResult = Storage.getAppDB(Constants.dbConstants.waterFactor1Id, "") * (magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) * (magnitudeSelector.inputLiquidVolume.slider.value / magnitudeSelector.inputLiquidVolume.conversionFactor)
    }

    saturationResult = saturationResult * magnitudeSelector.inputLiquidVolume.conversionFactor

    return saturationResult
}

function oilDose(time){
    var saturationResult
//  IP = 11 * Cg0 * Fg * t / Va / 60

    saturationResult = (Storage.getAppDB(Constants.dbConstants.oilFactorId, "") * (magnitudeSelector.inputO3.slider.value / magnitudeSelector.inputO3.conversionFactor) * (magnitudeSelector.inputFlow.slider.value / magnitudeSelector.inputFlow.conversionFactor) * (time / magnitudeSelector.inputTime.conversionFactor)) / (magnitudeSelector.inputLiquidVolume.slider.value / magnitudeSelector.inputLiquidVolume.conversionFactor) / 60

    return saturationResult
}

function resolveDependentMagnitude(){

    switch (tabBar.selectedOption){
        case option2Id:   return salineBublingTime()
        case option5_1Id: return autoHemoDose()
        case option6_1Id: return Math.round(salineDose(magnitudeSelector.inputTime.magnitudeValue))
        case option6_2Id: return Math.round(distilledWaterDose(magnitudeSelector.inputTime.magnitudeValue))
        case option6_3Id: return Math.round(oilDose(magnitudeSelector.inputTime.magnitudeValue))
        default: return 0
    }
}

function actionsWhenMagnitudeSelectorSliderChanges(){
    //DEB->debug.log(saveScreenEventsConsoleLog, "Save screen timer restarted by slider...")
    saveScreenTimer.restart()
}

function setTotalLabelsWhenError(){
    if (appConsole.state === Constants.CONSOLE_ST_ERROR){
        totalsBoard.totalsO3.cumulatedLabel.text = "--"
        totalsBoard.totalsVolume.cumulatedLabel.text = "--"
        totalsBoard.totalsTime.cumulatedLabel.text = "--"
        totalsBoard.totalsPressure.cumulatedLabel.text = "--"
        totalsBoard.totalsTimeSeconds.cumulatedLabel.text = "--"
        totalsBoard.totalsIpIndex.cumulatedLabel.text =  "--"
        totalsBoard.totalsTotalConcentration.cumulatedLabel.text =  "--"
        //DEB->debug.log(DC.therapiesLog, "Cleaning total board texts on error...")
    }
}



