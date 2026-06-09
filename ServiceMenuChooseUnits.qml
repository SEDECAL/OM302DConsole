// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants
import "Singletons"

Rectangle {
    id: serviceMenuShowData

    property alias titleLabel: titleLabel

    property int buttonRadius: 4
    property int buttonHeight: 80
    property int spaceBetweenButtons: 20
    property int radioButtonSelection: 0
    property int radioButtonSize: 40
    property int initialState: 0
    property int currentSelection: 0
    property int currentLanguageSelection: applicationWindow.selectedLanguage
    property int restartTimeOut: 4
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuButtonId, "black")
    property string labelColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")
    property string labelDeselectedColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuDeselectedTextId, "white")

    property bool viewGrid: false

    function changeUnits(){
        var i
        var tmp

        switch (radioButtonSelection){
        case 0:
            tmp = Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsAId, "*")
            Storage.setAppDB(Constants.dbParameter.temperatureId + Constants.unitsId, tmp)
            tmp = Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsAId, "*")
            Storage.setAppDB(Constants.dbParameter.pressureId + Constants.unitsId, tmp)
            tmp = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsAId, "*")
            Storage.setAppDB(Constants.dbParameter.personWeightId + Constants.unitsId, tmp)

            tmp = Storage.getAppDB(Constants.optionId[0] + "_" + Constants.inputPressureSelectorId + "_" + Constants.sliderUnitsAId, "*")
            for (i = 0; i < Constants.optionId.length; i++){
                Storage.setAppDB(Constants.optionId[i] + "_" + Constants.inputPressureSelectorId + "_" + Constants.sliderUnitsId, tmp)
            }
            Storage.saveAppDB()
            break;
        case 1:
            tmp = Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsBId, "*")
            Storage.setAppDB(Constants.dbParameter.temperatureId + Constants.unitsId, tmp)
            tmp = Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsBId, "*")
            Storage.setAppDB(Constants.dbParameter.pressureId + Constants.unitsId, tmp)
            tmp = Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsBId, "*")
            Storage.setAppDB(Constants.dbParameter.personWeightId + Constants.unitsId, tmp)

            tmp = Storage.getAppDB(Constants.optionId[0] + "_" + Constants.inputPressureSelectorId + "_" + Constants.sliderUnitsBId, "*")
            for (i = 0; i < Constants.optionId.length; i++){
                Storage.setAppDB(Constants.optionId[i] + "_" + Constants.inputPressureSelectorId + "_" + Constants.sliderUnitsId, tmp)
            }
            Storage.saveAppDB()
            break;
        }
        Storage.saveAppDB()
    }

    width: QtConstants.serviceWindowPopUpWidth
    height: QtConstants.serviceWindowPopUpHeight
    radius: buttonRadius
    color: Storage.getAppDB(Constants.dbAppColor.serviceMenuChooseUnitsId, "black")

    Label {
        id: titleLabel
        visible: true
        color: "#FFFFFF"
        text: "Tittle"
        height: buttonHeight
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: spaceBetweenButtons
        anchors.leftMargin: spaceBetweenButtons
        anchors.rightMargin: spaceBetweenButtons
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pointSize: buttonHeight * 0.5
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: viewGrid
        }
    }

    Rectangle{
        color: "transparent"
        border.color: "white"
        border.width: 2
        radius: buttonRadius
        anchors.right: cancelButton.left
        anchors.left: parent.left
        anchors.top: titleLabel.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: spaceBetweenButtons
        anchors.rightMargin: spaceBetweenButtons
        anchors.topMargin: spaceBetweenButtons
        anchors.bottomMargin: spaceBetweenButtons

        // units management
        Column {
            anchors.top: parent.top
            anchors.topMargin: spaceBetweenButtons
            anchors.left: parent.left
            anchors.leftMargin: spaceBetweenButtons
            spacing: radioButtonSize * 0.5

            onVisibleChanged:{  // update checked item
                if(visible){
                    if(Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsId, "*") === Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsAId, "*")){
                        unitsRepeaterId.itemAt(0).checked = true
                    }else{
                        unitsRepeaterId.itemAt(1).checked = true
                    }
                }
            }

            Repeater{
                id: unitsRepeaterId
                model: 2
                RadioButton {
                    id: unitsRadioButtonId
                    text: switch (index){
                          case 0: Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsAId, "*") + " - " + Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsAId, "*") + " - " + Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsAId, "*"); break;
                          case 1: Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsBId, "*") + " - " + Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsBId, "*") + " - " + Storage.getAppDB(Constants.dbParameter.personWeightId + Constants.unitsBId, "*"); break;
                          }

                    spacing: radioButtonSize * 0.01

                    checked:{
                        if((index === 0) && (Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsId, "*") === Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsAId, "*"))){
                            true
                        }
                        else if((index === 1) && (Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsId, "*") === Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsBId, "*"))){
                            true
                        }
                        else{
                            false
                        }
                    }

                    indicator: Rectangle {
                        implicitWidth: radioButtonSize
                        implicitHeight: radioButtonSize
                        radius: radioButtonSize * 0.5
                        border.width: radioButtonSize * 0.1
                        border.color: "white"
                        color: "transparent"
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            width: radioButtonSize * 0.83
                            height: width
                            radius: width * 0.5
                            anchors.centerIn: parent
                            color: "white"
                            visible: unitsRadioButtonId.checked
                        }
                    }

                    contentItem: Text {
                        text: unitsRadioButtonId.text
                        font.pixelSize: radioButtonSize * 0.85
                        color: unitsRadioButtonId.checked ? labelColor : labelDeselectedColor
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: unitsRadioButtonId.indicator.width + unitsRadioButtonId.spacing
                        Rectangle{
                            anchors.fill: parent
                            color: "#00000000"
                            border.color: "lightblue"
                            visible: viewGrid
                        }
                    }

                    onCheckedChanged: {
                        if(unitsRadioButtonId.checked) {
                            radioButtonSelection = index
                        }
                        currentSelection = index
                    }
                }
            }
        }

        // language management
        Rectangle{
            id: laguageOptionsId
            height: parent.height
            width: parent.width * 0.5
            color: "transparent"
            border.color: (viewGrid) ? "orange" : "transparent"
            anchors.right: parent.right
            z: parent.z - 1

            Flickable {
                anchors.fill: parent

                contentWidth: languageControlId.width
                contentHeight: languageControlId.height * (1 + (1 / languageRepeaterId.model))
                flickableDirection: Flickable.VerticalFlick
                clip: true

                ScrollBar.vertical: ScrollBar {
                    width: parent.width * 0.04
                    anchors.right: parent.right
                    anchors.rightMargin: width * 0.5
                    policy:(languageControlId.height > parent.height) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
                }

                interactive: (languageControlId.height > parent.height) ? true : false

                onVisibleChanged:{  // make current item visible (in the case it be outside of window bounds)
                    if(visible){
                        var currentSelection = Number(Storage.getLanguageDB(Constants.dbLanguageSelectedLanguageId, ""))
                        var currentSelectionPosition = languageRepeaterId.itemAt(currentSelection).y + (languageControlId.spacing * 0.5)

                        if(currentSelectionPosition > parent.height){
                            contentY = parent.height
                        }
                    }
                }

                Column {
                    id: languageControlId
                    anchors.top: parent.top
                    anchors.topMargin: spaceBetweenButtons
                    anchors.left: parent.left
                    anchors.leftMargin: spaceBetweenButtons
                    spacing: radioButtonSize * 0.5

                    onVisibleChanged:{  // update checked item
                        if(visible){
                            languageRepeaterId.itemAt(Number(Storage.getLanguageDB(Constants.dbLanguageSelectedLanguageId, ""))).checked = true
                        }
                    }

                    Repeater{
                        id: languageRepeaterId
                        model: Storage.getLanguageDB(Constants.dbLanguageNumberOflanguagesId, "")

                        RadioButton {
                            id: languageRadioButtonId
                            spacing: radioButtonSize * 0.01
                            width: laguageOptionsId.width * 0.9
                            text: Storage.getLanguageDB(Constants.dbLanguageNameId + index, "")
                            visible: (Storage.getLanguageDB(Constants.dbLanguageFields[index]["available"], "false") === "true") ? true : false

                            indicator: Rectangle {
                                implicitWidth: radioButtonSize
                                implicitHeight: radioButtonSize
                                radius: radioButtonSize * 0.5
                                border.width: radioButtonSize * 0.1
                                border.color: "white"
                                color: "transparent"
                                anchors.verticalCenter: parent.verticalCenter

                                Rectangle {
                                    width: radioButtonSize * 0.83
                                    height: width
                                    radius: width * 0.5
                                    anchors.centerIn: parent
                                    color: "white"
                                    visible: languageRadioButtonId.checked
                                }
                            }

                            contentItem: Text {
                                text: languageRadioButtonId.text
                                font.pixelSize: radioButtonSize * 0.85
                                color: languageRadioButtonId.checked ? labelColor : labelDeselectedColor
                                verticalAlignment: Text.AlignVCenter
                                leftPadding: languageRadioButtonId.indicator.width + languageRadioButtonId.spacing
                                elide: Text.ElideRight
                                Rectangle{
                                    anchors.fill: parent
                                    color: "#00000000"
                                    border.color: "lightblue"
                                    visible: viewGrid
                                }
                            }

                            onCheckedChanged: {
                                currentLanguageSelection = index
                                console.log("currentLanguageSelection: ", currentLanguageSelection)
                            }
                        }
                    }
                }
            }
        }
        Component.onCompleted: {
            if((Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsId, "*") === Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsAId, "*"))){
                initialState = 0
            }
            else if((Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsId, "*") === Storage.getAppDB(Constants.dbParameter.temperatureId + Constants.unitsBId, "*"))){
                initialState = 1
            }
            else{
                initialState = 1000
            }
            currentSelection = initialState
        }
    }

    Rectangle {
        id: cancelButton
        width: buttonHeight
        height: buttonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.bottom: parent.bottom
        anchors.bottomMargin: spaceBetweenButtons
        anchors.right: parent.right
        anchors.rightMargin: spaceBetweenButtons

        Image{
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.backId, "")
            opacity: cancelButtonButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: cancelButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked: {
                serviceMenuShowData.visible = false
            }
        }
    }
    Rectangle {
        id: okButton
        width: buttonHeight
        height: buttonHeight
        color: buttonsColor
        radius: buttonRadius
        anchors.bottom: cancelButton.top
        anchors.bottomMargin: spaceBetweenButtons
        anchors.right: parent.right
        anchors.rightMargin: spaceBetweenButtons

        Image{
            anchors.fill: parent
            source: Storage.getAppDB(Constants.dbAppIcon.doneId, "")
            opacity: okButtonButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: okButtonButton
            opacity: 0
            anchors.fill: parent

            onClicked: {
                if(currentLanguageSelection !== applicationWindow.selectedLanguage){
                    Storage.setLanguageDB(Constants.dbLanguageSelectedLanguageId, currentLanguageSelection)
                    Storage.saveLanguageDB()
                    applicationWindow.initLanguageSettings()
                }
                if(currentSelection !== initialState){
                    changeUnits()
                    serviceMenu.restartScreen.visible = true
                }
                else{
                    serviceMenuShowData.visible = false
                }
            }
        }
    }

    Timer{
        id: restartTimer
        interval: 1000
        repeat: true
        onTriggered: {
            restartTimeOut = restartTimeOut - 1
            if(!restartTimeOut){
                Qt.quit()
            }
        }
    }
}
