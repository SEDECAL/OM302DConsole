// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle{
    id: rectangle

    property string buttonsColor: "#292929"
    property int borderMargin: 3
    property int buttonRadius: 4

    color: "#333333"
    radius: buttonRadius
    property alias numberLabel: numberLabel
/*
    function savingEffect(destinationObject){
//      console.log("numberLabelRectangle.mapFromItem(appItem, 0, 0)", numberLabelRectangle.mapFromItem(appItem, 0, 0))
//      console.log("numberLabelRectangle.mapToItem(appItem, 0, 0)", numberLabelRectangle.mapToItem(appItem, 0, 0))
        magnitudeSelector.inputO3.auxRectangleForSavingEffect.x = destinationObject.mapToItem(appItem, 0, 0).x - magnitudeSelector.inputO3.mapToItem(appItem,0,0).x
        magnitudeSelector.inputO3.auxRectangleForSavingEffect.y = destinationObject.mapToItem(appItem, 0, 0).y - magnitudeSelector.inputO3.mapToItem(appItem,0,0).y
        magnitudeSelector.inputO3.auxRectangleForSavingEffect.width = destinationObject.width
        magnitudeSelector.inputO3.auxRectangleForSavingEffect.height = destinationObject.height
        magnitudeSelector.inputO3.magnitudeLabelForSavingEffect.state= "saving"
    }
    */
    function savingEffect(originObject, destinationObject){
//      console.log("numberLabelRectangle.mapFromItem(appItem, 0, 0)", numberLabelRectangle.mapFromItem(appItem, 0, 0))
//      console.log("numberLabelRectangle.mapToItem(appItem, 0, 0)", numberLabelRectangle.mapToItem(appItem, 0, 0))
        originObject.auxRectangleForSavingEffect.x = destinationObject.mapToItem(appItem, 0, 0).x - originObject.mapToItem(appItem,0,0).x
        originObject.auxRectangleForSavingEffect.y = destinationObject.mapToItem(appItem, 0, 0).y - originObject.mapToItem(appItem,0,0).y
        originObject.auxRectangleForSavingEffect.width = destinationObject.width
        originObject.auxRectangleForSavingEffect.height = destinationObject.height
        originObject.magnitudeLabelForSavingEffect.state= "saving"
        originObject.magnitudeLabel2ForSavingEffect.state= "saving"
        originObject.magnitudeLabel3ForSavingEffect.state= "saving"
    }

    Rectangle{
        id: numberLabelRectangle
        width: parent.height - (2 * borderMargin)
        height: numberLabel.width
        radius: buttonRadius
        color: "#00000000"//buttonsColor
        anchors.left: parent.left
        anchors.leftMargin: borderMargin
        anchors.verticalCenter: parent.verticalCenter
        Label{
            id: numberLabel
            color: "#FFFFFF"
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            opacity: 0.2
            text: "*"
            font.pixelSize: parent.height * 0.75
            Rectangle{
                anchors.fill: parent
                color: "#00000000"
                border.color: "blue"
                visible: false
            }
        }
    }

    Row{
        spacing: 30
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: parent.height * 0.5

        StoredValue_00{
            id: inputO3StoredValue
            width: parent.height
            height: parent.height
            unitsLabel.color: "#0097A7"
            valueLabel.color: "#80DEEA"
            visible: true
        }
        StoredValue_00{
            id: inputFlowStoredValue
            width: parent.height
            height: parent.height
            unitsLabel.color: "#388E3C"
            valueLabel.color: "#81C784"
            visible: true
        }
        StoredValue_00{
            id: inputTimeStoredValue
            width: parent.height
            height: parent.height
            unitsLabel.color: "#FFB300"
            valueLabel.color: "#FFE082"
            visible: true
        }
        StoredValue_00{
            id: inputTimeVolumeStoredValue
            width: parent.height
            height: parent.height
            unitsLabel.color: "#AB47BC"
            valueLabel.color: "#CE93D6"
            visible: true
        }
        StoredValue_00{
            id: otherStoredValue
            width: parent.height
            height: parent.height
            unitsLabel.color: "#AFB42B"
            valueLabel.color: "#DCE775"
            visible: false
        }
    }

    Button{
        opacity: 0
        anchors.fill: parent
        onClicked: {
            magnitudeSelector.inputO3.slider.value = inputO3StoredValue.valueLabel.text
            magnitudeSelector.inputFlow.slider.value = inputFlowStoredValue.valueLabel.text
            magnitudeSelector.inputTime.slider.value = inputTimeStoredValue.valueLabel.text
            magnitudeSelector.inputTimeVolume.slider.value = inputTimeVolumeStoredValue.valueLabel.text
        }
        onPressAndHold: {
            savingEffect(magnitudeSelector.inputO3, inputO3StoredValue.valueLabel)
            savingEffect(magnitudeSelector.inputFlow, inputFlowStoredValue.valueLabel)
            savingEffect(magnitudeSelector.inputTime, inputTimeStoredValue.valueLabel)
            savingEffect(magnitudeSelector.inputTimeVolume, inputTimeVolumeStoredValue.valueLabel)

            inputO3StoredValue.valueLabel.text = magnitudeSelector.inputO3.magnitudeLabel.text
            inputFlowStoredValue.valueLabel.text = magnitudeSelector.inputFlow.magnitudeLabel.text
            inputTimeStoredValue.valueLabel.text = magnitudeSelector.inputTime.magnitudeLabel.text
            inputTimeVolumeStoredValue.valueLabel.text = magnitudeSelector.inputTimeVolume.magnitudeLabel.text
        }
    }
}

