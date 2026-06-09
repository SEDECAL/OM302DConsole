// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard.Styles 2.2
import QtQuick.VirtualKeyboard.Settings 2.2
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants
import "DebugConstants.js" as DC


Rectangle {
    id: serviceMenu

    property alias serviceMenuControls: serviceMenuControls
    property alias serviceMenuShowData: serviceMenuShowData
    property alias serviceMenuShowDateTime: serviceMenuShowDateTime
    property alias restartScreen: restartScreen
    property alias textInput: textInput

    property bool resetNeeded: false
    property bool alwaysReset: false
    property bool pinValidated: false

    property int buttonRadius: 4
    property int buttonWidth: 400
    property int buttonHeight: 80
    property int menuButtonHeight: 80 * 0.77
    property int buttonFontSize: 20
    property int spaceBetweenButtons: 20 * 0.77
    property int calibrationStepsCount: 0

    property double opacityOnButtonPressed: 0.4

    property color backButtonColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuButtonId, "black")
    property color backFrameColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuBackFrameId, "black")
    property color labelFreeButtonColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
    property color labelProtectedButtonColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
    property color labelProtedtedButtonColor: "lightBlue"

    property variant calibrationType
    property variant freeButtonsText: [Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "0", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "1", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "2", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "3", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "4", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "5", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "6", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "7", "")]

    property variant protectedButtonsText: [Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "8", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "9", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "10", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "11", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "12", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "13", ""),
        Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "14", ""),]

    function freeButtonsClicked(text){
        calibrationType = text
        switch (text){
        case  freeButtonsText[0]: showPressureAndTemperature();  serviceMenuShowData.titleLabel.text = freeButtonsText[0]; break
        case  freeButtonsText[1]: showDeviceInformation();       serviceMenuShowData.titleLabel.text = freeButtonsText[1]; break
        case  freeButtonsText[2]: showParameters();              serviceMenuShowData.titleLabel.text = freeButtonsText[2]; break
        case  freeButtonsText[3]: loadParameters();              serviceMenuShowData.titleLabel.text = freeButtonsText[3]; break
        case  freeButtonsText[4]: showEditDeviceNameResources(); serviceMenuShowData.titleLabel.text = freeButtonsText[4]; break
        case  freeButtonsText[5]: showLastStartUp();             serviceMenuShowData.titleLabel.text = freeButtonsText[5]; break
        case  freeButtonsText[6]: changeUnitsDialog();           serviceMenuShowData.titleLabel.text = freeButtonsText[6]; break
        case  freeButtonsText[7]: showDateTime();                serviceMenuShowData.titleLabel.text = freeButtonsText[7]; break
        default: //DEB->debug.log(DC.calibrationConsoleLog, "freeButtonsClicked (unknown option)"); break
        }
    }

    function protectedButtonsClicked(text){
        calibrationType = text
        serviceMenuControls.sliderDebiation = 0
        if(pinValidated){
            switch (text){
            case  protectedButtonsText[0]: calibratePressure(); break
            case  protectedButtonsText[1]: calibrateFlow(); break
            case  protectedButtonsText[2]: periodCalibration(); break
            case  protectedButtonsText[3]: calibrateO3(); break
            case  protectedButtonsText[4]: calibratePressureFactor(); break
            case  protectedButtonsText[5]: saveParameters(); break
            case  protectedButtonsText[6]: resetGenerationTime(); break
            default: //DEB->debug.log(DC.calibrationConsoleLog, "protectedButtonsClicked (unknown option)"); break
            }
        }else{
            pinPad.visible = isPinProtectedOption(text)
            //DEB->debug.log(DC.calibrationConsoleLog, "pin blocked")
        }
    }

    function needResetOption(text){
        switch (text){
        case  protectedButtonsText[0]: resetNeeded = true; break
        case  protectedButtonsText[1]: resetNeeded = true; break
        case  protectedButtonsText[2]: resetNeeded = true; break
        case  protectedButtonsText[3]: resetNeeded = true; break
        default:
        }
    }

    function calibratePressure(){
        switch (calibrationStepsCount){
        case 0: consoleSocket.sendData(Constants.CALIBRATE_PRESS_START)
            //              serviceMenuControls.messageText.text = "Pressure calibration"
            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "35", "")
            serviceMenuControls.slider.from = 800
            serviceMenuControls.slider.to = 1100
            serviceMenuControls.slider.value = applicationWindow.atmosphericPressure //Constants.calibrationPressure
            calibrationStepsCount = calibrationStepsCount + 1
            showControlsDuringO3Calibration(true)
            serviceMenuControls.visible = true
            break;
        default:calibrationStepsCount = 0
            serviceMenuControls.visible = false
            appConsole.state = Constants.CONSOLE_ST_SERVICE_MENU
            break;
        }
    }

    function calibrateFlow(){
        switch (calibrationStepsCount){
        case 0: consoleSocket.sendData(Constants.CALIBRATE_FLOW_START)
            //              serviceMenuControls.messageText.text = "Flow calibration (step 1)\n"
            //              serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "Try to fix 11 l/h (0.18 l/min)"
            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "36", "") + "\n"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "37", "")
            serviceMenuControls.slider.from = 1
            serviceMenuControls.slider.to = 60
            serviceMenuControls.slider.value = 27
            calibrationStepsCount = calibrationStepsCount + 1
            showControlsDuringO3Calibration(true)
            serviceMenuControls.visible = true
            break;
        case 1: serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "36", "") + "\n"
            // serviceMenuControls.messageText.text = "Flow calibration (step 1)\n"
            // serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "External measurement (ml/min)"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "38", "")
            serviceMenuControls.slider.from = 100
            serviceMenuControls.slider.to = 900
            serviceMenuControls.slider.value = 180
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        case 2: serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "39", "") + "\n"
            // serviceMenuControls.messageText.text = "Flow calibration (step 2)\n"
            // serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "Try to fix 21 l/h (0.35 l/min)"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "40", "")
            serviceMenuControls.slider.from = 1
            serviceMenuControls.slider.to = 60
            serviceMenuControls.slider.value = 30
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            serviceMenuControls.visible = true
            break;
        case 3: serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "39", "") + "\n"
            // serviceMenuControls.messageText.text = "Flow calibration (step 2)\n"
            // serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "External measurement (ml/min)"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "38", "")
            serviceMenuControls.slider.from = 100
            serviceMenuControls.slider.to = 900
            serviceMenuControls.slider.value = 350
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        case 4: serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "41", "") + "\n"
            // serviceMenuControls.messageText.text = "Flow calibration (step 3)\n"
            // serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "Try to fix 40 l/h (0.66 l/min)"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "42", "")
            serviceMenuControls.slider.from = 11
            serviceMenuControls.slider.to = 60
            serviceMenuControls.slider.value = 36
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        case 5: serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "41", "") + "\n"
            // serviceMenuControls.messageText.text = "Flow calibration (step 3)\n"
            // serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "External measurement (ml/min)"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "38", "")
            serviceMenuControls.slider.from = 100
            serviceMenuControls.slider.to = 900
            serviceMenuControls.slider.value = 660
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        default:calibrationStepsCount = 0
            serviceMenuControls.visible = false
            appConsole.state = Constants.CONSOLE_ST_SERVICE_MENU
            break;
        }
    }

    function calibrateO3(){
        switch (calibrationStepsCount){
        case 0: consoleSocket.sendData(Constants.CALIBRATE_O3_START)
            // serviceMenuControls.messageText.text = "O3 calibration (step 1)\n"
            // serviceMenuControls.messageText.text = "Cleaning...\n"
            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "44", "") + "\n"
            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "43", "") + "\n"
            showControlsDuringO3Calibration(false)
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true

            serviceMenuControls.cancelButton.enabled = false  // walk around to solve avoid problems described in ticket #4216
            serviceMenuControls.cancelButton.opacity = 0.4    // walk around to solve avoid problems described in ticket #4216
            break;
        case 1:
            serviceMenuControls.cancelButton.enabled = true   // walk around to solve avoid problems described in ticket #4216
            serviceMenuControls.cancelButton.opacity = 1      // walk around to solve avoid problems described in ticket #4216

            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "44", "") + "\n"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "45", "")
            // serviceMenuControls.messageText.text = "O3 calibration (step 1)\n"
            // serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "Try to fix 76 \u03BCg"
            serviceMenuControls.slider.from = 1
            serviceMenuControls.slider.to = 500
            serviceMenuControls.slider.value = 200
            showControlsDuringO3Calibration(true)
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        case 2: serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "46", "") + "\n"
            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "43", "") + "\n"
            // serviceMenuControls.messageText.text = "O3 calibration (step 2)\n"
            // serviceMenuControls.messageText.text = "Cleaning...\n"
            showControlsDuringO3Calibration(false)
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        case 3: serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "46", "") + "\n"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "47", "")
            // serviceMenuControls.messageText.text = "O3 calibration (step 2)\n"
            // serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "Try to fix 47 \u03BCg"
            serviceMenuControls.slider.from = 1
            serviceMenuControls.slider.to = 500
            serviceMenuControls.slider.value = 100
            showControlsDuringO3Calibration(true)
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        case 4: serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "48", "") + "\n"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "49", "")
            // serviceMenuControls.messageText.text = "O3 calibration (step 3)\n"
            // serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "Try to fix 22 \u03BCg"
            serviceMenuControls.slider.from = 1
            serviceMenuControls.slider.to = 500
            serviceMenuControls.slider.value = 50
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        case 5: serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "50", "") + "\n"
            serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "51", "") + "\n"
            // serviceMenuControls.messageText.text = "O3 calibration (step 4)\n"
            // serviceMenuControls.messageText.text = serviceMenuControls.messageText.text + "Try to fix 1 \u03BCg"
            serviceMenuControls.slider.from = 1
            serviceMenuControls.slider.to = 500
            serviceMenuControls.slider.value = 10
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        default:calibrationStepsCount = 0
            serviceMenuControls.visible = false
            appConsole.state = Constants.CONSOLE_ST_SERVICE_MENU
            break;
        }
    }

    function calibratePressureFactor(){
        serviceMenuControls.sliderDebiation = 10
        switch (calibrationStepsCount){
        case 0: consoleSocket.sendData(Constants.CALIBRATE_PRESS_FACTOR_START)
            // serviceMenuControls.messageText.text = "Pressure compensation factor calibration\nPrevious value: " + Constants.pressureCompensation
            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "52", "") + "\n" +
                                                   Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "53", "") +
                                                   Constants.pressureCompensation
            serviceMenuControls.slider.from = -10
            serviceMenuControls.slider.to = 10
            serviceMenuControls.slider.value = Constants.pressureCompensation
            showControlsDuringO3Calibration(true)
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            break;
        default:// after pressure compensation factor calibration, the system starts O3 calibration
                // automatically, then prepare de interface to follow this process
            calibrationStepsCount = 0
            serviceMenuControls.visible = false

            serviceMenu.calibrationType = protectedButtonsText[3]
            serviceMenu.protectedButtonsClicked(serviceMenu.calibrationType)
          // Walk around. First spep calibrateO3()
