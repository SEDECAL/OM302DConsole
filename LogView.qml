// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle {
    id: scrollableBox
    clip: true
    color: "black"
    border.color: "#b55a01"

    property alias text: content.text // expose text element for external acess

    Text {
        id: content
        color: "#027421"
        font.pointSize: 10
        anchors.left: scrollableBox.left
        anchors.right: scrollableBox.right
        leftPadding: 5
        rightPadding: 12
        topPadding: 3
        bottomPadding: 3
        wrapMode: Text.WrapAnywhere
    }

    ScrollBar {
        id: verticalBar
        hoverEnabled: true
        active: hovered || pressed  // just visible when hovered or pressed
        orientation: Qt.Vertical // Vertical
//      size: scrollableBox.height / content.implicitHeight // Set Size using implicitHeight of text
        size: scrollableBox.height / (content.implicitHeight * 2) // Set Size using implicitHeight of text
        width: parent.width * 0.02
        anchors.top: scrollableBox.top
        anchors.right: scrollableBox.right
        anchors.bottom: scrollableBox.bottom
        onPositionChanged: {content.y = -position * content.implicitHeight} // get new position from ScrollBar because ImplicitHeight is not setted in content Inicialization
    }
    MouseArea{
        height: parent.height
        width: parent.width - (2 * verticalBar.width)

        onPressAndHold: {
            if(content.visible){
                content.visible = false
                verticalBar.visible = false
                scrollableBox.color = "transparent"
                scrollableBox.border.color = "transparent"
            }else{
                content.visible = true
                verticalBar.visible = true
                scrollableBox.color = "black"
                scrollableBox.border.color = "#b55a01"
            }
        }
    }
}
