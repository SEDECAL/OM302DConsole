// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

Qt.include("Constants.js")
Qt.include("Storaje.js")
Qt.include("DebugConstants.js")

function initTherapy(){

    if(magnitudeSelector.inputBottleVolume.visible)        magnitudeSelector.inputBottleVolume.init()
    if(magnitudeSelector.inputBloodVolume.visible)         magnitudeSelector.inputBloodVolume.init()
    if(magnitudeSelector.inputLiquidVolume.visible)        magnitudeSelector.inputLiquidVolume.init()
    if(magnitudeSelector.inputSalineVolume.visible)        magnitudeSelector.inputSalineVolume.init()
    if(magnitudeSelector.inputO3.visible)                  magnitudeSelector.inputO3.init()
//  if(magnitudeSelector.inputFlow.visible)                magnitudeSelector.inputFlow.init()
    if(magnitudeSelector.inputTime.visible)                magnitudeSelector.inputTime.init()
    if(magnitudeSelector.inputTotalConcentration.visible)  magnitudeSelector.inputTotalConcentration.init()
    if(magnitudeSelector.inputTherapyTime.visible)         magnitudeSelector.inputTherapyTime.init()
    if(magnitudeSelector.inputVacuumTime.visible)          magnitudeSelector.inputVacuumTime.init()
    if(magnitudeSelector.inputTimeVolume.visible)          magnitudeSelector.inputTimeVolume.init()
    if(magnitudeSelector.inputVolumeDose.visible)          magnitudeSelector.inputVolumeDose.init()
    if(magnitudeSelector.inputTimeDose.visible)            magnitudeSelector.inputTimeDose.init()
    if(magnitudeSelector.inputVolume.visible)              magnitudeSelector.inputVolume.init()
    if(magnitudeSelector.inputCleanTime.visible)           magnitudeSelector.inputCleanTime.init()
    if(magnitudeSelector.inputIp.visible)                  magnitudeSelector.inputIp.init()
    if(magnitudeSelector.inputNormoOrHiper.visible)        magnitudeSelector.inputNormoOrHiper.init()
    if(magnitudeSelector.inputPreviousVaccumYesNo.visible) magnitudeSelector.inputPreviousVaccumYesNo.init()
    if(magnitudeSelector.inputCycles.visible)              magnitudeSelector.inputCycles.init()
    if(magnitudeSelector.inputReinfusionTime.visible)      magnitudeSelector.inputReinfusionTime.init()

     magnitudeSelector.inputFlow.init()      // allways done since this parameter is sent even when is fixed for a therapy

    if(magnitudeSelector.previousVacuum) {
        magnitudeSelector.inputVacuumTime.init() // in therapies with previous vacuum yes no selector, vacuum time is fixed with database values for magnitudeSelector.inputVacuumTime
        magnitudeSelector.inputPressure.init()   // in therapies with previous vacuum yes no selector, vacuum pressure fixed with database values for magnitudeSelector.inputPressure
    }

    magnitudeSelector.updateFullViewOffsetCorrection()
    appConsole.state = CONSOLE_ST_EDITING
}

function toolBarStateWhileEditing(){
    var ret

    ret = "settingsPlayHelp"

    switch(tabBar.selectedOption){
    case "":
    case option1Id:
    case option3Id:
    case option4Id:
    case option5Id:
    case option6Id:
    case option7Id:
        ret = "settingsHelp"
        break;
    }
    return ret
}

function toolBarStateDependingOnTherapyWhileEditing(){
    var ret

    switch(tabBar.selectedOption){
    case option1Id:
    case option3Id:
    case option4Id:
    case option5Id:
    case option6Id:
    case option7Id:
        ret = "settingsHelp"
        break;
    default:
        ret = "settingsPlayHelp"
    }
    return ret
}