//            serviceMenu.calibrationType = protectedButtonsText[3]
//            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "44", "") + "\n"
//            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "43", "") + "\n"
//            showControlsDuringO3Calibration(false)
//            calibrationStepsCount = calibrationStepsCount + 1
//            serviceMenuControls.visible = true

            break;
        }
    }

    function testO3(){
    }

    function saveParameters(){
        switch (calibrationStepsCount){
        case 0: yesNoPopUp.titleLabel.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "54", "") + "\n" +
                Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "55", "")
            // yesNoPopUp.titleLabel.text = "Save parameters\n Continue?"
            yesNoPopUp.visible = true
            calibrationStepsCount = calibrationStepsCount + 1
            break;
        case 1: consoleSocket.sendData(Constants.SAVE_PARAMETERS_START)
            consoleSocket.sendData(Constants.ENT_SIM)
            serviceMenuControls.messageText.text = "Saving parameters..."
            showControlsDuringO3Calibration(false)
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true

            serviceMenuControls.cancelButton.enabled = false   // walk around to solve avoid problems described in ticket #4219
            serviceMenuControls.cancelButton.opacity = 0.4     // walk around to solve avoid problems described in ticket #4219
            break;
        case 2: calibrationStepsCount = calibrationStepsCount + 1
            break;
        default:calibrationStepsCount = 0
            serviceMenuControls.visible = false

            serviceMenuControls.cancelButton.enabled = true   // walk around to solve avoid problems described in ticket #4219
            serviceMenuControls.cancelButton.opacity = 1      // walk around to solve avoid problems described in ticket #4219
            break;
        }
    }

    function resetGenerationTime()
    {

        switch (calibrationStepsCount){
        case 0: yesNoPopUp.titleLabel.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "14", "") + "\n" +
                Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "56", "")
            // yesNoPopUp.titleLabel.text = "Reset generation time\n Continue?"
            yesNoPopUp.visible = true
            calibrationStepsCount = calibrationStepsCount + 1
            break;
        case 1:
            calibrationStepsCount = calibrationStepsCount + 1
            consoleSocket.sendData(Constants.RESET_GENERATION_TIME)
            calibrationStepsCount = 0
            serviceMenuControls.visible = false
            consoleSocket.sendData(Constants.GET_INFO)
            break;
        default:calibrationStepsCount = 0
            serviceMenuControls.visible = false
            break;
        }


    }

    function showPressureAndTemperature(){
        //DEB->debug.log(DC.calibrationConsoleLog, "temperature to show: ", normalizationImage.temperature)
        //      serviceMenuShowData.titleLabel.text = freeButtonsText[0]
        //      serviceMenuShowData.dataLabel.text = "T: " + normalizationImage.temperature + " \u00B0C\n" + "P: " + normalizationImage.pressure + " mbar"
        serviceMenuShowData.dataLabel.text = normalizationImage.editTemperatureValue() + "\n" + normalizationImage.editPressureValue()
        serviceMenuShowData.visible = true
    }

    function showParameters(){
        //      serviceMenuShowData.titleLabel.text = freeButtonsText[2]
        //      serviceMenuShowData.dataLabel.text = ""
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "Calibration pressure: " + Constants.calibrationPressure + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "O3 sensor gain: " + Constants.o3Sensorgain + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "Ini period: " + Constants.periodIni + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "Pressure compensation: " + Constants.pressureCompensation + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "Flow gain 1: " + Constants.flowGainSector1 + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "Flow gain 2: " + Constants.flowGainSector2 + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "Flow gain 3: " + Constants.flowGainSector3 + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "1 \u03BCg pulses: " + Constants.oneMicrogramePulses + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "O3 pulses 1: " + Constants.o3PulsesSector1 + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "O3 pulses 2: " + Constants.o3PulsesSector2 + "\n"
        //      serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "O3 pulses 3: " + Constants.o3PulsesSector3 + "\n"
        serviceMenuShowData.dataLabel.text =                                             Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "20", "") + Constants.calibrationPressure
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "21", "") + Constants.o3Sensorgain
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "22", "") + Constants.periodIni
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "23", "") + Constants.pressureCompensation
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "24", "") + Constants.flowGainSector1
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "25", "") + Constants.flowGainSector2
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "26", "") + Constants.flowGainSector3
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "27", "") + Constants.oneMicrogramePulses
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "28", "") + Constants.o3PulsesSector1
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "29", "") + Constants.o3PulsesSector2
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "30", "") + Constants.o3PulsesSector3
        serviceMenuShowData.visible = true

    }
    function showDeviceInformation(){
        var intPart = parseInt(applicationWindow.generationTime / 3600)
        var decPart = (applicationWindow.generationTime / 3600) - intPart


        var hours = (applicationWindow.generationTime / 3600)
        var mins =  (hours - parseInt(hours)) * 60
        var secs =  (mins - parseInt(mins)) * 60


//      serviceMenuShowData.titleLabel.text = freeButtonsText[1]
//      serviceMenuShowData.dataLabel.text = "Software versions:" + "\n   - Console: " + Constants.consoleSW +  "\n   - Control Board: " + Constants.controlBoardSW + "\n   - Interface Board: " + Constants.interfaceSW + "\n\nGeneration Time: "// + applicationWindow.generationTime
        serviceMenuShowData.dataLabel.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "15", "") +
                "\n   - " +
                Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "16", "") +
                Constants.consoleSW +
                "\n   - " +
                Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "17", "") +
                applicationWindow.controlBoardSW +
                "\n   - " +
                Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "18", "") +
                applicationWindow.interfaceSW +
                "\n   - " +
                Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "62", "") +
                Storage.getAppDB(Constants.dataBaseVerId, "") +
                "\n\n" +
                Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "19", "")
        serviceMenuShowData.dataLabel.text = serviceMenuShowData.dataLabel.text  + parseInt(hours) + "h " + parseInt(mins) + "m " + parseInt(secs) + "s"
        serviceMenuShowData.visible = true
    }

    function periodCalibration(){
        switch (calibrationStepsCount){
        case 0:
//          yesNoPopUp.titleLabel.text = "Period calibration\n Continue?"
            yesNoPopUp.titleLabel.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "10", "") + "\n" + Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "55", "")
            yesNoPopUp.visible = true
            calibrationStepsCount = calibrationStepsCount + 1
            appConsole.state = Constants.CONSOLE_ST_SERVICE_MENU
            break;
        case 1: consoleSocket.sendData(Constants.CALIBRATE_PERIOD_START)
