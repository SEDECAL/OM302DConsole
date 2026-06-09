// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Controls 1.4 as QQC1
import QtQuick.Controls.Styles 1.0
import QtGraphicalEffects 1.0

import "storage.js" as Storage
import "Constants.js" as Constants
import "DebugConstants.js" as DC
import "Therapies.js" as Therapies
import "Singletons"

Rectangle{
    id: memoryBoard

    property alias textInput: textInput

    property int buttonRadius: 4
    property int memoryItemsSpacing: 15
    property int memoryVisibleRows: 4
    property int elementsPerMemory: 22
    property int memoryItemHeight: (memoryBoard.height - memoryTopBar.height - (memoryItemsSpacing * (memoryVisibleRows + 1))) / (memoryVisibleRows)
    property int keyboardButtomHeight: memoryItemHeight * 0.75
    property int maxListItems: 10
    property int visibleRowItemsNumber: 0
    property int selectedMemoryRow: 0
    property int updateScreenOnSavingEffetcCounter: 0
    property int fullViewX: QtConstants.fullViewInputElementX
    property int fullViewY: QtConstants.fullViewInputElementY + QtConstants.magnitudeSelectorY
    property int fullViewWidth: QtConstants.fullViewInputElementWith
    property int fullViewHeight: QtConstants.fullViewInputElementWith * QtConstants.fullViewInputElementAspectRatio
    property int reducedViewX: 0
    property int reducedViewY: 0
    property int reducedViewWidth: 0
    property int reducedViewHeight: 0
    property int operationButtonWidth: memoryBoard.width * 0.085
    property int enlargeTime: 300
    property int srinkTime: 100
    property int textSavingEffectSize: memoryFakeRectangleForSavingEffect.height
    property int iconsAreaFullViewHeight: operationButtonWidth
    property int iconsAreaReducedViewHeight: 0
    property int memoryTopBarFullViewHeight: operationButtonWidth + (1.5 * memoryItemsSpacing)
    property int memoryTopBarReducedViewHeight: 0
    property int backButtomFullViewHeight: operationButtonWidth
    property int backButtomReducedViewHeight: 0
    property int savingEffectTransitionTime: 300
    property int updatingEffectTransitionTime: 300

    property double memoryLabelHeightProportionalFactor: 0.7
    property double gostMarginRectangleWidth: updateGostMarginRectangleWidth()
    property double labelsFakeRectangleForSavingEffectWidth: ((QtConstants.inputElementWidth * visibleRowItemsNumber) + (QtConstants.magnitudeSelectorRowSpacing * (visibleRowItemsNumber - 1)))
    property double labelsFakeRectangleForSavingEffectOiginX: gostMarginRectangleWidth + QtConstants.magnitudeSelectorRowSpacing - memoryBoard.x
    property double magnitudeSelectorFakeRectangleForSavingEffectWidth: QtConstants.inputElementWidth
    property double labelsFakeRectangleForSavingEffectSpacing: QtConstants.magnitudeSelectorRowSpacing * magnitudeSelector.narrowMarginCoeficient
    property double memoryFakeRectangleForSavingEffectSpacing: memoryItemsSpacing
    property double memoryFakeRectangleForSavingEffectWidth: ((memoryBoard.width - (4 * memoryItemsSpacing) - (2 * memoryItemHeight) - operationButtonWidth) - ((visibleRowItemsNumber - 1) * memoryItemsSpacing)) / visibleRowItemsNumber
    property double oneItemFinalWidthforSavingEffect: (( memoryBoard.width - (3 * memoryItemHeight) - (5 * memoryItemsSpacing) )- ((visibleRowItemsNumber - 1) * memoryItemsSpacing)) / visibleRowItemsNumber

    property string backColor: Storage.getAppDB(Constants.dbAppColor.memoryBackId, "black")
    property string buttonColor: Storage.getAppDB(Constants.dbAppColor.memeoryButtonId, "black")

    property bool viewGrid: false

    function updateGostMarginRectangleWidth(){
        var retValue

        if(magnitudeSelector.inputCyclesFake.visible){
            retValue = (QtConstants.magnitudeSelectorWidth - magnitudeSelector.inputCycles.width - (QtConstants.inputElementWidth  * (visibleRowItemsNumber - 3)) - (QtConstants.magnitudeSelectorRowSpacing * magnitudeSelector.narrowMarginCoeficient * (visibleRowItemsNumber - 3))) * 0.5
        }
        else if(magnitudeSelector.inputPreviousVaccumYesNo.visible){
            retValue = (QtConstants.magnitudeSelectorWidth - (QtConstants.inputElementWidth  * (visibleRowItemsNumber - 2)) - (QtConstants.magnitudeSelectorRowSpacing * (visibleRowItemsNumber - 3))) * 0.5
            retValue = retValue + ((magnitudeSelector.inputPreviousVaccumYesNo.width + QtConstants.magnitudeSelectorRowSpacing) * 0.5)
        }
        else{
            retValue = (QtConstants.magnitudeSelectorWidth - (QtConstants.inputElementWidth  * visibleRowItemsNumber) - (QtConstants.magnitudeSelectorRowSpacing * (visibleRowItemsNumber - 1))) * 0.5
        }
        return retValue - labelsFakeRectangleForSavingEffectSpacing
    }

    function setMemoryKeyboardPosition(){
        keyboard.anchors.left = memoryBoard.left
        keyboard.anchors.leftMargin = memoryBottomBar.height
        keyboard.anchors.right = memoryBoard.right
        keyboard.anchors.rightMargin = memoryBottomBar.height
    }

    function loadMemoryContent(){
        var i
        memoryModel.clear()

        for(i=0; i<maxListItems; i++){
            importMemoriesFromDB(i)
        }
    }

    function updateVisibleMemoryItems(){
        var i

        console.log("Updating memory visible items...",new Date().getTime())

        for(i=0; i<maxListItems; i++){
            memoryModel.set(i, {"visible0":   magnitudeSelector.inputNormoOrHiper.visible })
            memoryModel.set(i, {"visible1":   magnitudeSelector.inputCycles.visible })
            memoryModel.set(i, {"visible2":   magnitudeSelector.inputPreviousVaccumYesNo.visible })
            memoryModel.set(i, {"visible3":   magnitudeSelector.inputSalineVolume.visible })
            memoryModel.set(i, {"visible4":   magnitudeSelector.inputBottleVolume.visible })
            memoryModel.set(i, {"visible5":   magnitudeSelector.inputBloodVolume.visible })
            memoryModel.set(i, {"visible6":   magnitudeSelector.inputLiquidVolume.visible })
            memoryModel.set(i, {"visible7":   magnitudeSelector.inputVacuumTime.visible })
            memoryModel.set(i, {"visible8":   magnitudeSelector.inputO3.visible })
            memoryModel.set(i, {"visible9":   magnitudeSelector.inputFlow.visible })
            memoryModel.set(i, {"visible10":  magnitudeSelector.inputTime.visible })
            memoryModel.set(i, {"visible11":  magnitudeSelector.inputTimeVolume.visible })
            memoryModel.set(i, {"visible12":  magnitudeSelector.inputTotalConcentration.visible })
            memoryModel.set(i, {"visible13":  magnitudeSelector.inputVolumeDose.visible })
            memoryModel.set(i, {"visible14":  magnitudeSelector.inputTimeDose.visible })
            memoryModel.set(i, {"visible15":  magnitudeSelector.inputVolume.visible })
            memoryModel.set(i, {"visible16":  magnitudeSelector.inputTherapyTime.visible })
            memoryModel.set(i, {"visible17":  magnitudeSelector.inputCleanTime.visible })
            memoryModel.set(i, {"visible18":  magnitudeSelector.inputPressure.visible })
            memoryModel.set(i, {"visible19":  magnitudeSelector.inputReinfusionTime.visible })
            memoryModel.set(i, {"visible20":  magnitudeSelector.inputIp.visible })
            memoryModel.set(i, {"visible21":  magnitudeSelector.inputSalineTime.visible })

            memoryModel.set(i, {"value0":    (magnitudeSelector.inputNormoOrHiper.visible) ?        Storage.getMemDB(magnitudeSelector.inputNormoOrHiper.saveStamp +       "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value1":    (magnitudeSelector.inputCycles.visible) ?              Storage.getMemDB(magnitudeSelector.inputCycles.saveStamp +             "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value2":    (magnitudeSelector.inputPreviousVaccumYesNo.visible) ? Storage.getMemDB(magnitudeSelector.inputPreviousVaccumYesNo.saveStamp +"_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value3":    (magnitudeSelector.inputSalineVolume.visible) ?        Storage.getMemDB(magnitudeSelector.inputSalineVolume.saveStamp +       "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value4":    (magnitudeSelector.inputBottleVolume.visible) ?        Storage.getMemDB(magnitudeSelector.inputBottleVolume.saveStamp +       "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value5":    (magnitudeSelector.inputBloodVolume.visible) ?         Storage.getMemDB(magnitudeSelector.inputBloodVolume.saveStamp +        "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value6":    (magnitudeSelector.inputLiquidVolume.visible) ?        Storage.getMemDB(magnitudeSelector.inputLiquidVolume.saveStamp +       "_" + Constants.memoryId + i, "-") : "-"})
//          memoryModel.set(i, {"value7":    (magnitudeSelector.inputVacuumTime.visible) ?          Storage.getMemDB(magnitudeSelector.inputVacuumTime.saveStamp +         "_" + Constants.memoryId + i, "-") : "-"})
            //#4831
            memoryModel.set(i, {"value7":    ((magnitudeSelector.inputVacuumTime.visible || magnitudeSelector.inputPreviousVaccumYesNo.visible)) ?
                                              Storage.getMemDB(magnitudeSelector.inputVacuumTime.saveStamp + "_" + Constants.memoryId + i, "-") : "-"})

            memoryModel.set(i, {"value8":    (magnitudeSelector.inputO3.visible) ?                  Storage.getMemDB(magnitudeSelector.inputO3.saveStamp +                 "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value9":    (magnitudeSelector.inputFlow.visible) ?                Storage.getMemDB(magnitudeSelector.inputFlow.saveStamp +               "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value10":   (magnitudeSelector.inputTime.visible) ?                Storage.getMemDB(magnitudeSelector.inputTime.saveStamp +               "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value11":   (magnitudeSelector.inputTimeVolume.visible) ?          Storage.getMemDB(magnitudeSelector.inputTimeVolume.saveStamp +         "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value12":   (magnitudeSelector.inputTotalConcentration.visible) ?  Storage.getMemDB(magnitudeSelector.inputTotalConcentration.saveStamp + "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value13":   (magnitudeSelector.inputVolumeDose.visible) ?          Storage.getMemDB(magnitudeSelector.inputVolumeDose.saveStamp +         "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value14":   (magnitudeSelector.inputTimeDose.visible) ?            Storage.getMemDB(magnitudeSelector.inputTimeDose.saveStamp +           "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value15":   (magnitudeSelector.inputVolume.visible) ?              Storage.getMemDB(magnitudeSelector.inputVolume.saveStamp +             "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value16":   (magnitudeSelector.inputTherapyTime.visible) ?         Storage.getMemDB(magnitudeSelector.inputTherapyTime.saveStamp +        "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value17":   (magnitudeSelector.inputCleanTime.visible) ?           Storage.getMemDB(magnitudeSelector.inputCleanTime.saveStamp +          "_" + Constants.memoryId + i, "-") : "-"})
//          memoryModel.set(i, {"value18":   (magnitudeSelector.inputPressure.visible) ?            Storage.getMemDB(magnitudeSelector.inputPressure.saveStamp +           "_" + Constants.memoryId + i, "-") : "-"})
            //#4831
            memoryModel.set(i, {"value18":   ((magnitudeSelector.inputPressure.visible || magnitudeSelector.inputPreviousVaccumYesNo.visible)) ?
                                               Storage.getMemDB(magnitudeSelector.inputPressure.saveStamp + "_" + Constants.memoryId + i, "-") : "-"})

            memoryModel.set(i, {"value19":   (magnitudeSelector.inputReinfusionTime.visible) ?      Storage.getMemDB(magnitudeSelector.inputReinfusionTime.saveStamp +     "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value20":   (magnitudeSelector.inputIp.visible) ?                  Storage.getMemDB(magnitudeSelector.inputIp.saveStamp +                 "_" + Constants.memoryId + i, "-") : "-"})
            memoryModel.set(i, {"value21":   (magnitudeSelector.inputSalineTime.visible) ?          Storage.getMemDB(magnitudeSelector.inputSalineTime.saveStamp +         "_" + Constants.memoryId + i, "-") : "-"})

            memoryModel.set(i, {"memTex": Storage.getMemDB(tabBar.selectedOption + "_" + Constants.memoryTextId + i, "-") })
            memoryModel.set(i, {"repeatState": (Storage.getMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatId + i, "-") === "1") ? true : false })
            memoryModel.set(i, {"indexEntry": i })
            memoryModel.set(i, {"extendedTextVisibility": false})

        }
//      console.log("Memory visible items updated...",new Date().getTime())

        memoryList.currentIndex = 0
    }

    function importMemoriesFromDB(i){
        memoryModel.append({
                               value0:  (magnitudeSelector.inputNormoOrHiper.visible) ?        Storage.getMemDB(magnitudeSelector.inputNormoOrHiper.saveStamp +       "_" + Constants.memoryId + i, "-") : "-",
                               value1:  (magnitudeSelector.inputCycles.visible) ?              Storage.getMemDB(magnitudeSelector.inputCycles.saveStamp +             "_" + Constants.memoryId + i, "-") : "-",
                               value2:  (magnitudeSelector.inputPreviousVaccumYesNo.visible) ? Storage.getMemDB(magnitudeSelector.inputPreviousVaccumYesNo.saveStamp +"_" + Constants.memoryId + i, "-") : "-",
                               value3:  (magnitudeSelector.inputSalineVolume.visible) ?        Storage.getMemDB(magnitudeSelector.inputSalineVolume.saveStamp +       "_" + Constants.memoryId + i, "-") : "-",
                               value4:  (magnitudeSelector.inputBottleVolume.visible) ?        Storage.getMemDB(magnitudeSelector.inputBottleVolume.saveStamp +       "_" + Constants.memoryId + i, "-") : "-",
                               value5:  (magnitudeSelector.inputBloodVolume.visible) ?         Storage.getMemDB(magnitudeSelector.inputBloodVolume.saveStamp +        "_" + Constants.memoryId + i, "-") : "-",
                               value6:  (magnitudeSelector.inputLiquidVolume.visible) ?        Storage.getMemDB(magnitudeSelector.inputLiquidVolume.saveStamp +       "_" + Constants.memoryId + i, "-") : "-",
//                             value7:  (magnitudeSelector.inputVacuumTime.visible) ?          Storage.getMemDB(magnitudeSelector.inputVacuumTime.saveStamp +         "_" + Constants.memoryId + i, "-") : "-",
                               //#4831
                               value7:  ((magnitudeSelector.inputVacuumTime.visible || magnitudeSelector.inputPreviousVaccumYesNo.visible)) ?
                                         Storage.getMemDB(magnitudeSelector.inputVacuumTime.saveStamp + "_" + Constants.memoryId + i, "-") : "-",

                               value8:  (magnitudeSelector.inputO3.visible) ?                  Storage.getMemDB(magnitudeSelector.inputO3.saveStamp +                 "_" + Constants.memoryId + i, "-") : "-",
                               value9:  (magnitudeSelector.inputFlow.visible) ?                Storage.getMemDB(magnitudeSelector.inputFlow.saveStamp +               "_" + Constants.memoryId + i, "-") : "-",
                               value10: (magnitudeSelector.inputTime.visible) ?                Storage.getMemDB(magnitudeSelector.inputTime.saveStamp +               "_" + Constants.memoryId + i, "-") : "-",
                               value11: (magnitudeSelector.inputTimeVolume.visible) ?          Storage.getMemDB(magnitudeSelector.inputTimeVolume.saveStamp +         "_" + Constants.memoryId + i, "-") : "-",
                               value12: (magnitudeSelector.inputTotalConcentration.visible) ?  Storage.getMemDB(magnitudeSelector.inputTotalConcentration.saveStamp + "_" + Constants.memoryId + i, "-") : "-",
                               value13: (magnitudeSelector.inputVolumeDose.visible) ?          Storage.getMemDB(magnitudeSelector.inputVolumeDose.saveStamp +         "_" + Constants.memoryId + i, "-") : "-",
                               value14: (magnitudeSelector.inputTimeDose.visible) ?            Storage.getMemDB(magnitudeSelector.inputTimeDose.saveStamp +           "_" + Constants.memoryId + i, "-") : "-",
                               value15: (magnitudeSelector.inputVolume.visible) ?              Storage.getMemDB(magnitudeSelector.inputVolume.saveStamp +             "_" + Constants.memoryId + i, "-") : "-",
                               value16: (magnitudeSelector.inputTherapyTime.visible) ?         Storage.getMemDB(magnitudeSelector.inputTherapyTime.saveStamp +        "_" + Constants.memoryId + i, "-") : "-",
                               value17: (magnitudeSelector.inputCleanTime.visible) ?           Storage.getMemDB(magnitudeSelector.inputCleanTime.saveStamp +          "_" + Constants.memoryId + i, "-") : "-",
//                             value18: (magnitudeSelector.inputPressure.visible) ?            Storage.getMemDB(magnitudeSelector.inputPressure.saveStamp +           "_" + Constants.memoryId + i, "-") : "-",
                               //#4831
                               value18: ((magnitudeSelector.inputPressure.visible || magnitudeSelector.inputPreviousVaccumYesNo.visible)) ?
                                         Storage.getMemDB(magnitudeSelector.inputPressure.saveStamp + "_" + Constants.memoryId + i, "-") : "-",

                               value19: (magnitudeSelector.inputReinfusionTime.visible) ?      Storage.getMemDB(magnitudeSelector.inputReinfusionTime.saveStamp +     "_" + Constants.memoryId + i, "-") : "-",
                               value20: (magnitudeSelector.inputIp.visible) ?                  Storage.getMemDB(magnitudeSelector.inputIp.saveStamp +                 "_" + Constants.memoryId + i, "-") : "-",
                               value21: (magnitudeSelector.inputSalineTime.visible) ?          Storage.getMemDB(magnitudeSelector.inputSalineTime.saveStamp +         "_" + Constants.memoryId + i, "-") : "-",

                               memTex:  Storage.getMemDB(tabBar.selectedOption + "_" + Constants.memoryTextId + i, "-"),
                               repeatState: (Storage.getMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatId + i, "-") === "1") ? true : false,
                               indexEntry: i,
                               extendedTextVisibility: false,

                               color0:  "white",
                               color1:  magnitudeSelector.inputCyclesLabel.color,
                               color2:  "white",
                               color3:  magnitudeSelector.inputSalineVolume.magnitudeLabel.color,
                               color4:  magnitudeSelector.inputBottleVolume.magnitudeLabel.color,
                               color5:  magnitudeSelector.inputBloodVolume.magnitudeLabel.color,
                               color6:  magnitudeSelector.inputLiquidVolume.magnitudeLabel.color,
                               color7:  magnitudeSelector.inputVacuumTime.magnitudeLabel.color,
                               color8:  magnitudeSelector.inputO3.magnitudeLabel.color,
                               color9:  magnitudeSelector.inputFlow.magnitudeLabel.color,
                               color10: magnitudeSelector.inputTime.magnitudeLabel.color,
                               color11: magnitudeSelector.inputTimeVolume.magnitudeLabel.color,
                               color12: magnitudeSelector.inputTotalConcentration.magnitudeLabel.color,
                               color13: magnitudeSelector.inputVolumeDose.magnitudeLabel.color,
                               color14: magnitudeSelector.inputTimeDose.magnitudeLabel.color,
                               color15: magnitudeSelector.inputVolume.magnitudeLabel.color,
                               color16: magnitudeSelector.inputTherapyTime.magnitudeLabel.color,
                               color17: magnitudeSelector.inputCleanTime.magnitudeLabel.color,
                               color18: magnitudeSelector.inputPressure.magnitudeLabel.color,
                               color19: magnitudeSelector.inputReinfusionTime.magnitudeLabel.color,
                               color20: magnitudeSelector.inputIp.magnitudeLabel.color,
                               color21: magnitudeSelector.inputSalineTime.magnitudeLabel.color,

                               visible0:  magnitudeSelector.inputNormoOrHiper.visible,
                               visible1:  magnitudeSelector.inputCycles.visible,
                               visible2:  magnitudeSelector.inputPreviousVaccumYesNo.visible,
                               visible3:  magnitudeSelector.inputSalineVolume.visible,
                               visible4:  magnitudeSelector.inputBottleVolume.visible,
                               visible5:  magnitudeSelector.inputBloodVolume.visible,
                               visible6:  magnitudeSelector.inputLiquidVolume.visible,
                               visible7:  magnitudeSelector.inputVacuumTime.visible,
                               visible8:  magnitudeSelector.inputO3.visible,
                               visible9:  magnitudeSelector.inputFlow.visible,
                               visible10: magnitudeSelector.inputTime.visible,
                               visible11: magnitudeSelector.inputTimeVolume.visible,
                               visible12: magnitudeSelector.inputTotalConcentration.visible,
                               visible13: magnitudeSelector.inputVolumeDose.visible,
                               visible14: magnitudeSelector.inputTimeDose.visible,
                               visible15: magnitudeSelector.inputVolume.visible,
                               visible16: magnitudeSelector.inputTherapyTime.visible,
                               visible17: magnitudeSelector.inputCleanTime.visible,
                               visible18: magnitudeSelector.inputPressure.visible,
                               visible19: magnitudeSelector.inputReinfusionTime.visible,
                               visible20: magnitudeSelector.inputIp.visible,
                               visible21: magnitudeSelector.inputSalineTime.visible,
                           })
    }

    function visibleMemoryItemsPerRow(){
        visibleRowItemsNumber = (magnitudeSelector.inputNormoOrHiper.visible * 1) +
                                (magnitudeSelector.inputCycles.visible * 1) +
                                (magnitudeSelector.inputPreviousVaccumYesNo.visible * 1) +
                                (magnitudeSelector.inputSalineVolume.visible * 1) +
                                (magnitudeSelector.inputBottleVolume.visible * 1) +
                                (magnitudeSelector.inputBloodVolume.visible * 1) +
                                (magnitudeSelector.inputLiquidVolume.visible * 1) +
                                (magnitudeSelector.inputVacuumTime.visible * 1) +
                                (magnitudeSelector.inputO3.visible * 1) +
                                (magnitudeSelector.inputFlow.visible * 1) +
                                (magnitudeSelector.inputTime.visible * 1) +
                                (magnitudeSelector.inputTimeVolume.visible * 1) +
                                (magnitudeSelector.inputTotalConcentration.visible * 1) +
                                (magnitudeSelector.inputVolumeDose.visible * 1) +
                                (magnitudeSelector.inputTimeDose.visible * 1) +
                                (magnitudeSelector.inputVolume.visible * 1) +
                                (magnitudeSelector.inputTherapyTime.visible * 1) +
                                (magnitudeSelector.inputCleanTime.visible * 1) +
                                (magnitudeSelector.inputPressure.visible * 1) +
                                (magnitudeSelector.inputReinfusionTime.visible * 1) +
                                (magnitudeSelector.inputIp.visible * 1) +
                                (magnitudeSelector.inputSalineTime.visible * 1)
    }

    function updateScreenOnSavingEffetc(i){
        switch(i){
            case 0:  magnitudeSelector.theraphyPressure =                             (magnitudeSelector.inputNormoOrHiper.visible) ?        memoryModel.get(selectedMemoryRow).value0  : magnitudeSelector.theraphyPressure; break
            case 1:  magnitudeSelector.theraphyCycles =                               (magnitudeSelector.inputCycles.visible) ?              memoryModel.get(selectedMemoryRow).value1  : magnitudeSelector.theraphyCycles; break
            case 2:  magnitudeSelector.previousVacuum =                               (magnitudeSelector.inputPreviousVaccumYesNo.visible) ? memoryModel.get(selectedMemoryRow).value2  : magnitudeSelector.previousVacuum; break
            case 3:  magnitudeSelector.inputSalineVolume.magnitudeLabel.text =        (magnitudeSelector.inputSalineVolume.visible) ?        memoryModel.get(selectedMemoryRow).value3  : magnitudeSelector.inputSalineVolume.magnitudeLabel.text; break
            case 4:  magnitudeSelector.inputBottleVolume.magnitudeLabel.text =        (magnitudeSelector.inputBottleVolume.visible) ?        memoryModel.get(selectedMemoryRow).value4  : magnitudeSelector.inputBottleVolume.magnitudeLabel.text; break
            case 5:  magnitudeSelector.inputBloodVolume.magnitudeLabel.text =         (magnitudeSelector.inputBloodVolume.visible) ?         memoryModel.get(selectedMemoryRow).value5  : magnitudeSelector.inputBloodVolume.magnitudeLabel.text; break
            case 6:  magnitudeSelector.inputLiquidVolume.magnitudeLabel.text =        (magnitudeSelector.inputLiquidVolume.visible) ?        memoryModel.get(selectedMemoryRow).value6  : magnitudeSelector.inputLiquidVolume.magnitudeLabel.text; break
            case 7:  magnitudeSelector.inputVacuumTime.magnitudeLabel.text =          (magnitudeSelector.inputVacuumTime.visible) ?          memoryModel.get(selectedMemoryRow).value7  : magnitudeSelector.inputVacuumTime.magnitudeLabel.text; break
            case 8:  magnitudeSelector.inputO3.magnitudeLabel.text =                  (magnitudeSelector.inputO3.visible) ?                  memoryModel.get(selectedMemoryRow).value8  : magnitudeSelector.inputO3.magnitudeLabel.text; break
            case 9:  magnitudeSelector.inputFlow.magnitudeLabel.text =                (magnitudeSelector.inputFlow.visible) ?                memoryModel.get(selectedMemoryRow).value9  : magnitudeSelector.inputFlow.magnitudeLabel.text; break
            case 10: magnitudeSelector.inputTime.magnitudeLabel.text =                (magnitudeSelector.inputTime.visible) ?                memoryModel.get(selectedMemoryRow).value10 : magnitudeSelector.inputTime.magnitudeLabel.text; break
            case 11: magnitudeSelector.inputTimeVolume.magnitudeLabel.text =          (magnitudeSelector.inputTimeVolume.visible) ?          memoryModel.get(selectedMemoryRow).value11 : magnitudeSelector.inputTimeVolume.magnitudeLabel.text; break
            case 12: magnitudeSelector.inputTotalConcentration.magnitudeLabel.text =  (magnitudeSelector.inputTotalConcentration.visible) ?  memoryModel.get(selectedMemoryRow).value12 : magnitudeSelector.inputTotalConcentration.magnitudeLabel.text; break
            case 13: magnitudeSelector.inputVolumeDose.magnitudeLabel.text =          (magnitudeSelector.inputVolumeDose.visible) ?          memoryModel.get(selectedMemoryRow).value13 : magnitudeSelector.inputVolumeDose.magnitudeLabel.text; break
            case 14: magnitudeSelector.inputTimeDose.magnitudeLabel.text =            (magnitudeSelector.inputTimeDose.visible) ?            memoryModel.get(selectedMemoryRow).value14 : magnitudeSelector.inputTimeDose.magnitudeLabel.text; break
            case 15: magnitudeSelector.inputVolume.magnitudeLabel.text =              (magnitudeSelector.inputVolume.visible) ?              memoryModel.get(selectedMemoryRow).value15 : magnitudeSelector.inputVolume.magnitudeLabel.text; break
            case 16: magnitudeSelector.inputTherapyTime.magnitudeLabel.text =         (magnitudeSelector.inputTherapyTime.visible) ?         memoryModel.get(selectedMemoryRow).value16 : magnitudeSelector.inputTherapyTime.magnitudeLabel.text; break
            case 17: magnitudeSelector.inputCleanTime.magnitudeLabel.text =           (magnitudeSelector.inputCleanTime.visible) ?           memoryModel.get(selectedMemoryRow).value17 : magnitudeSelector.inputCleanTime.magnitudeLabel.text; break
            case 18: magnitudeSelector.inputPressure.magnitudeLabel.text =            (magnitudeSelector.inputPressure.visible) ?            memoryModel.get(selectedMemoryRow).value18 : magnitudeSelector.inputPressure.magnitudeLabel.text; break
            case 19: magnitudeSelector.inputReinfusionTime.magnitudeLabel.text =      (magnitudeSelector.inputReinfusionTime.visible) ?      memoryModel.get(selectedMemoryRow).value19 : magnitudeSelector.inputReinfusionTime.magnitudeLabel.text; break
            case 20: magnitudeSelector.inputIp.magnitudeLabel.text =                  (magnitudeSelector.inputIp.visible) ?                  memoryModel.get(selectedMemoryRow).value20 : magnitudeSelector.inputIp.magnitudeLabel.text; break
            case 21: magnitudeSelector.inputSalineTime.magnitudeLabel.text =          (magnitudeSelector.inputSalineTime.visible) ?          memoryModel.get(selectedMemoryRow).value21 : magnitudeSelector.inputSalineTime.magnitudeLabel.text; break
        }
    }

    function prepareContextForEffects(index){
        labelsFakeRectangleForSavingEffect.x =  magnitudeSelector.x  - memoryBoard.x
        labelsFakeRectangleForSavingEffect.y =  magnitudeSelector.y + magnitudeSelector.inputO3.y + magnitudeSelector.inputO3.magnitudeLabel.y - memoryBoard.y
        memoryFakeRectangleForSavingEffect.height = memoryItemHeight * memoryLabelHeightProportionalFactor
        memoryFakeRectangleForSavingEffect.width = memoryBoard.width - (4 * memoryItemsSpacing) - (2 * memoryItemHeight) - operationButtonWidth
        memoryList.currentIndex = index
        memoryFakeRectangleForSavingEffect.y = memoryList.currentItem.y + memoryWindow.y - memoryList.contentY
        magnitudeSelectorFakeRectangleForSavingEffectWidth = magnitudeSelector.inputO3.width
        labelsFakeRectangleForSavingEffectSpacing = QtConstants.magnitudeSelectorRowSpacing * magnitudeSelector.narrowMarginCoeficient
        gostMarginRectangleWidth = updateGostMarginRectangleWidth()
        selectedMemoryRow = index
    }

    function prepareContextForSaving(index){
        prepareContextForEffects(index)
        savingEffect.y = memoryFakeRectangleForSavingEffect.y + 1
        savingGif.currentFrame = 0
        savingEffect.visible = true
        labelsFakeRectangleForSavingEffect.state = "saving"
    }

    function prepareContextForUpdating(index){
        if(isFullMemory(index)){
            prepareContextForEffects(index)
            memoryFakeRectangleForSavingEffect.state = "updating"
        }
    }

    function isFullMemory(index){
        var ret = true

        if((memoryModel.get(index).value0  === "-") &&
           (memoryModel.get(index).value1  === "-") &&
           (memoryModel.get(index).value2  === "-") &&
           (memoryModel.get(index).value3  === "-") &&
           (memoryModel.get(index).value4  === "-") &&
           (memoryModel.get(index).value5  === "-") &&
           (memoryModel.get(index).value6  === "-") &&
           (memoryModel.get(index).value7  === "-") &&
           (memoryModel.get(index).value8  === "-") &&
           (memoryModel.get(index).value9  === "-") &&
           (memoryModel.get(index).value10 === "-") &&
           (memoryModel.get(index).value11 === "-") &&
           (memoryModel.get(index).value12 === "-") &&
           (memoryModel.get(index).value13 === "-") &&
           (memoryModel.get(index).value14 === "-") &&
           (memoryModel.get(index).value15 === "-") &&
           (memoryModel.get(index).value16 === "-") &&
           (memoryModel.get(index).value17 === "-") &&
           (memoryModel.get(index).value18 === "-") &&
           (memoryModel.get(index).value19 === "-") &&
           (memoryModel.get(index).value20 === "-") ){
//         (memoryModel.get(index).value21 === "-") ){
            ret = false
        }

        return ret
    }

    function updateMagnitudeLabels(){
        magnitudeSelector.theraphyPressure = (magnitudeSelector.inputNormoOrHiper.visible) ?  memoryModel.get(selectedMemoryRow).value0 : ""
        magnitudeSelector.theraphyCycles = (magnitudeSelector.inputCycles.visible) ? memoryModel.get(selectedMemoryRow).value1 : 0
        if(magnitudeSelector.inputPreviousVaccumYesNo.visible) {
            switch (memoryModel.get(selectedMemoryRow).value2){
                case "0": magnitudeSelector.previousVacuum = false; break
                case "1": magnitudeSelector.previousVacuum = true; break
            }
        }
        magnitudeSelector.inputSalineVolume.slider.value = (magnitudeSelector.inputSalineVolume.visible) ? memoryModel.get(selectedMemoryRow).value3 : ""
        magnitudeSelector.inputBottleVolume.slider.value = (magnitudeSelector.inputBottleVolume.visible) ?memoryModel.get(selectedMemoryRow).value4 : ""
        magnitudeSelector.inputBloodVolume.slider.value = (magnitudeSelector.inputBloodVolume.visible) ? memoryModel.get(selectedMemoryRow).value5 : ""
        magnitudeSelector.inputLiquidVolume.slider.value = (magnitudeSelector.inputLiquidVolume.visible) ? memoryModel.get(selectedMemoryRow).value6 : ""
        magnitudeSelector.inputVacuumTime.slider.value = (magnitudeSelector.inputVacuumTime.visible) ? memoryModel.get(selectedMemoryRow).value7 : ""

        //#4831
        if(magnitudeSelector.inputPreviousVaccumYesNo.visible) {
            magnitudeSelector.inputVacuumTime.slider.value = memoryModel.get(selectedMemoryRow).value7
        }

        magnitudeSelector.inputO3.slider.value = (magnitudeSelector.inputO3.visible) ? memoryModel.get(selectedMemoryRow).value8 : ""
        magnitudeSelector.inputFlow.slider.value = (magnitudeSelector.inputFlow.visible) ? memoryModel.get(selectedMemoryRow).value9 : ""
        magnitudeSelector.inputTime.slider.value = (magnitudeSelector.inputTime.visible) ? memoryModel.get(selectedMemoryRow).value10 : ""
        magnitudeSelector.inputTimeVolume.slider.value = (magnitudeSelector.inputTimeVolume.visible) ? parseFloat(memoryModel.get(selectedMemoryRow).value11) : ""

        if(magnitudeSelector.inputTotalConcentration.visible){
            magnitudeSelector.inputTotalConcentration.performSliderRangeChangeFromFixedButton(parseFloat(memoryModel.get(selectedMemoryRow).value12))
            magnitudeSelector.inputTotalConcentration.slider.value = parseFloat(memoryModel.get(selectedMemoryRow).value12)
        }

        magnitudeSelector.inputVolumeDose.slider.value = (magnitudeSelector.inputVolumeDose.visible) ? memoryModel.get(selectedMemoryRow).value13 : ""
        magnitudeSelector.inputTimeDose.slider.value = (magnitudeSelector.inputTimeDose.visible) ? memoryModel.get(selectedMemoryRow).value14 : ""
        magnitudeSelector.inputVolume.slider.value = (magnitudeSelector.inputVolume.visible) ? memoryModel.get(selectedMemoryRow).value15 : ""
        magnitudeSelector.inputTherapyTime.slider.value = (magnitudeSelector.inputTherapyTime.visible) ? memoryModel.get(selectedMemoryRow).value16 : ""
        magnitudeSelector.inputCleanTime.slider.value = (magnitudeSelector.inputCleanTime.visible) ? memoryModel.get(selectedMemoryRow).value17 : ""
        magnitudeSelector.inputPressure.slider.value = (magnitudeSelector.inputPressure.visible) ? memoryModel.get(selectedMemoryRow).value18 : ""

        //#4831
        if(magnitudeSelector.inputPreviousVaccumYesNo.visible) {
            magnitudeSelector.inputPressure.slider.value = memoryModel.get(selectedMemoryRow).value18
        }

        magnitudeSelector.inputReinfusionTime.slider.value = (magnitudeSelector.inputReinfusionTime.visible) ? memoryModel.get(selectedMemoryRow).value19 : ""
        magnitudeSelector.inputIp.slider.value = (magnitudeSelector.inputIp.visible) ? memoryModel.get(selectedMemoryRow).value20 : ""
//      magnitudeSelector.inputSalineTime.slider.value = memoryModel.get(selectedMemoryRow).value21

//      multiple label autohemo
        if(magnitudeSelector.inputO3.visible) {
            if(Storage.getMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatId + selectedMemoryRow, "-") === "1"){
                magnitudeSelector.inputO3.differentValuesOnCycles.activated = true
            }else{
                magnitudeSelector.inputO3.differentValuesOnCycles.activated = false
            }
            magnitudeSelector.inputO3.fixButtonLabel_1.text = Storage.getMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[0] + "_" +  selectedMemoryRow, "-");
            magnitudeSelector.inputO3.fixButtonLabel_2.text = Storage.getMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[1] + "_" +  selectedMemoryRow, "-");
            magnitudeSelector.inputO3.fixButtonLabel_3.text = Storage.getMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[2] + "_" +  selectedMemoryRow, "-");
            magnitudeSelector.inputO3.fixButtonLabel_4.text = Storage.getMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[3] + "_" +  selectedMemoryRow, "-");
            magnitudeSelector.inputO3.fixButtonLabel_5.text = Storage.getMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[4] + "_" +  selectedMemoryRow, "-");
        }
    }

    function updateValuesAtEndOfUpdateTransition(){
        if(magnitudeSelector.inputNormoOrHiper.visible)        theraphyPressure = memoryModel.get(memoryList.currentIndex).value0
        if(magnitudeSelector.inputCycles.visible)              theraphyCycles =   memoryModel.get(memoryList.currentIndex).value1
        if(magnitudeSelector.inputPreviousVaccumYesNo.visible) previousVacuum =   memoryModel.get(memoryList.currentIndex).value2
        if(magnitudeSelector.inputSalineVolume.visible)        magnitudeSelector.inputSalineVolume.magnitudeLabel.text =       memoryModel.get(memoryList.currentIndex).value3
        if(magnitudeSelector.inputBottleVolume.visible)        magnitudeSelector.inputBottleVolume.magnitudeLabel.text =       memoryModel.get(memoryList.currentIndex).value4
        if(magnitudeSelector.inputBloodVolume.visible)         magnitudeSelector.inputBloodVolume.magnitudeLabel.text =        memoryModel.get(memoryList.currentIndex).value5
        if(magnitudeSelector.inputLiquidVolume.visible)        magnitudeSelector.inputLiquidVolume.magnitudeLabel.text =       memoryModel.get(memoryList.currentIndex).value6
        if(magnitudeSelector.inputVacuumTime.visible)          magnitudeSelector.inputVacuumTime.magnitudeLabel.text =         memoryModel.get(memoryList.currentIndex).value7
        if(magnitudeSelector.inputO3.visible)                  magnitudeSelector.inputO3.magnitudeLabel.text =                 memoryModel.get(memoryList.currentIndex).value8
        if(magnitudeSelector.inputFlow.visible)                magnitudeSelector.inputFlow.magnitudeLabel.text =               memoryModel.get(memoryList.currentIndex).value9
        if(magnitudeSelector.inputTime.visible)                magnitudeSelector.inputTime.magnitudeLabel.text =               memoryModel.get(memoryList.currentIndex).value10
        if(magnitudeSelector.inputTimeVolume.visible)          magnitudeSelector.inputTimeVolume.magnitudeLabel.text =         memoryModel.get(memoryList.currentIndex).value11
        if(magnitudeSelector.inputTotalConcentration.visible)  magnitudeSelector.inputTotalConcentration.magnitudeLabel.text = memoryModel.get(memoryList.currentIndex).value12
        if(magnitudeSelector.inputVolumeDose.visible)          magnitudeSelector.inputVolumeDose.magnitudeLabel.text =         memoryModel.get(memoryList.currentIndex).value13
        if(magnitudeSelector.inputTimeDose.visible)            magnitudeSelector.inputTimeDose.magnitudeLabel.text =           memoryModel.get(memoryList.currentIndex).value14
        if(magnitudeSelector.inputVolume.visible)              magnitudeSelector.inputVolume.magnitudeLabel.text =             memoryModel.get(memoryList.currentIndex).value15
        if(magnitudeSelector.inputTherapyTime.visible)         magnitudeSelector.inputTherapyTime.magnitudeLabel.text =        memoryModel.get(memoryList.currentIndex).value16
        if(magnitudeSelector.inputCleanTime.visible)           magnitudeSelector.inputCleanTime.magnitudeLabel.text =          memoryModel.get(memoryList.currentIndex).value17
        if(magnitudeSelector.inputPressure.visible)            magnitudeSelector.inputPressure.magnitudeLabel.text =           memoryModel.get(memoryList.currentIndex).value18
        if(magnitudeSelector.inputReinfusionTime.visible)      magnitudeSelector.inputReinfusionTime.magnitudeLabel.text =     memoryModel.get(memoryList.currentIndex).value19
        if(magnitudeSelector.inputIp.visible)                  magnitudeSelector.inputIp.magnitudeLabel.text =                 memoryModel.get(memoryList.currentIndex).value20
        if(magnitudeSelector.inputSalineTime.visible)          magnitudeSelector.inputSalineTime.magnitudeLabel.text =         memoryModel.get(memoryList.currentIndex).value21
    }

    function refreshValuesAtEndOfUpdate(){
        magnitudeSelector.inputBottleVolume.refreshSlider()
        magnitudeSelector.inputBloodVolume.refreshSlider()
        magnitudeSelector.inputLiquidVolume.refreshSlider()
        magnitudeSelector.inputVacuumTime.refreshSlider()
        magnitudeSelector.inputO3.refreshSlider()
        magnitudeSelector.inputFlow.refreshSlider()
        magnitudeSelector.inputTime.refreshSlider()
        magnitudeSelector.inputTimeVolume.refreshSlider()
        magnitudeSelector.inputTotalConcentration.refreshSlider()
        magnitudeSelector.inputVolumeDose.refreshSlider()
        magnitudeSelector.inputTimeDose.refreshSlider()
        magnitudeSelector.inputVolume.refreshSlider()
        magnitudeSelector.inputTherapyTime.refreshSlider()
        magnitudeSelector.inputCleanTime.refreshSlider()
        magnitudeSelector.inputPressure.refreshSlider()
        magnitudeSelector.inputReinfusionTime.refreshSlider()
        magnitudeSelector.inputIp.refreshSlider()
//      magnitudeSelector.inputSalineTime.refreshSlider()
    }

    function updateValuesAtEndOfSaveTransition(){

        if(magnitudeSelector.inputNormoOrHiper.visible) {
            memoryModel.set(selectedMemoryRow, {"value0":  magnitudeSelector.theraphyPressure})
            Storage.setMemDB(magnitudeSelector.inputNormoOrHiper.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.theraphyPressure)
        }
        if(magnitudeSelector.inputCycles.visible) {
            memoryModel.set(selectedMemoryRow, {"value1":  magnitudeSelector.theraphyCycles})
            Storage.setMemDB(magnitudeSelector.inputCycles.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.theraphyCycles)
        }
        if(magnitudeSelector.inputPreviousVaccumYesNo.visible) {
            memoryModel.set(selectedMemoryRow, {"value2":  ((magnitudeSelector.previousVacuum) ? "1" : "0") })
            Storage.setMemDB(magnitudeSelector.inputPreviousVaccumYesNo.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, (magnitudeSelector.previousVacuum) ? "1" : "0")
        }
        if(magnitudeSelector.inputSalineVolume.visible) {
            memoryModel.set(selectedMemoryRow, {"value3":  magnitudeSelector.inputSalineVolume.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputSalineVolume.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputSalineVolume.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputBottleVolume.visible) {
            memoryModel.set(selectedMemoryRow, {"value4":  magnitudeSelector.inputBottleVolume.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputBottleVolume.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputBottleVolume.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputBloodVolume.visible) {
            memoryModel.set(selectedMemoryRow, {"value5":  magnitudeSelector.inputBloodVolume.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputBloodVolume.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputBloodVolume.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputLiquidVolume.visible) {
            memoryModel.set(selectedMemoryRow, {"value6":  magnitudeSelector.inputLiquidVolume.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputLiquidVolume.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputLiquidVolume.magnitudeLabel.text)
        }
//      if(magnitudeSelector.inputVacuumTime.visible) {
//          memoryModel.set(selectedMemoryRow, {"value7":  magnitudeSelector.inputVacuumTime.magnitudeLabel.text})
//          Storage.setMemDB(magnitudeSelector.inputVacuumTime.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputVacuumTime.magnitudeLabel.text)
//        }

        //#4831
        if(magnitudeSelector.inputVacuumTime.visible || magnitudeSelector.inputPreviousVaccumYesNo.visible) {
            memoryModel.set(selectedMemoryRow, {"value7":  magnitudeSelector.inputVacuumTime.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputVacuumTime.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputVacuumTime.magnitudeLabel.text)
        }

        if(magnitudeSelector.inputO3.visible) {
            memoryModel.set(selectedMemoryRow, {"value8":  magnitudeSelector.inputO3.magnitudeLabel.text})
            memoryModel.set(selectedMemoryRow, {"repeatState":  magnitudeSelector.inputO3.differentValuesOnCycles.activated})
            Storage.setMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputO3.magnitudeLabel.text);
            Storage.setMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatId + selectedMemoryRow, magnitudeSelector.inputO3.differentValuesOnCycles.activated);
            Storage.setMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[0] + "_" +  selectedMemoryRow, magnitudeSelector.inputO3.fixButtonLabel_1.text)
            Storage.setMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[1] + "_" +  selectedMemoryRow, magnitudeSelector.inputO3.fixButtonLabel_2.text)
            Storage.setMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[2] + "_" +  selectedMemoryRow, magnitudeSelector.inputO3.fixButtonLabel_3.text)
            Storage.setMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[3] + "_" +  selectedMemoryRow, magnitudeSelector.inputO3.fixButtonLabel_4.text)
            Storage.setMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[4] + "_" +  selectedMemoryRow, magnitudeSelector.inputO3.fixButtonLabel_5.text)
        }
        if(magnitudeSelector.inputFlow.visible) {
            memoryModel.set(selectedMemoryRow, {"value9":  magnitudeSelector.inputFlow.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputFlow.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputFlow.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputTime.visible) {
            memoryModel.set(selectedMemoryRow, {"value10":  magnitudeSelector.inputTime.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputTime.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputTime.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputTimeVolume.visible) {
            memoryModel.set(selectedMemoryRow, {"value11": magnitudeSelector.inputTimeVolume.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputTimeVolume.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputTimeVolume.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputTotalConcentration.visible) {
            memoryModel.set(selectedMemoryRow, {"value12": magnitudeSelector.inputTotalConcentration.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputTotalConcentration.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputTotalConcentration.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputVolumeDose.visible) {
            memoryModel.set(selectedMemoryRow, {"value13": magnitudeSelector.inputVolumeDose.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputVolumeDose.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputVolumeDose.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputTimeDose.visible) {
            memoryModel.set(selectedMemoryRow, {"value14": magnitudeSelector.inputTimeDose.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputTimeDose.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputTimeDose.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputVolume.visible) {
            memoryModel.set(selectedMemoryRow, {"value15": magnitudeSelector.inputVolume.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputVolume.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputVolume.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputTherapyTime.visible) {
            memoryModel.set(selectedMemoryRow, {"value16": magnitudeSelector.inputTherapyTime.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputTherapyTime.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputTherapyTime.magnitudeLabel.text)
        }
        if(magnitudeSelector.inputCleanTime.visible) {
            memoryModel.set(selectedMemoryRow, {"value17": magnitudeSelector.inputCleanTime.magnitudeLabel.text})
            Storage.setMemDB(magnitudeSelector.inputCleanTime.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputCleanTime.magnitudeLabel.text)
        }
//      if(magnitudeSelector.inputPressure.visible) {
//          memoryModel.set(selectedMemoryRow, {"value18": magnitudeSelector.inputPressure.magnitudeLabel.text.replace("-","")})
//          Storage.setMemDB(magnitudeSelector.inputPressure.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputPressure.magnitudeLabel.text.replace("-",""))
//      }

        //#4831
        if(magnitudeSelector.inputPressure.visible || magnitudeSelector.inputPreviousVaccumYesNo.visible) {
            memoryModel.set(selectedMemoryRow, {"value18": magnitudeSelector.inputPressure.magnitudeLabel.text.replace("-","")})
            Storage.setMemDB(magnitudeSelector.inputPressure.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputPressure.magnitudeLabel.text.replace("-",""))
        }

        if(magnitudeSelector.inputReinfusionTime.visible) {
            memoryModel.set(selectedMemoryRow, {"value19": magnitudeSelector.inputReinfusionTime.magnitudeLabel.text.replace("-","")})
            Storage.setMemDB(magnitudeSelector.inputReinfusionTime.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputReinfusionTime.magnitudeLabel.text.replace("-",""))
        }
        if(magnitudeSelector.inputIp.visible) {
            memoryModel.set(selectedMemoryRow, {"value20": magnitudeSelector.inputIp.magnitudeLabel.text.replace("-","")})
            Storage.setMemDB(magnitudeSelector.inputIp.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputIp.magnitudeLabel.text.replace("-",""))
        }
        if(magnitudeSelector.inputSalineTime.visible) {
            memoryModel.set(selectedMemoryRow, {"value21": magnitudeSelector.inputSalineTime.magnitudeLabel.text.replace("-","")})
            Storage.setMemDB(magnitudeSelector.inputSalineTime.saveStamp + "_" + Constants.memoryId + selectedMemoryRow, magnitudeSelector.inputSalineTime.magnitudeLabel.text.replace("-",""))
        }

        Storage.saveMemDB()
    }

    function setExendedTex(memIndex, maxVisible){
        var i
        var text = ""
        for(i=0; i < maxVisible; i++){
              text = text + Storage.getMemDB(magnitudeSelector.inputO3.saveStamp + "_" + Constants.memoryRepeatValueId[i] + "_" +  memIndex, "-") + (((i + 1) < maxVisible) ? " " : "")
        }
        return text
    }

    function exitMemory(){
        Therapies.extiMemory()
        memoryBoard.state = "noViewMemory"
    }

    states:[
        State{
            name: "memoryStart"
            PropertyChanges { target: memoryBoard; visible: true }
            PropertyChanges { target: memoryTopBar; visible: true }
            PropertyChanges { target: memoryBottomBar; visible: true }
            PropertyChanges { target: memoryExternBottomBar; visible: true }
            PropertyChanges { target: memoryWindow; visible: true }
        },
        State{
            name: "noViewMemory"
            PropertyChanges { target: memoryBoard; visible: false }
            PropertyChanges { target: keyboard; visible: false }
            PropertyChanges { target: memoryTopBar; visible: false}
            PropertyChanges { target: memoryBottomBar; visible: false}
            PropertyChanges { target: memoryExternBottomBar; visible: false}
            PropertyChanges { target: memoryWindow; visible: false}
            StateChangeScript {script: Therapies.completeGadgetCloseEffect()}
        },
        State{
            name: "noViewMemoryQuick"
            PropertyChanges { target: memoryBoard; visible: false }
            PropertyChanges { target: keyboard; visible: false }
            PropertyChanges { target: memoryTopBar; visible: false}
            PropertyChanges { target: memoryBottomBar; visible: false}
            PropertyChanges { target: memoryExternBottomBar; visible: false}
            PropertyChanges { target: memoryWindow; visible: false}
        },
        State{
            name: "memoryStartPending"
        }
    ]

    property alias memoryTopBar: memoryTopBar
    property alias memoryBottomBar: memoryBottomBar
    property alias memoryExternBottomBar: memoryExternBottomBar
    property alias memoryWindow: memoryWindow

    transitions:[
        Transition {
            to: "noViewMemory"
            SequentialAnimation{
                ScriptAction{ script: { keyboard.anchors.left = undefined; keyboard.anchors.right = undefined } }
                PropertyAnimation { target: keyboard; property: "visible"; to: false; duration: 0}
            }
        },
        Transition {
            to: "noViewMemoryQuick"
            ScriptAction{ script: { keyboard.anchors.left = undefined; keyboard.anchors.right = undefined} }
        }
    ]

    x: fullViewX
    y: fullViewY
    width: fullViewWidth
    height: fullViewHeight
    state: "noViewMemory"

    color: Storage.getAppDB(Constants.dbAppColor.memoryPanelId, "black")
    radius: buttonRadius

    onVisibleChanged: {
        if(visible){
            setMemoryKeyboardPosition()
            visibleMemoryItemsPerRow()
            restoreSettingsAfterSaving()
            restoreSettingsAfterUpdating()
            labelsFakeRectangleForSavingEffectSpacing = QtConstants.magnitudeSelectorRowSpacing * magnitudeSelector.narrowMarginCoeficient
            gostMarginRectangleWidth = updateGostMarginRectangleWidth()
        }
    }

    Component.onCompleted: {
        loadMemoryContent()
    }

    Rectangle{
        id: testButton
        height: 40
        width: 40
        color: "green"
        border.color: "orange"
        z: memoryBoard.z + 1
        anchors.bottom: memoryTopBar.top
        visible: viewGrid

        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log(": ",)
            }
        }
    }

    Rectangle{
        id: memoryTopBar
        height: memoryTopBarFullViewHeight
        width: memoryBoard.width
        color: memoryBoard.color
        border.color: viewGrid ? "deeppink" : "transparent"
        z: memoryBoard.z + 1
        radius: buttonRadius
        visible: false
        opacity: 1

        Rectangle{
            id: backButtom
            height: operationButtonWidth
            width: height
            color: buttonColor
            border.color: viewGrid ? "lightblue" : "transparent"
            radius: buttonRadius
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: memoryItemsSpacing
            anchors.rightMargin: memoryItemsSpacing

            Button{
                id: backButtomButton
                opacity: 0
                anchors.fill: parent
                onClicked: exitMemory()
            }
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.backId, "")
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
                opacity: backButtomButton.down ? 0.4 : 1
            }
        }

        Rectangle{
            id: iconsArea
            anchors.top: parent.top
            anchors.topMargin: memoryItemsSpacing
            anchors.left: parent.left
            anchors.leftMargin: memoryItemHeight + (3 * memoryItemsSpacing)
            height: operationButtonWidth
            width: memoryBoard.width - (3 * memoryItemHeight) - (5 * memoryItemsSpacing)
            color: "transparent"
            border.color: viewGrid ? "lightgreen" : "transparent"
            Row{
                anchors.fill: parent
                spacing: memoryItemsSpacing
                Repeater{
                    id: memoryRepeater
                    model: elementsPerMemory
                    Rectangle {
                        id: memoryLabel
                        color: "transparent"
                        border.color: viewGrid ? "brown" : "transparent"
                        visible: {
                            switch (index){
                            case 0:  magnitudeSelector.inputNormoOrHiper.visible; break
                            case 1:  magnitudeSelector.inputCycles.visible; break
                            case 2:  magnitudeSelector.inputPreviousVaccumYesNo.visible; break
                            case 3:  magnitudeSelector.inputSalineVolume.visible; break
                            case 4:  magnitudeSelector.inputBottleVolume.visible; break
                            case 5:  magnitudeSelector.inputBloodVolume.visible; break
                            case 6:  magnitudeSelector.inputLiquidVolume.visible; break
                            case 7:  magnitudeSelector.inputVacuumTime.visible; break
                            case 8:  magnitudeSelector.inputO3.visible; break
                            case 9:  magnitudeSelector.inputFlow.visible; break
                            case 10: magnitudeSelector.inputTime.visible; break
                            case 11: magnitudeSelector.inputTimeVolume.visible; break
                            case 12: magnitudeSelector.inputTotalConcentration.visible; break
                            case 13: magnitudeSelector.inputVolumeDose.visible; break
                            case 14: magnitudeSelector.inputTimeDose.visible; break
                            case 15: magnitudeSelector.inputVolume.visible; break
                            case 16: magnitudeSelector.inputTherapyTime.visible; break
                            case 17: magnitudeSelector.inputCleanTime.visible; break
                            case 18: magnitudeSelector.inputPressure.visible; break
                            case 19: magnitudeSelector.inputReinfusionTime.visible; break
                            case 20: magnitudeSelector.inputIp.visible; break
                            case 21: magnitudeSelector.inputSalineTime.visible; break
                            default: true
                            }
                        }
                        height: parent.height
                        width: (parent.width - ((visibleRowItemsNumber - 1) * memoryItemsSpacing)) / visibleRowItemsNumber
                        Image{
                            height: (index < 3) ? memoryLabel.height * 0.65 :  memoryLabel.height
                            width: (index < 3) ? memoryLabel.height * 0.65 :memoryLabel.height
                            anchors.centerIn: parent
                            asynchronous: true                // performance improvement
                            sourceSize.width: parent.width    // performance improvement
                            sourceSize.height:  parent.height // performance improvement
                            source: {
                                switch (index){
                                case 0:  magnitudeSelector.inputNormoHiperImage; break
                                case 1:  magnitudeSelector.inputCyclesMainImage.source; break
                                case 2:  magnitudeSelector.inputPreviousVaccumYesImage; break
                                case 3:  magnitudeSelector.inputSalineVolume.mainImage.source; break
                                case 4:  magnitudeSelector.inputBottleVolume.mainImage.source; break
                                case 5:  magnitudeSelector.inputBloodVolume.mainImage.source; break
                                case 6:  magnitudeSelector.inputLiquidVolume.mainImage.source; break
                                case 7:  magnitudeSelector.inputVacuumTime.mainImage.source; break
                                case 8:  magnitudeSelector.inputO3.mainImage.source; break
                                case 9:  magnitudeSelector.inputFlow.mainImage.source; break
                                case 10: magnitudeSelector.inputTime.mainImage.source; break
                                case 11: magnitudeSelector.inputTimeVolume.mainImage.source; break
                                case 12: magnitudeSelector.inputTotalConcentration.mainImage.source; break
                                case 13: magnitudeSelector.inputVolumeDose.mainImage.source; break
                                case 14: magnitudeSelector.inputTimeDose.mainImage.source; break
                                case 15: magnitudeSelector.inputVolume.mainImage.source; break
                                case 16: magnitudeSelector.inputTherapyTime.mainImage.source; break
                                case 17: magnitudeSelector.inputCleanTime.mainImage.source; break
                                case 18: magnitudeSelector.inputPressure.mainImage.source; break
                                case 19: magnitudeSelector.inputReinfusionTime.mainImage.source; break
                                case 20: magnitudeSelector.inputIp.mainImage.source; break
                                case 21: magnitudeSelector.inputSalineTime.mainImage.source; break
                                default: true
                                }
                            }
                        }
                    }
                }
            }
        }

    }

    Rectangle{
        id: memoryBottomBar
        height: memoryItemsSpacing * 0.6
        width: memoryBoard.width
        anchors.bottom: memoryBoard.bottom
        color: memoryBoard.color
        border.color: viewGrid ? "yellowGreen" : "transparent"
        z: memoryBoard.z + 1
        radius: buttonRadius
        visible: false
    }

    Rectangle{
        id: memoryExternBottomBar
        height: memoryItemHeight + (1.3 * memoryItemsSpacing)
        width: memoryBoard.width
        anchors.top: memoryBoard.bottom
        color: backColor
        border.color: viewGrid ? "lightgreen" : "transparent"
        z: memoryBoard.z + 1
        visible: false //M->
    }

    ListModel {
        id: memoryModel
        dynamicRoles: true
//        ListElement {
//            value0: "-"
//            value1: "-"
//            value2: "-"
//            value3: "-"
//            value4: "-"
//            value5: "-"
//            value6: "-"
//            value7: "-"
//            value8: "-"
//            value9: "-"
//            value10: "-"
//            value11: "-"
//            value12: "-"
//            value13: "-"

//            memTex: "-"

//            text0: "-"
//            text1: "-"
//            text2: "-"
//            text3: "-"
//            text4: "-"
//            text5: "-"
//            text6: "-"
//            text7: "-"
//            text8: "-"
//            text9: "-"
//            text10: "-"
//            text11: "-"
//            text12: "-"
//            text13: "-"

//            color0:  ""
//            color1:  ""
//            color2:  ""
//            color3:  ""
//            color4:  ""
//            color5:  ""
//            color6:  ""
//            color7:  ""
//            color8:  ""
//            color9:  ""
//            color10: ""
//            color11: ""
//            color12: ""
//            color13: ""

//            visible0: true
//            visible1: true
//            visible2: true
//            visible3: true
//            visible4: true
//            visible5: true
//            visible6: true
//            visible7: true
//            visible8: true
//            visible9: true
//            visible10: true
//            visible11: true
//            visible12: true
//            visible13: true
//        }
    }

    Rectangle{
        id: memoryWindow
        width: memoryBoard.width - (2 * memoryItemsSpacing)
        x: memoryItemsSpacing
        anchors.top: memoryTopBar.bottom
        anchors.bottom: memoryBottomBar.top
        color: "transparent"
        border.color: viewGrid ? "lightblue" : "transparent"
        opacity: 1
        visible: false

        Component {
            id: memoryDelegate

            Row {
                spacing: memoryItemsSpacing
                Rectangle{
                    id: memoryIcon
                    height: memoryItemHeight
                    width: height
                    radius: buttonRadius
                    color: buttonColor
                    Image{
                        anchors.fill: parent
                        source: Storage.getAppDB(Constants.dbAppIcon.saveId, "")
                        asynchronous: true                // performance improvement
                        sourceSize.width: parent.width    // performance improvement
                        sourceSize.height: parent.height  // performance improvement
                    }
                    Text{
                        height: memoryItemHeight * 0.28
                        width: height
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: memoryItemHeight * 0.11
                        anchors.rightMargin: memoryItemHeight * 0.11
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        fontSizeMode: Text.Fit
                        font.pixelSize: parent.height
                        text: index + 1
                        Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                            border.color: "lightblue"
                            visible: viewGrid
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: prepareContextForSaving(index)
                    }
                }
                Rectangle{
                    id: memoryViewArea
                    height: memoryItemHeight
                    width: memoryBoard.width - (2 * (memoryItemHeight + (2 * memoryItemsSpacing)))
                    radius: buttonRadius
                    color: buttonColor

                    Row{
                        id: memoryRow
                        anchors.left: parent.left
                        anchors.leftMargin: memoryItemsSpacing
                        spacing: memoryItemsSpacing
                        z:1
                        Repeater{
                            id: memoryRepeater
                            model: elementsPerMemory
                            Text {
                                id: memoryLabel
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                fontSizeMode: Text.Fit
                                font.pixelSize: parent.height
                                z: (index === 8) ? z = 2 : z = 0
                                opacity: {
                                    switch (index){
                                        case 0: (value0 !== "-") ? 0 : 1;  break
                                        case 2: (value2 !== "-") ? 0 : 1;  break
                                        default: 1
                                    }
                                }
                                color: {
                                    switch (index){
                                        case 0:  color0;  break
                                        case 1:  color1;  break
                                        case 2:  color2;  break
                                        case 3:  color3;  break
                                        case 4:  color4;  break
                                        case 5:  color5;  break
                                        case 6:  color6;  break
                                        case 7:  color7;  break
                                        case 8:  color8;  break
                                        case 9:  color9;  break
                                        case 10: color10; break
                                        case 11: color11; break
                                        case 12: color12; break
                                        case 13: color13; break
                                        case 14: color14; break
                                        case 15: color15; break
                                        case 16: color16; break
                                        case 17: color17; break
                                        case 18: color18; break
                                        case 19: color19; break
                                        case 20: color20; break
                                        case 21: color21; break
                                        default: "white"
                                    }
                                }

                                text: {
                                    switch (index){
                                        case 0:  value0;  break
                                        case 1:  value1;  break
                                        case 2:  value2;  break
                                        case 3:  value3;  break
                                        case 4:  value4;  break
                                        case 5:  value5;  break
                                        case 6:  value6;  break
                                        case 7:  value7;  break
//                                      case 8:  value8;  break
//                                      case 8:  (memoryLabelFrameId.visible) ? "..." : value8;  break •	// trac #3707
                                        case 8:  ((index === 8) && visible8 && (visible1) && (value1 > 1) && (repeatState)) ? "..." : value8;  break
                                        case 9:  value9;  break
                                        case 10: value10; break
                                        case 11: value11; break
                                        case 12: value12; break
                                        case 13: value13; break
                                        case 14: value14; break
                                        case 15: value15; break
                                        case 16: value16; break
                                        case 17: value17; break
                                        case 18: "-" + value18; break
                                        case 19: value19; break
                                        case 20: value20; break
                                        case 21: value21; break
                                        default: ""
                                    }
                                }

                                visible: {
                                    switch (index){
                                        case 0:  visible0;  break
                                        case 1:  visible1;  break
                                        case 2:  visible2;  break
                                        case 3:  visible3;  break
                                        case 4:  visible4;  break
                                        case 5:  visible5;  break
                                        case 6:  visible6;  break
                                        case 7:  visible7;  break
                                        case 8:  visible8;  break
                                        case 9:  visible9;  break
                                        case 10: visible10; break
                                        case 11: visible11; break
                                        case 12: visible12; break
                                        case 13: visible13; break
                                        case 14: visible14; break
                                        case 15: visible15; break
                                        case 16: visible16; break
                                        case 17: visible17; break
                                        case 18: visible18; break
                                        case 19: visible19; break
                                        case 20: visible20; break
                                        case 21: visible21; break
                                        default: true
                                    }
                                }
                                height: memoryViewArea.height * memoryLabelHeightProportionalFactor
                                width: (memoryViewArea.width - keyBoardButtom.width - ( (visibleRowItemsNumber + 1) * memoryItemsSpacing)) / visibleRowItemsNumber

                                Rectangle{  // show exended values of O3 concentration in autohemo
                                    id: memoryLabelFrameId
                                    anchors.fill: parent
                                    color: "transparent"
                                    border.color: viewGrid ? "lightgreen" : "transparent"
                                    visible: (index === 8) && visible8 && (visible1) && (value1 > 1) && (repeatState)
                                    Text {
                                        anchors.right: parent.right
                                        anchors.bottom: parent.bottom
                                        height: memoryLabelFrameId.height * 0.45
                                        width: height
                                        verticalAlignment: Text.AlignTop
                                        horizontalAlignment: Text.AlignRight
                                        font.pixelSize: height * 0.6
                                        color: color8
                                        text: "\u25BC" // down triangle
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            extendedTextVisibility = true
                                            memoryList.currentIndex = indexEntry
                                        }
                                        onPressAndHold: prepareContextForUpdating(indexEntry)
                                    }
                                }
                                Text {  // show exended values of O3 concentration in autohemo
                                    id: extendedTextId
                                    anchors.horizontalCenter: memoryLabelFrameId.horizontalCenter
                                    y: memoryItemHeight * 0.4
                                    height: memoryLabelFrameId.height * 0.8
                                    visible: (extendedTextVisibility && memoryLabelFrameId.visible)
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.pixelSize: parent.height * 0.55
                                    color: color8
                                    z: parent.z + 1
                                    text: (visible) ? setExendedTex(indexEntry, value1) : ""
                                    onVisibleChanged: (visible) ? extendedTextTimerId.running = true : extendedTextTimerId.running = false
                                    Timer {
                                        id: extendedTextTimerId
                                        interval: 1200
                                        repeat: false
                                        running: false
                                        onTriggered: {
                                            extendedTextVisibility = false
                                        }
                                    }
                                }
                                Rectangle{  // show exended values of O3 concentration in autohemo
                                    height: extendedTextId.height
                                    width: extendedTextId.width * 1.1
                                    anchors.centerIn: extendedTextId
                                    color: buttonColor
                                    border.color: Storage.getAppDB(Constants.dbAppColor.memoryExtendedValuesBorderId, "black")
                                    visible: extendedTextId.visible
                                    radius: height * 0.03
                                }
                                Rectangle{
                                    anchors.fill: parent
                                    color: "transparent"
                                    border.color: "pink"
                                    visible: viewGrid
                                }
                            }
                        }
                    }

                    Row{ // this row is placed over the memoryRow one to replace some texts by icons
                        id: memoryRowGhost
                        x: memoryRow.x
                        y: memoryRow.y
                        width: memoryRow.width
                        height: memoryRow.height
                        spacing: memoryItemsSpacing
                        Repeater{
                            id: memoryRepeaterGhost
                            model: elementsPerMemory
                            Item{
                                height: memoryViewArea.height * memoryLabelHeightProportionalFactor
                                width: (memoryViewArea.width - keyBoardButtom.width - ( (visibleRowItemsNumber + 1) * memoryItemsSpacing)) / visibleRowItemsNumber
                                visible: {
                                    switch (index){
                                    case 0:  visible0;  break
                                    case 1:  visible1;  break
                                    case 2:  visible2;  break
                                    default: false; break
                                    }
                                }
                                Image {
                                    id: imageGost
                                    height: parent.height
                                    width: height
                                    anchors.centerIn: parent
                                    asynchronous: true                // performance improvement
                                    sourceSize.width: parent.width    // performance improvement
                                    sourceSize.height: parent.height  // performance improvement
                                    visible: {
                                        switch (index){
                                        case 0:  visible0;  break
                                        case 2:  visible2;  break
                                        default: false; break
                                        }
                                    }
                                    source: {
                                        switch (index){
                                        case 0: if (value0 === "N"){ magnitudeSelector.inputNormoImage }
                                            else if (value0 === "H"){ magnitudeSelector.inputHiperImage }
                                            else{ "" }
                                            break
                                        case 2: if (value2 === "1"){ magnitudeSelector.inputPreviousVaccumYesImage }
                                            else if (value2 === "0"){ magnitudeSelector.inputPreviousVaccumNoImage }
                                            else{ "" }
                                            break
                                        default: ""
                                        }
                                    }
                                }
                                Colorize {
                                    anchors.fill: imageGost
                                    source: imageGost
                                    visible: imageGost.visible & ((value0 !== "-"))
                                    hue: 0.0
                                    saturation: 0.0
                                    lightness:  -0.1//0.0
                                }
                                Rectangle{
                                    anchors.fill: parent
                                    color: "transparent"
                                    border.color: "magenta"
                                    visible: viewGrid
                                }
                            }
                        }
                    }

                    Rectangle{
                        id: keyBoardButtom
                        height: parent.height
                        width: keyboardButtomHeight
                        color: "transparent"
                        border.color: viewGrid ? "orange" : "transparent"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        Image{
                            width: parent.width
                            height: width
                            anchors.bottom: parent.bottom
                            source: Storage.getAppDB(Constants.dbAppIcon.keyboradId, "")
                            asynchronous: true                // performance improvement
                            sourceSize.width: parent.width    // performance improvement
                            sourceSize.height: parent.height  // performance improvement
                            opacity: keyBoardButtomButton.down ? 0.4 : 1
                        }
                        Button{
                            id: keyBoardButtomButton
                            anchors.fill: parent
                            opacity: 0
                            onClicked: {
                                selectedMemoryRow = index
                                keyboard.visible = true
                                textInput.text = memTex
                                textInputBackFrame.state = "visible"
                                memoryList.currentIndex = index // perform highligthing memory register on keyboard symbol pressed
                            }
                        }
                    }

                    Text{
                        id: memoryName
                        height: memoryItemHeight * (1 - memoryLabelHeightProportionalFactor)
                        width: memoryViewArea.width - keyBoardButtom.width - (2 * memoryItemsSpacing)
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: memoryItemsSpacing
                        verticalAlignment: Text.AlignVCenter
                        fontSizeMode: Text.Fit
                        elide: Text.ElideRight
                        color: Storage.getAppDB(Constants.dbAppColor.memoryNameId, "black")
                        text: memTex

                        Rectangle{
                            anchors.fill: parent
                            color: "transparent"
                            border.color: "green"
                            visible: viewGrid
                        }
                    }
                    MouseArea{
                        height: memoryItemHeight
                        width: memoryViewArea.width - keyBoardButtom.width
                        pressAndHoldInterval: 200
                        onPressAndHold: prepareContextForUpdating(index)
                        onClicked: {
                            memoryList.currentIndex = index
                            extendedTextVisibility = true
                        }
                    }
                }
            }
        }

        ListView {
            id: memoryList
            anchors.fill: parent
            model: memoryModel
            spacing: memoryItemsSpacing
            delegate: memoryDelegate
            highlight: Rectangle {
                id: memoryListHighlightRectangle
                z: 100
                color: "transparent"
                opacity: 0.8
                border.width: 1
                border.color: Storage.getAppDB(Constants.dbAppColor.memoryHighLihgtSelectionId, "black")
                radius: buttonRadius
                Rectangle {
                    anchors.fill: parent
                    color: parent.color
                    opacity: 0.1
                    radius: buttonRadius
                }
            }
            highlightMoveVelocity : 2000 // pixels per  second
            clip: true // avoid to show highlight outside the list view area

            ScrollBar.vertical: ScrollBar {
                id: memoryListScrollBar
                width: memoryItemHeight * 0.25
                anchors.left: parent.right
                anchors.leftMargin: - width
                policy: ScrollBar.AlwaysOn
            }
        }
    }

//
// Text input form memory names management
//
    Rectangle{
        id: textInputBackFrame
        height:0
        width: parent.width - (2 * memoryBottomBar.height)
        x: memoryBottomBar.height
        y: memoryBottomBar.height
        z: memoryBoard.z + 2
        color: Storage.getAppDB(Constants.dbAppColor.memoryTextInputId, "black")
        border.color: viewGrid ? "olive" : "transparent"

        MouseArea{                  // Bug solved
            anchors.fill: parent    // When clicking over right side of the rectangle, the memory exit button (in the back)
        }                           // receives the signal and the memory widow closes unexpectedly

        Image{
            id: memoryNumberIcon
            height: memoryItemHeight
            width: height
            source: Storage.getAppDB(Constants.dbAppIcon.saveId, "")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: memoryBottomBar.height
            opacity: 0
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height  // performance improvement
            Text{
                height: memoryItemHeight * 0.28
                width: height
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: memoryItemHeight * 0.11
                anchors.rightMargin: memoryItemHeight * 0.11
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                font.pixelSize: parent.height
                text: selectedMemoryRow + 1
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "lightblue"
                    visible: viewGrid
                }
            }
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "green"
                visible: viewGrid
            }
        }

        TextInput {
            id: textInput
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: memoryNumberIcon.right
            anchors.leftMargin: memoryBottomBar.height
            anchors.right: parent.right
            anchors.rightMargin: memoryBottomBar.height
            color: Storage.getAppDB(Constants.dbAppColor.memoryTextEditorId, "black")
            text: ""
            verticalAlignment: TextInput.AlignVCenter
            opacity: 0
            z: memoryBoard.z + 2

            onContentWidthChanged: {
                if(textInput.contentWidth >= textInput.width){
                    textInput.text = textInput.text.substring(0, textInput.text.length - 1)
                }
            }
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "orange"
                visible: viewGrid
            }

            onEditingFinished: {
             // * 'rebounds' here that generates bad refresh textInput
             //   solved in onVisibleChanged of main element
                Storage.setMemDB(tabBar.selectedOption + "_" + Constants.memoryTextId + selectedMemoryRow, textInput.text)
                Storage.saveMemDB()
                debug.log(DC.memoryLog, "Saving memory :", tabBar.selectedOption + "_" + Constants.memoryTextId + selectedMemoryRow)
                memoryModel.set(selectedMemoryRow, {"memTex": textInput.text})
            }
        }
        states:[
            State {
                name: "visible"
                PropertyChanges { target: textInputBackFrame; height: parent.height - (2 * memoryBottomBar.height) - keyboard.height }
                PropertyChanges { target: textInput; focus: true }
                PropertyChanges { target: textInput; opacity: 1 }
                PropertyChanges { target: memoryNumberIcon; opacity: 1 }
            },
            State {
                name: "invisible"
                when: (!(keyboard.active) & (textInputBackFrame.visible))
                PropertyChanges { target: textInputBackFrame; height: 0 }
                PropertyChanges { target: textInput; focus: false }
                PropertyChanges { target: textInput; opacity: 0 }
                PropertyChanges { target: memoryNumberIcon; opacity: 0 }
            }
        ]
        transitions:[
            Transition {
                to: "visible"
                SequentialAnimation{
                    NumberAnimation { properties: "height"; duration: 250; easing.type: Easing.InOutQuad }
                    PropertyAction { target: memoryNumberIcon; property: "opacity" }
                    PropertyAction { target: textInput; property: "opacity" }
                    PropertyAction { target: textInput; property: "focus" }
                }
            },
            Transition {
                to: "invisible"
                SequentialAnimation{
                    PropertyAction { target: textInput; property: "opacity" }
                    PropertyAction { target: memoryNumberIcon; property: "opacity" }
                    NumberAnimation { properties: "height"; duration: 250; easing.type: Easing.InOutQuad }
                }
            }
        ]
    }

//
// Saving and restoring memory effect
//
    function xCorrectionforSavingEffect(){
        if(magnitudeSelector.inputCyclesFake.visible){
            return (3 * oneItemFinalWidthforSavingEffect) + (1 * memoryItemsSpacing) - magnitudeSelector.inputCycles.width
        }
        else if(magnitudeSelector.inputPreviousVaccumYesNo.visible){
            return oneItemFinalWidthforSavingEffect
        }
        else{
            return (-memoryItemsSpacing)
        }
    }

    function restoreSettingsAfterSaving(){
        labelsFakeRectangleForSavingEffect.width = magnitudeSelector.width
        gostMarginRectangleWidth = updateGostMarginRectangleWidth()
    }

    Rectangle{
        id: labelsFakeRectangleForSavingEffect
        opacity: 0
        x: magnitudeSelector.x - memoryBoard.x
        width: magnitudeSelector.width
//      keep commented (affect to magnitude selector transition)
//      height: magnitudeSelector.inputO3.magnitudeLabel.height
//      y: magnitudeSelector.y + magnitudeSelector.inputO3.y + magnitudeSelector.inputO3.magnitudeLabel.y - memoryBoard.y
        height: magnitudeSelector.inputO3.magnitudeLabelHeigtht_reducedView
        y: magnitudeSelector.y + magnitudeSelector.inputO3.initialY + magnitudeSelector.inputO3.magnitudeLabelY_reducedView - memoryBoard.y
        color: "transparent"
        border.color: viewGrid ? "yellow" : "transparent"
        z: memoryTopBar.z + 1

        Row{
            anchors.fill: parent
            spacing: labelsFakeRectangleForSavingEffectSpacing
            Rectangle{
                id: gostMarginRectangle
                height: 10
                width: gostMarginRectangleWidth
                color: "transparent"
                border.color: viewGrid ? "white" : "transparent"
            }

            Repeater{
                model: elementsPerMemory
                Rectangle {
                    color: "transparent"
                    border.color: viewGrid ? "magenta" : "transparent"
                    height: parent.height
                    width: {
                        switch (index){
                        case 1:  magnitudeSelector.inputCycles.width; break
                        default:magnitudeSelectorFakeRectangleForSavingEffectWidth
                        }
                    }

                    visible: {
                        switch (index){
                        case 0:  false; break;//magnitudeSelector.inputNormoOrHiper.visible; break
                        case 1:  magnitudeSelector.inputCycles.visible; break
                        case 2:  false; break;//magnitudeSelector.inputPreviousVaccumYesNo.visible; break
                        case 3:  magnitudeSelector.inputSalineVolume.visible; break
                        case 4:  magnitudeSelector.inputBottleVolume.visible; break
                        case 5:  magnitudeSelector.inputBloodVolume.visible; break
                        case 6:  magnitudeSelector.inputLiquidVolume.visible; break
                        case 7:  magnitudeSelector.inputVacuumTime.visible; break
                        case 8:  magnitudeSelector.inputO3.visible; break
                        case 9:  magnitudeSelector.inputFlow.visible; break
                        case 10: magnitudeSelector.inputTime.visible; break
                        case 11: magnitudeSelector.inputTimeVolume.visible; break
                        case 12: magnitudeSelector.inputTotalConcentration.visible; break
                        case 13: magnitudeSelector.inputVolumeDose.visible; break
                        case 14: magnitudeSelector.inputTimeDose.visible; break
                        case 15: magnitudeSelector.inputVolume.visible; break
                        case 16: magnitudeSelector.inputTherapyTime.visible; break
                        case 17: magnitudeSelector.inputCleanTime.visible; break
                        case 18: magnitudeSelector.inputPressure.visible; break
                        case 19: magnitudeSelector.inputReinfusionTime.visible; break
                        case 20: magnitudeSelector.inputIp.visible; break
                        case 21: false; break;//magnitudeSelector.inputSalineTime.visible; break
                        default: true
                        }
                    }

                    Text{
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        fontSizeMode: Text.Fit
                        font.pixelSize: parent.height
                        text: {
                            switch (index){
//                          case 0:  magnitudeSelector.inputNormoOrHiper.theraphyPressure; break
//                          case 1:  magnitudeSelector.theraphyCycles; break
//                          case 2:  magnitudeSelector.previousVacuum; break
                            case 3:  magnitudeSelector.inputSalineVolume.magnitudeLabel.text; break
                            case 4:  magnitudeSelector.inputBottleVolume.magnitudeLabel.text; break
                            case 5:  magnitudeSelector.inputBloodVolume.magnitudeLabel.text; break
                            case 6:  magnitudeSelector.inputLiquidVolume.magnitudeLabel.text; break
                            case 7:  magnitudeSelector.inputVacuumTime.magnitudeLabel.text; break
                            case 8:  magnitudeSelector.inputO3.magnitudeLabel.text; break
                            case 9:  magnitudeSelector.inputFlow.magnitudeLabel.text; break
                            case 10: magnitudeSelector.inputTime.magnitudeLabel.text; break
                            case 11: magnitudeSelector.inputTimeVolume.magnitudeLabel.text; break
                            case 12: magnitudeSelector.inputTotalConcentration.magnitudeLabel.text; break
                            case 13: magnitudeSelector.inputVolumeDose.magnitudeLabel.text; break
                            case 14: magnitudeSelector.inputTimeDose.magnitudeLabel.text; break
                            case 15: magnitudeSelector.inputVolume.magnitudeLabel.text; break
                            case 16: magnitudeSelector.inputTherapyTime.magnitudeLabel.text; break
                            case 17: magnitudeSelector.inputCleanTime.magnitudeLabel.text; break
                            case 18: magnitudeSelector.inputPressure.magnitudeLabel.text; break
                            case 19: magnitudeSelector.inputReinfusionTime.magnitudeLabel.text; break
                            case 20: magnitudeSelector.inputIp.magnitudeLabel.text; break
                            case 21: magnitudeSelector.inputSalineTime.magnitudeLabel.text; break
                            default: ""
                            }
                        }
                        color: {
                            switch (index){
//                          case 0:  magnitudeSelector.inputNormoOrHiper.magnitudeLabel.color; break
                            case 1:  magnitudeSelector.inputCyclesLabel.color; break
//                          case 2:  magnitudeSelector.inputPreviousVaccumYesNo.magnitudeLabel.color; break
                            case 3:  magnitudeSelector.inputSalineVolume.magnitudeLabel.color; break
                            case 4:  magnitudeSelector.inputBottleVolume.magnitudeLabel.color; break
                            case 5:  magnitudeSelector.inputBloodVolume.magnitudeLabel.color; break
                            case 6:  magnitudeSelector.inputLiquidVolume.magnitudeLabel.color; break
                            case 7:  magnitudeSelector.inputVacuumTime.magnitudeLabel.color; break
                            case 8:  magnitudeSelector.inputO3.magnitudeLabel.color; break
                            case 9:  magnitudeSelector.inputFlow.magnitudeLabel.color; break
                            case 10: magnitudeSelector.inputTime.magnitudeLabel.color; break
                            case 11: magnitudeSelector.inputTimeVolume.magnitudeLabel.color; break
                            case 12: magnitudeSelector.inputTotalConcentration.magnitudeLabel.color; break
                            case 13: magnitudeSelector.inputVolumeDose.magnitudeLabel.color; break
                            case 14: magnitudeSelector.inputTimeDose.magnitudeLabel.color; break
                            case 15: magnitudeSelector.inputVolume.magnitudeLabel.color; break
                            case 16: magnitudeSelector.inputTherapyTime.magnitudeLabel.color; break
                            case 17: magnitudeSelector.inputCleanTime.magnitudeLabel.color; break
                            case 18: magnitudeSelector.inputPressure.magnitudeLabel.color; break
                            case 19: magnitudeSelector.inputReinfusionTime.magnitudeLabel.color; break
                            case 20: magnitudeSelector.inputIp.magnitudeLabel.color; break
                            case 21: magnitudeSelector.inputSalineTime.magnitudeLabel.color; break
                            default: "transparent"
                            }

                        }
                    }
                }
            }
        }

        states: [
            State {
                name: "saving"
            },
            State {
                name: "saved"
                PropertyChanges { target: labelsFakeRectangleForSavingEffect; opacity: 0 }
                AnchorChanges { target: labelsFakeRectangleForSavingEffect; anchors.horizontalCenter: undefined }
                AnchorChanges { target: labelsFakeRectangleForSavingEffect; anchors.verticalCenter: undefined }
                PropertyChanges { target: labelsFakeRectangleForSavingEffect; height: magnitudeSelector.inputO3.magnitudeLabelHeigtht_reducedView }
                PropertyChanges { target: savingEffect; visible: false }
            }
        ]
        transitions: [
            Transition {
                to: "saving"
                SequentialAnimation{
                    PropertyAnimation { target: labelsFakeRectangleForSavingEffect; property: "opacity"; to: 1}
                    ParallelAnimation{
                        PropertyAnimation { target: labelsFakeRectangleForSavingEffect; property: "y"; to: memoryFakeRectangleForSavingEffect.y; duration: savingEffectTransitionTime}
                        PropertyAnimation { target: labelsFakeRectangleForSavingEffect; property: "x"; to: memoryFakeRectangleForSavingEffect.x + xCorrectionforSavingEffect(); duration: savingEffectTransitionTime}
                        PropertyAnimation { target: labelsFakeRectangleForSavingEffect; property: "width"; to: memoryFakeRectangleForSavingEffect.width; duration: savingEffectTransitionTime}
                        PropertyAnimation { target: labelsFakeRectangleForSavingEffect; property: "opacity"; to: 0; duration: savingEffectTransitionTime}
                        PropertyAnimation { target: labelsFakeRectangleForSavingEffect; property: "height"; to: memoryFakeRectangleForSavingEffect.height; duration: savingEffectTransitionTime}
                        PropertyAnimation { target: memoryBoard; property: "magnitudeSelectorFakeRectangleForSavingEffectWidth"; to: oneItemFinalWidthforSavingEffect; duration: savingEffectTransitionTime}
                        PropertyAnimation { target: memoryBoard; property: "labelsFakeRectangleForSavingEffectSpacing"; to: memoryItemsSpacing; duration: savingEffectTransitionTime}
                        PropertyAnimation { target: memoryBoard; property: "gostMarginRectangleWidth"; to: 0; duration: savingEffectTransitionTime}
                    }
                    PropertyAnimation { target: labelsFakeRectangleForSavingEffect; property: "opacity"; to: 0}
                    ScriptAction{script: updateValuesAtEndOfSaveTransition()}
                    ScriptAction{script: restoreSettingsAfterSaving()}
                    PropertyAnimation { target: labelsFakeRectangleForSavingEffect; property: "state"; to: "saved"}
                }
            }
        ]
    }

    function computeUpdatingEffectException(){  // experimental adjust  :o(
        if(magnitudeSelector.inputCyclesFake.visible){
            return (labelsFakeRectangleForSavingEffectOiginX - 582) // 670
        }
        else if(magnitudeSelector.inputPreviousVaccumYesNo.visible){
            return  (labelsFakeRectangleForSavingEffectOiginX - 263)
        }
        else{
            return  (labelsFakeRectangleForSavingEffectOiginX)
        }
    }

    function restoreSettingsAfterUpdating(){
        memoryFakeRectangleForSavingEffectWidth = ((memoryBoard.width - (4 * memoryItemsSpacing) - (2 * memoryItemHeight) - operationButtonWidth) - ((visibleRowItemsNumber - 1) * memoryItemsSpacing)) / visibleRowItemsNumber
        memoryFakeRectangleForSavingEffectSpacing = memoryItemsSpacing
    }

    Rectangle{
        id: memoryFakeRectangleForSavingEffect
        z:200
        height: memoryItemHeight * memoryLabelHeightProportionalFactor
        width: memoryBoard.width - (4 * memoryItemsSpacing) - (2 * memoryItemHeight) - operationButtonWidth
        color: "transparent"
        opacity: 0
        border.color: viewGrid ? "blue" : "transparent"
        x: memoryItemHeight + (3 * memoryItemsSpacing)
        onYChanged: x = memoryItemHeight + (3 * memoryItemsSpacing)

        Row{
            anchors.fill: parent
            spacing: memoryFakeRectangleForSavingEffectSpacing
            Repeater{
                model: elementsPerMemory
                Rectangle {
                    color: "transparent"
                    border.color: viewGrid ? "pink" : "transparent"
                    visible: {
                        switch (index){
                        case 0:  magnitudeSelector.inputNormoOrHiper.visible; break
                        case 1:  magnitudeSelector.inputCycles.visible; break
                        case 2:  magnitudeSelector.inputPreviousVaccumYesNo.visible; break
                        case 3:  magnitudeSelector.inputSalineVolume.visible; break
                        case 4:  magnitudeSelector.inputBottleVolume.visible; break
                        case 5:  magnitudeSelector.inputBloodVolume.visible; break
                        case 6:  magnitudeSelector.inputLiquidVolume.visible; break
                        case 7:  magnitudeSelector.inputVacuumTime.visible; break
                        case 8:  magnitudeSelector.inputO3.visible; break
                        case 9:  magnitudeSelector.inputFlow.visible; break
                        case 10: magnitudeSelector.inputTime.visible; break
                        case 11: magnitudeSelector.inputTimeVolume.visible; break
                        case 12: magnitudeSelector.inputTotalConcentration.visible; break
                        case 13: magnitudeSelector.inputVolumeDose.visible; break
                        case 14: magnitudeSelector.inputTimeDose.visible; break
                        case 15: magnitudeSelector.inputVolume.visible; break
                        case 16: magnitudeSelector.inputTherapyTime.visible; break
                        case 17: magnitudeSelector.inputCleanTime.visible; break
                        case 18: magnitudeSelector.inputPressure.visible; break
                        case 19: magnitudeSelector.inputReinfusionTime.visible; break
                        case 20: magnitudeSelector.inputIp.visible; break
                        case 21: magnitudeSelector.inputSalineTime.visible; break
                        default: true
                        }
                    }

                    opacity: {
                        switch (index){
                        case 0:  0; break
                        case 1:  0; break
                        case 2:  0; break
                        default: 1
                        }
                    }

                    height: parent.height
                    width: memoryFakeRectangleForSavingEffectWidth

                    Text{
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        fontSizeMode: Text.Fit
                        font.pixelSize: parent.height
                        text:{
                            if((memoryModel.count == maxListItems) && (memoryBoard.visible)){ // avoid warnings on "memoryFakeRectangleForSavingEffect" element creation
                                switch (index){
                                case 0:  memoryModel.get(selectedMemoryRow).value0;  break
                                case 1:  memoryModel.get(selectedMemoryRow).value1;  break
                                case 2:  memoryModel.get(selectedMemoryRow).value2;  break
                                case 3:  memoryModel.get(selectedMemoryRow).value3;  break
                                case 4:  memoryModel.get(selectedMemoryRow).value4;  break
                                case 5:  memoryModel.get(selectedMemoryRow).value5;  break
                                case 6:  memoryModel.get(selectedMemoryRow).value6;  break
                                case 7:  memoryModel.get(selectedMemoryRow).value7;  break
                                case 8:  memoryModel.get(selectedMemoryRow).value8;  break
                                case 9:  memoryModel.get(selectedMemoryRow).value9;  break
                                case 10: memoryModel.get(selectedMemoryRow).value10; break
                                case 11: memoryModel.get(selectedMemoryRow).value11; break
                                case 12: memoryModel.get(selectedMemoryRow).value12; break
                                case 13: memoryModel.get(selectedMemoryRow).value13; break
                                case 14: memoryModel.get(selectedMemoryRow).value14; break
                                case 15: memoryModel.get(selectedMemoryRow).value15; break
                                case 16: memoryModel.get(selectedMemoryRow).value16; break
                                case 17: memoryModel.get(selectedMemoryRow).value17; break
                                case 18: memoryModel.get(selectedMemoryRow).value18; break
                                case 19: memoryModel.get(selectedMemoryRow).value19; break
                                case 20: memoryModel.get(selectedMemoryRow).value20; break
                                case 21: memoryModel.get(selectedMemoryRow).value21; break
                                default: 0
                                }
                            }
                            else{
                                ""
                            }
                        }
                        color: {
                            switch (index){
//                          case 0:  magnitudeSelector.inputNormoOrHiper.magnitudeLabel.color; break
                            case 1:  magnitudeSelector.inputCyclesLabel.color; break
//                          case 2:  magnitudeSelector.inputPreviousVaccumYesNo.magnitudeLabel.color; break
                            case 3:  magnitudeSelector.inputSalineVolume.magnitudeLabel.color; break
                            case 4:  magnitudeSelector.inputBottleVolume.magnitudeLabel.color; break
                            case 5:  magnitudeSelector.inputBloodVolume.magnitudeLabel.color; break
                            case 6:  magnitudeSelector.inputLiquidVolume.magnitudeLabel.color; break
                            case 7:  magnitudeSelector.inputVacuumTime.magnitudeLabel.color; break
                            case 8:  magnitudeSelector.inputO3.magnitudeLabel.color; break
                            case 9:  magnitudeSelector.inputFlow.magnitudeLabel.color; break
                            case 10: magnitudeSelector.inputTime.magnitudeLabel.color; break
                            case 11: magnitudeSelector.inputTimeVolume.magnitudeLabel.color; break
                            case 12: magnitudeSelector.inputTotalConcentration.magnitudeLabel.color; break
                            case 13: magnitudeSelector.inputVolumeDose.magnitudeLabel.color; break
                            case 14: magnitudeSelector.inputTimeDose.magnitudeLabel.color; break
                            case 15: magnitudeSelector.inputVolume.magnitudeLabel.color; break
                            case 16: magnitudeSelector.inputTherapyTime.magnitudeLabel.color; break
                            case 17: magnitudeSelector.inputCleanTime.magnitudeLabel.color; break
                            case 18: magnitudeSelector.inputPressure.magnitudeLabel.color; break
                            case 19: magnitudeSelector.inputReinfusionTime.magnitudeLabel.color; break
                            case 20: magnitudeSelector.inputIp.magnitudeLabel.color; break
                            case 20: magnitudeSelector.inputSalineTime.magnitudeLabel.color; break
                            default: "transparent"
                            }
                        }
                    }
                }
            }
        }

        states: [
            State {
                name: "updating"
            },
            State {
                name: "updated"
                PropertyChanges { target: memoryFakeRectangleForSavingEffect; opacity: 0 }
                AnchorChanges { target: memoryFakeRectangleForSavingEffect; anchors.horizontalCenter: undefined }
                AnchorChanges { target: memoryFakeRectangleForSavingEffect; anchors.verticalCenter: undefined }
                PropertyChanges { target: memoryFakeRectangleForSavingEffect; height: memoryItemHeight * memoryLabelHeightProportionalFactor }
                StateChangeScript {script: refreshValuesAtEndOfUpdate()}
            }
        ]
        transitions: [
            Transition {
                to: "updating"
                SequentialAnimation{
                    PropertyAnimation { target: memoryFakeRectangleForSavingEffect; property: "opacity"; to: 1}
                    ParallelAnimation{
                        PropertyAnimation { target: memoryFakeRectangleForSavingEffect; property: "y"; to: labelsFakeRectangleForSavingEffect.y; duration: updatingEffectTransitionTime}
                        PropertyAnimation { target: memoryFakeRectangleForSavingEffect; property: "x"; to: computeUpdatingEffectException(); duration: updatingEffectTransitionTime}
                        PropertyAnimation { target: memoryFakeRectangleForSavingEffect; property: "opacity"; to: 0; duration: updatingEffectTransitionTime *1.5}
                        PropertyAnimation { target: memoryFakeRectangleForSavingEffect; property: "height"; to: labelsFakeRectangleForSavingEffect.height; duration: updatingEffectTransitionTime}
                        PropertyAnimation { target: memoryFakeRectangleForSavingEffect; property: "width"; to: labelsFakeRectangleForSavingEffectWidth; duration: updatingEffectTransitionTime}
                        PropertyAnimation { target: memoryBoard; property: "memoryFakeRectangleForSavingEffectSpacing"; to: labelsFakeRectangleForSavingEffectSpacing; duration: savingEffectTransitionTime}
                        PropertyAnimation { target: memoryBoard; property: "memoryFakeRectangleForSavingEffectWidth"; to: QtConstants.inputElementWidth; duration: savingEffectTransitionTime}
                    }
                    ScriptAction{ script: updateMagnitudeLabels()}
                    ScriptAction{script: restoreSettingsAfterUpdating()}
                    PropertyAnimation { target: memoryFakeRectangleForSavingEffect; property: "state"; to: "updated"}
                }
            }
        ]
    }

    Rectangle{
        id: savingEffect
        x: memoryItemsSpacing + 2
        y: 0
        opacity: 1
        height: memoryItemHeight - 2
        width: height - 1
        radius: buttonRadius
        color: buttonColor
        visible: false
        Rectangle {
            anchors.fill: parent
            color: Storage.getAppDB(Constants.dbAppColor.memoryHighLihgtSelectionId, "black")
            opacity: 0.1
            radius: buttonRadius
        }
        AnimatedImage {
            id: savingGif
            anchors.centerIn: parent
            width: parent.width * 0.85
            height: parent.height * 0.85
            source: visible ? Storage.getAppDB(Constants.dbAppIcon.savingGifId, "") : "" // 12/2021
        }
    }
}

