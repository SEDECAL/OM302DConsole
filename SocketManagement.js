// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

Qt.include("Therapies.js")
Qt.include("Constants.js")
Qt.include("DebugConstants.js")

function onConnected() {
    debug.log(socketFlowConsoleLog, "Socket connected!")
    manageSocketConnection()
}

function onDisconnected() {
    debug.log(socketFlowConsoleLog, "Socket disconnected!")
    manageSocketDisconnection()
}

function onWrite(data) {
    debug.log(socketFlowConsoleLog, "Socket write: ", data)
}

function onWritten(data) {
//  //DEB->debug.log(socketFlowConsoleLog, "Socket written: ", data, "btyes")
}

function onRead(data) {    
    debug.log(socketFlowConsoleLog, "Socket read: ", data)
    decodeSocket(data)
}

function preDecodeSocket(data){
    var i = 0
    var index = 0
    var responsesIndex = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]

    if ((index = data.indexOf(GET_DATA_ACK)) >= 0){
        responsesIndex[i++] = index
    }
    if ((index = data.indexOf(GET_VER_ACK)) >= 0){
        responsesIndex[i++] = index
    }
    if ((index = data.indexOf(GET_PAR_ACK)) >= 0){
        responsesIndex[i++] = index
    }

    for(i=0; i<responsesIndex.length; i++){
        if(responsesIndex[i] >= 0){
            decodeSocket(data.substring(responsesIndex[i], (responsesIndex[i+1] >= 0) ? responsesIndex[i+1] : data.length))
        }
    }
}

//function decodeSocket(data){
//    var index

//    if ((index = data.indexOf(GET_DATA_ACK)) >= 0){
//        index += GET_DATA_ACK.length + 1 // '+1' to skip ','
//        manageTerapyState(parseInt(data.substring(index, index + 2), 16), parseInt(data.substring(index + 3, index + 5), 16))
//        index += 3
//        manageErrorState(parseInt(data.substring(index, index + 2), 16))
//        index += 3
//        manageTimeState(parseInt(data.substring(index, index + 2), 16), parseInt(data.substring(index + 3, index + 5), 16))
//        index += 6
//        manageMeanFlowState(parseInt(data.substring(index, index + 2), 16))
//        index += 3
//        manageMeanO3State(parseInt(data.substring(index, index + 2), 16))
//        index += 3
////      manageTotalDoseState(parseInt(data.substring(index, index + 4), 16))
////      index += 5
//        manageTotalDoseState(parseInt(data.substring(index, index + 8), 16))
//        index += 9
////      manageOutputVolumeState(parseInt(data.substring(index, index + 4), 16))
////      index += 5
//        manageOutputVolumeState(parseInt(data.substring(index, index + 8), 16))
//        index += 9
//        managePressureState(parseInt(data.substring(index, index + 4), 16), parseInt(data.substring(index + 5, index + 9), 16))
//        index += 10
//        manageTemperatureState(parseInt(data.substring(index, index + 4), 16))
//        index += 5
//        manageVacuumTimeState(parseInt(data.substring(index, index + 4), 16))
//        index += 5
//        manageTherapyTimeState(parseInt(data.substring(index, index + 4), 16))
//        index += 5
//        manageMaxAvailableFlow(parseInt(data.substring(index, index + 4), 16))
//        index += 5
//        manageAutoHemoCycles(parseInt(data.substring(index, index + 4), 16))
//        index += 5
//        manageConfiguredFlushingTime(parseInt(data.substring(index, index + 4), 16))
//        index += 5
//        manageRemainingFlushingTime(parseInt(data.substring(index, index + 4), 16))
//        index += 5
//        manageOverpressureDuringTherapy(parseInt(data.substring(index, index + 2), 16))
//        index += 3
//        manageInsufflationState(parseInt(data.substring(index, index + 2), 16))
//        index += 3