function toolBarStateDependingOnTherapyWhileGenerating(){
    var ret

    switch(tabBar.selectedOption){
    case option1Id:
        ret = "justStop"
        break;
    case option1_1Id:
        ret = "justStop"
        break;
    case option1_2Id:
        ret = "playStop"
        break;
    case option2Id:
        if(appConsole.state === Constants.CONSOLE_ST_GENERATING_CONT_VIEW){
            ret = "playStop"
        }
        else{
            ret = "justStop"
        }
        break;
    case option3Id:
        ret = "justStop"
        break;
    case option3_1Id:
        ret = "playStop"
        break;
    case option3_2Id:
        ret = "playStop"
        break;
    case option5_1Id:
        if(appConsole.state === Constants.CONSOLE_ST_GENERATING_CONT_VIEW){
            ret = "playStop"
        }
        else{
            ret = "justStop"
        }
        break;
    case option5_2Id:
        ret = "justStop"
        break;
    case option4Id:
        ret = "playStop"
        break;
    case option4_1Id:
        ret = "playStop"
        break;
    case option4_2Id:
        ret = "playStop"
        break;
    case option6Id:
        ret = "justStop"
        break;
    case option6_1Id:
        ret = "justStop"
        break;
    case option6_2Id:
        ret = "justStop"
        break;
    case option6_3Id:
        ret = "justStop"
        break;
    case option7Id:
        ret = "pauseStop"
        break;
    case option7_1Id:
        ret = "pauseStop"
        break;
    case option7_2Id:
        ret = "pauseStop"
        break;
    }
    return ret
}

function toolBarStateDependingOnTherapyWhileVaccum(){
    var ret

    switch(tabBar.selectedOption){
    case option2Id:
        ret = "playStop"
        break;
    case option3Id:
        ret = "playStop"
        break;
    case option3_1Id:
        ret = "playStop"
        break;
    case option3_2Id:
        ret = "playStop"
        break;
    case option5_1Id:
        ret = "playStop"
        break;
    case option7Id:
        ret = "pauseStop"
        break;
    case option7_1Id:
        ret = "pauseStop"
        break;
    case option7_2Id:
        ret = "pauseStop"
        break;
    }
    return ret
}

function toolBarStateDependingOnTherapyWhileWaitingTime(){
    var ret

    switch(tabBar.selectedOption){
    case option2Id:
        ret = "playStop"
        break;
    case option3Id:
        ret = "justStop"
        break;
    case option3_1Id:
        ret = "justStop" // "playStop" implemented but comented due to specification change
        break;
    case option3_2Id:
        ret = "justStop"
        break;
//  case option5Id:
    case option5_1Id:
        ret = "playStop"
        break;
    }
    return ret
}

