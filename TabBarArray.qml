// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import "Constants.js" as Constants

Item {
    id: tabArray
    anchors.fill: parent

    property bool row_1_visible: false
    property bool row_2_visible: false
    property bool row_3_visible: false
    property bool row_4_visible: false
    property bool row_5_visible: false
    property bool row_6_visible: false

    states: [
        State {
            name: "showSubmenu_1"
            PropertyChanges { target: tabBar_1; visible: true }
            PropertyChanges { target: tabBar_2; visible: true }
            PropertyChanges { target: tabBar_3; visible: true }
            PropertyChanges { target: tabArray; row_1_visible: true}
        },
        State {
            name: "showSubmenu_2"
            PropertyChanges { target: tabBar_1; visible: true }
            PropertyChanges { target: tabBar_2; visible: true }
            PropertyChanges { target: tabBar_3; visible: true }
            PropertyChanges { target: tabArray; row_2_visible: true}
        },
        State {
            name: "showSubmenu_3"
            PropertyChanges { target: tabBar_1; visible: true }
            PropertyChanges { target: tabBar_2; visible: true }
            PropertyChanges { target: tabBar_3; visible: true }
            PropertyChanges { target: tabArray; row_3_visible: true}
        },
        State {
            name: "showSubmenu_4"
            PropertyChanges { target: tabBar_1; visible: true }
            PropertyChanges { target: tabBar_2; visible: true }
            PropertyChanges { target: tabBar_3; visible: true }
            PropertyChanges { target: tabArray; row_4_visible: true}
        },
        State {
            name: "showSubmenu_5"
            PropertyChanges { target: tabBar_1; visible: true }
            PropertyChanges { target: tabBar_2; visible: true }
            PropertyChanges { target: tabBar_3; visible: true }
            PropertyChanges { target: tabArray; row_5_visible: true}
        },
        State {
            name: "showSubmenu_6"
            PropertyChanges { target: tabBar_1; visible: true }
            PropertyChanges { target: tabBar_2; visible: true }
            PropertyChanges { target: tabBar_3; visible: true }
            PropertyChanges { target: tabArray; row_6_visible: true}
        },
        State {
            name: "hideSubmenu"
//            PropertyChanges { target: tabBar_1; visible: false }
//            PropertyChanges { target: tabBar_2; visible: false }
//            PropertyChanges { target: tabBar_3; visible: false }
        }
    ]

    transitions: [
        Transition {
            to: "showSubmenu_2"
//            PropertyAnimation { target: tabArray; property: "row_2_visible"; to: true }
            NumberAnimation { target: tabBar_1; property: "anchors.rightMargin"; to: tabBar_1.width - tabBar_1.marginBetweenButtons; duration: 300}
            NumberAnimation { target: tabBar_2; property: "anchors.rightMargin"; to: 2 * (tabBar_1.width - tabBar_1.marginBetweenButtons); duration: 300}
            NumberAnimation { target: tabBar_3; property: "anchors.rightMargin"; to: 3 * (tabBar_1.width - tabBar_1.marginBetweenButtons); duration: 300}
        },
        Transition {
            to: "hideSubmenu"
            NumberAnimation { target: tabBar_1; property: "anchors.rightMargin"; to: 0; duration: 300}
            NumberAnimation { target: tabBar_2; property: "anchors.rightMargin"; to: 0; duration: 300}
            NumberAnimation { target: tabBar_3; property: "anchors.rightMargin"; to: 0; duration: 300}
        }
    ]


    state: "hideSubmenu"

    TabBar_04{
        id: extensionIndicator
        z: 1
        anchors.rightMargin: 10
        button1.visible: false
        button2.visible: true
        button3.visible: true
        button4.visible: false
        button5.visible: true
        button6.visible: false
        opacity: 1
    }
    TabBar_04{
        id: tabBar_1
        z: 1
        anchors.rightMargin: tabBar_1.width - tabBar_1.marginBetweenButtons
        button1.visible: false & row_1_visible
        button2.visible: true  & row_2_visible
        button3.visible: true  & row_3_visible
        button4.visible: false & row_4_visible
        button5.visible: true  & row_5_visible
        button6.visible: false & row_6_visible
        tabBarId: 1
        opacity: 1
    }
    TabBar_04{
        id: tabBar_2
        z: 1
        anchors.rightMargin: 2 *( tabBar_1.width -  tabBar_1.marginBetweenButtons)
        button1.visible: false & row_1_visible
        button2.visible: true  & row_2_visible
        button3.visible: true  & row_3_visible
        button4.visible: false & row_4_visible
        button5.visible: true  & row_5_visible
        button6.visible: false & row_6_visible
        tabBarId: 2
        opacity: 1
    }
    TabBar_04{
        id: tabBar_3
        z: 1
        anchors.rightMargin: 3 *( tabBar_1.width -  tabBar_1.marginBetweenButtons)
        button1.visible: false & row_1_visible
        button2.visible: false & row_2_visible
        button3.visible: true  & row_3_visible
        button4.visible: false & row_4_visible
        button5.visible: true  & row_5_visible
        button6.visible: false & row_6_visible
        tabBarId: 3
        opacity: 1
    }
}