//        Therapies.setTotalLabelsWhenError()
//    }
//    else if ((index = data.indexOf(GET_VER_ACK)) >= 0){
//        index += GET_VER_ACK.length + 1 // '+1' to skip ','
//        manageSoftwareVersions(data.substring(index))
//    }
//    else if ((index = data.indexOf(GET_PAR_ACK)) >= 0){
//        index += GET_PAR_ACK.length + 1 // '+1' to skip ','
//        manageCalibrationParameters(data.substring(index))
//    }
//    else if ((index = data.indexOf(GET_TEXT_ACK)) >= 0){
//        index += GET_TEXT_ACK.length + 1 // '+1' to skip ','
//        manageTextInfo(data.substring(index))
//    }
//    else if ((index = data.indexOf(GET_INFO_ACK)) >= 0){
//        index += GET_INFO_ACK.length + 1 // '+1' to skip ','
//        manageDeviceInfo(parseInt(data.substring(index), 10))
//    }
//}

function decodeSocket(data){
    var index

    if ((index = data.indexOf(GET_DATA_ACK)) >= 0){
        index += GET_DATA_ACK.length + 1 // '+1' to skip ','

        if((parseInt(data.substring(index, index + 2), 16) === 1) && applicationWindow.skipError){  // #4316
            consoleSocket.sendData(Constants.CNL_SIM)
            console.log("Skip error...")
            return
        }

        manageTerapyState(parseInt(data.substring(index, index + 2), 16), parseInt(data.substring(index + 3, index + 5), 16))
        index += 3
        manageErrorState(parseInt(data.substring(index, index + 2), 16))
        index += 3
        manageTimeState(parseInt(data.substring(index, index + 2), 16), parseInt(data.substring(index + 3, index + 5), 16))
        index += 6
        manageMeanFlowState(parseInt(data.substring(index, index + 2), 16))
        index += 3
        manageMeanO3State(parseInt(data.substring(index, index + 2), 16))
        index += 3
//      manageTotalDoseState(parseInt(data.substring(index, index + 4), 16))
//      index += 5
        manageTotalDoseState(parseInt(data.substring(index, index + 8), 16))
        index += 9
//      manageOutputVolumeState(parseInt(data.substring(index, index + 4), 16))
//      index += 5
        manageOutputVolumeState(parseInt(data.substring(index, index + 8), 16))
        index += 9
        managePressureState(parseInt(data.substring(index, index + 4), 16), parseInt(data.substring(index + 5, index + 9), 16))
        index += 10
        manageTemperatureState(parseInt(data.substring(index, index + 4), 16))
        index += 5
        manageVacuumTimeState(parseInt(data.substring(index, index + 4), 16))
        index += 5
        manageTherapyTimeState(parseInt(data.substring(index, index + 4), 16))
        index += 5
        manageMaxAvailableFlow(parseInt(data.substring(index, index + 4), 16))
        index += 5
        manageAutoHemoCycles(parseInt(data.substring(index, index + 4), 16))
        index += 5
        manageConfiguredFlushingTime(parseInt(data.substring(index, index + 4), 16))
        index += 5
        manageRemainingFlushingTime(parseInt(data.substring(index, index + 4), 16))
        index += 5
        manageOverpressureDuringTherapy(parseInt(data.substring(index, index + 2), 16))
        index += 3
        manageInsufflationState(parseInt(data.substring(index, index + 2), 16))
        index += 3

        Therapies.setTotalLabelsWhenError()
    }
    else if ((index = data.indexOf(GET_VER_ACK)) >= 0){
        index += GET_VER_ACK.length + 1 // '+1' to skip ','
        manageSoftwareVersions(data.substring(index))
    }
    else if ((index = data.indexOf(GET_PAR_ACK)) >= 0){
        index += GET_PAR_ACK.length + 1 // '+1' to skip ','
        manageCalibrationParameters(data.substring(index))
    }
    else if ((index = data.indexOf(GET_TEXT_ACK)) >= 0){
        index += GET_TEXT_ACK.length + 1 // '+1' to skip ','
        manageTextInfo(data.substring(index))
    }
    else if ((index = data.indexOf(GET_INFO_ACK)) >= 0){
        index += GET_INFO_ACK.length + 1 // '+1' to skip ','
        manageDeviceInfo(parseInt(data.substring(index), 10))
    }
}
