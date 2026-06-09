// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.12

import "storage.js" as Storage
import "Constants.js" as Constants
import "Therapies.js" as Therapies
import "DebugConstants.js" as DC
import "Singletons"

Item {
    id: inputControl

    property alias inputControl: inputControl
    property alias slider: slider
    property alias unitsLabel: unitsLabel
    property alias unitsLabel2: unitsLabel2
    property alias magnitudeLabel: magnitudeLabel
    property alias magnitudeLabel2: magnitudeLabel2
    property alias mainImage: mainImage
    property alias mainDoubleImage: mainDoubleImage
    property alias mainCombinedImage: mainCombinedImage
    property alias fixButtonLabel_5: fixButtonLabel_5
    property alias fixButtonLabel_4: fixButtonLabel_4
    property alias fixButtonLabel_3: fixButtonLabel_3
    property alias fixButtonLabel_2: fixButtonLabel_2
    property alias fixButtonLabel_1: fixButtonLabel_1
    property alias inputForm: inputForm
    property alias auxRectangleForSavingEffect: auxRectangleForSavingEffect
    property alias magnitudeLabelForSavingEffect: magnitudeLabelForSavingEffect
    property alias magnitudeLabel2ForSavingEffect: magnitudeLabel2ForSavingEffect
    property alias magnitudeLabel3ForSavingEffect: magnitudeLabel3ForSavingEffect
    property alias differentValuesOnCycles: differentValuesOnCycles
    property alias fullControlButton: fullControlButton
    property alias changeSliderRangeLabel: changeSliderRangeLabel
    property alias changeSliderRangeButton:changeSliderRangeButton

    property bool viewGrid: false
    property bool inspected: false
    property bool doubleLabelVisible: false
    property bool dependentMagnitude: false
    property bool multilabelView: false
    property bool multiRangeSlider: false
    property bool sliderMaxDependent: false
    property bool differentValuesOnCyclesBack: false
    property bool buttonsVisibility: false
    property bool negativeMagnitude: false

    property int tit: 0
    property int initialX: 0
    property int initialY: 0
    property int fullViewX: 0
    property int fullViewY: 0
    property int fullViewWidth: 0
    property int fullViewHeight: 0
    property int therapyCyclesNumber: 0
    property int therapyCyclesNumberBack: 0
    property int operationButtonWidth: fullViewWidth * 0.085
    property int operationButtonHeight: fullViewWidth * 0.085
    property int fixButtonWidth: fullViewWidth * 0.1
    property int fixButtonHeight: fullViewWidth * 0.055
    property int fixButtonMargin: fullViewWidth * 0.025
    property int externalBorderMargin: fullViewWidth * 0.02
    property int sliderMargins: fullViewWidth * 0.035
    property int sliderverticalCenterOffset: fullViewWidth * 0.018
    property int upDownButtonBottomMargin: fullViewWidth * 0.12
    property int saveButtonBottomMargin: fullViewWidth * 0.12
    property int buttonRadius: fullViewWidth * 0.008
    property int fixButtonFontSize: fullViewWidth * 0.03
    property int magnitudeTextSize: fullViewWidth * 0.16
    property int unitsTextSize: fullViewWidth * 0.03
    property int backgroundRadius: fullViewWidth * 0.006
    property int mainImageSize: fullViewWidth * 0.20
    property int sliderRectangleHeight: fullViewWidth * 0.014
    property int sliderHandlePressed: fullViewWidth * 0.080
    property int sliderHandleUnpressed: fullViewWidth * 0.070
    property int mainImageWidth_reducedView: 0
    property int mainImageMargin_reducedView: 0
    property int mainImageDoubleWidth_reducedView: 10
    property int mainImageDoubleMargin_reducedView: 10
    property int magnitudeLabelFontSize_reducedView: 0
    property int magnitudeLabelFontSize2_reducedView: 0
    property int magnitudeLabelWidth_reducedView: 0
    property int magnitudeLabelHeigtht_reducedView: 0
    property int magnitudeLabelX_reducedView: 0
    property int magnitudeLabelY_reducedView: 0
    property int magnitudeLabelDoubleTopX_reducedView: 0
    property int magnitudeLabelDoubleTopY_reducedView: 0
    property int magnitudeLabelDoubleBottomY_reducedView: 0
    property int unitsLabelFontSize_reducedView: 0
    property int unitsLabelWidth_reducedView: 0
    property int unitsLabelHeigtht_reducedView: 0
    property int unitsLabelX_reducedView: 0
    property int unitsLabelY_reducedView: 0
    property int unitsLabel2Y_reducedView: 0
    property int initialWidth_reducedView: 0
    property int initialheight_reducedView: 0
    property int mainImageWith_fullView: fullViewWidth * 0.25
    property int mainImageMargin_fullView : fullViewWidth * 0.02
    property int magnitudeLabelFontSize_fullView: fullViewWidth * 0.16
    property int magnitudeLabelFontSize2_fullView: fullViewWidth * 0.09
    property int magnitudeLabelWidth_fullView: fullViewWidth * 0.57
    property int magnitudeLabelHeigtht_fullView: fullViewWidth * 0.13
    property int magnitudeLabelX_fullView: fullViewWidth * 0.29
    property int magnitudeLabelY_fullView: fullViewWidth * 0.14
    property int unitsLabelFontSize_fullView: fullViewWidth * 0.05
    property int unitsLabelWidth_fullView: fullViewWidth * 0.241
    property int unitsLabelHeigtht_fullView: fullViewWidth * 0.078
    property int unitsLabelX_fullView: fullViewWidth * 0.6
    property int unitsLabel2X_fullView: fullViewWidth * 0.25
    property int unitsLabelY_fullView: fullViewWidth * 0.02
    property int initialWidth_fullView: fullViewWidth
    property int initialheight_fullView: fullViewHeight
    property int fadeOffTime: 100
    property int appearTime: 250
    property int shrinkTime: 250
    property int enlargeTime: 250
    property int multilabelMainLabel: 0
    property int fixButtonsMax: 5
    property int sliderRangeChangeSequencer: 0
    property int maxSliderRanges: 3
    property int multiRangeSliderStep: 1


    readonly property int shadowSamples: 17
    readonly property int shadowRadius: 8
    readonly property int shadowButtonHorizontalOffset: 3
    readonly property int shadowButtonVerticalOffset: 3

    property double maxFlow: 0
    property double convertToTimeFlow: 0
    property double convertToVolumeDose: 0
    property double convertToTimeDose_flow: 0
    property double convertToTimeDose_concentration: 0
    property double proportionalFactor: 1 // included to correct final result of operation (a.e: absorption factor)
    property double fixButtonsOpacity: 0
    property double sliderValueBack: 0 // slider value when the input frame is maximized
    property double sliderMaxDependentValue: 1
    property double sliderMaxNotDependentValue: 1
    property double opacityOnButtonPressed: 0.4
    property double conversionFactor: 1
    property double conversionFactorB: 1
    property double magnitudeValue: (dependentMagnitude) ? Therapies.resolveDependentMagnitude() : slider.value

    property string name: "_"
    property string saveStamp: "_"
    property string startState: "reducedView"
    property string fixButtonLabel_1TextBack: ""
    property string fixButtonLabel_2TextBack: ""
    property string fixButtonLabel_3TextBack: ""
    property string fixButtonLabel_4TextBack: ""
    property string fixButtonLabel_5TextBack: ""
    property string buttonsColor: Storage.getAppDB(Constants.dbAppColor.inputCtrlButtonId, "black")
    property string fixButtonTextColor: Storage.getAppDB(Constants.dbAppColor.inputCtrlFixButtonTextId, "black")
    readonly property string shadowColor: "#70000000"

    signal fullControlStateOn(string name)
    signal fullControlStateOff()

    enabled: !(dependentMagnitude)

    states:[
        State{
            id: fullView
        },
        State{
            id: fullViewWithOffset
        },
        State{
            id: fullViewDouble
        },
        State{
            id: reducedView
        }
    ]

    transitions: [
        Transition {
            to: "fullView"
            SequentialAnimation{
                ParallelAnimation{
                    NumberAnimation { target: inputControl; property: "sliderValueBack"; to: slider.value}
                    PropertyAnimation { target: inputControl; property: "z"; to: 1}
                    PropertyAnimation { target: separatorLine; property: "visible"; to: false}

                    ParallelAnimation{
                        PropertyAnimation{ target: inputControl; property: "x"; to: fullViewX; duration: enlargeTime}
                        PropertyAnimation { target: inputControl; property: "y"; to: fullViewY; duration: enlargeTime}
                        PropertyAnimation { target: inputControl; property: "width"; to: fullViewWidth; duration: enlargeTime}
                        PropertyAnimation { target: inputControl; property: "height"; to: fullViewHeight; duration: enlargeTime;}
                        PropertyAnimation { target: mainImage; property: "width"; to: mainImageWith_fullView; duration: enlargeTime}
                        PropertyAnimation { target: mainImage; property: "anchors.leftMargin"; to: mainImageMargin_fullView; duration: enlargeTime}
                        PropertyAnimation { target: mainImage; property: "anchors.topMargin"; to: mainImageMargin_fullView/2; duration: enlargeTime}
                        PropertyAnimation { target: mainImage; property: "opacity"; to: (mainCombinedImage.status === Image.Null) ? 1 : 0 ; duration: enlargeTime}
                        PropertyAnimation { target: multipleLabelRectangle; property: "opacity"; to: 0; duration: enlargeTime}
                        PropertyAnimation { target: magnitudeLabel; property: "x"; to: (magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView * 0.5)) - (magnitudeLabelWidth_reducedView * 0.5); duration: enlargeTime}
                        PropertyAnimation { target: magnitudeLabel; property: "y"; to: (magnitudeLabelY_fullView + (magnitudeLabelHeigtht_fullView * 0.5)) - (magnitudeLabelHeigtht_reducedView * 0.5); duration: enlargeTime}
                        PropertyAnimation { target: unitsLabel; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView * 0.5) + (unitsLabelWidth_fullView * 0.5) - (unitsLabelWidth_reducedView * 0.5); duration: enlargeTime}
                        PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_fullView + (unitsLabelHeigtht_fullView * 0.5) - (unitsLabelHeigtht_reducedView * 0.5); duration: enlargeTime}
                    }
                }

                PropertyAnimation { target: inputControl; property: "buttonsVisibility"; to: true; duration: 0}

                ParallelAnimation{
                    PropertyAnimation { target: magnitudeLabel; property: "font.pixelSize"; to: magnitudeLabelFontSize_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel; property: "width"; to: magnitudeLabelWidth_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel; property: "height"; to: magnitudeLabelHeigtht_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel; property: "x"; to: magnitudeLabelX_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel; property: "y"; to: magnitudeLabelY_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel; property: "font.pixelSize"; to: unitsLabelFontSize_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel; property: "height"; to: unitsLabelHeigtht_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel; property: "width"; to: magnitudeLabelWidth_fullView * 0.49; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView / 2); duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: slider; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: downButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: upButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: inputControl; property: "fixButtonsOpacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: differentValuesOnCycles; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: sequentialButtonImage_1Id; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: doneButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: cancelButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: saveButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: changeSliderRangeButton; property: "opacity"; to: 1; duration: appearTime}
                }
            }
        },
        Transition {
            to: "fullViewWithOffset"
            PropertyAnimation{ target: inputControl; property: "opacity"; to: 1; duration: 0}
            PropertyAnimation{ target: inputControl; property: "x"; to: fullViewX; duration: enlargeTime}
        },
        Transition {
            to: "fullViewDouble"
            SequentialAnimation{
                ParallelAnimation{
                    NumberAnimation { target: inputControl; property: "sliderValueBack"; to: slider.value}
                    PropertyAnimation { target: inputControl; property: "z"; to: 1}
                    PropertyAnimation { target: separatorLine; property: "visible"; to: false}

                    ParallelAnimation{
                        PropertyAnimation { target: inputControl; property: "x"; to: fullViewX; duration: enlargeTime}
                        PropertyAnimation { target: inputControl; property: "y"; to: fullViewY; duration: enlargeTime}
                        PropertyAnimation { target: inputControl; property: "width"; to: fullViewWidth; duration: enlargeTime}
                        PropertyAnimation { target: inputControl; property: "height"; to: fullViewHeight; duration: enlargeTime;}

                        PropertyAnimation { target: mainImage; property: "width"; to: mainImageWith_fullView; duration: enlargeTime}
                        PropertyAnimation { target: mainImage; property: "anchors.leftMargin"; to: mainImageMargin_fullView; duration: enlargeTime}
                        PropertyAnimation { target: mainImage; property: "anchors.topMargin"; to: mainImageMargin_fullView/2; duration: enlargeTime}
                        PropertyAnimation { target: mainImage; property: "opacity"; to: (mainCombinedImage.status === Image.Null) ? 1 : 0 ; duration: enlargeTime}

                        PropertyAnimation { target: mainDoubleImage; property: "width"; to: mainImageWith_fullView; duration: enlargeTime}
                        PropertyAnimation { target: mainDoubleImage; property: "anchors.leftMargin"; to: mainImageMargin_fullView; duration: enlargeTime}
                        PropertyAnimation { target: mainDoubleImage; property: "anchors.bottomMargin"; to:(fullViewHeight- mainImageWith_fullView-(mainImageMargin_fullView/2)); duration: enlargeTime}
                        PropertyAnimation { target: mainDoubleImage; property: "opacity"; to: 0; duration: enlargeTime}

                        PropertyAnimation { target: mainCombinedImage; property: "opacity"; to: (mainCombinedImage.status === Image.Null) ? 0 : 1 ; duration: enlargeTime}

                        PropertyAnimation { target: magnitudeLabel2; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView / 4) - (magnitudeLabelWidth_reducedView * 0.25); duration: enlargeTime}
                        PropertyAnimation { target: magnitudeLabel2; property: "y"; to: (magnitudeLabelY_fullView + (magnitudeLabelHeigtht_fullView * 0.5)) - (magnitudeLabelHeigtht_reducedView * 0.5); duration: enlargeTime}

                        PropertyAnimation { target: magnitudeLabel3; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView / 2) + (magnitudeLabelWidth_fullView / 4) - (magnitudeLabelWidth_reducedView * 0.25); duration: enlargeTime}
                        PropertyAnimation { target: magnitudeLabel3; property: "y"; to: (magnitudeLabelY_fullView + (magnitudeLabelHeigtht_fullView * 0.5)) - (magnitudeLabelHeigtht_reducedView * 0.5); duration: enlargeTime}

                        PropertyAnimation { target: unitsLabel; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView * 0.5) + (unitsLabelWidth_fullView * 0.5) - (unitsLabelWidth_reducedView * 0.5); duration: enlargeTime}
                        PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_fullView + (unitsLabelHeigtht_fullView * 0.5) - (unitsLabelHeigtht_reducedView * 0.5); duration: enlargeTime}

                        PropertyAnimation { target: unitsLabel2; property: "x"; to: magnitudeLabelX_fullView + (unitsLabelWidth_fullView * 0.5) - (unitsLabelWidth_reducedView * 0.5); duration: enlargeTime}
                        PropertyAnimation { target: unitsLabel2; property: "y"; to: unitsLabelY_fullView + (unitsLabelHeigtht_fullView * 0.5) - (unitsLabelHeigtht_reducedView * 0.5); duration: enlargeTime}
                    }
                }

                PropertyAnimation { target: inputControl; property: "buttonsVisibility"; to: true; duration: 0}

                ParallelAnimation{
                    PropertyAnimation { target: magnitudeLabel2; property: "font.pixelSize"; to: magnitudeLabelFontSize2_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel2; property: "width"; to: magnitudeLabelWidth_fullView * 0.49; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel2; property: "height"; to: magnitudeLabelHeigtht_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel2; property: "x"; to: magnitudeLabelX_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel2; property: "y"; to: magnitudeLabelY_fullView; duration: appearTime * 0.3}

                    PropertyAnimation { target: magnitudeLabel3; property: "font.pixelSize"; to: magnitudeLabelFontSize2_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel3; property: "width"; to: magnitudeLabelWidth_fullView * 0.49; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel3; property: "height"; to: magnitudeLabelHeigtht_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel3; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView / 2); duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel3; property: "y"; to: magnitudeLabelY_fullView; duration: appearTime * 0.3}

                    PropertyAnimation { target: magnitudeLabel2Replication; property: "font.pixelSize"; to: magnitudeLabelFontSize2_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel2Replication; property: "width"; to: magnitudeLabelWidth_fullView / 2; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel2Replication; property: "height"; to: magnitudeLabelHeigtht_fullView; duration: appearTime * 0.3}

                    PropertyAnimation { target: magnitudeLabel3Replication; property: "font.pixelSize"; to: magnitudeLabelFontSize2_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel3Replication; property: "width"; to: magnitudeLabelWidth_fullView / 2; duration: appearTime * 0.3}
                    PropertyAnimation { target: magnitudeLabel3Replication; property: "height"; to: magnitudeLabelHeigtht_fullView; duration: appearTime * 0.3}

                    PropertyAnimation { target: unitsLabel; property: "font.pixelSize"; to: unitsLabelFontSize_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel; property: "height"; to: unitsLabelHeigtht_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel; property: "width"; to: magnitudeLabelWidth_fullView * 0.49; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView / 2); duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_fullView; duration: appearTime * 0.3}

                    PropertyAnimation { target: unitsLabel2; property: "font.pixelSize"; to: unitsLabelFontSize_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel2; property: "height"; to: unitsLabelHeigtht_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel2; property: "width"; to: magnitudeLabelWidth_fullView * 0.49; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel2; property: "x"; to: magnitudeLabelX_fullView; duration: appearTime * 0.3}
                    PropertyAnimation { target: unitsLabel2; property: "y"; to: unitsLabelY_fullView; duration: appearTime * 0.3}

                    PropertyAnimation { target: slider; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: downButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: upButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: inputControl; property: "fixButtonsOpacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: differentValuesOnCycles; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: sequentialButtonImage_1Id; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: doneButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: cancelButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: saveButton; property: "opacity"; to: 1; duration: appearTime}
                    PropertyAnimation { target: changeSliderRangeButton; property: "opacity"; to: 1; duration: appearTime}
                }
            }
        },
        Transition {
            to: "reducedView"
            SequentialAnimation{

                ParallelAnimation{
                    PropertyAnimation { target: magnitudeLabel; property: "font.pixelSize"; to: magnitudeLabelFontSize_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel; property: "width"; to: magnitudeLabelWidth_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel; property: "height"; to: magnitudeLabelHeigtht_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel; property: "x"; to: (magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView * 0.5)) - (magnitudeLabelWidth_reducedView * 0.5); duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel; property: "y"; to: (magnitudeLabelY_fullView + (magnitudeLabelHeigtht_fullView * 0.5)) - (magnitudeLabelHeigtht_reducedView * 0.5); duration: fadeOffTime * 0.4}

                    PropertyAnimation { target: magnitudeLabel2; property: "font.pixelSize"; to: magnitudeLabelFontSize2_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel2; property: "width"; to: magnitudeLabelWidth_reducedView * 0.56; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel2; property: "height"; to: magnitudeLabelHeigtht_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel2; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView / 4) - (magnitudeLabelWidth_reducedView * 0.25); duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel2; property: "y"; to: (magnitudeLabelY_fullView + (magnitudeLabelHeigtht_fullView * 0.5)) - (magnitudeLabelHeigtht_reducedView * 0.5); duration: fadeOffTime * 0.4}

                    PropertyAnimation { target: magnitudeLabel3; property: "font.pixelSize"; to: magnitudeLabelFontSize2_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel3; property: "width"; to: magnitudeLabelWidth_reducedView * 0.56; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel3; property: "height"; to: magnitudeLabelHeigtht_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel3; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView / 2) + (magnitudeLabelWidth_fullView / 4) - (magnitudeLabelWidth_reducedView * 0.25); duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel3; property: "y"; to: (magnitudeLabelY_fullView + (magnitudeLabelHeigtht_fullView * 0.5)) - (magnitudeLabelHeigtht_reducedView * 0.5); duration: fadeOffTime * 0.4}

                    PropertyAnimation { target: magnitudeLabel2Replication; property: "font.pixelSize"; to: magnitudeLabelFontSize2_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel2Replication; property: "width"; to: magnitudeLabelWidth_reducedView / 2; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel2Replication; property: "height"; to: magnitudeLabelHeigtht_reducedView; duration: fadeOffTime * 0.4}

                    PropertyAnimation { target: magnitudeLabel3Replication; property: "font.pixelSize"; to: magnitudeLabelFontSize2_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel3Replication; property: "width"; to: magnitudeLabelWidth_reducedView /2; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: magnitudeLabel3Replication; property: "height"; to: magnitudeLabelHeigtht_reducedView; duration: fadeOffTime * 0.4}

                    PropertyAnimation { target: unitsLabel; property: "font.pixelSize"; to: unitsLabelFontSize_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: unitsLabel; property: "width"; to: unitsLabelWidth_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: unitsLabel; property: "height"; to: unitsLabelHeigtht_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: unitsLabel; property: "x"; to: magnitudeLabelX_fullView + (magnitudeLabelWidth_fullView * 0.5) + (unitsLabelWidth_fullView * 0.5) - (unitsLabelWidth_reducedView * 0.5); duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_fullView + (unitsLabelHeigtht_fullView * 0.5) - (unitsLabelHeigtht_reducedView * 0.5); duration: fadeOffTime * 0.4}

                    PropertyAnimation { target: unitsLabel2; property: "font.pixelSize"; to: unitsLabelFontSize_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: unitsLabel2; property: "width"; to: unitsLabelWidth_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: unitsLabel2; property: "height"; to: unitsLabelHeigtht_reducedView; duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: unitsLabel2; property: "x"; to: magnitudeLabelX_fullView + (unitsLabelWidth_fullView * 0.5) - (unitsLabelWidth_reducedView * 0.5); duration: fadeOffTime * 0.4}
                    PropertyAnimation { target: unitsLabel2; property: "y"; to: unitsLabelY_fullView + (unitsLabelHeigtht_fullView * 0.5) - (unitsLabelHeigtht_reducedView * 0.5); duration: fadeOffTime * 0.4}

                    PropertyAnimation { target: slider; property: "opacity"; to: 0; duration: fadeOffTime}
                    PropertyAnimation { target: downButton; property: "opacity"; to: 0; duration: fadeOffTime}
                    PropertyAnimation { target: upButton; property: "opacity"; to: 0; duration: fadeOffTime}
                    PropertyAnimation { target: inputControl; property: "fixButtonsOpacity"; to: 0; duration: appearTime}
                    PropertyAnimation { target: differentValuesOnCycles; property: "opacity"; to: 0; duration: fadeOffTime}
                    PropertyAnimation { target: sequentialButtonImage_1Id; property: "opacity"; to: 0; duration: fadeOffTime}
                    PropertyAnimation { target: doneButton; property: "opacity"; to: 0; duration: fadeOffTime}
                    PropertyAnimation { target: cancelButton; property: "opacity"; to: 0; duration: fadeOffTime}
                    PropertyAnimation { target: saveButton; property: "opacity"; to: 0; duration: fadeOffTime}
                    PropertyAnimation { target: changeSliderRangeButton; property: "opacity"; to: 0; duration: fadeOffTime}
                }
                PropertyAnimation { target: inputControl; property: "buttonsVisibility"; to: false; duration: 0}

                ParallelAnimation{
                    PropertyAnimation { target: inputControl; property: "x"; to: initialX; duration: shrinkTime}
                    PropertyAnimation { target: inputControl; property: "y"; to: initialY; duration: shrinkTime}
                    PropertyAnimation { target: inputControl; property: "width"; to: initialWidth_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: inputControl; property: "height"; to: initialheight_reducedView; duration: shrinkTime}

                    PropertyAnimation { target: mainImage; property: "width"; to: doubleLabelVisible ? mainImageDoubleWidth_reducedView : mainImageWidth_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: mainImage; property: "anchors.leftMargin"; to: doubleLabelVisible ? mainImageDoubleMargin_reducedView : mainImageMargin_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: mainImage; property: "anchors.topMargin"; to: doubleLabelVisible ? mainImageDoubleMargin_reducedView : mainImageMargin_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: mainImage; property: "opacity"; to: 1; duration: shrinkTime}

                    PropertyAnimation { target: mainDoubleImage; property: "width"; to: mainImageDoubleWidth_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: mainDoubleImage; property: "anchors.leftMargin"; to: mainImageDoubleMargin_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: mainDoubleImage; property: "anchors.bottomMargin"; to: mainImageDoubleMargin_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: mainDoubleImage; property: "opacity"; to: 1; duration: shrinkTime}

                    PropertyAnimation { target: mainCombinedImage; property: "opacity"; to: 0; duration: shrinkTime}

                    PropertyAnimation { target: magnitudeLabel; property: "x"; to: magnitudeLabelX_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: magnitudeLabel; property: "y"; to: magnitudeLabelY_reducedView; duration: shrinkTime}

                    PropertyAnimation { target: magnitudeLabel2; property: "x"; to: magnitudeLabelDoubleTopX_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: magnitudeLabel2; property: "y"; to: magnitudeLabelDoubleBottomY_reducedView; duration: shrinkTime}

                    PropertyAnimation { target: magnitudeLabel3; property: "x"; to: magnitudeLabelDoubleTopX_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: magnitudeLabel3; property: "y"; to: magnitudeLabelDoubleTopY_reducedView; duration: shrinkTime}

                    PropertyAnimation { target: unitsLabel; property: "x"; to: unitsLabelX_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: unitsLabel; property: "y"; to: unitsLabelY_reducedView; duration: shrinkTime}

                    PropertyAnimation { target: unitsLabel2; property: "x"; to: unitsLabelX_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: unitsLabel2; property: "y"; to: unitsLabel2Y_reducedView; duration: shrinkTime}
                    PropertyAnimation { target: separatorLine; property: "visible"; to: doubleLabelVisible; duration: shrinkTime}
                    PropertyAnimation { target: multipleLabelRectangle; property: "opacity"; to: 1; duration: shrinkTime}
                }
                PropertyAnimation { target: inputControl; property: "z"; to: 0}
            }
        }
    ]

    function init(){
        var initRangeValue

        getStoredValues()
        initSliderRangeDependingOnStoredValue()
        initRangeValue = performSliderRangeChange(false)
        inputControl.inspected = false
        inputControl.state = startState
        inputControl.fullControlButton.visible = true//false
        changeSliderRangeLabel.text = "..." + initRangeValue
    }

    function getStoredValues(){
        var i
        var tmpConversionFactor

        unitsLabel.text = Storage.getAppDB(saveStamp + "_" + Constants.sliderUnitsId , "*")

        if(unitsLabel.text === Storage.getAppDB(saveStamp + "_" + Constants.sliderUnitsAId , "*")) {
            tmpConversionFactor = Storage.getAppDB(saveStamp + "_" + Constants.unitsConversionFactorAId, "1")
        }
        else if (unitsLabel.text === Storage.getAppDB(saveStamp + "_" + Constants.sliderUnitsBId , "*")) {
            tmpConversionFactor = Storage.getAppDB(saveStamp + "_" + Constants.unitsConversionFactorBId, "1")
        }
        else {
            tmpConversionFactor = 1
        }

        i = String(tmpConversionFactor).search("~")
        if(i !== -1){
            conversionFactorB = tmpConversionFactor.substring(0, i)
            conversionFactor = tmpConversionFactor.substring(i + 1)
        }else{
            conversionFactor = tmpConversionFactor
        }

        // Important: keept updating order (from, to and them value)
        slider.from = Storage.getAppDB(saveStamp + "_" + Constants.sliderMinId, "1") * conversionFactor
        sliderMaxNotDependentValue = Storage.getAppDB(saveStamp + "_" + Constants.sliderMaxId, "1") * conversionFactor
        slider.value = Storage.getAppDB(saveStamp + "_" + Constants.sliderInitId, "1") * conversionFactor

        console.log("saveStamp, slider.value: ", saveStamp, slider.value)

        fixButtonLabel_1.text = formatSeparators(formatFractionalPart(Storage.getAppDB(saveStamp + "_" + Constants.fixedButton1Id, "1") * conversionFactor))
        fixButtonLabel_2.text = formatSeparators(formatFractionalPart(Storage.getAppDB(saveStamp + "_" + Constants.fixedButton2Id, "1") * conversionFactor))
        fixButtonLabel_3.text = formatSeparators(formatFractionalPart(Storage.getAppDB(saveStamp + "_" + Constants.fixedButton3Id, "1") * conversionFactor))
        fixButtonLabel_4.text = formatSeparators(formatFractionalPart(Storage.getAppDB(saveStamp + "_" + Constants.fixedButton4Id, "1") * conversionFactor))
        fixButtonLabel_5.text = formatSeparators(formatFractionalPart(Storage.getAppDB(saveStamp + "_" + Constants.fixedButton5Id, "1") * conversionFactor))

        if(negativeMagnitude){
            fixButtonLabel_1.text = "-" + fixButtonLabel_1.text
            fixButtonLabel_2.text = "-" + fixButtonLabel_2.text
            fixButtonLabel_3.text = "-" + fixButtonLabel_3.text
            fixButtonLabel_4.text = "-" + fixButtonLabel_4.text
            fixButtonLabel_5.text = "-" + fixButtonLabel_5.text
        }

        i = unitsLabel.text.search("~")
        if(i !== -1){
            unitsLabel2.text = unitsLabel.text.substring(0, i)
            unitsLabel.text = unitsLabel.text.substring(i + 1)
        }

        therapyCyclesNumberBack = therapyCyclesNumber

        if(multilabelView){
            differentValuesOnCycles.activated = (Storage.getAppDB(saveStamp + "_" + Constants.diffValuesOnCyclesId, "false") === "true") ? true : false
            //DEB->debug.log(DC.inputItemLog, "differentValuesOnCycles.activated -> ", saveStamp + "_" + Constants.diffValuesOnCyclesId + differentValuesOnCycles.activated )

        }else{
            differentValuesOnCycles.activated = false
        }
    }

    function refreshSlider(){
        slider.value = Number(magnitudeLabel.text.replace(",", ".").replace("-", ""))
    }

    function getFixButtonPressed()
    {
        if(fixButton_1Button.pressed)
            return fixButton_1
        else if(fixButton_2Button.pressed)
            return fixButton_2
        else if(fixButton_3Button.pressed)
            return fixButton_3
        else if(fixButton_4Button.pressed)
            return fixButton_4
        else if(fixButton_5Button.pressed)
            return fixButton_5
    }

    function getFixButtonPressedLabel()
    {
        var value = slider.value

        if( Number(value) === parseInt(Number(value)) ){
            value = parseInt(Number(value))
        }else{
            value = slider.value.toFixed(2)
        }

        if(negativeMagnitude){
            value = -value
        }

        if(fixButton_1Button.pressed)
            fixButtonLabel_1.text = formatSeparators(value) // value
        else if(fixButton_2Button.pressed)
            fixButtonLabel_2.text = formatSeparators(value) // value // slider.value.toFixed(2) // Math.round(slider.value)
        else if(fixButton_3Button.pressed)
            fixButtonLabel_3.text = formatSeparators(value) // value // slider.value.toFixed(2) // Math.round(slider.value)
        else if(fixButton_4Button.pressed)
            fixButtonLabel_4.text = formatSeparators(value) // value // slider.value.toFixed(2) // Math.round(slider.value)
        else if(fixButton_5Button.pressed)
            fixButtonLabel_5.text = formatSeparators(value) // value // slider.value.toFixed(2) // Math.round(slider.value)
    }

    function savingEffect(destinationObject){
        auxRectangleForSavingEffect.x = destinationObject.x
        auxRectangleForSavingEffect.y = destinationObject.y
        auxRectangleForSavingEffect.width = destinationObject.width
        auxRectangleForSavingEffect.height = destinationObject.height
        magnitudeLabelForSavingEffect.state= "saving"
        magnitudeLabel2ForSavingEffect.state= "saving"
        magnitudeLabel3ForSavingEffect.state= "saving"
    }

    function formatFractionalPart(value){

        if( Number(value) === parseInt(Number(value)) ){
            return value
        }
        else{
            return value.toFixed(setNumberOfDecimalDigits(conversionFactor))
        }
    }


    function formatSeparators(value){
        return value.toString().replace(".",",")
    }

    function undoFormatSeparators(value){
        return value.replace(",",".")
    }

    function setStepSize(conversionFactor){ // set step size dependig on conversion factor
        var stepSize

        if(parseInt(conversionFactor)){
            stepSize = 1
        }
        else{
            if(conversionFactor > 1){
                stepSize = 0.1
            }
            else{
                stepSize = 1

                do{
                    stepSize = stepSize / 10
                    conversionFactor = conversionFactor * 10
                } while(conversionFactor < 1)
            }
        }
        return stepSize
    }

    function setNumberOfDecimalDigits(conversionFactor){ // set number of decimal digits dependig on conversion factor
        var digits = 0

        if(conversionFactor > 1){
            digits = 2
        }
        else{
            do{
                digits = digits + 1
                conversionFactor = conversionFactor * 10
            } while(conversionFactor < 1)

            if(digits < 2){
                digits = 2
            }
        }
        return digits
    }

    function volumeToTime(volume, flow) { // ( ml, l/h)
        var time
        var seconds = Math.round((volume / ((1000 / 3600) * flow)))
        var minutes = Math.floor(seconds / 60)

        seconds = seconds - (minutes * 60)

        time = minutes > 9 ? minutes.toString() : "0" + minutes.toString()
        time += seconds > 9 ? ":" + seconds.toString() : ":0" + seconds.toString()

        return time
    }

    function doseToVolume(dose, concentration) { // (ug, ug/Nml) -> return mililitres
        var volume

        volume = (dose / concentration)
        volume = volume * conversionFactorB

        return volume
    }

    function adjustMagnitudeLabel2Height(){
        if (magnitudeLabel2Replication.contentHeight < magnitudeLabel3Replication.contentHeight){
            return magnitudeLabel2Replication.contentHeight + 2
        }else{
            return magnitudeLabel3Replication.contentHeight + 2
        }
    }

    function adjustMagnitudeLabel3Height(){
        if (magnitudeLabel2Replication.contentHeight < magnitudeLabel3Replication.contentHeight){
            return magnitudeLabel2Replication.contentHeight + 2
        }else{
            return magnitudeLabel3Replication.contentHeight + 2
        }
    }

    function adjustDoubleLabelSizes(){
        if (magnitudeLabel2Replication.contentHeight < magnitudeLabel3Replication.contentHeight){
            magnitudeLabel3.height = magnitudeLabel2Replication.contentHeight + 2
            magnitudeLabel2.height = magnitudeLabel2Replication.contentHeight + 2
        }else{
            magnitudeLabel3.height = magnitudeLabel3Replication.contentHeight + 2
            magnitudeLabel2.height = magnitudeLabel3Replication.contentHeight + 2
        }
    }

    function adjustDoubleLabelPositions(){
    }

    function resolveDoubleLabel(){
        var str = ""
        if(convertToTimeFlow){
            str = volumeToTime((magnitudeValue / conversionFactor), convertToTimeFlow)
        }
        if(convertToVolumeDose){
            str = formatSeparators(formatFractionalPart(doseToVolume(magnitudeValue, convertToVolumeDose)))
        }
        if(convertToTimeDose_flow){
            str = volumeToTime(doseToVolume(((magnitudeValue / conversionFactor) * proportionalFactor), convertToTimeDose_concentration), convertToTimeDose_flow)
        }
        return str
    }

    function computeMagnitudeLabelSign(value){
        if(negativeMagnitude){
            value = -value
        }
        return value
    }

    function resolveFixButtonVisibility(){
        if(multilabelView === true){
            if(differentValuesOnCycles.activated){
                return buttonsVisibility
            }
            else
            {
                return false
            }
        }
        else{
            return buttonsVisibility
        }
    }

    function resolveFixButtonOpacity(buttonNumber){
        if(multilabelView === true){
            if(differentValuesOnCycles.activated){
                if((therapyCyclesNumber + 1) > buttonNumber){
                    return fixButtonsOpacity
                }
                else{
                    return opacityOnButtonPressed
                }
            }
            else{
                return fixButtonsOpacity
            }
        }
        else{
            return fixButtonsOpacity
        }
    }

    function saveFixButtons(){
        Storage.setAppDB(saveStamp + "_" + Constants.fixedButton1Id, fixButtonLabel_1.text)
        Storage.setAppDB(saveStamp + "_" + Constants.fixedButton2Id, fixButtonLabel_2.text)
        Storage.setAppDB(saveStamp + "_" + Constants.fixedButton3Id, fixButtonLabel_3.text)
        Storage.setAppDB(saveStamp + "_" + Constants.fixedButton4Id, fixButtonLabel_4.text)
        Storage.setAppDB(saveStamp + "_" + Constants.fixedButton5Id, fixButtonLabel_5.text)
        Storage.saveAppDB()
    }

    function initSliderRangeDependingOnStoredValue(){
        var from, to, iniValue, percent12_5, percent50

        from = Storage.getAppDB(saveStamp + "_" + Constants.sliderMinId, "1") * conversionFactor
        to = Storage.getAppDB(saveStamp + "_" + Constants.sliderMaxId, "1") * conversionFactor
        iniValue = Storage.getAppDB(saveStamp + "_" + Constants.sliderInitId, "1") * conversionFactor
        percent12_5 = to * 0.125
        percent50 = to * 0.5

        if(iniValue < percent12_5){
            sliderRangeChangeSequencer = 0
        }
        else if(iniValue < percent50){
            sliderRangeChangeSequencer = 1
        }
        else{
            sliderRangeChangeSequencer = 2
        }
    }

    function performSliderRangeChange(centerInitValue){
        var from, to, iniValue, percent12_5, percent50

        if(multiRangeSlider){
            from = Storage.getAppDB(saveStamp + "_" + Constants.sliderMinId, "1") * conversionFactor
            to = Storage.getAppDB(saveStamp + "_" + Constants.sliderMaxId, "1") * conversionFactor
            iniValue = Storage.getAppDB(saveStamp + "_" + Constants.sliderInitId, "1") * conversionFactor
            percent12_5 = to * 0.125
            percent50 = to * 0.5

            switch(sliderRangeChangeSequencer){
            case 0:
                to = percent12_5
                break;
            case 1:
                from = percent12_5
                to = percent50
                break;
            case 2:
                from = percent50
                break;
            }

            iniValue = (centerInitValue) ? (((to - from) * 0.5) + from) : iniValue

            // Important: keept updating order (from, to and them value)
            slider.from = from
            sliderMaxNotDependentValue = to
            slider.value = iniValue

            multiRangeSliderStep = ((to - from) < 10000) ? 50 : 100

            sliderRangeChangeSequencer = (++sliderRangeChangeSequencer === maxSliderRanges) ? 0 : sliderRangeChangeSequencer
        }
        return to
    }

    function performSliderRangeChangeFromFixedButton(value){
        var from, to, iniValue, percent12_5, percent50

        if(multiRangeSlider){
            console.log("In...")
            from = Storage.getAppDB(saveStamp + "_" + Constants.sliderMinId, "1") * conversionFactor
            to = Storage.getAppDB(saveStamp + "_" + Constants.sliderMaxId, "1") * conversionFactor
            percent12_5 = to * 0.125
            percent50 = to * 0.5

            if(value <= percent12_5){
                to = percent12_5
                sliderRangeChangeSequencer = 1
            }
            else if ((value <= percent50)){
                from = percent12_5
                to = percent50
                sliderRangeChangeSequencer = 2
            }
            else{
                from = percent50
                sliderRangeChangeSequencer = 0
            }

            iniValue = value

            // Important: keept updating order (from, to and them value)
            slider.from = from
            sliderMaxNotDependentValue = to
            slider.value = iniValue

            multiRangeSliderStep = ((to - from) < 10000) ? 50 : 100
            changeSliderRangeLabel.text = "..." + to
        }

        //      console.log("to: ",to)
        //      console.log("from: ",from)
        //      console.log("inivalue: ",iniValue)
        //      console.log("sliderRangeChangeSequencer: ",sliderRangeChangeSequencer)
    }

    function fullControlButtonTemporalDisable(miliseconds){
        fullControlButton.enabled = false
        delayedEnable.duration = miliseconds
        delayedEnable.start()
    }

    PropertyAnimation{ id: delayedEnable; target: fullControlButton; property: "enabled"; to: true; duration: 0 }

    onTherapyCyclesNumberChanged:{
        therapyCyclesNumberBack = therapyCyclesNumber
    }

    Component.onCompleted: {
        inputControl.fullControlStateOn.connect(Therapies.inputSelected)
        inputControl.fullControlStateOff.connect(Therapies.noInputSelected)

        fullViewHeight = fullViewWidth * QtConstants.fullViewInputElementAspectRatio// 0.47

        mainImageWidth_reducedView = inputControl.width * 0.4
        mainImageMargin_reducedView = inputControl.width * 0.012
        mainImageDoubleWidth_reducedView = inputControl.width * 0.3
        mainImageDoubleMargin_reducedView = inputControl.width * 0.025

        magnitudeLabelFontSize_reducedView = inputControl.width * 0.28
        magnitudeLabelFontSize2_reducedView = inputControl.width * 0.15
        magnitudeLabelWidth_reducedView = inputControl.width * 0.95
        magnitudeLabelHeigtht_reducedView = inputControl.width * 0.28
        magnitudeLabelX_reducedView = inputControl.width * 0.03
        magnitudeLabelY_reducedView = inputControl.width * 0.43

        magnitudeLabelDoubleTopY_reducedView = inputControl.width * 0.185
        magnitudeLabelDoubleBottomY_reducedView =  inputControl.width * 0.51
        magnitudeLabelDoubleTopX_reducedView = inputControl.width * 0.4

        unitsLabelFontSize_reducedView = inputControl.width * 0.12
        unitsLabelWidth_reducedView = inputControl.width * 0.45
        unitsLabelHeigtht_reducedView = inputControl.width * 0.15
        unitsLabelX_reducedView = inputControl.width * 0.48
        unitsLabelY_reducedView = inputControl.width * 0.04
        unitsLabel2Y_reducedView = inputControl.width * 0.36

        initialWidth_reducedView = inputControl.width
        initialheight_reducedView = inputControl.width * 0.72
        inputControl.height = initialheight_reducedView
        inputControl.state = startState
    }

    Rectangle {
        id: inputForm
        anchors.fill: parent
        visible: true
        color: Storage.getAppDB(Constants.dbAppColor.inputCtrlPanelId, "black")
        radius: backgroundRadius


        Behavior on opacity{
            NumberAnimation { duration: 250 }
        }

        Slider {
            id: slider
            opacity: 0
            from: 1
            to: (sliderMaxDependent) ? sliderMaxDependentValue : sliderMaxNotDependentValue
            stepSize: setStepSize(conversionFactor) * multiRangeSliderStep
            visible: buttonsVisibility//true//false
            anchors.right: upButton.left
            anchors.rightMargin: sliderMargins
            anchors.left: downButton.right
            anchors.leftMargin: sliderMargins
            anchors.verticalCenter: downButton.verticalCenter
            anchors.verticalCenterOffset: sliderverticalCenterOffset
            height: sliderHandlePressed

            background: Rectangle {
                id: sliderBackgroundInactive
                x: slider.leftPadding
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                width: slider.availableWidth
                height: sliderRectangleHeight
                radius: (sliderRectangleHeight / 2) + 1
                color: Storage.getAppDB(Constants.dbAppColor.inputCtrlBackSliderId, "black")

                Rectangle {
                    id: deactivated
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: unitsLabel.color
                    radius: sliderRectangleHeight / 2
                }
            }
            handle: Rectangle {
                id: sliderHandle
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                width: slider.pressed ? sliderHandlePressed : sliderHandleUnpressed
                height: sliderHandle.width
                radius: (sliderHandlePressed / 2) + 1
                color: slider.pressed ?  magnitudeLabel.color : unitsLabel.color
            }
            onValueChanged: {
                Therapies.actionsWhenMagnitudeSelectorSliderChanges()
            }
        }

        Rectangle {
            id: downButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            opacity: 0
            visible: buttonsVisibility//true//false
            anchors.bottom: parent.bottom
            anchors.bottomMargin: upDownButtonBottomMargin
            anchors.left: parent.left
            anchors.leftMargin: externalBorderMargin

            Label{
                color: unitsLabel.color
                text: "_"
                anchors.fill: parent
                anchors.bottomMargin: operationButtonHeight * 0.45
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                font.pointSize: operationButtonHeight
                opacity: downButtonButton.down ? opacityOnButtonPressed : 1
            }
            Button{
                id: downButtonButton
                opacity: 0
                autoRepeat: true
                anchors.fill: parent
                onClicked: slider.value = slider.value - slider.stepSize
            }
        }

        Rectangle {
            id: upButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            opacity: 0
            visible: buttonsVisibility//true//false
            anchors.bottom: parent.bottom
            anchors.bottomMargin: upDownButtonBottomMargin
            anchors.right: parent.right
            anchors.rightMargin: externalBorderMargin

            Label{
                color: unitsLabel.color
                text: "+"
                anchors.bottomMargin: operationButtonHeight * 0.08
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: operationButtonHeight
                opacity: upButtonButton.down ? opacityOnButtonPressed : 1
            }
            Button{
                id: upButtonButton
                focusPolicy: Qt.WheelFocus
                opacity: 0
                autoRepeat: true
                anchors.fill: parent
                onClicked: slider.value = slider.value + slider.stepSize
            }
        }

        Rectangle {
            id: fixButton_1
            width: fixButtonWidth
            height: fixButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.right: fixButton_2.left
            anchors.rightMargin: fixButtonMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: externalBorderMargin
            opacity: resolveFixButtonOpacity(1)
            visible: resolveFixButtonVisibility()

            Label {
                id: fixButtonLabel_1
                color: fixButtonTextColor
                text: "1"
                width: parent.width * 0.95
                height: parent.height
                font.pointSize: fixButtonFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                opacity: fixButton_1Button.down ? opacityOnButtonPressed : resolveFixButtonOpacity(1)
                fontSizeMode: Text.Fit
            }
            Button{
                id: fixButton_1Button
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    (parent.opacity === 1) ? slider.value = Math.abs(undoFormatSeparators(fixButtonLabel_1.text)) : null
                    performSliderRangeChangeFromFixedButton(fixButtonLabel_1.text)
                }
                onPressAndHold: {
                    if(parent.opacity === 1){
                        if(!multilabelView){
                            Storage.setAppDB(saveStamp + "_" + Constants.fixedButton1Id, slider.value)
                            Storage.saveAppDB()
                        }
                        savingEffect(getFixButtonPressed())
                    }
                }
            }
        }
        Rectangle {
            id: fixButton_2
            width: fixButtonWidth
            height: fixButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.right: fixButton_3.left
            anchors.rightMargin: fixButtonMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: externalBorderMargin
            opacity: resolveFixButtonOpacity(2)
            visible: resolveFixButtonVisibility()

            Label {
                id: fixButtonLabel_2
                color: fixButtonTextColor
                text: "2"
                width: parent.width * 0.95
                height: parent.height
                font.pointSize: fixButtonFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                opacity: fixButton_2Button.down ? opacityOnButtonPressed : resolveFixButtonOpacity(2)
                fontSizeMode: Text.Fit
            }
            Button{
                id: fixButton_2Button
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    (parent.opacity === 1) ? slider.value = Math.abs(fixButtonLabel_2.text) : null
                    performSliderRangeChangeFromFixedButton(fixButtonLabel_2.text)
                }
                onPressAndHold: {
                    if(parent.opacity === 1){
                        if(!multilabelView){
                            Storage.setAppDB(saveStamp + "_" + Constants.fixedButton2Id, slider.value)
                            Storage.saveAppDB()
                        }
                        savingEffect(getFixButtonPressed())
                    }
                }
            }
        }
        Rectangle {
            id: fixButton_3
            width: fixButtonWidth
            height: fixButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: externalBorderMargin
            opacity: resolveFixButtonOpacity(3)
            visible: resolveFixButtonVisibility()

            Label {
                id: fixButtonLabel_3
                color: fixButtonTextColor
                text: "3"
                width: parent.width * 0.95
                height: parent.height
                font.pointSize: fixButtonFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                opacity: fixButton_3Button.down ? opacityOnButtonPressed : resolveFixButtonOpacity(3)
                fontSizeMode: Text.Fit
            }
            Button{
                id: fixButton_3Button
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    (parent.opacity === 1) ? slider.value = Math.abs(fixButtonLabel_3.text) : null
                    performSliderRangeChangeFromFixedButton(fixButtonLabel_3.text)
                }
                onPressAndHold: {
                    if(parent.opacity === 1){
                        if(!multilabelView){
                            Storage.setAppDB(saveStamp + "_" + Constants.fixedButton3Id, slider.value)
                            Storage.saveAppDB()
                        }
                        savingEffect(getFixButtonPressed())
                    }
                }
            }
        }
        Rectangle {
            id: fixButton_4
            width: fixButtonWidth
            height: fixButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.left: fixButton_3.right
            anchors.leftMargin: fixButtonMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: externalBorderMargin
            opacity: resolveFixButtonOpacity(4)
            visible: resolveFixButtonVisibility()

            Label {
                id: fixButtonLabel_4
                color: fixButtonTextColor
                text: "4"
                width: parent.width * 0.95
                height: parent.height
                font.pointSize: fixButtonFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                opacity: fixButton_4Button.down ? opacityOnButtonPressed : resolveFixButtonOpacity(4)
                fontSizeMode: Text.Fit
            }
            Button{
                id: fixButton_4Button
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    (parent.opacity === 1) ? slider.value = Math.abs(fixButtonLabel_4.text) : null
                    performSliderRangeChangeFromFixedButton(fixButtonLabel_4.text)
                }
                onPressAndHold: {
                    if(parent.opacity === 1){
                        if(!multilabelView){
                            Storage.setAppDB(saveStamp + "_" + Constants.fixedButton4Id, slider.value)
                            Storage.saveAppDB()
                        }
                        savingEffect(getFixButtonPressed())
                    }
                }
            }
        }

        Rectangle {
            id: fixButton_5
            width: fixButtonWidth
            height: fixButtonHeight
            color: buttonsColor
            radius: buttonRadius
            anchors.left: fixButton_4.right
            anchors.leftMargin: fixButtonMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: externalBorderMargin
            opacity: resolveFixButtonOpacity(5)
            visible: resolveFixButtonVisibility()

            Label {
                id: fixButtonLabel_5
                color: fixButtonTextColor
                text: "5"
                width: parent.width * 0.95
                height: parent.height
                font.pointSize: fixButtonFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                opacity: fixButton_5Button.down ? opacityOnButtonPressed : resolveFixButtonOpacity(5)
                fontSizeMode: Text.Fit
            }
            Button{
                id: fixButton_5Button
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    (parent.opacity === 1) ? slider.value = Math.abs(fixButtonLabel_5.text) : null
                    performSliderRangeChangeFromFixedButton(fixButtonLabel_5.text)
                }
                onPressAndHold: {
                    if(parent.opacity === 1){
                        if(!multilabelView){
                            Storage.setAppDB(saveStamp + "_" + Constants.fixedButton5Id, slider.value / conversionFactor)
                            Storage.saveAppDB()
                        }
                        savingEffect(getFixButtonPressed())
                    }
                }
            }
        }
        Rectangle {
            id: doneButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            opacity: 0
            visible: buttonsVisibility//true
            anchors.top: parent.top
            anchors.topMargin: externalBorderMargin
            anchors.right: parent.right
            anchors.rightMargin: externalBorderMargin
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.doneId, "")
                opacity: doneButtonButton.down ? opacityOnButtonPressed : 1
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
            Button{
                id: doneButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked:{
                    fullControlButtonTemporalDisable(500) // ticket #4168 solved
                    fullControlStateOff()
                    inputControl.state = "reducedView"
                    inputControl.inspected = true
                    if(differentValuesOnCycles.activated){
                        slider.value = fixButtonLabel_1.text
                    }
                }
            }
        }

        Rectangle {
            id: cancelButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            opacity: 0
            visible: buttonsVisibility//true//false
            anchors.top: parent.top
            anchors.topMargin: saveButtonBottomMargin
            anchors.right: parent.right
            anchors.rightMargin: externalBorderMargin
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.backId, "")
                opacity: cancelButtonButton.down ? opacityOnButtonPressed : 1
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
            Button{
                id: cancelButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    fullControlButtonTemporalDisable(500) // ticket #4168 solved
                    fullControlStateOff()
                    slider.value = sliderValueBack
                    inputControl.state = "reducedView"
                    inputControl.inspected = true
                    differentValuesOnCycles.activated = differentValuesOnCyclesBack

                    Storage.setAppDB(saveStamp + "_" + Constants.fixedButton1Id, fixButtonLabel_1TextBack.replace("-",""))
                    Storage.setAppDB(saveStamp + "_" + Constants.fixedButton2Id, fixButtonLabel_2TextBack.replace("-",""))
                    Storage.setAppDB(saveStamp + "_" + Constants.fixedButton3Id, fixButtonLabel_3TextBack.replace("-",""))
                    Storage.setAppDB(saveStamp + "_" + Constants.fixedButton4Id, fixButtonLabel_4TextBack.replace("-",""))
                    Storage.setAppDB(saveStamp + "_" + Constants.fixedButton5Id, fixButtonLabel_5TextBack.replace("-",""))

                    fixButtonLabel_1.text = fixButtonLabel_1TextBack
                    fixButtonLabel_2.text = fixButtonLabel_2TextBack
                    fixButtonLabel_3.text = fixButtonLabel_3TextBack
                    fixButtonLabel_4.text = fixButtonLabel_4TextBack
                    fixButtonLabel_5.text = fixButtonLabel_5TextBack

                    if (saveButton.pressed){  // #4319
                        Storage.setAppDB(saveStamp + "_" + "slider_init", sliderValueBack)
                    }

                    Storage.saveAppDB()

                    if(differentValuesOnCycles.activated){
                        slider.value = fixButtonLabel_1.text
                    }
                }
            }
        }

        Rectangle {
            id: saveButton
            property bool pressed: false  // #4319

            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            opacity: 0
            visible: buttonsVisibility//true//false
            anchors.bottom: parent.bottom
            anchors.bottomMargin: externalBorderMargin
            anchors.right: parent.right
            anchors.rightMargin: externalBorderMargin
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.saveId, "")
                opacity: saveButtonButton.down ? opacityOnButtonPressed : 1
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
            Button{
                id: saveButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    saveButton.pressed = true // #4319
                    savingEffect(saveButton)
                    Storage.setAppDB(saveStamp + "_" + "slider_init", slider.value / conversionFactor)
                    Storage.saveAppDB()
                }
            }
        }

        Rectangle{
            id: separatorLine
            x: initialWidth_reducedView * 0.025//0.42
            y: initialheight_reducedView * 0.5
            height: 2
            width: initialWidth_reducedView * 0.95//0.55
            color:"#444444"
            visible: doubleLabelVisible
        }

        Image {
            id: mainImage
            anchors.left: parent.left
            anchors.leftMargin: (doubleLabelVisible) ? mainImageDoubleMargin_reducedView : mainImageMargin_reducedView
            anchors.top: parent.top
            anchors.topMargin: (doubleLabelVisible) ? mainImageDoubleMargin_reducedView : mainImageMargin_reducedView
            width: (doubleLabelVisible) ? mainImageDoubleWidth_reducedView : mainImageWidth_reducedView
            height: mainImage.width
            source: ""
            asynchronous: false // if asynchronous is allowed strange effects appears when enlage and srink
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "yellow"
                visible: viewGrid
            }
        }
        Image {
            id: mainDoubleImage
            anchors.left: parent.left
            anchors.leftMargin: (doubleLabelVisible) ? mainImageDoubleMargin_reducedView : mainImageMargin_reducedView
            anchors.bottom: parent.bottom
            anchors.bottomMargin: (doubleLabelVisible) ? mainImageDoubleMargin_reducedView : mainImageMargin_reducedView
            width: (doubleLabelVisible) ? mainImageDoubleWidth_reducedView : mainImageWidth_reducedView
            height: mainImage.width
            source: ""
            visible: doubleLabelVisible
            asynchronous: false // if asynchronous is allowed strange effects appears when enlage and srink
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "pink"
                visible: viewGrid
            }
        }
        Image {
            id: mainCombinedImage
            anchors.left: mainImage.anchors.left
            anchors.leftMargin: mainImage.anchors.leftMargin
            anchors.top: mainImage.anchors.top
            anchors.topMargin: mainImage.anchors.topMargin
            width: mainImage.width
            height: mainImage.height
            source: ""
            visible: doubleLabelVisible & (inputControl.state === "fullViewDouble")
            asynchronous: false // if asynchronous is allowed strange effects appears when enlage and srink
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "green"
                visible: viewGrid
            }
        }

        Label {
            id: magnitudeLabel
            visible: (inputControl.state !== "reducedView") ? true : (!doubleLabelVisible && !differentValuesOnCycles.activated)
            opacity: (dependentMagnitude) ? 0 : 1
            text: formatSeparators(formatFractionalPart(computeMagnitudeLabelSign(magnitudeValue)))
            width: magnitudeLabelWidth_reducedView
            height: magnitudeLabelHeigtht_reducedView
            x: magnitudeLabelX_reducedView
            y: magnitudeLabelY_reducedView
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: magnitudeLabelFontSize_reducedView
            fontSizeMode: Text.Fit
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "green"
                visible: viewGrid
            }
        }

        Label {
            id: magnitudeLabel2
            visible: doubleLabelVisible
            text: magnitudeLabel2Replication.text
            width: magnitudeLabelWidth_reducedView * 0.56
            height: magnitudeLabelHeigtht_reducedView
            x: magnitudeLabelDoubleTopX_reducedView
            y: magnitudeLabelDoubleBottomY_reducedView
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.pixelSize: magnitudeLabel2Replication.font.pixelSize
            fontSizeMode: Text.VerticalFit
            onTextChanged: {
                adjustDoubleLabelSizes()
            }
            onXChanged: {
                adjustDoubleLabelSizes()
                adjustDoubleLabelPositions()
            }
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "red"
                visible: viewGrid
            }
        }

        Label {
            id: magnitudeLabel2Replication
            visible: doubleLabelVisible
            opacity: 0
            text: resolveDoubleLabel()
            width: magnitudeLabelWidth_reducedView * 0.5
            height: magnitudeLabelHeigtht_reducedView
            anchors.top: parent.top
            anchors.left: parent.left
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: magnitudeLabelFontSize2_reducedView
            fontSizeMode: Text.Fit

            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "red"
                visible: viewGrid
            }
        }

        Label {
            id: magnitudeLabel3
            visible: doubleLabelVisible
            color: magnitudeLabel.color
            text: magnitudeLabel3Replication.text
            width: magnitudeLabelWidth_reducedView * 0.56
            height: magnitudeLabelHeigtht_reducedView
            x: magnitudeLabelDoubleTopX_reducedView
            y: magnitudeLabelDoubleTopY_reducedView
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.pixelSize: magnitudeLabel3Replication.font.pixelSize
            fontSizeMode: Text.VerticalFit

            onTextChanged: {
                adjustDoubleLabelSizes()
            }
            onXChanged: {
                adjustDoubleLabelSizes()
            }
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "orange"
                visible: viewGrid
            }
        }
        Label {
            id: magnitudeLabel3Replication
            visible: doubleLabelVisible
            color: magnitudeLabel.color
            opacity: 0
            text: formatSeparators(formatFractionalPart(computeMagnitudeLabelSign(magnitudeValue)))
            width: magnitudeLabelWidth_reducedView * 0.5
            height: magnitudeLabelHeigtht_reducedView
            anchors.top: parent.top
            anchors.right: parent.right
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: magnitudeLabelFontSize2_reducedView
            fontSizeMode: Text.Fit
            onTextChanged: {
            }
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "orange"
                visible: viewGrid
            }
        }

        Label {
            id: unitsLabel
            text: ""
            width: unitsLabelWidth_reducedView
            height: unitsLabelHeigtht_reducedView
            x: unitsLabelX_reducedView
            y: unitsLabelY_reducedView
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: unitsLabelFontSize_reducedView
            fontSizeMode: Text.Fit
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "purple"
                visible: viewGrid
            }
        }

        Label {
            id: unitsLabel2
            visible: doubleLabelVisible
            text: "mm:ss"
            width: unitsLabelWidth_reducedView
            height: unitsLabelHeigtht_reducedView
            x: unitsLabelX_reducedView
            y: unitsLabel2Y_reducedView
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: unitsLabelFontSize_reducedView
            fontSizeMode: Text.Fit
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "brown"
                visible: viewGrid
            }
        }

        Label {
            id: magnitudeLabelForSavingEffect

            states: [
                State {
                    name: "saving"
                    PropertyChanges { target: magnitudeLabelForSavingEffect; opacity: 1 }
                    AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.horizontalCenter: auxRectangleForSavingEffect.horizontalCenter }
                    AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.verticalCenter: auxRectangleForSavingEffect.verticalCenter }
                },
                State {
                    name: "saved"
                    PropertyChanges { target: magnitudeLabelForSavingEffect; opacity: 0 }
                    PropertyChanges { target: magnitudeLabelForSavingEffect; font.pixelSize: magnitudeLabel.font.pixelSize }
                    AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.horizontalCenter: magnitudeLabel.horizontalCenter }
                    AnchorChanges { target: magnitudeLabelForSavingEffect; anchors.verticalCenter: magnitudeLabel.verticalCenter }
                    StateChangeScript { script: getFixButtonPressedLabel() } // no effect in save button
                }
            ]
            transitions: [
                Transition {
                    to: "saving"
                    AnchorAnimation  {duration: 400}
                    PropertyAnimation { target: magnitudeLabelForSavingEffect; property: "font.pixelSize"; to: 0; easing.type: Easing.Linear; duration: 400}
                    PropertyAnimation { target: magnitudeLabelForSavingEffect; property: "state"; to: "saved"; duration: 401 }
                }
            ]

            state: "saved"
            text: magnitudeLabel.text
            visible: magnitudeLabel.visible
            width: magnitudeLabel.width
            height: magnitudeLabel.height
            x: magnitudeLabel.x
            y: magnitudeLabel.y
            color: magnitudeLabel.color
            verticalAlignment: magnitudeLabel.verticalAlignment
            horizontalAlignment: magnitudeLabel.horizontalAlignment
            textFormat: magnitudeLabel.textFormat
            font.pixelSize: magnitudeLabel.font.pixelSize
            fontSizeMode: Text.Fit
        }

        Label {
            id: magnitudeLabel2ForSavingEffect

            states: [
                State {
                    name: "saving"
                    PropertyChanges { target: magnitudeLabel2ForSavingEffect; opacity: 1 }
                    AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.horizontalCenter: auxRectangleForSavingEffect.horizontalCenter }
                    AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.verticalCenter: auxRectangleForSavingEffect.verticalCenter }
                },
                State {
                    name: "saved"
                    PropertyChanges { target: magnitudeLabel2ForSavingEffect; opacity: 0 }
                    PropertyChanges { target: magnitudeLabel2ForSavingEffect; font.pixelSize: magnitudeLabel2.font.pixelSize }
                    AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.horizontalCenter: magnitudeLabel2.horizontalCenter }
                    AnchorChanges { target: magnitudeLabel2ForSavingEffect; anchors.verticalCenter: magnitudeLabel2.verticalCenter }
                    StateChangeScript { script: getFixButtonPressedLabel() } // no effect in save button
                }
            ]
            transitions: [
                Transition {
                    to: "saving"
                    AnchorAnimation  {duration: 400}
                    PropertyAnimation { target: magnitudeLabel2ForSavingEffect; property: "font.pixelSize"; to: 0; duration: 400}
                    PropertyAnimation { target: magnitudeLabel2ForSavingEffect; property: "state"; to: "saved"; duration: 401 }
                }
            ]

            state: "saved"
            text: magnitudeLabel2.text
            visible: magnitudeLabel2.visible
            width: magnitudeLabel2.width
            height: magnitudeLabel2.height
            x: magnitudeLabel2.x
            y: magnitudeLabel2.y
            color: magnitudeLabel2.color
            verticalAlignment: magnitudeLabel2.verticalAlignment
            horizontalAlignment: magnitudeLabel2.Text.AlignHCenter
            textFormat: magnitudeLabel2.textFormat
            font.pixelSize: magnitudeLabel2.font.pixelSize
            fontSizeMode: Text.Fit
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "pink"
                visible: viewGrid
            }
        }

        Label {
            id: magnitudeLabel3ForSavingEffect

            states: [
                State {
                    name: "saving"
                    PropertyChanges { target: magnitudeLabel3ForSavingEffect; opacity: 1 }
                    AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.horizontalCenter: auxRectangleForSavingEffect.horizontalCenter }
                    AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.verticalCenter: auxRectangleForSavingEffect.verticalCenter }
                    StateChangeScript { script: getFixButtonPressedLabel() } // no effect in save button
                },
                State {
                    name: "saved"
                    PropertyChanges { target: magnitudeLabel3ForSavingEffect; opacity: 0 }
                    PropertyChanges { target: magnitudeLabel3ForSavingEffect; font.pixelSize: magnitudeLabel3.font.pixelSize }
                    AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.horizontalCenter: magnitudeLabel3.horizontalCenter }
                    AnchorChanges { target: magnitudeLabel3ForSavingEffect; anchors.verticalCenter: magnitudeLabel3.verticalCenter }
                }
            ]
            transitions: [
                Transition {
                    to: "saving"
                    AnchorAnimation  {duration: 400}
                    PropertyAnimation { target: magnitudeLabel3ForSavingEffect; property: "font.pixelSize"; to: 0; duration: 400}
                    PropertyAnimation { target: magnitudeLabel3ForSavingEffect; property: "state"; to: "saved"; duration: 401 }
                }
            ]

            state: "saved"
            text: magnitudeLabel3.text
            visible: magnitudeLabel3.visible
            width: magnitudeLabel3.width
            height: magnitudeLabel3.height
            x: magnitudeLabel3.x
            y: magnitudeLabel3.y
            color: magnitudeLabel3.color
            verticalAlignment: magnitudeLabel3.verticalAlignment
            horizontalAlignment: magnitudeLabel3.Text.AlignHCenter
            textFormat: magnitudeLabel3.textFormat
            font.pixelSize: magnitudeLabel3.font.pixelSize
            fontSizeMode: Text.Fit
        }      

        Button{
            id: fullControlButton
            visible: true
            anchors.fill: parent
            opacity: 0
            z:5
            onClicked: {
                fullControlStateOn(name)

                if(doubleLabelVisible) {
                    inputControl.state = "fullViewDouble"
                }
                else {
                    inputControl.state = "fullView"
                }

                sliderValueBack = slider.value
                differentValuesOnCyclesBack = differentValuesOnCycles.activated
                fixButtonLabel_1TextBack = fixButtonLabel_1.text
                fixButtonLabel_2TextBack = fixButtonLabel_2.text
                fixButtonLabel_3TextBack = fixButtonLabel_3.text
                fixButtonLabel_4TextBack = fixButtonLabel_4.text
                fixButtonLabel_5TextBack = fixButtonLabel_5.text

                saveButton.pressed = false  // #4319
                //DEB->debug.log(DC.inputItemLog, "slider.value:",slider.value)
                //DEB->debug.log(DC.inputItemLog, "magnitudeLabel.text:",magnitudeLabel.text)
                //DEB->debug.log(DC.inputItemLog, "magnitudeValue:",magnitudeValue)
            }
        }

        Rectangle{
            id: auxRectangleForSavingEffect
            opacity: 0
            height: 50
            width: 50
        }

        Rectangle {
            id: differentValuesOnCycles
            property bool activated: false
            width: fixButtonWidth * 1.5
            height: fixButtonHeight
            color: buttonsColor
            radius: buttonRadius
            visible: multilabelView & buttonsVisibility
            anchors.left: downButton.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: externalBorderMargin
            opacity: 0

            Rectangle{
                id: equalButtom
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: parent.height * 0.1
                width: (parent.width * 0.5) - anchors.margins
                radius: parent.radius * 0.5
                color: differentValuesOnCycles.activated  ? inputForm.color : parent.color

                Image{
                    height: parent.height * 0.85
                    width: height
                    anchors.centerIn: parent
                    source: Storage.getAppDB(Constants.dbAppIcon.equalCyclesId, "")
                    opacity: differentValuesOnCycles.activated  ? disabledOpacity * 0.3 : 1
                    asynchronous: true                // performance improvement
                    sourceSize.width: parent.width    // performance improvement
                    sourceSize.height: parent.height  // performance improvement
                }
            }

            Rectangle{
                id: nonEqualButtom
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: parent.height * 0.1
                width: (parent.width * 0.5) - anchors.margins
                radius: parent.radius * 0.5
                color: differentValuesOnCycles.activated  ? parent.color : inputForm.color

                Image{
                    height: parent.height * 0.85
                    width: height
                    anchors.centerIn: parent
                    source: Storage.getAppDB(Constants.dbAppIcon.differentCyclesId, "")
                    opacity: differentValuesOnCycles.activated  ? 1 : disabledOpacity * 0.3
                    asynchronous: true                // performance improvement
                    sourceSize.width: parent.width    // performance improvement
                    sourceSize.height: parent.height  // performance improvement
                }
            }
            Button{
                id: sequentialOnButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: {
                    differentValuesOnCycles.activated = !differentValuesOnCycles.activated
                }
                onPressAndHold:{
                    if(differentValuesOnCycles.activated){
                        saveFixButtons()
                        Storage.setAppDB(saveStamp + "_" + Constants.diffValuesOnCyclesId, "true")
                    }
                    else {
                        Storage.setAppDB(saveStamp + "_" + Constants.diffValuesOnCyclesId, "false")
                    }
                    Storage.saveAppDB()
                    differentValuesOnCyclesSavingEffect.startAnimation("down")
                }
            }
            Rectangle{
                id: dummyPositioningRectangle
                height: parent.height * 2
                width: height
                x: parent.width * 0.25
                y: - parent.height
                color: "transparent"
                radius: parent.radius

                SaveEffect{
                    id: differentValuesOnCyclesSavingEffect
                    height: parent.height
                    width: height
                    radius: parent.radius
                    blinkRecangle.x: - dummyPositioningRectangle.x
                    blinkRecangle.y: - dummyPositioningRectangle.y
                    blinkRecangle.height: differentValuesOnCycles.height
                    blinkRecangle.width: differentValuesOnCycles.width
                }
            }
            Rectangle{
                anchors.fill:parent
                color: "transparent"
                border.color: "olive"
                visible: viewGrid
            }
        }


        Image{
            id: sequentialButtonImage_1Id
            width: fixButtonWidth * 0.25
            height: width
            anchors.bottom: fixButton_1.top
            anchors.bottomMargin: fixButtonMargin * 0.25
            anchors.right: fixButton_1.right
            anchors.rightMargin: fixButton_1.width * 0.5
            source: Storage.getAppDB(Constants.dbAppIcon.smallCyclesCounterId, "")
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height; // performance improvement
            visible: fixButton_1.visible & differentValuesOnCycles.activated
            opacity: fixButton_1.opacity
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "red"
                visible: viewGrid
            }
        }
        Image{
            id: sequentialButtonImage_2Id
            anchors.bottom: fixButton_2.top
            anchors.right: fixButton_2.right
            width: sequentialButtonImage_1Id.width
            height: sequentialButtonImage_1Id.height
            anchors.bottomMargin: sequentialButtonImage_1Id.anchors.bottomMargin
            anchors.rightMargin: fixButton_1.width * 0.5
            source: sequentialButtonImage_1Id.source
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height; // performance improvement
            visible: sequentialButtonImage_1Id.visible
            opacity: fixButton_2.opacity
        }
        Image{
            id: sequentialButtonImage_3Id
            anchors.bottom: fixButton_3.top
            anchors.right: fixButton_3.right
            width: sequentialButtonImage_1Id.width
            height: sequentialButtonImage_1Id.height
            anchors.bottomMargin: sequentialButtonImage_1Id.anchors.bottomMargin
            anchors.rightMargin: fixButton_1.width * 0.5
            source: sequentialButtonImage_1Id.source
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height; // performance improvement
            visible: sequentialButtonImage_1Id.visible
            opacity: fixButton_3.opacity
        }
        Image{
            id: sequentialButtonImage_4Id
            anchors.bottom: fixButton_4.top
            anchors.right: fixButton_4.right
            width: sequentialButtonImage_1Id.width
            height: sequentialButtonImage_1Id.height
            anchors.bottomMargin: sequentialButtonImage_1Id.anchors.bottomMargin
            anchors.rightMargin: fixButton_1.width * 0.5
            source: sequentialButtonImage_1Id.source
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height; // performance improvement
            visible: sequentialButtonImage_1Id.visible
            opacity: fixButton_4.opacity
        }
        Image{
            id: sequentialButtonImage_5Id
            anchors.bottom: fixButton_5.top
            anchors.right: fixButton_5.right
            width: sequentialButtonImage_1Id.width
            height: sequentialButtonImage_1Id.height
            anchors.bottomMargin: sequentialButtonImage_1Id.anchors.bottomMargin
            anchors.rightMargin: fixButton_1.width * 0.5
            source: sequentialButtonImage_1Id.source
            asynchronous: true                // performance improvement
            sourceSize.width: parent.width    // performance improvement
            sourceSize.height: parent.height; // performance improvement
            visible: sequentialButtonImage_1Id.visible
            opacity: fixButton_5.opacity
        }

        Label{
            id: sequentialButtonLabel_1Id
            height: sequentialButtonImage_1Id.height
            width: height * 0.75
            anchors.bottom: sequentialButtonImage_1Id.bottom
            anchors.left: sequentialButtonImage_1Id.right
            anchors.leftMargin: height * 0.1
            color: Storage.getAppDB(Constants.dbAppColor.inputCtrlSeqButtonLabelId, "black")
            text: "1"
            horizontalAlignment: Text.AlignCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height * 1000
            fontSizeMode: Text.Fit
            visible: sequentialButtonImage_1Id.visible
            opacity: fixButton_1.opacity
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                border.color: "olive"
                visible: viewGrid
            }
        }
        Label{
            id: sequentialButtonLabel_2Id
            height: sequentialButtonLabel_1Id.height
            width: sequentialButtonLabel_1Id.width
            anchors.bottom: sequentialButtonImage_2Id.bottom
            anchors.left: sequentialButtonImage_2Id.right
            anchors.leftMargin: sequentialButtonLabel_1Id.anchors.leftMargin
            color:sequentialButtonLabel_1Id.color
            text: "2"
            horizontalAlignment: sequentialButtonLabel_1Id.horizontalAlignment
            verticalAlignment: sequentialButtonLabel_1Id.verticalAlignment
            font.pixelSize: sequentialButtonLabel_1Id.font.pixelSize
            fontSizeMode: sequentialButtonLabel_1Id.fontSizeMode
            visible: sequentialButtonLabel_1Id.visible
            opacity: fixButton_2.opacity
        }
        Label{
            id: sequentialButtonLabel_3Id
            height: sequentialButtonLabel_1Id.height
            width: sequentialButtonLabel_1Id.width
            anchors.bottom: sequentialButtonImage_3Id.bottom
            anchors.left: sequentialButtonImage_3Id.right
            anchors.leftMargin: sequentialButtonLabel_1Id.anchors.leftMargin
            color:sequentialButtonLabel_1Id.color
            text: "3"
            horizontalAlignment: sequentialButtonLabel_1Id.horizontalAlignment
            verticalAlignment: sequentialButtonLabel_1Id.verticalAlignment
            font.pixelSize: sequentialButtonLabel_1Id.font.pixelSize
            fontSizeMode: sequentialButtonLabel_1Id.fontSizeMode
            visible: sequentialButtonLabel_1Id.visible
            opacity: fixButton_3.opacity
        }
        Label{
            id: sequentialButtonLabel_4Id
            height: sequentialButtonLabel_1Id.height
            width: sequentialButtonLabel_1Id.width
            anchors.bottom: sequentialButtonImage_4Id.bottom
            anchors.left: sequentialButtonImage_4Id.right
            anchors.leftMargin: sequentialButtonLabel_1Id.anchors.leftMargin
            color:sequentialButtonLabel_1Id.color
            text: "4"
            horizontalAlignment: sequentialButtonLabel_1Id.horizontalAlignment
            verticalAlignment: sequentialButtonLabel_1Id.verticalAlignment
            font.pixelSize: sequentialButtonLabel_1Id.font.pixelSize
            fontSizeMode: sequentialButtonLabel_1Id.fontSizeMode
            visible: sequentialButtonLabel_1Id.visible
            opacity: fixButton_4.opacity
        }
        Label{
            id: sequentialButtonLabel_5Id
            height: sequentialButtonLabel_1Id.height
            width: sequentialButtonLabel_1Id.width
            anchors.bottom: sequentialButtonImage_5Id.bottom
            anchors.left: sequentialButtonImage_5Id.right
            anchors.leftMargin: sequentialButtonLabel_1Id.anchors.leftMargin
            color:sequentialButtonLabel_1Id.color
            text: "5"
            horizontalAlignment: sequentialButtonLabel_1Id.horizontalAlignment
            verticalAlignment: sequentialButtonLabel_1Id.verticalAlignment
            font.pixelSize: sequentialButtonLabel_1Id.font.pixelSize
            fontSizeMode: sequentialButtonLabel_1Id.fontSizeMode
            visible: sequentialButtonLabel_1Id.visible
            opacity: fixButton_5.opacity
        }

        Rectangle {
            id: multipleLabelRectangle
            visible: (inputControl.state != "reducedView") ? false : (multilabelView & differentValuesOnCycles.activated)
            color: "transparent"
            width: magnitudeLabelWidth_reducedView
            height: magnitudeLabelHeigtht_reducedView
            x: magnitudeLabel.x
            y: magnitudeLabel.y

            Row{
                spacing: parent.width * 0.035
                height: parent.height
                anchors.centerIn: parent
                Repeater{
                    model: fixButtonsMax
                    Text {
                        id: cylce1label
                        color: magnitudeLabel.color
                        visible: (index < therapyCyclesNumber) ? true : false
                        opacity: (multilabelMainLabel === (index + 1)) ? 1 : 0.3
                        text: {
                            switch(index + 1){
                            case 1: fixButtonLabel_1.text; break
                            case 2: fixButtonLabel_2.text; break
                            case 3: fixButtonLabel_3.text; break
                            case 4: fixButtonLabel_4.text; break
                            case 5: fixButtonLabel_5.text; break
                            default: ""
                            }
                        }
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: (multilabelMainLabel === (index + 1)) ? magnitudeLabelFontSize_reducedView : unitsLabelFontSize_reducedView * 0.8
                        fontSizeMode: Text.Fit
                        Rectangle{
                            anchors.fill:parent
                            color: "transparent"
                            border.color: "magenta"
                            visible: viewGrid
                        }
                    }
                }
            }
        }

        Rectangle {
            id: changeSliderRangeButton
            width: operationButtonWidth
            height: operationButtonHeight
            color: buttonsColor
            radius: buttonRadius
            opacity: 0
            visible: buttonsVisibility & multiRangeSlider
            anchors.bottom: parent.bottom
            anchors.bottomMargin: externalBorderMargin
            anchors.left: parent.left
            anchors.leftMargin: externalBorderMargin
            Image{
                anchors.fill: parent
                source: Storage.getAppDB(Constants.dbAppIcon.sliderRangeId, "")
                opacity: changeSliderRangeButtonButton.down ? opacityOnButtonPressed : 1
                asynchronous: true                // performance improvement
                sourceSize.width: parent.width    // performance improvement
                sourceSize.height: parent.height  // performance improvement
            }
            Button{
                id: changeSliderRangeButtonButton
                opacity: 0
                anchors.fill: parent
                onClicked: changeSliderRangeLabel.text = "..." + performSliderRangeChange(true)
            }
            Label{
                id: changeSliderRangeLabel
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.9
                height: parent.height * 0.33
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height
                fontSizeMode: Text.Fit
                text: ""//"...40000"
                color: Storage.getAppDB(Constants.dbAppColor.inputCtrlChangeRangeLabelId, "black")
                visible: false
            }
        }
    }
}
