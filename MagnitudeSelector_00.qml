// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0


Item {
    id:magnitudeSelectorItem

    property alias inputO3: inputO3
    property alias inputFlow: inputFlow
    property alias inputTime: inputTime
    property alias inputTimeVolume: inputTimeVolume
    property alias inputO3Fake: inputO3Fake
    property alias inputFlowFake: inputFlowFake
    property alias inputTimeFake: inputTimeFake
    property alias inputTimeVolumeFake: inputTimeVolumeFake
/*
    property int inputWith: 240
    property int fullViewInputWith: 1000
    property int fullViewInputY: 230
    property int fullViewInputX: (1280 - (133) - 1000) / 2
*/
//  property int inputWith: 150//magnitudeSelectorItem.width * 0.21
    property int inputWith: magnitudeSelectorItem.width * 0.21
    property int fullViewInputWith: magnitudeSelectorItem.width * 0.80//0.877
    property int fullViewInputY: magnitudeSelectorItem.width * 0.160//0.201
    property int fullViewInputX: (magnitudeSelectorItem.width - fullViewInputWith) / 2


    property double disabledopacity: 0.4
    property bool wizarddOn: true

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

    function inputSelectedAnalisys(state_1, state_2, state_3, state_4) {
      if( (state_1 === "fullView") || (state_2 === "fullView") || (state_3 === "fullView") || (state_4 === "fullView") )
        {
            appToolBar.state = "justHelp"
            return "inputSelected"
        }
        else
        {
            if(inputO3.visible === true){ // 'if' statement to avoid enabled 'play' control when just started and no teraphy is selected
                appToolBar.state = "settingsPlayHelp"
            }
            return "noInputSelected"
        }
    }
/*
    function generating(){
        state = "generating"
        showProgress()
    }
*/
    function showProgress(){
        if(inputO3Fake.visible === true){
            inputO3.progressIndicator.state = "viewProgress"
        }
        if(inputFlowFake.visible === true){
            inputFlow.progressIndicator.state = "viewProgress"
        }
        if(inputTimeFake.visible === true){
            inputTime.progressIndicator.state = "viewProgress"
        }
        if(inputTimeVolume.visible === true){
            inputTimeVolume.progressIndicator.state = "viewProgress"
        }
    }

    function hideProgress(){
        inputO3.progressIndicator.state = "noViewProgress"
        inputFlow.progressIndicator.state = "noViewProgress"
        inputTime.progressIndicator.state = "noViewProgress"
        inputTimeVolume.progressIndicator.state = "noViewProgress"
    }

    states:[
        State{
            name: "inputSelected"
            PropertyChanges { target: inputO3; opacity: (inputO3.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputFlow; opacity: (inputFlow.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTime; opacity: (inputTime.state === "fullView") ? 1 : disabledOpacity }
            PropertyChanges { target: inputTimeVolume; opacity: (inputTimeVolume.state === "fullView") ? 1 : disabledOpacity }

            PropertyChanges { target: inputO3; fullControlButton.visible: false}
            PropertyChanges { target: inputFlow; fullControlButton.visible: false}
            PropertyChanges { target: inputTime; fullControlButton.visible: false}
            PropertyChanges { target: inputTimeVolume; fullControlButton.visible: false}
        },
        State{
            name: "noInputSelected"
            PropertyChanges { target: inputO3; opacity: 1 }
            PropertyChanges { target: inputFlow; opacity: 1 }
            PropertyChanges { target: inputTime; opacity: 1 }
            PropertyChanges { target: inputTimeVolume; opacity: 1 }

            PropertyChanges { target: inputO3; fullControlButton.visible: true}
            PropertyChanges { target: inputFlow; fullControlButton.visible: true}
            PropertyChanges { target: inputTime; fullControlButton.visible: true}
            PropertyChanges { target: inputTimeVolume; fullControlButton.visible: true}
        }
/*        ,
        State{
            name: "generating"
            PropertyChanges { target: inputO3.inputForm; opacity: disabledOpacity }
            PropertyChanges { target: inputFlow.inputForm; opacity: disabledOpacity }
            PropertyChanges { target: inputTime.inputForm; opacity: disabledOpacity }
            PropertyChanges { target: inputTimeVolume.inputForm; opacity: disabledOpacity }

            PropertyChanges { target: inputO3.progressIndicator; opacity: 1 }

            PropertyChanges { target: inputO3; fullControlButton.visible: false}
            PropertyChanges { target: inputFlow; fullControlButton.visible: false}
            PropertyChanges { target: inputTime; fullControlButton.visible: false}
            PropertyChanges { target: inputTimeVolume; fullControlButton.visible: false}
        }
*/
    ]

    state: inputSelectedAnalisys(inputO3.state, inputFlow.state, inputTime.state, inputTimeVolume.state)

    Row{
        id: magnitudeRow
        spacing: magnitudeSelectorItem.width * 0.024//0.026 //30
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter        

//      add: Transition {
//          NumberAnimation{duration: 2000}
//      }
        Rectangle{
            id: inputO3Fake
            opacity: 0
            visible: false
            width: inputWith
            height: 10
        }
        Rectangle{
            id: inputFlowFake
            opacity: 0
            visible: false
            width: inputWith
            height: 10
        }
        Rectangle{
            id: inputTimeFake
            opacity: 0
            visible: false
            width: inputWith
            height: 10
        }
        Rectangle{
            id: inputTimeVolumeFake
            opacity: 0
            visible: false
            width: inputWith
            height: 10
        }
    }

    Input_10{
        id: inputO3
        name: "inputO3"
        x: magnitudeRow.x + inputO3Fake.x
        y: magnitudeRow.y + inputO3Fake.y
        initialX: magnitudeRow.x + inputO3Fake.x
        initialY: magnitudeRow.y + inputO3Fake.y
        visible: inputO3Fake.visible

        width: inputWith
        fullViewWidth: fullViewInputWith
        fullViewX: fullViewInputX
        fullViewY: fullViewInputY

        unitsLabel.text: "ug/Nml"
        unitsLabel.color: "#0097A7"
        magnitudeLabel.color: "#80DEEA"

        slider.from: 1
        slider.to: 80
        slider.value: 15
        sliderBackgroundInactive.color: "white"

        fixButtonLabel_1.text: "10"
        fixButtonLabel_2.text: "20"
        fixButtonLabel_3.text: "30"
        fixButtonLabel_4.text: "40"
        fixButtonLabel_5.text: "50"


        mainImage.source: "Images/O3_white.png"

        state:"reducedView"
//      startState: (wizarddOn) ? "fullView" : "reducedView"
//      onVerificado: wizarddAnalisys()
        saveStamp: ""
    }

    Input_10{
        id: inputFlow
        name: "inputFlow"
        x: magnitudeRow.x + inputFlowFake.x
        y: magnitudeRow.y + inputFlowFake.y
        initialX: magnitudeRow.x + inputFlowFake.x
        initialY: magnitudeRow.y + inputFlowFake.y
        visible: inputFlowFake.visible

        width: inputWith
        fullViewWidth: fullViewInputWith
        fullViewX: fullViewInputX
        fullViewY: fullViewInputY

        unitsLabel.text: "l/h"
        unitsLabel.color: "#388E3C"
        magnitudeLabel.color: "#81C784"

        slider.from: 10
        slider.to: 20
        slider.value: 50
        sliderBackgroundInactive.color: "white"

        fixButtonLabel_1.text: "10"
        fixButtonLabel_2.text: "20"
        fixButtonLabel_3.text: "30"
        fixButtonLabel_4.text: "40"
        fixButtonLabel_5.text: "50"

        mainImage.source: "Images/Flow_white.png"

        state:"reducedView"
//      onVerificado: wizarddAnalisys()
//      saveStamp: "xxx"
    }

    Input_10{
        id: inputTime
        name: "inputTime"
        x: magnitudeRow.x + inputTimeFake.x
        y: magnitudeRow.y + inputTimeFake.y
        initialX: magnitudeRow.x + inputTimeFake.x
        initialY: magnitudeRow.y + inputTimeFake.y
        visible: inputTimeFake.visible

        width: inputWith
        fullViewWidth: fullViewInputWith
        fullViewX: fullViewInputX
        fullViewY: fullViewInputY

        unitsLabel.text: "min"
        unitsLabel.color: "#FFB300"
        magnitudeLabel.color: "#FFE082"

        slider.from: 1
        slider.to: 3
        slider.value: 30
        sliderBackgroundInactive.color: "white"

        fixButtonLabel_1.text: "2"
        fixButtonLabel_2.text: "10"
        fixButtonLabel_3.text: "15"
        fixButtonLabel_4.text: "25"
        fixButtonLabel_5.text: "30"

        mainImage.source: "Images/ic_schedule_white_48dp.png"

        state:"reducedView"
//      onVerificado: wizarddAnalisys()
//      saveStamp: "xxx"
    }

    Input_10{
        id: inputTimeVolume
        name: "inputTimeVolume"
        x: magnitudeRow.x + inputTimeVolumeFake.x
        y: magnitudeRow.y + inputTimeVolumeFake.y
        initialX: magnitudeRow.x + inputTimeVolumeFake.x
        initialY: magnitudeRow.y + inputTimeVolumeFake.y
        visible: inputTimeVolumeFake.visible

        width: inputWith
        fullViewWidth: fullViewInputWith
        fullViewX: fullViewInputX
        fullViewY: fullViewInputY

        unitsLabel.text: "ml"
        unitsLabel.color: "#AFB42B"
        magnitudeLabel.color: "#DCE775"

        unitsLabel2.text: "min"
        unitsLabel2.color: "#AB47BC"
        magnitudeLabel2.color: "#CE93D6"

        slider.from: 1
        slider.to: 100
        slider.value: 3000
        sliderBackgroundInactive.color: "white"

        fixButtonLabel_1.text: "2"
        fixButtonLabel_2.text: "10"
        fixButtonLabel_3.text: "15"
        fixButtonLabel_4.text: "25"
        fixButtonLabel_5.text: "30"

        mainImage.source: "Images/ic_remove_circle_outline_white_48dp.png"

        state:"reducedView"
//      onVerificado: wizarddAnalisys()
//      saveStamp: "xxx"

        doubleLabelVisible: true
        convertToTimeFlow: 30 // ¿?
    }
}
