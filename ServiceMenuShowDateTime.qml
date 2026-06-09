// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import QtQuick.LocalStorage 2.12
import Process 1.0
import "storage.js" as Storage
import "Constants.js" as Constants
import "Singletons"

Rectangle {
    id: serviceMenuShowDateTime

    property alias titleLabel: titleLabel

    property int buttonRadius: 4
    property int buttonHeight: 80
    property int spaceBetweenButtons: 20
    property int tumblerWidth: width / 13
    property int tumblerHeight: width / 3.1
    property int tumblerTextSize: width / 21.25
    property int tumblerColumnSpace: tumblerTextSize / 8
    property double auxiliarTimeDateLinesOpacity: 0.5
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.serviceMenuButtonId, "black")

    property bool updateDatePending: false
    property bool viewGrid: false

    function formatText(count, modelData) {
        var data = ( (count === 12) || (count === 31) ) ? modelData + 1 : modelData

        if(count === 100){
            return 2000+ data
        }
        else{
            return data.toString().length < 2 ? "0" + data : data
        }
    }

    function updateDateAndTime(){
        updateDate()
        updateTime()
    }

    function updateDate(){
        dayTumbler.currentIndex = Qt.formatDate(new Date(), "dd") - 1
        monthTumbler.currentIndex = Qt.formatDate(new Date(), "MM") - 1
        yearTumbler.currentIndex = Qt.formatDate(new Date(), "yy")
    }

    function updateTime(){
        hoursTumbler.currentIndex = Qt.formatTime(new Date(), "hh")
        minutesTumbler.currentIndex = Qt.formatTime(new Date(), "mm")
        secondsTumbler.currentIndex = Qt.formatTime(new Date(), "ss")
    }

    width: QtConstants.serviceWindowPopUpWidth
    height: QtConstants.serviceWindowPopUpHeight
    radius: buttonRadius
    color: Storage.getAppDB(Constants.dbAppColor.serviceMenuShowDateTimeId, "black")

    onVisibleChanged: {
        if(visible) {
            updateDateAndTime()
        }
    }

    Label {
        id: titleLabel
        visible: true
        color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"
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

        Image{
            id: dateImageId
            source: Storage.getAppDB(Constants.dbAppIcon.setDateId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            width: buttonHeight
            height: buttonHeight
            anchors.top: parent.top
            anchors.topMargin: spaceBetweenButtons * 0.5
            anchors.horizontalCenter: dateTumblerRowId.horizontalCenter
            opacity: dateImageButtonId.down ? 0.4 : 1
            Button{
                id: dateImageButtonId
                anchors.fill: parent
                opacity: 0
                onClicked: updateDate()
            }
        }

        Image{
            id: timeImageId
            source: Storage.getAppDB(Constants.dbAppIcon.setTimeId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            width: buttonHeight
            height: buttonHeight
            anchors.top: parent.top
            anchors.topMargin: spaceBetweenButtons * 0.5
            anchors.horizontalCenter: timeTumblerRowId.horizontalCenter
            opacity: timeImageButtonId.down ? 0.4 : 1
            Button{
                id: timeImageButtonId
                anchors.fill: parent
                opacity: 0
                onClicked: updateTime()
            }
        }

        Component {
            id: delegateComponent

            Label {
                id: delegateComponentLabel
                text: formatText(Tumbler.tumbler.count, modelData)
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2.3)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: tumblerTextSize * ( 1 - ( Math.abs(Tumbler.displacement) / Tumbler.tumbler.visibleItemCount ) )
                color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"

            }
        }

        Row {
            id: dateTumblerRowId
            spacing: tumblerColumnSpace
            anchors.left: parent.left
            anchors.leftMargin: spaceBetweenButtons * 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: spaceBetweenButtons * 0.25

            Tumbler {
                id: dayTumbler
                model: 31
                delegate: delegateComponent
                width: tumblerWidth
                height: tumblerHeight
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "orange"
                    visible: viewGrid
                }
            }

            Label{
                text: "-"
                font.pixelSize: tumblerTextSize
                color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"
                height: tumblerHeight
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "olive"
                    visible: viewGrid
                }
            }

            Tumbler {
                id: monthTumbler
                model: 12
                delegate: delegateComponent
                width: tumblerWidth
                height: tumblerHeight
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "orange"
                    visible: viewGrid
                }
            }

            Label{
                text: "-"
                font.pixelSize: tumblerTextSize
                color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"
                height: tumblerHeight
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "olive"
                    visible: viewGrid
                }
            }

            Tumbler {
                id: yearTumbler
                model: 100
                delegate: delegateComponent
                width: tumblerWidth * 1.75
                height: tumblerHeight
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "orange"
                    visible: viewGrid
                }
            }
        }

        Row {
            id: timeTumblerRowId
            spacing: tumblerColumnSpace
            anchors.right: parent.right
            anchors.rightMargin: spaceBetweenButtons * 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: spaceBetweenButtons * 0.25

            Tumbler {
                id: hoursTumbler
                model: 24
                delegate: delegateComponent
                width: tumblerWidth
                height: tumblerHeight
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "orange"
                    visible: viewGrid
                }
            }

            Label{
                text: ":"
                font.pixelSize: tumblerTextSize
                color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"
                height: tumblerHeight
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "olive"
                    visible: viewGrid
                }
            }

            Tumbler {
                id: minutesTumbler
                model: 60
                delegate: delegateComponent
                width: tumblerWidth
                height: tumblerHeight
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "orange"
                    visible: viewGrid
                }
            }

            Label{
                text: ":"
                font.pixelSize: tumblerTextSize
                color: Storage.getAppDB(Constants.dbAppColor.serviceMenuTextId, "white")//"white"
                height: tumblerHeight
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Tumbler {
                id: secondsTumbler
                model: 60
                delegate: delegateComponent
                width: tumblerWidth
                height: tumblerHeight
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "orange"
                    visible: viewGrid
                }
            }
        }

        Rectangle{
            id: upDateLineId
            height: 1
            width: dateTumblerRowId.width
            anchors.horizontalCenter: dateTumblerRowId.horizontalCenter
            anchors.verticalCenter: dateTumblerRowId.verticalCenter
            anchors.verticalCenterOffset: - tumblerTextSize * 0.75
            opacity: auxiliarTimeDateLinesOpacity
        }

        Rectangle{
            id: downDateLineId
            height: 1
            width: dateTumblerRowId.width
            anchors.horizontalCenter: dateTumblerRowId.horizontalCenter
            anchors.verticalCenter: dateTumblerRowId.verticalCenter
            anchors.verticalCenterOffset: tumblerTextSize * 0.75
            opacity: auxiliarTimeDateLinesOpacity
        }

        Rectangle{
            id: upTimeLineId
            height: 1
            width: timeTumblerRowId.width
            anchors.horizontalCenter: timeTumblerRowId.horizontalCenter
            anchors.verticalCenter: timeTumblerRowId.verticalCenter
            anchors.verticalCenterOffset: - tumblerTextSize * 0.75
            opacity: auxiliarTimeDateLinesOpacity
        }

        Rectangle{
            id: downTimeLineId
            height: 1
            width: timeTumblerRowId.width
            anchors.horizontalCenter: timeTumblerRowId.horizontalCenter
            anchors.verticalCenter: timeTumblerRowId.verticalCenter
            anchors.verticalCenterOffset: tumblerTextSize * 0.75
            opacity: auxiliarTimeDateLinesOpacity
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
                serviceMenuShowDateTime.visible = false
            }
        }
    }

    Rectangle {
        id: doneButton
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
            opacity: doneButtonButton.down ? 0.4 : 1
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
        }
        Button{
            id: doneButtonButton
            opacity: 0
            anchors.fill: parent
            onClicked: {
                // console command: hwclock --set --date "dd/mm/yy hh:mm:ss"
                // process command: hwclock --set --date  dd/mm/yy hh:mm:ss                
                skipErrorDuringTimerUpdate.restart() // #4316

                var dateTime = (((monthTumbler.currentIndex + 1).toString().length < 2)   ? "0" + (monthTumbler.currentIndex + 1) : (monthTumbler.currentIndex + 1)) + "/" +
                                (((dayTumbler.currentIndex + 1).toString().length < 2)    ? "0" + (dayTumbler.currentIndex + 1)   : (dayTumbler.currentIndex + 1))   + "/" +
                                "20" + (( yearTumbler.currentIndex.toString().length < 2) ? "0" +  yearTumbler.currentIndex       :  yearTumbler.currentIndex)       + " " +
                                (( hoursTumbler.currentIndex.toString().length < 2)       ? "0" +  hoursTumbler.currentIndex      :  hoursTumbler.currentIndex)      + ":" +
                                (( minutesTumbler.currentIndex.toString().length < 2)     ? "0" +  minutesTumbler.currentIndex    :  minutesTumbler.currentIndex)    + ":" +
                                (( secondsTumbler.currentIndex.toString().length < 2)     ? "0" +  secondsTumbler.currentIndex    :  secondsTumbler.currentIndex)

                console.log("date time: ", dateTime)
                process.start("hwclock", ["--set", "--date", dateTime]) // update hardware clock
                updateDatePending = true
                serviceMenuShowDateTime.visible = false // execute this line at the end ...
            }
        }
    }

    Process {
        id: process
        onStarted: {
            console.log("(process) start: ")//, process.readAll())
        }
        onStateChanged: {
            console.log("(process) state changed: ")//, process.readAll())
        }
        onReadyReadStandardOutput: {
            console.log("(process) standard output: ")//, process.readAll())
        }
        onReadyReadStandardError: {
            console.log("(process) error: ")//, process.readAll())
            updateDatePending = false
        }
        onReadChannelFinished: {
            console.log("(process) channel finished: ")//, process.readAll())
            if(updateDatePending){
                updateDatePending = false
                process.start("hwclock", ["-s"]) // update system clock
            }
        }
    }

    Timer {
        id: updateTimeTimer
        interval: 400
        repeat: true
        running: false // parent.visible (ticket #4171 solved)
        onTriggered: {
            updateDateAndTime()
        }
    }

    Timer {  // #4316
        id: skipErrorDuringTimerUpdate
        interval: 10000
        repeat: false
        running: false
        onRunningChanged: running ? applicationWindow.skipError = true : applicationWindow.skipError = false
    }
}