function cumulatedBoardStateDependingOnTherapy(){
    var ret = "viewCumulated"

    if(appConsole.state === Constants.CONSOLE_ST_SETTING){
        ret = "noViewCumulated"
    }
    else if( ((tabBar.selectedOption === option5_1Id) || (tabBar.selectedOption === option2Id)) && (appConsole.state === Constants.CONSOLE_ST_SETTING) ){
        hideCumulatedBoard()
        cumulatedBoard.cyclesCounter.visible = true
//      trick to keep cycles counter at same position during setting state (start)
        cumulatedBoard.cumulatedO3.visible = true
        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.cumulatedO3.opacity = 0
        cumulatedBoard.pressureIndicator.opacity = 0
//      trick to keep cycles counter at same position during setting state (end)
    }
    else if( (tabBar.selectedOption === option5_1Id) && (appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME) ){
//      hideCumulatedBoard()                          // hide to avoid blink effect before depressure effect
        cumulatedBoard.cumulatedO3.visible = false    // added to avoid blink effect before depressure effect
        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.cyclesCounter.visible = true
        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.waveImage.state = "viewWave"
        if(magnitudeSelector.theraphyPressure === "N") {
            cumulatedBoard.pressureIndicator.state = "simulateDepressure"
        }
    }
    else if( (tabBar.selectedOption === option2Id) && (appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME) ){
        hideCumulatedBoard()
        cumulatedBoard.removingBloodImage.state = "viewRemovingSaline"
        cumulatedBoard.cyclesCounter.visible = true
        console.log("show waiting for patient connection 1")
    }
    else if( (tabBar.selectedOption === option5_1Id) && (appConsole.state === Constants.CONSOLE_ST_GENERATING_CUM_VIEW) ){
        hideCumulatedBoard()
        cumulatedBoard.cumulatedO3.visible = true
        cumulatedBoard.cyclesCounter.visible = true
        cumulatedBoard.pressureIndicator.visible = true
//      trick to keep cycles counter at same position during setting state (start)
        cumulatedBoard.cumulatedO3.opacity = 1
        cumulatedBoard.pressureIndicator.opacity = 1
//      trick to keep cycles counter at same position during setting state (end)
    }
    else if( (tabBar.selectedOption === option2Id) && (appConsole.state === Constants.CONSOLE_ST_GENERATING_CUM_VIEW) ){
        hideCumulatedBoard()
        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.cyclesCounter.visible = true
        cumulatedBoard.pressureIndicator.visible = true
//      trick to keep cycles counter at same position during setting state (start)
        cumulatedBoard.cumulatedTime.opacity = 1
        cumulatedBoard.pressureIndicator.opacity = 1
//      trick to keep cycles counter at same position during setting state (end)
    }
    else if( (tabBar.selectedOption === option5_1Id) && (appConsole.state === Constants.CONSOLE_ST_GENERATING_CONT_VIEW) ){
        hideCumulatedBoard()
        cumulatedBoard.removingBloodImage.state = "viewRemovingBlood"
        cumulatedBoard.cyclesCounter.visible = true
    }
    else if( (tabBar.selectedOption === option2Id) && (appConsole.state === Constants.CONSOLE_ST_GENERATING_CONT_VIEW) ){
        hideCumulatedBoard()
        cumulatedBoard.removingSalineImage.state = "viewRemovingSaline"
        cumulatedBoard.cyclesCounter.visible = true
        cumulatedBoard.cumulatedTime.progressTool.maximumValue = 60 * Math.round(magnitudeSelector.inputReinfusionTime.slider.value / magnitudeSelector.inputReinfusionTime.conversionFactor)
        console.log("show waiting for patient connection 2")
    }
    else if( (tabBar.selectedOption === option2Id) && (appConsole.state === Constants.CONSOLE_ST_VACCUM) ){ // #4843
        hideCumulatedBoard()
        cumulatedBoard.cumulatedTimeSeconds.visible = true
        cumulatedBoard.cumulatedPressure.visible = true
        cumulatedBoard.cyclesCounter.visible = true
    }
    else if( (tabBar.selectedOption === option5_1Id) && (appConsole.state === Constants.CONSOLE_ST_VACCUM) ){  // #4843
        hideCumulatedBoard()
        cumulatedBoard.cumulatedPressure.visible = true
        cumulatedBoard.cyclesCounter.visible = true
    }
    else if( (tabBar.selectedOption === option3_1Id) && (appConsole.state === Constants.CONSOLE_ST_GENERATING_CUM_VIEW) ){
        cumulatedBoard.cumulatedO3.visible = true
        cumulatedBoard.cumulatedVolume.visible = true
        cumulatedBoard.cumulatedTime.visible = false
        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.cumulatedTimeSeconds.visible = false
    }
    else if( (tabBar.selectedOption === option3_1Id) && (appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME) ){
        cumulatedBoard.cumulatedO3.visible = false
        cumulatedBoard.cumulatedVolume.visible = false
        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.cumulatedTimeSeconds.visible = false
    }
    else if( (tabBar.selectedOption === option3_1Id) && (appConsole.state === Constants.CONSOLE_ST_VACCUM) ){
        cumulatedBoard.cumulatedO3.visible = false
        cumulatedBoard.cumulatedVolume.visible = false
        cumulatedBoard.cumulatedTime.visible = false
        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.cumulatedTimeSeconds.visible = true
    }
    else if( (tabBar.selectedOption === option3_2Id) && (appConsole.state === Constants.CONSOLE_ST_GENERATING_CUM_VIEW) ){
        cumulatedBoard.cumulatedO3.visible = true
        cumulatedBoard.cumulatedVolume.visible = true
        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.cumulatedTimeSeconds.visible = false
    }
    else if( (tabBar.selectedOption === option3_2Id) && (appConsole.state === Constants.CONSOLE_ST_VACCUM) ){
        cumulatedBoard.cumulatedO3.visible = false
        cumulatedBoard.cumulatedVolume.visible = false
        cumulatedBoard.cumulatedTime.visible = false
        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.cumulatedTimeSeconds.visible = true
    }
    else if( (tabBar.selectedOption === option3_2Id) && (appConsole.state === Constants.CONSOLE_ST_WAITING_THERAPY_TIME) ){
        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.pressureIndicator.visible = false
        cumulatedBoard.cumulatedTimeSeconds.visible = true
    }
    return ret
}

