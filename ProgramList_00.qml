// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0

Item{
    id: programListItem

    property int programHeight: 50

    states:[
        State{
            id: viewProgramList
        },
        State{
            id: noViewProgramList
        }
    ]
    transitions:[
        Transition {
            to: "viewProgramList"
            SequentialAnimation{
//              PropertyAnimation { target: programListItem; property: "color"; to: programListItem.color; duration: 200} // just delay
                PropertyAnimation { target: programListItem; property: "opacity"; to: 1; duration: 200}
            }
        },
        Transition {
            to: "noViewProgramList"
            PropertyAnimation { target: programListItem; property: "opacity"; to: 0; duration: 200}
        }
    ]


    Column{
        spacing:15
        width: parent.width

        Program_00{
            height: programHeight
            width: parent.width
            numberLabel.text: "1"
        }
        Program_00{
            height: programHeight
            width: parent.width
            numberLabel.text: "2"
        }
        Program_00{
            height: programHeight
            width: parent.width
            numberLabel.text: "3"
        }
//      Program_00{
//          height: 50
//          width: parent.width
//          numberLabel.text: "4"
//      }
//      Program_00{
//          height: 50
//          width: parent.width
//          numberLabel.text: "5"
//      }
    }
}
