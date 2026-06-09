// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

pragma Singleton
import QtQuick 2.7

QtObject {
    readonly property int screenWidth: 1280 //* 0.87
    readonly property int screenHeight: 800 //* 0.87

    readonly property int magnitudeSelectorY: screenWidth * 0.025
    readonly property int magnitudeSelectorWidth: screenWidth * 0.896
    readonly property int magnitudeSelectorHeight: screenWidth * 0.14
    readonly property int magnitudeSelectorRowSpacing: screenWidth * 0.0179

    readonly property int inputElementWidth: screenWidth * 0.188 //magnitudeSelectorWidth * 0.21
    readonly property int fullViewInputElementWith: screenWidth * 0.72 //magnitudeSelectorItem.width * 0.80//0.877
    readonly property int fullViewInputElementY: screenWidth * 0.143 //magnitudeSelectorItem.width * 0.160//0.201
    readonly property int fullViewInputElementX: (magnitudeSelectorWidth - fullViewInputElementWith) * 0.5

    readonly property double fullViewInputElementAspectRatio: 0.47


}
