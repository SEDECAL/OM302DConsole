// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle{
    id: tTest
    color: "green"// "#333333"

    property int enlargeTime: 300

    anchors.top: reducedViewTransitionDestiny.top
    anchors.bottom: reducedViewTransitionDestiny.bottom
    anchors.left: reducedViewTransitionDestiny.left
    anchors.right: reducedViewTransitionDestiny.right
    visible: true
    state: "small"

    states:[
        State{
            name: "big"
            AnchorChanges { target: tTest; anchors.top: fullViewTransitionDestiny.top }
            AnchorChanges { target: tTest; anchors.bottom: fullViewTransitionDestiny.bottom }
            AnchorChanges { target: tTest; anchors.left: fullViewTransitionDestiny.left }
            AnchorChanges { target: tTest; anchors.right: fullViewTransitionDestiny.right }
        },
        State{
            name: "small"
            AnchorChanges { target: tTest; anchors.top: reducedViewTransitionDestiny.top }
            AnchorChanges { target: tTest; anchors.bottom: reducedViewTransitionDestiny.bottom }
            AnchorChanges { target: tTest; anchors.left: reducedViewTransitionDestiny.left }
            AnchorChanges { target: tTest; anchors.right: reducedViewTransitionDestiny.right }
        }
    ]

    transitions:[
        Transition {
            to: "big"
            AnchorAnimation {duration: enlargeTime}
//          ScriptAction{script: console.log("iewSyringeCalculator transition")}
        },
        Transition {
            to: "small"
            AnchorAnimation {duration: enlargeTime}
//          ScriptAction{script: console.log("noViewSyringeCalculatorTest transition")}
        }
    ]



}
