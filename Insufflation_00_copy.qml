// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0


Item {
    property alias insufflationTherapy: insufflationTherapy

    property int inputMargins: 30
    property int inputWidth: 240
    property int inputNumber: 4
    property int firstInputX: (1280 - (133) - ((inputNumber - 1) * inputMargins) - (inputNumber * inputWidth)) / 2
    property int fullViewInputX: (1280 - (133) - 1000) / 2


    function inputSelectedAnalisys(state_1, state_2, state_3, state_4) {
        if( (state_1 === "fullView") || (state_2 === "fullView") || (state_3 === "fullView") || (state_4 === "fullView") )
        {
            return "inputSelected"
        }
        else
        {
            return "noInputSelected"
        }
    }

    function init()
    {
        inputO3.init()
        inputFlow.init()
        inputTime.init()
        inputTime2.init()
    }

    states:[
        State{
            name: "inputSelected"
            PropertyChanges { target: inputO3; opacity: (inputO3.state === "fullView") ? 1 : 0.2 }
            PropertyChanges { target: inputFlow; opacity: (inputFlow.state === "fullView") ? 1 : 0.2 }
            PropertyChanges { target: inputTime; opacity: (inputTime.state === "fullView") ? 1 : 0.2 }
            PropertyChanges { target: inputTime2; opacity: (inputTime2.state === "fullView") ? 1 : 0.2 }

            PropertyChanges { target: inputO3; fullControlButton.visible: false}
            PropertyChanges { target: inputFlow; fullControlButton.visible: false}
            PropertyChanges { target: inputTime; fullControlButton.visible: false}
            PropertyChanges { target: inputTime2; fullControlButton.visible: false}
        },
        State{
            name: "noInputSelected"
            PropertyChanges { target: inputO3; opacity: 1 }
            PropertyChanges { target: inputFlow; opacity: 1 }
            PropertyChanges { target: inputTime; opacity: 1 }
            PropertyChanges { target: inputTime2; opacity: 1 }
        }
    ]

    id: insufflationTherapy
    state: inputSelectedAnalisys(inputO3.state, inputFlow.state, inputTime.state, inputTime2.state)

    Input_04{
        id: inputO3
        x: firstInputX
        y:25

        saveStamp: "insufflation_O3"

        fullViewX: fullViewInputX
        fullViewY: 230

        width: 240
        fullViewWidth: 1000

        unitsLabel.text: "ug/Nml"
        magnitudeLabel.color: "#80DEEA"
        unitsLabel.color: "#0097A7"

        slider.from: 3
        slider.to: 200
        slider.value: 15
        sliderBackgroundInactive.color: "#FFFFFF" //"#B2EBF2"


        fixButtonLabel_1.text: "10"
        fixButtonLabel_2.text: "20"
        fixButtonLabel_3.text: "30"
        fixButtonLabel_4.text: "40"
        fixButtonLabel_5.text: "50"
        mainImage.source: "Images/ic_schedule_white_48dp.png"




        //        Behavior on opacity{
        //            NumberAnimation { duration: 1000 }
        //        }

        //fullControlButton.visible: buttonVisibleAnalisys(inputO3.state, inputFlow.state, inputTime.state, inputTime2.state)
        //opacity: buttonOpacityAnalisys(inputFlow.state, inputTime.state, inputTime2.state)
    }

    Input_04{
        id: inputFlow
        //x: (applicationWindow.width - tabBar.width - 2*(((inputNumber - 1) * inputMargins) - (inputNumber * inputWidth))) / 2
        x: firstInputX + (inputWidth + inputMargins)
        y:25
        fullViewX: fullViewInputX
        fullViewY: 230

        width: 240
        fullViewWidth: 1000

        unitsLabel.text: "ug/Nml"
        magnitudeLabel.color: "#81c784"
        unitsLabel.color: "#388E3C"

        slider.from: 3
        slider.to: 40000
        slider.value: 40000
        sliderBackgroundInactive.color: "#FFFFFF" //"#B2EBF2"


        fixButtonLabel_1.text: "111"
        fixButtonLabel_2.text: "222"
        fixButtonLabel_3.text: "333"
        fixButtonLabel_4.text: "444"
        fixButtonLabel_5.text: "555"
        mainImage.source: "Images/ic_schedule_white_48dp.png"
        //        Behavior on opacity{
        //            NumberAnimation { duration: 1000 }
        //        }
    }
    Input_04{
        id: inputTime
        x: firstInputX + (inputWidth + inputMargins) * 2
        y:25
        fullViewX: fullViewInputX
        fullViewY: 230

        width: 240
        fullViewWidth: 1000

        unitsLabel.text: "ug/Nml"
        magnitudeLabel.color: "#FFE082"
        unitsLabel.color: "#FFB300"
//      magnitudeLabel.color: "#FFD54f"
//      unitsLabel.color: "#FFA000"

        slider.from: 3
        slider.to: 40000
        slider.value: 40000
        sliderBackgroundInactive.color: "#FFFFFF" //"#B2EBF2"


        fixButtonLabel_1.text: "111"
        fixButtonLabel_2.text: "222"
        fixButtonLabel_3.text: "333"
        fixButtonLabel_4.text: "444"
        fixButtonLabel_5.text: "555"
        mainImage.source: "Images/ic_schedule_white_48dp.png"
        //        Behavior on opacity{
        //            NumberAnimation { duration: 1000 }
        //        }

    }

    Input_04{
        id: inputTime2
        x: firstInputX + (inputWidth + inputMargins) * 3
        y:25
        fullViewX: fullViewInputX
        fullViewY: 230

        width: 240
        fullViewWidth: 1000

        unitsLabel.text: "ug/Nml"
//        magnitudeLabel.color: "#FFD54f"
//        unitsLabel.color: "#FFA000"
        magnitudeLabel.color: "#DCE775"
        unitsLabel.color: "#AFB42B"

        magnitudeLabel2.color: "#CE93D6"
        unitsLabel2.color: "#AB47BC"

        slider.from: 3
        slider.to: 9999
        slider.value: 100
        sliderBackgroundInactive.color: "#FFFFFF" //"#B2EBF2"


        fixButtonLabel_1.text: "111"
        fixButtonLabel_2.text: "222"
        fixButtonLabel_3.text: "333"
        fixButtonLabel_4.text: "444"
        fixButtonLabel_5.text: "555"
        mainImage.source: "Images/ic_schedule_white_48dp.png"

        doubleLabelVisible: true
        convertToTimeFlow: 30
//        Behavior on opacity{
//            NumberAnimation { duration: 1000 }
//        }

    }
/*
    //  Shadows
    readonly property int shadowSamples: 17
    readonly property int shadowRadius: 8
    readonly property int shadowButtonHorizontalOffset: 3
    readonly property int shadowButtonVerticalOffset: 3
    readonly property string shadowColor: "#70000000"

    DropShadow {
        id: inputO3Shadow
        anchors.fill: inputO3
        horizontalOffset: shadowButtonHorizontalOffset
        verticalOffset: shadowButtonVerticalOffset
        radius: shadowRadius
        samples: shadowSamples
        color: shadowColor
        source: inputO3
        visible: true
    }
*/
}