//          serviceMenuControls.messageText.text = "Period calibration"
            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "10", "")
            showControlsDuringO3Calibration(false)
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true
            serviceMenuControls.cancelButton.enabled = false  // walk around to solve avoid problems described in ticket #4315
            serviceMenuControls.cancelButton.opacity = 0.4    // walk around to solve avoid problems described in ticket #4315
            break;
        case 2: calibrationStepsCount = calibrationStepsCount + 1
            break;
        default:calibrationStepsCount = 0
            serviceMenuControls.visible = false
            serviceMenuControls.cancelButton.enabled = true   // walk around to solve avoid problems described in ticket #4315
            serviceMenuControls.cancelButton.opacity = 1      // walk around to solve avoid problems described in ticket #4315
            break;
        }
    }

    function loadParameters(){
        switch (calibrationStepsCount){
            //      case 0: yesNoPopUp.titleLabel.text = "Load parameters\n Continue?"
        case 0: yesNoPopUp.titleLabel.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "31", "") + "\n" +
                Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "56", "")
            yesNoPopUp.visible = true
            calibrationStepsCount = calibrationStepsCount + 1
            appConsole.state = Constants.CONSOLE_ST_SERVICE_MENU
            break;
        case 1: consoleSocket.sendData(Constants.LOAD_PARAMETERS_START)
            consoleSocket.sendData(Constants.ENT_SIM)
            //            serviceMenuControls.messageText.text = "Load parameters"
            serviceMenuControls.messageText.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "31", "")
            showControlsDuringO3Calibration(false)
            calibrationStepsCount = calibrationStepsCount + 1
            serviceMenuControls.visible = true

            serviceMenuControls.cancelButton.enabled = false  // walk around to solve avoid problems described in ticket #4219
            serviceMenuControls.cancelButton.opacity = 0.4    // walk around to solve avoid problems described in ticket #4219
            break;
        case 2: calibrationStepsCount = calibrationStepsCount + 1
            break;
        default:calibrationStepsCount = 0
            serviceMenuControls.visible = false
            appConsole.state = Constants.CONSOLE_ST_SERVICE_MENU
            serviceMenuControls.cancelButton.enabled = true   // walk around to solve avoid problems described in ticket #4219
            serviceMenuControls.cancelButton.opacity = 1      // walk around to solve avoid problems described in ticket #4219
            break;
        }
    }


    function showControlsDuringO3Calibration(state){
        serviceMenuControls.magnitudeLabel.visible = state
        serviceMenuControls.rangeMinLabel.visible = state
        serviceMenuControls.rangeMaxLabel.visible = state
        serviceMenuControls.slider.visible = state
        serviceMenuControls.upButton.visible = state
        serviceMenuControls.downButton.visible = state
        serviceMenuControls.doneButton.visible = state
        serviceMenuControls.bussyIndicator.visible = !state
    }

    function isPinProtectedOption(text){
        switch (text){
        case  protectedButtonsText[0]:
        case  protectedButtonsText[1]:
        case  protectedButtonsText[2]:
        case  protectedButtonsText[3]:
        case  protectedButtonsText[4]:
        case  protectedButtonsText[5]:
        case  protectedButtonsText[6]: return true
        default: return false
        }
    }

    function baseControlsEnabled(){
        return !restartScreen.visible & !serviceMenuControls.visible & !pinPad.visible & !serviceMenuShowData.visible & !serviceMenuShowDateTime.visible & !yesNoPopUp.visible & !serviceMenuChooseUnits.visible & !deviceNameEditor.visible
    }

    function showEditDeviceNameResources(){
        keyboard.visible = true
        deviceNameEditor.visible = true
        textInput.forceActiveFocus()
        textInput.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "33", "")
    }

    function showLastStartUp(){
        //DEB->debug.log(DC.calibrationConsoleLog, "temperature to show: ", normalizationImage.temperature)
        //      serviceMenuShowData.titleLabel.text = freeButtonsText[5]
        serviceMenuShowData.scrollDataLabel.text = startUp.startUpHiddenText.text
        serviceMenuShowData.dataLabel.visible = false
        serviceMenuShowData.scrollDataLabel.visible = true
        serviceMenuShowData.visible = true
    }

    function changeUnitsDialog(){
        //DEB->debug.log(DC.calibrationConsoleLog, "temperature to show: ", normalizationImage.temperature)
        //      serviceMenuChooseUnits.titleLabel.text = Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "0", "")
        serviceMenuChooseUnits.titleLabel.text = freeButtonsText[6]
        serviceMenuChooseUnits.visible = true
    }

    function showDateTime(){
        serviceMenuShowDateTime.titleLabel.text = freeButtonsText[7]
        serviceMenuShowDateTime.visible = true
    }


    anchors.fill: parent
    anchors.topMargin: 20
    anchors.bottomMargin: 20
    anchors.leftMargin: 100
    anchors.rightMargin: 100
    color: Storage.getAppDB(Constants.dbAppColor.serviceMenuBackId, "black")
    radius: 8

    onVisibleChanged: {
        pinValidated = false

        if(visible){
            keyboard.anchors.left = serviceMenu.left
            keyboard.anchors.right = serviceMenu.right

            resetNeeded = false
            pinValidated = false
            calibrationType = ""
            calibrationStepsCount = 0
            serviceMenuShowData.visible = false
            serviceMenuChooseUnits.visible = false
            serviceMenuShowDateTime.visible = false
            serviceMenuControls.visible = false
            yesNoPopUp.visible = false
            pinPad.visible = false
            serviceMenuControls.cancelButton.enabled = true   // walk around to solve avoid problems described in ticket #4219
            serviceMenuControls.cancelButton.opacity = 1      // walk around to solve avoid problems described in ticket #4219
        }
        else{
            keyboard.anchors.left = undefined
            keyboard.anchors.right = undefined
        }
    }

    Rectangle{
        id: freeMenuBackFrame
        x: (parent.width - (protectedMenuBackFrame.width + freeMenuBackFrame.width + backButton.width)) / 4
        y: protectedMenuBackFrame.y
        color: backFrameColor
        width: buttonWidth + (2 * spaceBetweenButtons)
        height: ((freeMenuRepeater.count + 1) * (menuButtonHeight + spaceBetweenButtons)) + spaceBetweenButtons + spaceBetweenButtons
        radius: buttonRadius
        enabled: baseControlsEnabled()

        Rectangle{
            id: openLockIndcator
            height: buttonHeight
            width: buttonHeight
            color: "transparent"
            radius: buttonRadius
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: spaceBetweenButtons
            anchors.rightMargin: spaceBetweenButtons
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.unLockId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
        }

        Column{
            id: freeMenuColumn
            anchors.top: openLockIndcator.bottom
            anchors.right: openLockIndcator.right
            anchors.topMargin: spaceBetweenButtons
            spacing: spaceBetweenButtons
            Repeater{
                id: freeMenuRepeater
                model: freeButtonsText
                Rectangle{
                    height: menuButtonHeight
                    width: buttonWidth
                    color: backButtonColor
                    radius: buttonRadius
                    Label {
                        color: labelFreeButtonColor
                        text: modelData
                        anchors.fill: parent
                        font.pointSize: buttonFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        opacity: freeButton.down ? opacityOnButtonPressed : 1
                        fontSizeMode: Text.Fit
                    }
                    Button{
                        id: freeButton
                        anchors.fill: parent
                        opacity: 0
                        onClicked: freeButtonsClicked(modelData)
                    }
                }
            }
        }
    }

    Rectangle{
        id: protectedMenuBackFrame
        x: (((parent.width - (protectedMenuBackFrame.width + freeMenuBackFrame.width + backButton.width)) / 4) * 2) + protectedMenuBackFrame.width
        anchors.top: parent.top
        anchors.topMargin: spaceBetweenButtons * 2//3
        color: backFrameColor
        width: buttonWidth + (2 * spaceBetweenButtons)
        height: ((protectedMenuRepeater.count + 1) * (menuButtonHeight + spaceBetweenButtons)) + spaceBetweenButtons + spaceBetweenButtons
        radius: buttonRadius
        enabled: baseControlsEnabled()

        Rectangle{
            id: closeLockIndcator
            height: buttonHeight
            width: buttonHeight
            color: pinValidated ? "transparent" : backButtonColor
            radius: buttonRadius
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: spaceBetweenButtons
            anchors.rightMargin: spaceBetweenButtons
            Image{
                id: lockImage
                anchors.fill: parent
                source: pinValidated ? Storage.getAppDB(Constants.dbAppIcon.unLockId, "") : Storage.getAppDB(Constants.dbAppIcon.lockId, "")
                opacity: lockButton.down ? opacityOnButtonPressed : 1
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
            Button{
                id: lockButton
                anchors.fill: parent
                opacity: 0
                onClicked: {
                    pinValidated ? pinPad.visible = false : pinPad.visible = true
                }
            }
        }

        Column{
            id: protectedMenuColumn
            anchors.top: closeLockIndcator.bottom
            anchors.right: closeLockIndcator.right
            anchors.topMargin: spaceBetweenButtons
            spacing: spaceBetweenButtons
            Repeater{
                id: protectedMenuRepeater
                model: protectedButtonsText
                Rectangle{
                    height: menuButtonHeight
                    width: buttonWidth
                    color: backButtonColor
                    radius: buttonRadius
                    Label {
                        color: labelProtectedButtonColor
                        text: modelData
                        anchors.fill: parent
                        font.pointSize: buttonFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        opacity: protectedButton.down ? opacityOnButtonPressed : 1
                        fontSizeMode: Text.Fit
                    }
                    Button{
                        id: protectedButton
                        anchors.fill: parent
                        opacity: 0
                        onClicked: protectedButtonsClicked(modelData)
                    }
                }
            }
        }
    }

    Rectangle{
        id: backButton
        height: buttonHeight
        width: buttonHeight
        color: backButtonColor
        radius: buttonRadius
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: anchors.rightMargin
        anchors.rightMargin: (parent.width - (protectedMenuBackFrame.width + freeMenuBackFrame.width + backButton.width)) / 4
        enabled: baseControlsEnabled()
        Image{
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.backId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            opacity: backButtonButton.down ? 0.4 : 1
        }
        Button{
            id: backButtonButton
            anchors.fill: parent
            opacity: 0
            onClicked: {
                if((resetNeeded) || (alwaysReset)){
                    restartScreen.visible = true
                }
                else{
                    pinValidated = false
                    appConsole.state = Constants.CONSOLE_ST_EDITING
                    appHelpMenu.state = "HideHelp"
                }
            }
        }
    }

    PinPad{
        id: pinPad
        visible: false
        anchors.centerIn: parent
        onPinAccepted: pinValidated = true
        z: disableEffectMask.z + 1
    }

    ServiceMenuControls{
        id: serviceMenuControls
        visible: false
        anchors.centerIn: parent
        onAccepted: {
            freeButtonsClicked(calibrationType)
            protectedButtonsClicked(calibrationType)
            needResetOption(calibrationType)
        }
        onCancelled: {
            calibrationStepsCount = 0
            appConsole.state = Constants.CONSOLE_ST_SERVICE_MENU
        }
        z: disableEffectMask.z + 1
    }
    ServiceMenuShowData{
        id: serviceMenuShowData
        visible: false
        anchors.centerIn: parent
        z: disableEffectMask.z + 1
    }
    ServiceMenuShowDateTime{
        id: serviceMenuShowDateTime
        visible: false
        anchors.centerIn: parent
        z: disableEffectMask.z + 1
    }
    ServiceMenuChooseUnits{
        id: serviceMenuChooseUnits
        visible: false
        anchors.centerIn: parent
        z: disableEffectMask.z + 1
    }
    YesNoPopUp{
        id: yesNoPopUp
        visible: false
        anchors.centerIn: parent
        z: disableEffectMask.z + 1

        onYes: {
            freeButtonsClicked(calibrationType)
            protectedButtonsClicked(calibrationType)
        }
        onNo:{
            calibrationStepsCount = 0
            appConsole.state = Constants.CONSOLE_ST_SERVICE_MENU
        }
    }
    Rectangle{
        id: deviceNameEditor
        width: parent.width
        height: parent.height * 0.115
        anchors.centerIn: parent
        color: parent.color
        visible: false
        z: disableEffectMask.z + 1

        onVisibleChanged: {
            //DEB->debug.log(DC.servicemenuLog, "Saving company name...")
            Storage.setLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "33", textInput.text)
            Storage.saveAppDB()
            brandName.businessName.text = textInput.text
        }
        TextInput {
            id: textInput
            anchors.centerIn: parent
            width: parent.width * 0.9
            height: parent.height * 0.9
            color: labelFreeButtonColor
            text: Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "33", "")
            font.pointSize: buttonFontSize
            verticalAlignment: TextInput.AlignVCenter
            font.family: "Helvetica"
            onTextChanged: {
                if(textInput.text.length > 60){
                    textInput.text = textInput.text.substring(0, 60)
                }
            }
        }
        states:[
            State {
                name: "withoutFocus";
                when: (!(keyboard.active) & serviceMenu.visible)
                PropertyChanges { target: textInput; visible: false }
                PropertyChanges { target: deviceNameEditor; visible: false }
            },
            State {
                name: "withFocus";
                when:  (keyboard.active & serviceMenu.visible & !serviceMenuShowData.visible)
                PropertyChanges { target: textInput; visible: true }
                PropertyChanges { target: deviceNameEditor; visible: true }
            }
        ]
    }

    Rectangle{
        id: disableEffectMask
        anchors.fill: parent
        radius: parent.radius
        visible: !baseControlsEnabled()
        opacity: 0.5
        z: parent.z + 1
        color: "black"
    }

    RestartScreen{
        id: restartScreen
        visible: false
        z: disableEffectMask.z + 1
    }

}


