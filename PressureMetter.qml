// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.LocalStorage 2.12
import "storage.js" as Storage
import "Constants.js" as Constants

Rectangle{
    id: containerRectangle

    property alias progressTool: progressTool       // just for compatibility
    property alias cumulatedLabel: cumulatedLabel   // just for compatibility
    property alias unitsLabel: unitsLabel
    property alias overpressureAlert: overpressureAlert
    property alias topGradient: topGradient
    property alias mediumTopGradient: mediumTopGradient
    property alias mediumBottomGradient: mediumBottomGradient
    property alias bottomGradient: bottomGradient
    property alias scaleRectangle: scaleRectangle

    property int containerRectangleY: containerRectangle.y
    property int containerRectangleHeight: containerRectangle.height

    property double maxLimit: progressTool.maximumValue
    property double minLimit: progressTool.minimumValue
    property double limitsRange: maxLimit - minLimit
    property double maxIndicatorPosition: scaleRectangle.height
    property double minIndicatorPosition: 0
    property double indicatorPosition: 0
    property double measure: 0
    property double conversionFactor: 1
    property double targetPressureForDepressureSimulation: 0

    property string overpressureAlertState: ""
    property string controlColor: Storage.getAppDB(Constants.dbAppColor.pressureMetterPanelId, "black")
    property string indicatorsImage: ""

    property bool firstMeasurement: false
    property bool viewDebug: false
    property bool viewGrid: false

    function getIndicatorPosition(measure, range){
        var value

        if(measure > maxLimit)
            value = maxLimit
        else if (measure < minLimit)
            value = minLimit
        else
            value = measure

        indicatorPosition = range - (((value - minLimit) * range) / limitsRange)

        if(firstMeasurement){
            maxIndicatorPosition = indicatorPosition
            minIndicatorPosition = indicatorPosition
            firstMeasurement = false
            indicatorRectangle.visible = true

        }else{

            if(indicatorPosition < maxIndicatorPosition){
                maxIndicatorPosition = indicatorPosition
            }
            if(indicatorPosition > minIndicatorPosition){
                minIndicatorPosition = indicatorPosition
            }
        }
    }

    function initPressureMetter(){
        indicatorRectangle.visible = false
        firstMeasurement = true

        getIndicatorPosition(applicationWindow.atmosphericPressure, scaleRectangle.height)
        atmosphericPressureLine.y = scaleRectangle.y + indicatorPosition// - (indicatorRectangle.height * 0.5)
        indicatorsImage = Storage.getAppDB(Constants.dbAppIcon.pressureLimitPointer1Id, "")
    }

    function configIndicatorPositionersForHideEffect(){
        maxIndicatorPosition =  0
        minIndicatorPosition = 0
        indicatorPosition = 0
        indicatorRectangle.visible = false
    }

    Component.onCompleted: {
        containerRectangleHeight = containerRectangle.height
        containerRectangleY = containerRectangle.y
        indicatorRectangle.visible = false
    }

    states:[
        State{
            id: viewPressureMetter
        },
        State{
            id: noViewPressureMetter
        },
        State{
            id: simulateDepressure
        },
        State{
            id: quickViewPressureMetter
            PropertyChanges { target: containerRectangle; opacity: 1 }
            PropertyChanges { target: containerRectangle; height: containerRectangleHeight }
            PropertyChanges { target: containerRectangle; y: containerRectangleY }
            PropertyChanges { target: scaleRectangle; opacity: 1 }
            PropertyChanges { target: scaleRectangle; height: containerRectangleHeight * 0.78 }
        },
        State{
            id: dummyStateId
        }
    ]

    transitions:[
        Transition {
            to: "viewPressureMetter"
            SequentialAnimation{
                PropertyAnimation { target: containerRectangle; property: "opacity"; to: 1; duration: 0}
                ParallelAnimation{
                    PropertyAnimation { target: containerRectangle; property: "height"; to: containerRectangleHeight; duration: 100}
                    PropertyAnimation { target: containerRectangle; property: "y"; to: containerRectangleY; duration: 100}
                }
                ParallelAnimation{
                    PropertyAnimation { target: scaleRectangle; property: "opacity"; to: 1; duration: 100}
                }
                ScriptAction{script: initPressureMetter()}
            }
        },
        Transition {
            to: "noViewPressureMetter"
            ParallelAnimation{
                PropertyAnimation { target: containerRectangle; property: "opacity"; to: 0; duration: 200}
                PropertyAnimation { target: containerRectangle; property: "height"; to: 0; duration: 200}
                PropertyAnimation { target: containerRectangle; property: "y"; to: containerRectangleY + containerRectangleHeight; duration: 200}
                PropertyAnimation { target: scaleRectangle; property: "opacity"; to: 0; duration: 75}
            }
        },
        Transition {
            to: "simulateDepressure"
            SequentialAnimation{
                PropertyAnimation { target: progressTool; property: "value"; to: applicationWindow.atmosphericPressure; duration: 1200}
                PropertyAnimation { target: containerRectangle; property: "state"; to: "dummyStateId"; duration: 0 } // during simulateDepressure state pressure is not updated
            }
        }
    ]

    width: 120
    height: 420
    color: controlColor
    radius:3
    state: "noViewPressureMetter"
    visible: false

    onVisibleChanged: {
        if(visible){
            initPressureMetter()
        }
    }

    Rectangle{
        id: scaleRectangle
        width: parent.width * 0.35
        height: containerRectangleHeight * 0.78  // keep in this way to avoid problems during transition effects
        radius:5
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.165

        gradient: Gradient
        {
            GradientStop
            {
                id: topGradient
                position: 0
                color: Storage.getAppDB(Constants.dbAppColor.pressureMetterGradientTopId, "black")
            }
            GradientStop
            {
                id: mediumTopGradient
                position: 0.4
                color: Storage.getAppDB(Constants.dbAppColor.pressureMetterGradientMediumId, "black")
            }
            GradientStop
            {
                id: mediumBottomGradient
                position: 0.6
                color: Storage.getAppDB(Constants.dbAppColor.pressureMetterGradientMediumId, "black")
            }
            GradientStop
            {
                id: bottomGradient
                position: 1
                color: Storage.getAppDB(Constants.dbAppColor.pressureMetterGradientBottomId, "black")
            }
        }

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "white"
            visible: viewGrid
        }
    }

    Rectangle{
        id: overpressureAlert
        height: width
        color: "transparent"
        anchors.right: parent.right
        anchors.left: scaleRectangle.right
        anchors.top: scaleRectangle.top
        visible: (overpressureAlertState === "1") ? true : false

        Image{
            anchors.centerIn: parent
            height: parent.width * 0.7
            width: height
            source: (visible) ? Storage.getAppDB(Constants.dbAppIcon.presureAlertId, "") : ""
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
    }

    Rectangle{
        id: auxiliarScaleRectangle
        width: scaleRectangle.width * 0.2
        anchors.top: scaleRectangle.top
        anchors.topMargin: - scaleRectangle.height * 0.025
        anchors.bottom: scaleRectangle.bottom
        anchors.bottomMargin: - scaleRectangle.height * 0.025
        anchors.right: scaleRectangle.left
        anchors.rightMargin: scaleRectangle.width * 0.015
        visible: indicatorRectangle.visible

        gradient: Gradient
        {
            GradientStop
            {
                position: 0
                color: Storage.getAppDB(Constants.dbAppColor.pressureMetterGradientTopId, "black")
            }
            GradientStop
            {
                position: 0.4
                color: Storage.getAppDB(Constants.dbAppColor.pressureMetterGradientMediumId, "black")
            }
            GradientStop
            {
                position: 0.6
                color: Storage.getAppDB(Constants.dbAppColor.pressureMetterGradientMediumId, "black")
            }
            GradientStop
            {
                position: 1
                color: Storage.getAppDB(Constants.dbAppColor.pressureMetterGradientBottomId, "black")
            }
        }
    }

    Rectangle{
        id: indicatorRectangle
        width: ((containerRectangle.width - scaleRectangle.width) * 0.4) + scaleRectangle.width
        height: (containerRectangle.width - scaleRectangle.width) * 0.4
        color: "transparent"
        y: scaleRectangle.y + indicatorPosition - (height * 0.5)
        x: scaleRectangle.x// + scaleRectangle.width
        Image{
            width: indicatorRectangle.height
            height: indicatorRectangle.height
            source: Storage.getAppDB(Constants.dbAppIcon.pressurePointerId, "")
            anchors.right: parent.right
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Rectangle{
            id: indicatorLine
            width: scaleRectangle.width * 0.93
            height: scaleRectangle.height * 0.006//9
            anchors.left: parent.left
            anchors.leftMargin: (scaleRectangle.width - width) * 0.5
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            opacity: 1
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "orange"
            visible: viewGrid
        }
    }

    Rectangle{
        id: atmosphericPressureLine
        width: scaleRectangle.width * 0.93
        height: scaleRectangle.height * 0.009
        anchors.left: indicatorRectangle.left
        anchors.leftMargin: (scaleRectangle.width - width) * 0.5
        color: "white"
        opacity: 0.5
    }

    Rectangle{
        id: maxIndicatorRectangle
        width: (containerRectangle.width - scaleRectangle.width) * 0.3
        height: width * 0.36
        color: "transparent"
        y: scaleRectangle.y + maxIndicatorPosition - (height * 0.5)
        anchors.right: scaleRectangle.left
        visible: indicatorRectangle.visible
        Image{
            anchors.fill: parent
            source: indicatorsImage
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "red"
            visible: viewGrid
        }
    }

    Rectangle{
        id: minIndicatorRectangle
        width: (containerRectangle.width - scaleRectangle.width) * 0.3
        height: width * 0.36
        color: "transparent"
        y: scaleRectangle.y + minIndicatorPosition - (height * 0.5)
        anchors.right: scaleRectangle.left
        visible: indicatorRectangle.visible
        Image{
            anchors.fill: parent
            source: indicatorsImage
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "blue"
            visible: viewGrid
        }
    }

    Rectangle{
        id: middleCoverIndicatorRectangle
        width: minIndicatorRectangle.width
        anchors.bottom: minIndicatorRectangle.top
        anchors.top: maxIndicatorRectangle.bottom
        color:  containerRectangle.color
        anchors.right: scaleRectangle.left
        visible: true

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "lightblue"
            visible: viewGrid
        }
    }

    Rectangle{
        id: upperCoverIndicatorRectangle
        width: minIndicatorRectangle.width
        anchors.bottom: maxIndicatorRectangle.top
        anchors.top: scaleRectangle.top
        anchors.topMargin: - width * 0.5
        color: containerRectangle.color
        anchors.right: scaleRectangle.left
        visible: true

        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "pink"
            visible: viewGrid
        }
    }

    Rectangle{
        id: lowerCoverIndicatorRectangle
        width: minIndicatorRectangle.width
        anchors.bottom: scaleRectangle.bottom
        anchors.bottomMargin: - width * 0.5
        anchors.top: minIndicatorRectangle.bottom
        color: containerRectangle.color
        anchors.right: scaleRectangle.left
        visible: true
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.color: "yellow"
            visible: viewGrid
        }
    }

    Label{
        id: unitsLabel
        width: parent.width
        height: parent.width * 0.4
        color: Storage.getAppDB(Constants.dbAppColor.pressureMetterLabelId, "black")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 1
        visible: true
        text: ""
        font.pixelSize:parent.width * 0.18//0.25
        fontSizeMode: Text.Fit
        Component.onCompleted: {
            if(Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsId) === Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsAId, "*")){
                text = Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsAId, "*")
            }
            else if(Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsId) === Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsBId, "*")){
                text = Storage.getAppDB(Constants.dbParameter.pressureId + Constants.unitsBId, "*")
            }
        }

    }

    //
    //  just for compatibility
    //
    ProgressBar{
        id: progressTool
        visible: false
        maximumValue: 1000000
        minimumValue: 0
        value: (maximumValue - minimumValue) * 0.5
        onValueChanged: {
            getIndicatorPosition(value, scaleRectangle.height)
        }
    }

    //
    //  just for compatibility
    //
    Label{
        id: cumulatedLabel
        opacity: 0
        width: parent.width
        height: parent.width * 0.4
        color: Storage.getAppDB(Constants.dbAppColor.pressureMetterValueId, "black")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        text: "40000"
        font.pixelSize:parent.width * 0.20//0.27
        fontSizeMode: Text.Fit
    }

    //
    // debug
    //
    Rectangle{
        width: parent.width
        height: 1
        y: (scaleRectangle.height * 0.2) + scaleRectangle.y
        visible: viewDebug
    }
    Text{
        id: maxLimitTextId
        text: " maxLimit:" + maxLimit
        color: "white"
        anchors.top: containerRectangle.top
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: minLimitTextId
        text: " minLimit:" + minLimit
        color: "white"
        anchors.top: maxLimitTextId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: limitsRangeId
        text: " limitsRange:" + limitsRange
        color: "white"
        anchors.top: minLimitTextId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: maxIndicatorPositionId
        text: " maxIndicatorPosition:" + maxIndicatorPosition
        color: "white"
        anchors.top: limitsRangeId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: minIndicatorPositionId
        text: " minIndicatorPosition:" + minIndicatorPosition
        color: "white"
        anchors.top: maxIndicatorPositionId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: indicatorPositionId
        text: " indicatorPosition:" + indicatorPosition
        color: "white"
        anchors.top: minIndicatorPositionId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: pressureValueId
        text: " pressure:" + progressTool.value
        color: "white"
        anchors.top: indicatorPositionId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: firstMeasurementId
        text: " firstMeasurement:" + firstMeasurement
        color: "white"
        anchors.top: pressureValueId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: stateId
        text: " state:" + parent.state
        color: "white"
        anchors.top: firstMeasurementId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: atmPressurelId
        text: " atm pressure:" + applicationWindow.atmosphericPressure
        color: "white"
        anchors.top: stateId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: indicatorRectanglepositionId
        text: " indicatorRectangle position:" + indicatorRectangle.y
        color: "white"
        anchors.top: atmPressurelId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }
    Text{
        id: atmosphericPressureLineId
        text: " atmosphericPressureLine position:" + atmosphericPressureLine.y
        color: "white"
        anchors.top: indicatorRectanglepositionId.bottom
        anchors.left: containerRectangle.right
        font.pixelSize: parent.width * 0.06
        visible: viewDebug
    }

}