function totalBoardStateDependigOnTherapy(){
    var ret = "viewTotalBoardOKIcon"

    if( (tabBar.selectedOption === option7_2Id) && (cumulatedBoard.cumulatedTimeSeconds.progressTool.value === 0) ){
        ret = "viewTotalBoardTimeOutIcon"
    }

    return ret
}

function syringeFillingAnimationOpacityDependingOnTherapy(){
    var ret = false

    if(tabBar.selectedOption === option1_1Id){
        ret = true
    }
    return ret
}

function waitingTimeDependingOnTherapy(){
    var ret = Storage.getAppDB(Constants.dbConstants.defaultWaitingTimeId, "")  // probably not used

    if( (tabBar.selectedOption === option3_1Id) || (tabBar.selectedOption === option3_2Id) ){
        ret = Math.round(((magnitudeSelector.inputTimeVolume.slider.value / magnitudeSelector.inputTimeVolume.conversionFactor) * 20) / 1000)
    }

    return ret
}

function waitingIconDependingOnTherapy(){
    var ret = "Images/OXIGENO 01.png"

    if(tabBar.selectedOption === option1_1Id){
        ret = ""
    }
    if((tabBar.selectedOption === option3Id) || (tabBar.selectedOption === option3_1Id) || (tabBar.selectedOption === option3_2Id)){
        ret = "Images/VACIO 02 192x192.png"
    }
    return ret
}

function cumulatedTimeSecondsDependingOnTherapy(){
    var ret = true

    if(tabBar.selectedOption === option5_1Id){
        ret = false
    }
    return ret
}

function cumulatedPressureDependingOnTherapy(){
    var ret = false

    if(tabBar.selectedOption === option5_1Id){
        ret = true
    }
    return ret
}
function waveImageDependingOnTherapy(){
    var ret = false

    if(tabBar.selectedOption === option5_1Id){
        ret = true
    }
    return ret
}
function emergencyButtonVisibilityDependingOnTherapy(){
    var ret = false

    if((tabBar.selectedOption === option4_1Id) || (tabBar.selectedOption === option4_2Id)){
        ret = true
    }
    return ret
}

function normalizationImageStateDependingOnTherapy(){
    var ret = "normalizationImageStateAnimated"

    if( (tabBar.selectedOption === option2Id) && (appConsole.state === Constants.CONSOLE_ST_GENERATING_CONT_VIEW) ){
        ret = "normalizationImageStateStatic"
    }
    if( (tabBar.selectedOption === option5_1Id) && (cumulatedBoard.removingBloodImage.state = "viewRemovingBlood") ){
        ret = "normalizationImageStateStatic"
    }

    return ret
}

function reduceMagnitudeSelector(){
    magnitudeSelector.inputBottleVolume.state = "reducedView"
    magnitudeSelector.inputBloodVolume.state = "reducedView"
    magnitudeSelector.inputLiquidVolume.state = "reducedView"
    magnitudeSelector.inputSalineVolume.state = "reducedView"
    magnitudeSelector.inputO3.state = "reducedView"
    magnitudeSelector.inputFlow.state = "reducedView"
    magnitudeSelector.inputTime.state = "reducedView"
    magnitudeSelector.inputTotalConcentration.state = "reducedView"
    magnitudeSelector.inputTherapyTime.state = "reducedView"
    magnitudeSelector.inputVacuumTime.state = "reducedView"
    magnitudeSelector.inputTimeVolume.state = "reducedView"
    magnitudeSelector.inputVolumeDose.state = "reducedView"
    magnitudeSelector.inputTimeDose.state = "reducedView"
    magnitudeSelector.inputVolume.state = "reducedView"
    magnitudeSelector.inputCleanTime.state = "reducedView"
    magnitudeSelector.inputPressure.state = "reducedView"
    magnitudeSelector.inputIp.state = "reducedView"
    magnitudeSelector.inputReinfusionTime.state = "reducedView"
//  magnitudeSelector.inputTotalConcentration.multiRangeSlider = false // comented to solve ticket #4120 (07/05/21)
//  magnitudeSelector.inputO3.multilabelView = false // comented to solve ticket #4107 (30/04/21)
}

