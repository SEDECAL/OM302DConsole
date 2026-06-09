// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12

import "Therapies.js" as Therapies
import "storage.js" as Storage
import "Constants.js" as Constants
import "Singletons"

Rectangle {
    id: gadgetInOutEffectId

    property int enlargeTime: 250
    property int fullViewX: QtConstants.fullViewInputElementX
    property int fullViewY: QtConstants.fullViewInputElementY + QtConstants.magnitudeSelectorY
    property int fullViewWidth: QtConstants.fullViewInputElementWith
    property int fullViewHeight: QtConstants.fullViewInputElementWith * QtConstants.fullViewInputElementAspectRatio
    property int reducedViewX: 0
    property int reducedViewY: 0

    states:[
        State{
            name: "gadgetVisible"
            PropertyChanges { target: gadgetInOutEffectId; visible: true }
        },
        State{
            name: "noGadgetVisible"
        },
        State{
            name: "noGadgetVisibleQuick"
            PropertyChanges { target: gadgetInOutEffectId; width: 0 }
            PropertyChanges { target: gadgetInOutEffectId; height: 0 }
            PropertyChanges { target: gadgetInOutEffectId; visible: false }
        }
    ]

    transitions:[
        Transition {
            to: "gadgetVisible"
            SequentialAnimation{
                ParallelAnimation{
                    PropertyAnimation { target: gadgetInOutEffectId; property: "x";      to: fullViewX; duration: enlargeTime}//; easing.type: Easing.OutCubic}
                    PropertyAnimation { target: gadgetInOutEffectId; property: "y";      to: fullViewY; duration: enlargeTime}//; easing.type: Easing.OutCubic}
                    PropertyAnimation { target: gadgetInOutEffectId; property: "width";  to: fullViewWidth; duration: enlargeTime}//; easing.type: Easing.OutCubic}
                    PropertyAnimation { target: gadgetInOutEffectId; property: "height"; to: fullViewHeight; duration: enlargeTime}//; easing.type: Easing.OutCubic}
                }
                ScriptAction { script: {Therapies.completeGadgetOpenEffect()} }
            }
        },
        Transition {
            to: "noGadgetVisible"
            SequentialAnimation{
                ParallelAnimation{
                    PropertyAnimation { target: gadgetInOutEffectId; property: "x";      to: reducedViewX; duration: enlargeTime}//; easing.type: Easing.OutCubic}
                    PropertyAnimation { target: gadgetInOutEffectId; property: "y";      to: reducedViewY; duration: enlargeTime}//; easing.type: Easing.OutCubic}
                    PropertyAnimation { target: gadgetInOutEffectId; property: "width";  to: 0; duration: enlargeTime}//; easing.type: Easing.OutCubic}
                    PropertyAnimation { target: gadgetInOutEffectId; property: "height"; to: 0; duration: enlargeTime}//; easing.type: Easing.OutCubic}
                }
                PropertyAnimation { target: gadgetInOutEffectId; property: "visible"; to: false}//; easing.type: Easing.OutCubic}
            }
        }
    ]

    state: "noGadgetVisible"
    radius: fullViewWidth * 0.006
    color: Storage.getAppDB(Constants.dbAppColor.gadgetInOutEffectId, "black")
}
