// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

// TabBar_02.qml (19/03/2018): Upgrade to TabButtom_01.

Rectangle{
    id: toolBar

    readonly property int toolBarWidth: parent.height / 6
    property var lastButtomClicked: fakeButton

    property string buttonColor_1: "lightgreen"
    property string buttonColor_2: "lightsalmon"
    property string buttonColor_3: "lightblue"
    property string buttonColor_4: "lightseagreen"
    property string buttonColor_5: "khaki"
    property string buttonColor_6: "lightslategrey"

    function tabButtonPressed(buttonCode) {
//      console.log("clicked:", buttonCode)
        lastButtomClicked.state = "unpressed"
        lastButtomClicked = buttonCode

        if (buttonCode === button6){
            appToolBar.helpButton.state = "iconPositionShifted"
        }
        else{
            appToolBar.helpButton.state = "iconPositionOriginal"
        }
    }

    visible: true
    width: toolBarWidth
    height: parent.height
    color: "#00000000"
    anchors.right: parent.right

    TabButton_01{
        id: fakeButton
        visible: false
    }
    TabButton_01{
        id: button1
        tabButton.color: buttonColor_1
        tabButtonImage.source: "/Images/JERINGA 02_white.png"
        onClicked:{
            continuousStackTherapy.init()
            therapiesStatck.pop()
            therapiesStatck.push(continuousStackItem)
        }
    }
    TabButton_01{
        id: button2
        tabButton.color: buttonColor_2
        anchors.top: button1.bottom
        tabButtonImage.source: "/Images/OZONO CONTINUO 02 192x192.png"
        onClicked:{
            insufflationStackTherapy.init()
            therapiesStatck.pop()
            therapiesStatck.push(insufflationStackItem)
        }
    }
    TabButton_01{
        id: button3
        tabButton.color: buttonColor_3
        anchors.top: button2.bottom
//      tabButtonImage.source: "/Images/OZONO CONTINUO 01.png"
        tabButtonImage.source: "/Images/BOLSA 01.png"
        onClicked:{
            doseStackTherapy.init()
            therapiesStatck.pop()
            therapiesStatck.push(doseStackItem)
        }
    }
    TabButton_01{
        id: button4
        tabButton.color: buttonColor_4
        anchors.top: button3.bottom
        tabButtonImage.source: "/Images/DOSIS 01.png"
        onClicked:{
            bagStackTherapy.init()
            therapiesStatck.pop()
            therapiesStatck.push(bagStackItem)
        }
    }
    TabButton_01{
        id: button5
        tabButton.color: buttonColor_5
        anchors.top: button4.bottom
        tabButtonImage.source: "/Images/INSUFLACION 01.png"
        onClicked:{
            syringeStackTherapy.init()
            therapiesStatck.pop()
            therapiesStatck.push(syringeStackItem)
        }
    }
    TabButton_01{
        id: button6
        tabButton.color: buttonColor_6
        anchors.top: button5.bottom
        tabButtonImage.source: "/Images/VACIO 01.png"

    }
}
