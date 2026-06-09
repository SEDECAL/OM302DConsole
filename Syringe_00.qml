// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4


Item {
    //property alias insufflationTherapy: insufflationTherapy

    property int inputMargins: 30
    property int inputWidth: 240
    property int inputNumber: 4
    property int firstInputX: (1280 - (133) - ((inputNumber - 1) * inputMargins) - (inputNumber * inputWidth)) / 2
    property int fullViewInputX: (1280 - (133) - 1000) / 2
    property alias progress1: progress1
    property alias progress2: progress2
    property alias progress3: progress3
    property alias progress4: progress4


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
            PropertyChanges { target: inputO3; opacity: 0.2 }
            PropertyChanges { target: inputFlow; opacity: 0.2 }
            PropertyChanges { target: inputTime; opacity: 0.2 }
            PropertyChanges { target: inputTime2; opacity: 0.2 }
        }
    ]

    id: syringeTherapy
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

    }



    Rectangle{
        id: rectangle
        x: 300
        y: 25
        height: 470
        width: 750
        color: "#00000000"
        anchors.bottom: parent.bottom
      anchors.bottomMargin: 480
      //       color: "#333333"
        visible: true

    }


    Rectangle{
        x:row.x+progress1.x
        y: row.y-100
        width: 150
        height: 100
        color: "#333333"
        Label{
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: inputO3.magnitudeLabel.color
            text: "ug"
            font.pixelSize: 60
        }
    }
    Rectangle{
        x:row.x+progress2.x
        y: row.y-100
        width: 150
        height: 100
        color: "#333333"
        Label{
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: inputFlow.magnitudeLabel.color
            text: "ml"
            font.pixelSize: 60
        }
    }
    Rectangle{
        x:row.x+progress3.x
        y: row.y-100
        width: 150
        height: 100
        color: "#333333"
        Label{
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: inputTime.magnitudeLabel.color
            text: "min"
            font.pixelSize: 60
        }
    }
    Rectangle{
        x:row.x+progress4.x
        y: row.y-100
        width: 150
        height: 100
        color: "#333333"
        Label{
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: inputTime2.magnitudeLabel.color
            text: "ug"
            font.pixelSize: 60
        }
    }


    Row{
        id: row
        width: 900
        height: 300

        spacing: 30

        x:225
        y:330

    Rectangle{
        id: progress1
        width: 150
        height: 300
//        x: 300
//        y: 125
        color: "#333333"
        Progress_00{

            height: parent.height
            width: parent.width
            radius: parent.radius
            anchors.fill: parent
            progressLabel.color: inputO3.magnitudeLabel.color
            progressLabel.text: "400"
            progressLabel.font.pixelSize: inputO3.magnitudeLabelFontSize_reducedView
            backgroundColor: inputO3.magnitudeLabel.color
            progressColor: inputO3.unitsLabel.color
            progressLabel.opacity: 1
            progressTool.opacity: 1
            progressRectangle.height: parent.height
        }
    }
    Rectangle{
        id: progress2
        width: 150
        height: 300
  //      x: 500
   //     y: 125
        color: "#333333"
        Progress_00{

            height: parent.height
            width: parent.width
            radius: parent.radius
            anchors.fill: parent
            progressLabel.color: inputFlow.magnitudeLabel.color
            progressLabel.text: "300"
            progressLabel.font.pixelSize: inputFlow.magnitudeLabelFontSize_reducedView
            backgroundColor: inputFlow.magnitudeLabel.color
            progressColor: inputFlow.unitsLabel.color
            progressLabel.opacity: 1
            progressTool.opacity: 1
            progressRectangle.height: parent.height
        }
    }

    Rectangle{
        id: progress3
        width: 150
        height: 300
//        x: 700
  //      y: 125
        color: "#333333"
        Progress_00{

            height: parent.height
            width: parent.width
            radius: parent.radius
            anchors.fill: parent
            progressLabel.color: inputTime.magnitudeLabel.color
            progressLabel.text: "20"
            progressLabel.font.pixelSize: inputTime.magnitudeLabelFontSize_reducedView
            backgroundColor: inputTime.magnitudeLabel.color
            progressColor: inputTime.unitsLabel.color
            progressLabel.opacity: 1
            progressTool.opacity: 1
            progressRectangle.height: parent.height
        }
    }

    Rectangle{
        id: progress4
        width: 150
        height: 300
//        x: 900
    //    y: 125
        color: "#333333"

        Progress_00{

            height: parent.height
            width: parent.width
            radius: parent.radius
            anchors.fill: parent
            progressLabel.color: inputTime2.magnitudeLabel.color
            progressLabel.text: "723"
            progressLabel.font.pixelSize: inputTime2.magnitudeLabelFontSize_reducedView
            backgroundColor: inputTime2.magnitudeLabel.color
            progressColor: inputTime2.unitsLabel.color
            progressLabel.opacity: 1
            progressTool.opacity: 1
            progressRectangle.height: parent.height
        }
    }
}
    Rectangle{
        width: 50
        height: 750
        x: 550
        y: 320
        color: "#333333"
        rotation:90
        Progress_00{

            progressTool.width: 20
            height: parent.height
            width: parent.width
            radius: parent.radius
            anchors.fill: parent
            progressLabel.rotation: -90
            progressLabel.color: inputTime2.magnitudeLabel.color
            progressLabel.text: "723"
            progressLabel.font.pixelSize: 50//inputTime2.magnitudeLabelFontSize_reducedView
            backgroundColor: inputTime2.magnitudeLabel.color
            progressColor: inputTime2.unitsLabel.color
            progressLabel.opacity: 1
            progressTool.opacity: 1
            progressRectangle.height: parent.height
        }
    }

}
