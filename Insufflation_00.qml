// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4


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

    }

    Rectangle{
        id: rectangle
        x:200
        y:250
        width: 800
        height: 100
        color: "#333333"
        radius: 3

        Label{
            x:0
            y:0
            width:150
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "ug"
            font.pixelSize: 60
            color:inputO3.unitsLabel.color
        }
        Label{
            width:150
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "125"
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.pixelSize: 60
            color:inputO3.magnitudeLabel.color
        }
        ProgressBar{
            id: progressTool
            width: parent.width * 0.6

            height: parent.height * 0.50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            value: 0.40
            orientation: Qt.Horizontal

            style: ProgressBarStyle {
                background: Rectangle {
                    radius: 3
                    color: inputO3.magnitudeLabel.color
                }
                progress: Rectangle {
                    color: inputO3.unitsLabel.color
                }
            }
        }
    }

    Rectangle{
        x:200
        y:375
        width: 800
        height: 100
        color: "#333333"
        radius: 3

        Label{
            x:0
            y:0
            width:150
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "ml"
            font.pixelSize: 60
            color:inputFlow.unitsLabel.color
        }
        Label{
            width:150
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "659"
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.pixelSize: 60
            color:inputFlow.magnitudeLabel.color
        }
        ProgressBar{
            width: parent.width * 0.6

            height: parent.height * 0.50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            value: 0.40
            orientation: Qt.Horizontal

            style: ProgressBarStyle {
                background: Rectangle {
                    radius: 3
                    color: inputFlow.magnitudeLabel.color
                }
                progress: Rectangle {
                    color: inputFlow.unitsLabel.color
                }
            }
        }
    }

    Rectangle{
        x:200
        y:500
        width: 800
        height: 100
        color: "#333333"
        radius: 3

        Label{
            x:0
            y:0
            width:150
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "min"
            font.pixelSize: 60
            color:inputTime.unitsLabel.color
        }
        Label{
            width:150
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "56"
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.pixelSize: 60
            color:inputTime.magnitudeLabel.color
        }
        ProgressBar{
            width: parent.width * 0.6

            height: parent.height * 0.50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            value: 0.40
            orientation: Qt.Horizontal

            style: ProgressBarStyle {
                background: Rectangle {
                    radius: 3
                    color: inputTime.magnitudeLabel.color
                }
                progress: Rectangle {
                    color: inputTime.unitsLabel.color
                }
            }
        }
    }
    Rectangle{
        x:200
        y:625
        width: 800
        height: 100
        color: "#333333"
        radius: 3

        Label{
            x:0
            y:0
            width:150
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "ml"
            font.pixelSize: 60
            color:inputTime2.unitsLabel.color
        }
        Label{
            width:150
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "25"
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.pixelSize: 60
            color:inputTime2.magnitudeLabel.color
        }
        ProgressBar{
            width: parent.width * 0.6

            height: parent.height * 0.50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            value: 0.40
            orientation: Qt.Horizontal

            style: ProgressBarStyle {
                background: Rectangle {
                    radius: 3
                    color: inputTime2.magnitudeLabel.color
                }
                progress: Rectangle {
                    color: inputTime2.unitsLabel.color
                }
            }
        }
    }

}
