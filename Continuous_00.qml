// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0


Item {
//    property double disabledOpacity: 0.4
//    property int inputMargins: 30
//    property int inputWidth: 240
//    property int inputNumber: 3
//    property int firstInputX: (1280 - (133) - ((inputNumber - 1) * inputMargins) - (inputNumber * inputWidth)) / 2
//    property int fullViewInputX: (1280 - (133) - 1000) / 2

//    property bool wizarOn: true

//    function wizarAnalisys() {
//        if(wizarOn){
//           if(inputO3.inspected === false){
//                inputO3.state = "fullView"
//            }
//            else if(inputFlow.inspected === false){
//                inputFlow.state = "fullView"
//            }
//            else if(inputTime.inspected === false){
//                inputTime.state = "fullView"
//            }
//        }
//    }

//    function inputSelectedAnalisys(state_1, state_2, state_3) {
//      if( (state_1 === "fullView") || (state_2 === "fullView") || (state_3 === "fullView"))
//        {
//            appToolBar.state = "justHelp"
//            return "inputSelected"
//        }
//        else
//        {
//            appToolBar.state = "full"
//            return "noInputSelected"
//        }
//    }

//    function init(){
//        inputO3.init()
//        inputFlow.init()
//        inputTime.init()
//    }


//    function generating(){
//        state = "generating"
//        showProgress()
//    }
//    function showProgress(){
//        inputO3.progressIndicator.state = "viewProgress"
//        inputFlow.progressIndicator.state = "viewProgress"
//        inputTime.progressIndicator.state = "viewProgress"
//    }
//    function hideProgress(){

//        inputO3.progressIndicator.state = "noViewProgress"
//        inputFlow.progressIndicator.state = "noViewProgress"
//        inputTime.progressIndicator.state = "noViewProgress"
//    }

//    states:[
//        State{
//            name: "inputSelected"
//            PropertyChanges { target: inputO3; opacity: (inputO3.state === "fullView") ? 1 : disabledOpacity }
//            PropertyChanges { target: inputFlow; opacity: (inputFlow.state === "fullView") ? 1 : disabledOpacity }
//            PropertyChanges { target: inputTime; opacity: (inputTime.state === "fullView") ? 1 : disabledOpacity }

//            PropertyChanges { target: inputO3; fullControlButton.visible: false}
//            PropertyChanges { target: inputFlow; fullControlButton.visible: false}
//            PropertyChanges { target: inputTime; fullControlButton.visible: false}
//        },
//        State{
//            name: "noInputSelected"
//            PropertyChanges { target: inputO3; opacity: 1 }
//            PropertyChanges { target: inputFlow; opacity: 1 }
//            PropertyChanges { target: inputTime; opacity: 1 }

//            PropertyChanges { target: inputO3; fullControlButton.visible: true}
//            PropertyChanges { target: inputFlow; fullControlButton.visible: true}
//            PropertyChanges { target: inputTime; fullControlButton.visible: true}
//        },
//        State{
//            name: "generating"
//            PropertyChanges { target: inputO3.inputForm; opacity: disabledOpacity }
//            PropertyChanges { target: inputFlow.inputForm; opacity: disabledOpacity }
//            PropertyChanges { target: inputTime.inputForm; opacity: disabledOpacity }

//            PropertyChanges { target: inputO3.progressIndicator; opacity: 1 }

//            PropertyChanges { target: inputO3; fullControlButton.visible: false}
//            PropertyChanges { target: inputFlow; fullControlButton.visible: false}
//            PropertyChanges { target: inputTime; fullControlButton.visible: false}
//        }
//    ]

//    id: continuousTherapy
//    state: inputSelectedAnalisys(inputO3.state, inputFlow.state, inputTime.state)

//    Input_07{
//        id: inputO3
//        x: firstInputX
//        y:25

//        saveStamp: "insufflation_O3"

//        fullViewX: fullViewInputX
//        fullViewY: 230

//        width: 240
//        fullViewWidth: 1000

//        unitsLabel.text: "ug/Nml"
//        magnitudeLabel.color: "#80DEEA"
//        unitsLabel.color: "#0097A7"

//        slider.from: 3
//        slider.to: 200
//        slider.value: 15
//        sliderBackgroundInactive.color: "#FFFFFF" //"#B2EBF2"


//        fixButtonLabel_1.text: "10"
//        fixButtonLabel_2.text: "20"
//        fixButtonLabel_3.text: "30"
//        fixButtonLabel_4.text: "40"
//        fixButtonLabel_5.text: "50"
//        mainImage.source: "Images/O3_white.png"
//        state:"reducedView"
//        startState: (wizarOn) ? "fullView" : "reducedView"

//        onVerificado: wizarAnalisys()

//    }
//    Input_07{
//        id: inputFlow
//        x: firstInputX + (inputWidth + inputMargins)
//        y:25
//        fullViewX: fullViewInputX
//        fullViewY: 230

//        width: 240
//        fullViewWidth: 1000

//        unitsLabel.text: "ug/Nml"
//        magnitudeLabel.color: "#81c784"
//        unitsLabel.color: "#388E3C"

//        slider.from: 3
//        slider.to: 40000
//        slider.value: 40000
//        sliderBackgroundInactive.color: "#FFFFFF" //"#B2EBF2"


//        fixButtonLabel_1.text: "111"
//        fixButtonLabel_2.text: "222"
//        fixButtonLabel_3.text: "333"
//        fixButtonLabel_4.text: "444"
//        fixButtonLabel_5.text: "555"
//        mainImage.source: "Images/Flow_white.png"
//        state:"reducedView"
//        onVerificado: wizarAnalisys()

//    }
//    Input_07{
//        id: inputTime
//        x: firstInputX + (inputWidth + inputMargins) * 2
//        y:25
//        fullViewX: fullViewInputX
//        fullViewY: 230

//        width: 240
//        fullViewWidth: 1000

//        unitsLabel.text: "ug/Nml"
//        magnitudeLabel.color: "#FFE082"
//        unitsLabel.color: "#FFB300"

//        slider.from: 3
//        slider.to: 40000
//        slider.value: 40000
//        sliderBackgroundInactive.color: "#FFFFFF" //"#B2EBF2"


//        fixButtonLabel_1.text: "111"
//        fixButtonLabel_2.text: "222"
//        fixButtonLabel_3.text: "333"
//        fixButtonLabel_4.text: "444"
//        fixButtonLabel_5.text: "555"
//        mainImage.source: "Images/ic_schedule_white_48dp.png"
//        state:"reducedView"
//        onVerificado: wizarAnalisys()
//    }


}