function hideMagnitudeSelector(){
    magnitudeSelector.inputNormoOrHiperFake.visible = false
    magnitudeSelector.inputCyclesFake.visible = false
    magnitudeSelector.inputPreviousVaccumYesNoFake.visible = false
    magnitudeSelector.inputBottleVolumeFake.visible = false
    magnitudeSelector.inputBloodVolumeFake.visible = false
    magnitudeSelector.inputLiquidVolumeFake.visible = false
    magnitudeSelector.inputSalineVolumeFake.visible = false
    magnitudeSelector.inputO3Fake.visible = false
    magnitudeSelector.inputFlowFake.visible = false
    magnitudeSelector.inputTimeFake.visible = false
    magnitudeSelector.inputTotalConcentrationFake.visible = false
    magnitudeSelector.inputTherapyTimeFake.visible = false
    magnitudeSelector.inputVacuumTimeFake.visible = false
    magnitudeSelector.inputTimeVolumeFake.visible = false
    magnitudeSelector.inputVolumeDoseFake.visible = false
    magnitudeSelector.inputTimeDoseFake.visible = false
    magnitudeSelector.inputVolumeFake.visible = false
    magnitudeSelector.inputCleanTimeFake.visible = false
    magnitudeSelector.inputPressureFake.visible = false
    magnitudeSelector.inputIpFake.visible = false
    magnitudeSelector.inputReinfusionTimeFake.visible = false
    magnitudeSelector.totalConcentrationLabelFake.visible = false
    magnitudeSelector.ipLabelFake.visible = false
    magnitudeSelector.inputTotalConcentration.multiRangeSlider = false
    magnitudeSelector.inputO3.multilabelView = false
}

function hideCumulatedBoard(){
    cumulatedBoard.cumulatedO3.visible = false
    cumulatedBoard.cumulatedVolume.visible = false
    cumulatedBoard.cumulatedTimeSeconds.visible = false
    cumulatedBoard.cumulatedTime.visible = false
    cumulatedBoard.cumulatedPressure.visible = false
    cumulatedBoard.pressureIndicator.visible = false
    cumulatedBoard.syringeAnimation.visible = false
    cumulatedBoard.cyclesCounter.visible = false
    cumulatedBoard.syringeAnimation.syringeGif.paused = false
    cumulatedBoard.waveImage.state = "noViewWave"
    cumulatedBoard.addingBloodImage.state = "noViewAddingBlood"
    cumulatedBoard.removingBloodImage.state = "noViewRemovingBlood"
    cumulatedBoard.addingSalineImage.state = "noViewAddingSaline"
    cumulatedBoard.removingSalineImage.state = "noViewRemovingSaline"
    cumulatedBoard.nextCycleConfirmation.visible = false
}

function hideTotalsBoard(){
    totalsBoard.totalsO3.visible = false
    totalsBoard.totalsVolume.visible = false
    totalsBoard.totalsTime.visible = false
    totalsBoard.totalsPressure.visible = false
    totalsBoard.totalsTimeSeconds.visible = false
    totalsBoard.totalsTotalConcentration.visible = false
    totalsBoard.totalsIpIndex.visible = false
}

function hideGadgetMenu(){
    gadgetMenu.memoryButton.visible = false
    gadgetMenu.bloodVolumeButton.visible = false
    gadgetMenu.testPressureButton.visible = false
    gadgetMenu.syringeCalculatorButton.visible = false
    gadgetMenu.salineHemoTherapyCalculatorButton.visible = false
    gadgetMenu.state = "noViewGadgetMenu"
}


