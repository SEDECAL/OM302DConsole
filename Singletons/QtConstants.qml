// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

pragma Singleton
import QtQuick 2.12//2.9

QtObject {
    readonly property int screenWidth: 1280 //* 0.87
    readonly property int screenHeight: 800 //* 0.87

    readonly property int tabBarNumberOfButtons: 7
    readonly property int tabBarMarginBetweenButtons: 4
    readonly property int tabBarWidth: (screenHeight - tabBarMarginBetweenButtons) / tabBarNumberOfButtons

    readonly property int magnitudeSelectorY: screenWidth * 0.025
    readonly property int magnitudeSelectorWidth: screenWidth - tabBarWidth
    readonly property int magnitudeSelectorHeight: screenWidth * 0.14
    readonly property int magnitudeSelectorRowSpacing: screenWidth * 0.0179

    readonly property int inputElementWidth: screenWidth * 0.188 //magnitudeSelectorWidth * 0.21
    readonly property int fullViewInputElementWith: screenWidth * 0.72 //magnitudeSelectorItem.width * 0.80//0.877
    readonly property int fullViewInputElementY: screenWidth * 0.143 //magnitudeSelectorItem.width * 0.160//0.201
    readonly property int fullViewInputElementX: (magnitudeSelectorWidth - fullViewInputElementWith) * 0.5

    readonly property double serviceWindowPopUpWidth: Math.round(screenWidth * 0.664)
    readonly property double serviceWindowPopUpHeight: serviceWindowPopUpWidth * 0.6

    readonly property double fullViewInputElementAspectRatio: 0.47


//    readonly property int slowRequestDataTime: 2000
//    readonly property int quickRequestDataTime: 400
}


// import "Singletons"
// QtConstants.
