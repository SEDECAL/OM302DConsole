// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.1

import "Constants.js" as Constants
import "DebugConstants.js" as DC

Rectangle{
    id: memoryViewArea
    //    height: memoryBoard.height / 6
    //    width: memoryBoard.width - (2 * (height + (2 * elemetSpacing)))
    //    radius: buttonRadius
    //    color: backColor

    property int itemsSpacing: 1
    property int itemsNumber: 16
    property int visibleItemsNumber: 1
//  property variant info:[ "3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i"]
    property bool vis0: true
    property bool vis1: true
    property bool vis2: true
    function memoryItemsSelection(){
        memoryRepeater.itemAt(3).visible = false
        console.log("dentro000000000000000000000000000000000000000000000000000")
        //        updateMemoryItemsWidth()
       // visibleItemsNumber = 12
    }

    Row{
        id: memoryRow
        spacing: itemsSpacing
        Repeater{
            id: memoryRepeater
            model: itemsNumber
            Text {
                id: memoryLabel
//                text:  index
                text:  info[index]

                visible:{
                    if(index === 0){vis0}
                    else if(index === 1){vis1}
                    else if(index === 2){vis2}
                    else {true}
                }

                height: memoryViewArea.height
//              width: (memoryViewArea.width - ( (visibleItemsNumber + 1) * itemsSpacing)) / visibleItemsNumber
                width: 25
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "pink"
                }
            }
        }
    }
    //   onOpacityChanged: updateMemoryItemsWidth()

}


//Rectangle{
//    id: memoryItemFrame

//    property int itemsSpacing: 1
//    property alias memoryItemListModel:memoryItemListModel
//    property alias memoryItemList:memoryItemList

//    ListModel {
//        id: memoryItemListModel

//        ListElement {
//            name: "Apple"
//            cost: 2.45
//        }
//        ListElement {
//            name: "Orange"
//            cost: 3.25
//        }
//        ListElement {
//            name: "Orange"
//            cost: 3.25
//        }
//        Component.onCompleted: {
//            memoryItemListModel.append({"name": "sss", "cost": 3})
//            memoryItemListModel.remove(1)
//        }
//    }
//    ListModel {
//        id: memoryItemListModel2

//        ListElement {
//            name: "Orange"
//            cost: 3.25
//        }
//        ListElement {
//            name: "Orange"
//            cost: 3.25
//        }
//    }

//    Component {
//        id: memoryItemDelegate
//        Rectangle{
//            id: memoryIcon
//            height: memoryItemFrame.height
//            width: (memoryItemFrame.width - (itemsSpacing * (memoryItemListModel.count + 1))) / memoryItemListModel.count
//            color: "transparent"
//            border.color: "orange"
//        }
//    }

//    ListView {
//        id: memoryItemList
////      anchors.fill: parent
//        height: parent.height
//        width: parent.width - itemsSpacing
//        anchors.left: parent.left
//        anchors.leftMargin: itemsSpacing
//        model: memoryItemListModel
//        spacing: itemsSpacing
//        orientation: ListView.Horizontal
//        delegate: memoryItemDelegate
//        interactive: false

//    }


//}