//TODO: Consider to change this switch by states in each control
function configureTherapy(therapyId){

    hideMagnitudeSelector()
    hideCumulatedBoard()
    hideTotalsBoard()
    hideGadgetMenu()

    switch(therapyId){
    case option1Id:
        tabBar.buttonASubMenu.state = "buttonASubmenuShow"
        break;
    case option1_1Id:
        magnitudeSelector.inputO3Fake.visible = true

        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.syringeAnimation.visible = true

        totalsBoard.totalsO3.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.syringeCalculatorButton.visible = true
        break;
    case option1_2Id:
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputFlowFake.visible = true

        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.syringeAnimation.visible = true
        cumulatedBoard.syringeAnimation.syringeGif.paused = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.syringeCalculatorButton.visible = true
        break;
    case option2Id:
        magnitudeSelector.inputPreviousVaccumYesNoFake.visible = true
        magnitudeSelector.inputSalineVolumeFake.visible = true
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputFlowFake.visible = true
        magnitudeSelector.inputReinfusionTimeFake.visible = true

        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.cumulatedPressure.visible = true
        cumulatedBoard.cyclesCounter.visible = true

        totalsBoard.totalsO3.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.testPressureButton.visible = true
        gadgetMenu.salineHemoTherapyCalculatorButton.visible = true
        break;
    case option3Id:
        tabBar.buttonBSubMenu.state = "buttonBSubmenuShow"
        break;
    case option3_1Id:
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputTherapyTimeFake.visible = true
        magnitudeSelector.inputVacuumTimeFake.visible = true
        magnitudeSelector.inputVolumeFake.visible = true

        cumulatedBoard.pressureIndicator.visible = true
        cumulatedBoard.cumulatedTimeSeconds.visible = true

        totalsBoard.totalsO3.visible = true
        totalsBoard.totalsVolume.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.testPressureButton.visible = true
        break;
    case option3_2Id:
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputFlowFake.visible = true
        magnitudeSelector.inputTimeFake.visible = true
        magnitudeSelector.inputCleanTimeFake.visible = true

        cumulatedBoard.cumulatedO3.visible = true
        cumulatedBoard.cumulatedVolume.visible = true
        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.pressureIndicator.visible = true

        totalsBoard.totalsO3.visible = true
        totalsBoard.totalsVolume.visible = true
        totalsBoard.totalsTime.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.testPressureButton.visible = true
        break;
    case option5Id:
        tabBar.buttonESubMenu.state = "buttonESubmenuShow"
        break;
    case option5_1Id:
        magnitudeSelector.inputNormoOrHiperFake.visible = true
        magnitudeSelector.inputCyclesFake.visible = true
        magnitudeSelector.inputPreviousVaccumYesNoFake.visible = true
        magnitudeSelector.inputBottleVolumeFake.visible = true
        magnitudeSelector.inputBloodVolumeFake.visible = true
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputTotalConcentrationFake.visible = true

        cumulatedBoard.cumulatedTimeSeconds.visible = true
        cumulatedBoard.cumulatedPressure.visible = true
        cumulatedBoard.cyclesCounter.visible = true

        totalsBoard.totalsO3.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.bloodVolumeButton.visible = true
        gadgetMenu.testPressureButton.visible = true

        magnitudeSelector.inputO3.multilabelView = true
        magnitudeSelector.inputTotalConcentration.dependentMagnitude = true
        magnitudeSelector.totalConcentrationLabelFake.visible = true
        break;
    case option5_2Id:
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputTotalConcentrationFake.visible = true
        magnitudeSelector.inputTotalConcentration.dependentMagnitude = false
        magnitudeSelector.inputTotalConcentration.multiRangeSlider = true

        cumulatedBoard.cumulatedO3.visible = true
        cumulatedBoard.pressureIndicator.visible = true

        totalsBoard.totalsO3.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.testPressureButton.visible = true
        break;
    case option4Id:
        tabBar.buttonCSubMenu.state = "buttonCSubmenuShow"
        break;
    case option4_1Id:
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputFlowFake.visible = true
        magnitudeSelector.inputTimeFake.visible = true

        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.pressureIndicator.visible = true

        totalsBoard.totalsO3.visible = true
        totalsBoard.totalsTime.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.testPressureButton.visible = true
        break;
    case option4_2Id:
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputFlowFake.visible = true
        magnitudeSelector.inputVolumeFake.visible = true

        cumulatedBoard.cumulatedVolume.visible = true
        cumulatedBoard.pressureIndicator.visible = true

        totalsBoard.totalsO3.visible = true
        totalsBoard.totalsVolume.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.testPressureButton.visible = true
        break;
    case option6Id:
        tabBar.buttonFSubMenu.state = "buttonFSubmenuShow"
        break;
    case option6_1Id:
    case option6_2Id:
        magnitudeSelector.inputLiquidVolumeFake.visible = true
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputTimeFake.visible = true
        magnitudeSelector.inputTotalConcentrationFake.visible = true

        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.pressureIndicator.visible = true

        totalsBoard.totalsTime.visible = true
        totalsBoard.totalsTotalConcentration.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.testPressureButton.visible = true

        magnitudeSelector.totalConcentrationLabelFake.visible = true
        magnitudeSelector.inputTotalConcentration.dependentMagnitude = true
        break;
    case option6_3Id:
        magnitudeSelector.inputLiquidVolumeFake.visible = true
        magnitudeSelector.inputO3Fake.visible = true
        magnitudeSelector.inputTimeFake.visible = true
        magnitudeSelector.inputIpFake.visible = true

        cumulatedBoard.cumulatedTime.visible = true
        cumulatedBoard.pressureIndicator.visible = true

        totalsBoard.totalsTime.visible = true
        totalsBoard.totalsIpIndex.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        gadgetMenu.testPressureButton.visible = true

        magnitudeSelector.ipLabelFake.visible = true
        magnitudeSelector.inputIp.dependentMagnitude = true
        break;
    case option7Id:
        tabBar.buttonGSubMenu.state = "buttonGSubmenuShow"
        break;
    case option7_1Id:
        magnitudeSelector.inputVacuumTimeFake.visible = true
        cumulatedBoard.cumulatedTimeSeconds.visible = true
        totalsBoard.totalsTimeSeconds.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true

        break;
    case option7_2Id:
        magnitudeSelector.inputPressureFake.visible = true
        cumulatedBoard.cumulatedPressure.visible = true
        totalsBoard.totalsPressure.visible = true

        gadgetMenu.state = "viewGadgetMenu"
        gadgetMenu.memoryButton.visible = true
        break;
    }

    if(therapyId === option5_1Id){
        magnitudeSelector.narrowMarginCoeficient = 0.3
    }
    else{
        magnitudeSelector.narrowMarginCoeficient = 1
    }

    tabBar.selectedOption = therapyId
    appToolBar.state = "settingsHelp"       // force transition to change appToolBar.state
    appToolBar.state = toolBarStateWhileEditing()

    applicationWindow.atmPressForAutohemo = -65535 // #4833

    magnitudeSelector.inputBottleVolume.saveStamp = therapyId + "_" + magnitudeSelector.inputBottleVolume.name
    magnitudeSelector.inputBloodVolume.saveStamp = therapyId + "_" + magnitudeSelector.inputBloodVolume.name
    magnitudeSelector.inputLiquidVolume.saveStamp = therapyId + "_" + magnitudeSelector.inputLiquidVolume.name
    magnitudeSelector.inputSalineVolume.saveStamp = therapyId + "_" + magnitudeSelector.inputSalineVolume.name
    magnitudeSelector.inputO3.saveStamp = therapyId + "_" + magnitudeSelector.inputO3.name
    magnitudeSelector.inputFlow.saveStamp = therapyId + "_" + magnitudeSelector.inputFlow.name
    magnitudeSelector.inputTime.saveStamp = therapyId + "_" + magnitudeSelector.inputTime.name
    magnitudeSelector.inputTotalConcentration.saveStamp = therapyId + "_" + magnitudeSelector.inputTotalConcentration.name
    magnitudeSelector.inputTherapyTime.saveStamp = therapyId + "_" + magnitudeSelector.inputTherapyTime.name
    magnitudeSelector.inputVacuumTime.saveStamp = therapyId + "_" + magnitudeSelector.inputVacuumTime.name
    magnitudeSelector.inputTimeVolume.saveStamp = therapyId + "_" + magnitudeSelector.inputTimeVolume.name
    magnitudeSelector.inputVolumeDose.saveStamp = therapyId + "_" + magnitudeSelector.inputVolumeDose.name
    magnitudeSelector.inputTimeDose.saveStamp = therapyId + "_" + magnitudeSelector.inputTimeDose.name
    magnitudeSelector.inputVolume.saveStamp = therapyId + "_" + magnitudeSelector.inputVolume.name
    magnitudeSelector.inputCleanTime.saveStamp = therapyId + "_" + magnitudeSelector.inputCleanTime.name
    magnitudeSelector.inputPressure.saveStamp = therapyId + "_" + magnitudeSelector.inputPressure.name
    magnitudeSelector.inputIp.saveStamp = therapyId + "_" + magnitudeSelector.inputIp.name
    magnitudeSelector.inputReinfusionTime.saveStamp = therapyId + "_" + magnitudeSelector.inputReinfusionTime.name
    magnitudeSelector.inputNormoOrHiper.saveStamp = therapyId + "_" + magnitudeSelector.inputNormoOrHiper.name
    magnitudeSelector.inputCycles.saveStamp = therapyId + "_" + magnitudeSelector.inputCycles.name
    magnitudeSelector.inputPreviousVaccumYesNo.saveStamp = therapyId + "_" + magnitudeSelector.inputPreviousVaccumYesNo.name

    //DEB->debug.log(true, "O3 save stamp: ",magnitudeSelector.inputO3.saveStamp)
    //DEB->debug.log(true, "Flow save stamp: ",magnitudeSelector.inputFlow.saveStamp)
    //DEB->debug.log(true, "Time save stamp: ",magnitudeSelector.inputTime.saveStamp)
    //DEB->debug.log(true, "Total concentration save stamp: ",magnitudeSelector.inputTotalConcentration.saveStamp)
    //DEB->debug.log(true, "Therapy time save stamp: ",magnitudeSelector.inputTherapyTime.saveStamp)
    //DEB->debug.log(true, "Vacuum time save stamp: ",magnitudeSelector.inputVacuumTime.saveStamp)
    //DEB->debug.log(true, "TimeVolume save stamp: ",magnitudeSelector.inputTimeVolume.saveStamp)
    //DEB->debug.log(true, "Volume dose save stamp: ",magnitudeSelector.inputVolumeDose.saveStamp)
    //DEB->debug.log(true, "Time dose save stamp: ",magnitudeSelector.inputTimeDose.saveStamp)
    //DEB->debug.log(true, "Volume save stamp: ",magnitudeSelector.inputVolume.saveStamp)
    //DEB->debug.log(true, "Clean save stamp: ",magnitudeSelector.inputCleanTime.saveStamp)
    //DEB->debug.log(true, "Pressure save stamp: ",magnitudeSelector.inputPressure.saveStamp)
    //DEB->debug.log(true, "tabBar.selectedOption: ",tabBar.selectedOption)
}

