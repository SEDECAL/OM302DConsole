// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0


Item {
//    property int inputMargins: 20
//    property int inputWidth: 220//240
//    property int inputHeight: inputWidth * 0.72
//    property int inputNumber: 4
//    property int firstInputX: (1280 - (133) - ((inputNumber - 1) * inputMargins) - (inputNumber * inputWidth)) / 2
//    property int fullViewInputX: (1280 - (133) - 1000) / 2

//    property int firstInputY: (800 - (133/2) - ((inputNumber - 1) * inputMargins) - (inputNumber * inputWidth * 0.72)) / 2

//    property bool wizarOn: false

//    function wizarAnalisys() {
//        if(wizarOn){
//           if(inputO3.inspected === false){
//                inputO3.state = "fullView"
//            }
//            else if(inputFlow.inspected === false){
//                inputFlow.state = "fullView"
//            }
//           else if(inputTime.inspected === false){
//               inputTime.state = "fullView"
//           }
//           else if(inputTime2.inspected === false){
//               inputTime.state = "fullView"
//           }
//        }
//    }

//    function inputSelectedAnalisys(state_1, state_2, state_3, state_4) {
//      if( (state_1 === "fullView") || (state_2 === "fullView") || (state_3 === "fullView") || (state_4 === "fullView"))
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
//        inputTime2.init()
//    }

//    function showProgress(){
//        inputO3.progressIndicator.state = "viewProgress"
//        inputFlow.progressIndicator.state = "viewProgress"
//        inputTime.progressIndicator.state = "viewProgress"
//        inputTime2.progressIndicator.state = "viewProgress"
//    }
//    function hideProgress(){
//        inputO3.progressIndicator.state = "noViewProgress"
//        inputFlow.progressIndicator.state = "noViewProgress"
//        inputTime.progressIndicator.state = "noViewProgress"
//        inputTime2.progressIndicator.state = "noViewProgress"
//    }

//    states:[
//        State{
//            name: "inputSelected"
//            PropertyChanges { target: inputO3; opacity: (inputO3.state === "fullView") ? 1 : 0.2 }
//            PropertyChanges { target: inputFlow; opacity: (inputFlow.state === "fullView") ? 1 : 0.2 }
//            PropertyChanges { target: inputTime; opacity: (inputTime.state === "fullView") ? 1 : 0.2 }
//            PropertyChanges { target: inputTime; opacity: (inputTime2.state === "fullView") ? 1 : 0.2 }

//            PropertyChanges { target: inputO3; fullControlButton.visible: false}
//            PropertyChanges { target: inputFlow; fullControlButton.visible: false}
//            PropertyChanges { target: inputTime; fullControlButton.visible: false}
//            PropertyChanges { target: inputTime2; fullControlButton.visible: false}
//        },
//        State{
//            name: "noInputSelected"
//            PropertyChanges { target: inputO3; opacity: 1 }
//            PropertyChanges { target: inputFlow; opacity: 1 }
//            PropertyChanges { target: inputTime; opacity: 1 }
//            PropertyChanges { target: inputTime2; opacity: 1 }

//            PropertyChanges { target: inputO3; fullControlButton.visible: true}
//            PropertyChanges { target: inputFlow; fullControlButton.visible: true}
//            PropertyChanges { target: inputTime; fullControlButton.visible: true}
//            PropertyChanges { target: inputTime2; fullControlButton.visible: true}
//        }
//    ]

//    id: continuousTherapy
//    state: inputSelectedAnalisys(inputO3.state, inputFlow.state, inputTime.state, inputTime2.state)

//    Input_05{
//        id: inputO3
//        x: 25
//        y: firstInputY

//        saveStamp: "insufflation_O3"

//        fullViewX: fullViewInputX
//        fullViewY: 230

//        width: inputWidth
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

//    Input_05{
//        id: inputFlow
//        x: 25
//        y:  firstInputY + inputHeight + inputMargins
//        fullViewX: fullViewInputX
//        fullViewY: 230

//        width: inputWidth
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

//    Input_05{
//        id: inputTime
//        x: 25
//        y:  firstInputY + (inputHeight + inputMargins) * 2
//        fullViewX: fullViewInputX
//        fullViewY: 230

//        width: inputWidth
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

//    Input_05{
//        id: inputTime2
//        x: 25
//        y:  firstInputY + (inputHeight + inputMargins) * 3
//        fullViewX: fullViewInputX
//        fullViewY: 230

//        width: inputWidth
//        fullViewWidth: 1000

//        unitsLabel.text: "ug/Nml"
//        magnitudeLabel.color: "#DCE775"
//        unitsLabel.color: "#AFB42B"

//        magnitudeLabel2.color: "#CE93D6"
//        unitsLabel2.color: "#AB47BC"

//        slider.from: 3
//        slider.to: 9999
//        slider.value: 100
//        sliderBackgroundInactive.color: "#FFFFFF" //"#B2EBF2"


//        fixButtonLabel_1.text: "111"
//        fixButtonLabel_2.text: "222"
//        fixButtonLabel_3.text: "333"
//        fixButtonLabel_4.text: "444"
//        fixButtonLabel_5.text: "555"
//        mainImage.source: "Images/ic_schedule_white_48dp.png"

//        doubleLabelVisible: true
//        convertToTimeFlow: 30
//        state:"reducedView"
//        onVerificado: wizarAnalisys()

//    }

//    Rectangle{
//        id: rectangle
//        x: 300
//        y: 25
//        height: 470
//        width: 750
//      color: "#00000000"
//      //       color: "#333333"
//        visible: true

//        Rectangle{
//            x:0
//            y:0
//            width: 150
//            height: 100
//            color: "#333333"
//            Label{
//                anchors.fill: parent
//                verticalAlignment: Text.AlignVCenter
//                horizontalAlignment: Text.AlignHCenter
//                color: inputO3.magnitudeLabel.color
//                text: "ug"
//                font.pixelSize: 60
//            }
//        }
//        Rectangle{
//            y:0
//            x:200
//            width: 150
//            height: 100
//            color: "#333333"
//            Label{
//                anchors.fill: parent
//                verticalAlignment: Text.AlignVCenter
//                horizontalAlignment: Text.AlignHCenter
//                color: inputFlow.magnitudeLabel.color
//                text: "ml"
//                font.pixelSize: 60
//            }
//        }
//        Rectangle{
//            y:0
//            x:400
//            width: 150
//            height: 100
//            color: "#333333"
//            Label{
//                anchors.fill: parent
//                verticalAlignment: Text.AlignVCenter
//                horizontalAlignment: Text.AlignHCenter
//                color: inputTime.magnitudeLabel.color
//                text: "min"
//                font.pixelSize: 60
//            }
//        }
//        Rectangle{
//            y:0
//            x:600
//            width: 150
//            height: 100
//            color: "#333333"
//            Label{
//                anchors.fill: parent
//                verticalAlignment: Text.AlignVCenter
//                horizontalAlignment: Text.AlignHCenter
//                color: inputTime2.magnitudeLabel.color
//                text: "ug"
//                font.pixelSize: 60
//            }
//        }
//    }

//    Rectangle{
//        width: 150
//        height: 350
//        x: 300
//        y: 125
//        color: "#333333"
//        Progress_00{

//            height: parent.height
//            width: parent.width
//            radius: parent.radius
//            anchors.fill: parent
//            progressLabel.color: inputO3.magnitudeLabel.color
//            progressLabel.text: "400"
//            progressLabel.font.pixelSize: inputO3.magnitudeLabelFontSize_reducedView
//            backgroundColor: inputO3.magnitudeLabel.color
//            progressColor: inputO3.unitsLabel.color
//            progressLabel.opacity: 1
//            progressTool.opacity: 1
//            progressRectangle.height: parent.height
//        }
//    }
//    Rectangle{
//        width: 150
//        height: 350
//        x: 500
//        y: 125
//        color: "#333333"
//        Progress_00{

//            height: parent.height
//            width: parent.width
//            radius: parent.radius
//            anchors.fill: parent
//            progressLabel.color: inputFlow.magnitudeLabel.color
//            progressLabel.text: "300"
//            progressLabel.font.pixelSize: inputFlow.magnitudeLabelFontSize_reducedView
//            backgroundColor: inputFlow.magnitudeLabel.color
//            progressColor: inputFlow.unitsLabel.color
//            progressLabel.opacity: 1
//            progressTool.opacity: 1
//            progressRectangle.height: parent.height
//        }
//    }

//    Rectangle{
//        width: 150
//        height: 350
//        x: 700
//        y: 125
//        color: "#333333"
//        Progress_00{

//            height: parent.height
//            width: parent.width
//            radius: parent.radius
//            anchors.fill: parent
//            progressLabel.color: inputTime.magnitudeLabel.color
//            progressLabel.text: "20"
//            progressLabel.font.pixelSize: inputTime.magnitudeLabelFontSize_reducedView
//            backgroundColor: inputTime.magnitudeLabel.color
//            progressColor: inputTime.unitsLabel.color
//            progressLabel.opacity: 1
//            progressTool.opacity: 1
//            progressRectangle.height: parent.height
//        }
//    }

//    Rectangle{
//        width: 150
//        height: 350
//        x: 900
//        y: 125
//        color: "#333333"

//        Progress_00{

//            height: parent.height
//            width: parent.width
//            radius: parent.radius
//            anchors.fill: parent
//            progressLabel.color: inputTime2.magnitudeLabel.color
//            progressLabel.text: "723"
//            progressLabel.font.pixelSize: inputTime2.magnitudeLabelFontSize_reducedView
//            backgroundColor: inputTime2.magnitudeLabel.color
//            progressColor: inputTime2.unitsLabel.color
//            progressLabel.opacity: 1
//            progressTool.opacity: 1
//            progressRectangle.height: parent.height
//        }
//    }

//    Rectangle{
//        width: 150
//        height: 750
//        x: 600
//        y: 240
//        color: "#333333"
//        rotation:90
//        Progress_00{

//            height: parent.height
//            width: parent.width
//            radius: parent.radius
//            anchors.fill: parent
//            progressLabel.color: inputTime2.magnitudeLabel.color
//            progressLabel.text: "723"
//            progressLabel.font.pixelSize: inputTime2.magnitudeLabelFontSize_reducedView
//            backgroundColor: inputTime2.magnitudeLabel.color
//            progressColor: inputTime2.unitsLabel.color
//            progressLabel.opacity: 1
//            progressTool.opacity: 1
//            progressRectangle.height: parent.height
//        }
//    }
}


