// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12

import "DebugConstants.js" as DC
import "storage.js" as Storage
import "Constants.js" as  Constants

Rectangle{
    id: brandName

    property alias businessName: businessName

    property double runModeX
    property double adjustingModeX
    property double saveScreenModeX

    property int saveScreenModeChangesInterval: 600

    property string textColor: Storage.getAppDB(Constants.dbAppColor.brandNameTextId, "black")
    property string saveScreenDeviceTextColor: Storage.getAppDB(Constants.dbAppColor.brandNameSaveScreenDeviceId, "black")
    property string saveScreenCompanyTextColor: Storage.getAppDB(Constants.dbAppColor.brandNameSaveScreenCompanyId, "black")
    property string saveScreenBusinessTextColor: Storage.getAppDB(Constants.dbAppColor.brandNameSaveScreenBusinessId, "black")

    property bool viewGrid: false

    states: [
        State {
            name: "adjustingMode"
            PropertyChanges { target: businessName; color: textColor }
        },
        State {
            name: "saveScreenMode"
            PropertyChanges { target: businessName; color: saveScreenBusinessTextColor }
        },
        State {
            name: "runMode"
            PropertyChanges { target: businessName; color: textColor }
        }
    ]
    transitions: [
        Transition {
            to: "adjustingMode"
            PropertyAnimation { target: brandName; property: "x"; to: adjustingModeX; duration: saveScreenModeChangesInterval }
        },
        Transition {
            to: "runMode"
            PropertyAnimation { target: brandName; property: "x"; to: runModeX; duration: saveScreenModeChangesInterval }
        },
        Transition {
            to: "saveScreenMode"
            PropertyAnimation { target: brandName; property: "x"; to: saveScreenModeX; duration: saveScreenModeChangesInterval }
        }
    ]

    color: "transparent"
    state: "saveScreenMode"

    Text{
        id: businessName
        text: Storage.getLanguageDB(Constants.dbLanguageTextId + applicationWindow.selectedLanguageId + "33", "")
        font.family: "Helvetica"
        font.pointSize: parent.height * 0.81//120
        color: saveScreenBusinessTextColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent
        fontSizeMode: Text.Fit

        onTextChanged: {
            if(businessName.text.length > 60){
                businessName.text = businessName.text.substring(0, 60)
            }
        }

        Rectangle{
            anchors.fill:parent
            color: "transparent"
            border.color: "orange"
            visible: viewGrid
        }
    }
}