/*
function testCumualtedColors(){
    cumulatedBoard.cumulatedO3.x = 0
    cumulatedBoard.cumulatedO3.y = 0

    cumulatedBoard.cumulatedVolume.x = cumulatedBoard.cumulatedO3.width + 100
    cumulatedBoard.cumulatedVolume.y = 0

    cumulatedBoard.cumulatedTimeSeconds.x = cumulatedBoard.cumulatedVolume.width + 100
    cumulatedBoard.cumulatedTimeSeconds.y = 0

    cumulatedBoard.cumulatedTime.x = cumulatedBoard.cumulatedTimeSeconds.width + 100
    cumulatedBoard.cumulatedTime.y = 0

    cumulatedBoard.cumulatedPressure.x = cumulatedBoard.cumulatedTime.width + 100
    cumulatedBoard.cumulatedPressure.y = 0

    cumulatedBoard.state = "viewCumulated"
    cumulatedBoard.cumulatedO3.visible = true
    cumulatedBoard.cumulatedVolume.visible = true
    cumulatedBoard.cumulatedTimeSeconds.visible = true
    cumulatedBoard.cumulatedTime.visible = true
    cumulatedBoard.cumulatedPressure.visible = true

    cumulatedBoard.cumulatedO3.progressTool.maximumValue = 40
    cumulatedBoard.cumulatedVolume.progressTool.maximumValue = 40
    cumulatedBoard.cumulatedTimeSeconds.progressTool.maximumValue = 40
    cumulatedBoard.cumulatedTime.progressTool.maximumValue = 40
    cumulatedBoard.cumulatedPressure.progressTool.maximumValue = 40

    cumulatedBoard.cumulatedO3.progressTool.value = 20
    cumulatedBoard.cumulatedVolume.progressTool.value = 20
    cumulatedBoard.cumulatedTimeSeconds.progressTool.value = 20
    cumulatedBoard.cumulatedTime.progressTool.value = 20
    cumulatedBoard.cumulatedPressure.progressTool.value = 20

    cumulatedBoard.pressureIndicator.visible = false
    cumulatedBoard.syringeAnimation.visible = false
}
*/
