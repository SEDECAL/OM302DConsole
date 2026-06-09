// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12

import "storage.js" as Storage
import "Constants.js" as Constants

Rectangle{
    property alias dcIconGif: dcIconGif

    width: height
    color: Storage.getAppDB(Constants.dbAppColor.dcImagePanelId, "black")

    AnimatedImage {
        id: dcIconGif
        anchors.centerIn: parent
        width: parent.width * 0.85
        height: parent.height * 0.85
        source: visible ? Storage.getAppDB(Constants.dbAppIcon.dcGifId, "") : "" //12/2021
//      playing: false
//      onVisibleChanged: dcIconGif.currentFrame = 0
    }
}
