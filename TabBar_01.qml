// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0


Rectangle{
    id: toolBar

  //  property alias toolBar: toolBar
/*   property alias button1: button1
    property alias button2: button2
    property alias button3: button3
    property alias button4: button4
    property alias button5: button5
    property alias button6: button6
*/
    readonly property int toolBarWidth: parent.height / 6
    readonly property int selectedButtonWidth: toolBarWidth * 1.30
    property var lastButtomClicked: fakeButton

    property string buttonColor_1: "lightgreen"
    property string buttonColor_2: "lightsalmon"
    property string buttonColor_3: "lightblue"
    property string buttonColor_4: "lightseagreen"
    property string buttonColor_5: "khaki"
    property string buttonColor_6: "lightslategrey"
/*
    function tabButtonPressed(buttonCode) {
        console.log("clicked:", buttonCode)

        lastButtomClicked.width = toolBar.width
        lastButtomClicked.tabButtonTopShadow.visible = false
        lastButtomClicked.tabButtonBottomShadow.visible = false
        lastButtomClicked.tabButtonImageShadow.visible = false
        lastButtomClicked.z = 0
        lastButtomClicked.tabButtonButton.enabled = true
        lastButtomClicked = buttonCode
        buttonCode.width = selectedButtonWidth
    }
*/
    function tabButtonPressed(buttonCode) {
        console.log("clicked:", buttonCode)

        lastButtomClicked.state = "unpressed"
        lastButtomClicked = buttonCode
    }

    visible: true
    width: toolBarWidth
    height: parent.height
    color: "#00000000"
    anchors.right: parent.right

    TabButton_00{
        id: fakeButton
        visible: false
    }
    TabButton_01{
        id: button1
        tabButton.color: buttonColor_1
        tabButtonImage.source: "/Images/JERINGA 02_white.png"
        page: 0
//      onClicked:{ stackView.push({item:"Continuous_00.qml", immediate: true, replace: true}) }
        onClicked:{
            continuousStackTherapy.init()
            therapiesStatck.pop()
            therapiesStatck.push(continuousStackItem)
        }
    }
/*    TabButton_00{
        id: button1
        tabButton.color: buttonColor_1
        tabButtonImage.source: "/Images/JERINGA 02_white.png"
        page: 0
//      onClicked:{ stackView.push({item:"Continuous_00.qml", immediate: true, replace: true}) }
        onClicked:{
            continuousStackTherapy.init()
            therapiesStatck.pop()
            therapiesStatck.push(continuousStackItem)
        }
    }*/
    TabButton_01{
        id: button2
        tabButton.color: buttonColor_2
        anchors.top: button1.bottom
        tabButtonImage.source: "/Images/OZONO CONTINUO 02 192x192.png"
        page: 1
        onClicked:{
            insufflationStackTherapy.init()
            therapiesStatck.pop()
            therapiesStatck.push(insufflationStackItem)
        }
    }
    TabButton_00{
        id: button3
        tabButton.color: buttonColor_3
        anchors.top: button2.bottom
        tabButtonImage.source: "/Images/OZONO CONTINUO 01.png"
//      tabButtonImage.source: "/Images/BOLSA 01.png"
        page: 2
    }
    TabButton_00{
        id: button4
        tabButton.color: buttonColor_4
        anchors.top: button3.bottom
        tabButtonImage.source: "/Images/DOSIS 01.png"
        page: 3
    }
    TabButton_00{
        id: button5
        tabButton.color: buttonColor_5
        anchors.top: button4.bottom
        tabButtonImage.source: "/Images/INSUFLACION 01.png"
        page: 4
    }
    TabButton_00{
        id: button6
        tabButton.color: buttonColor_6
        anchors.top: button5.bottom
        tabButtonImage.source: "/Images/VACIO 01.png"
        page: 5
    }
}
