// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

Item {
    property double initPressure: 0
    property double targetPressure: 0
    property double intervalPressure: 0

    Timer {
        id: depressureSimulationTimer
        interval: 100
        repeat: true
        running: false

        onTriggered: consoleSocket.startConnection()
    }
}
