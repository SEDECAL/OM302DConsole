// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

Qt.include("Constants.js")
Qt.include("Configurator.js")
Qt.include("Therapies.js")

/*
    TEST DOCUMENTATION

    - This test will modify application database. Database should be regenerated after this test.
    - This test runs based in to 'csv' files: 'testFile.txt' and 'testReferenceFile.txt'.
    - This test is automatic and the result will be: 'test ok' or 'test fail'.
    - A new 'TestFile.txt' is generated each time test were executed.
    - 'TestReferenceFile.txt' must be generated each time one new test case were added to the test.
    - Generation of 'testReferenceFile.txt' is not automatic and need human help process (using Excel).
    - If test fails, results must be checked using the process descibed below to generate 'testReferenceFile.txt'.

    Generation of 'testReferenceFile.txt'.
     1. Add a new test case creating a new input in all strings declared bellow.
     2. Keep track of the test case by briefly documenting it in the 'test track' section.
     3. Increment by one 'numberOfTests' varible.
     4. Run test (result should be fail).'TestFile.txt' should be available as a test result.
     5. Open 'ConversionSupervisor.xlsx' file on Excel.
     6. Open 'testFile.txt' file on Excel. 'Delimited fields' -> 'Semicolon' -> 'General'.
     7. Copy content of 'testFile.txt' on 'Test' folder of 'ConversionSupervisor.xlsx' file.
     8. Copy lines of each test from 'Test' folder on 'Temporal' folder (information will appear automatically on 'Check' folder).
     9. Check that the result is ok on 'Check' folder.
    10. Once the results are ok, 'testFile.txt' file should be renamed as 'testReferenceFile.txt'.
*/

// Test track:

// test 00: official units
// test 01: all input (magnitude) units to submultiple, output (cumulated & totals) remains official
// test 02: all input (magnitude) units to multiple, output (cumulated & totals) remains official
// test 03: all input (magnitude) units to official, output (cumulated & totals) to submultiple
// test 04: all input (magnitude) units to official, output (cumulated & totals) to multiple
// test 05: all input (magnitude) units to submultiple, output (cumulated & totals) to submultiple
// test 06: all input (magnitude) units to submultiple, output (cumulated & totals) to multiple
// test 07: all input (magnitude) units to multiple, output (cumulated & totals) to submultiple
// test 08: all input (magnitude) units to multiple, output (cumulated & totals) to multiple
// test 09: bottle units to official, weight units to submultiple
// test 10: bottle units to official, weight units to multiple

// test 11: bottle units to submultiple, weight units to official
// test 12: bottle units to submultiple, weight units to submultiple
// test 13: bottle units to submultiple, weight units to multiple

// test xx:
var numberOfTests = 17

//                                                        option1Id       option2Id      option3Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id
var sliderUnitsBottleVolumeTest =           /*[00]*/[[          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[01]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[02]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[03]*/ [          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[04]*/ [          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[05]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[06]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[07]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[08]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[09]*/ [          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[10]*/ [          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[11]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[12]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[13]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[14]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[15]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[16]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                                    ]
var sliderUnitsBloodVolumeTest =            /*[00]*/[[          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[01]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[02]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[03]*/ [          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[04]*/ [          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[05]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[06]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[07]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[08]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[09]*/ [          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[10]*/ [          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc",          "cc" ],
                                            /*[11]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[12]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[13]*/ [          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl",          "nl" ],
                                            /*[14]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[15]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                            /*[16]*/ [           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l",           "l" ],
                                                    ]
var sliderUnitsO3Test =                     /*[00]*/[[ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ],
                                            /*[01]*/ [      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml" ],
                                            /*[02]*/ [      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml" ],
                                            /*[03]*/ [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ],
                                            /*[04]*/ [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ],
                                            /*[05]*/ [      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml" ],
                                            /*[06]*/ [      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml",      "ng/Nml" ],
                                            /*[07]*/ [      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml" ],
                                            /*[08]*/ [      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml" ],
                                            /*[09]*/ [      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml" ],
                                            /*[10]*/ [      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml",      "mg/Nml" ],
                                            /*[11]*/ [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ],
                                            /*[12]*/ [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ],
                                            /*[13]*/ [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ],
                                            /*[14]*/ [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ],
                                            /*[15]*/ [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ],
                                            /*[16]*/ [ "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml", "\u03BCg/Nml" ],
                                                    ]
var sliderUnitsFlowTest =                   /*[00]*/[[         "l/h",         "l/h", /*fix*/ "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ],
                                            /*[01]*/ [         "l/d",         "l/d", /*fix*/ "l/h",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d" ],
                                            /*[02]*/ [         "l/m",         "l/m", /*fix*/ "l/h",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m" ],
                                            /*[03]*/ [         "l/h",         "l/h", /*fix*/ "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ],
                                            /*[04]*/ [         "l/h",         "l/h", /*fix*/ "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ],
                                            /*[05]*/ [         "l/d",         "l/d", /*fix*/ "l/h",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d" ],
                                            /*[06]*/ [         "l/d",         "l/d", /*fix*/ "l/h",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d",         "l/d" ],
                                            /*[07]*/ [         "l/m",         "l/m", /*fix*/ "l/h",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m" ],
                                            /*[08]*/ [         "l/m",         "l/m", /*fix*/ "l/h",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m" ],
                                            /*[09]*/ [         "l/m",         "l/m", /*fix*/ "l/h",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m" ],
                                            /*[10]*/ [         "l/m",         "l/m", /*fix*/ "l/h",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m",         "l/m" ],
                                            /*[11]*/ [         "l/h",         "l/h", /*fix*/ "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ],
                                            /*[12]*/ [         "l/h",         "l/h", /*fix*/ "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ],
                                            /*[13]*/ [         "l/h",         "l/h", /*fix*/ "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ],
                                            /*[14]*/ [         "l/h",         "l/h", /*fix*/ "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ],
                                            /*[15]*/ [         "l/h",         "l/h", /*fix*/ "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ],
                                            /*[16]*/ [         "l/h",         "l/h", /*fix*/ "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h",         "l/h" ],
                                                    ]
var sliderUnitsTimeTest =                   /*[00]*/[[         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[01]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[02]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[03]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[04]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[05]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[06]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[07]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[08]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[09]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[10]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[11]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[12]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[13]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[14]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[15]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[16]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                                    ]
var sliderUnitsTotalConcentrationTest =     /*[00]*/[[     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg" ],
                                            /*[01]*/ [          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng" ],
                                            /*[02]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[03]*/ [     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg" ],
                                            /*[04]*/ [     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg",     "\u03BCg" ],
                                            /*[05]*/ [          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng" ],
                                            /*[06]*/ [          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng",          "ng" ],
                                            /*[07]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[08]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[09]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[10]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[11]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[12]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[13]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[14]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[15]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                            /*[16]*/ [          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg",          "mg" ],
                                                    ]
var sliderUnitsTherapyTimeTest =            /*[00]*/[[         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[01]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[02]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[03]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[04]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[05]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[06]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[07]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[08]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[09]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[10]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[11]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[12]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[13]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[14]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[15]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                            /*[16]*/ [         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min",         "min" ],
                                                    ]
var sliderUnitsVacuumTimeTest =             /*[00]*/[[         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[01]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[02]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[03]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[04]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[05]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[06]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[07]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[08]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[09]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[10]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[11]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[12]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[13]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[14]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[15]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                            /*[16]*/ [         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec",         "sec" ],
                                                    ]
var sliderUnitsTimeVolumeTest =             /*[00]*/[[      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml" ],
                                            /*[01]*/ [      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl" ],
                                            /*[02]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[03]*/ [      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml" ],
                                            /*[04]*/ [      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml",      "min~ml" ],
                                            /*[05]*/ [      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl" ],
                                            /*[06]*/ [      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl",      "min~nl" ],
                                            /*[07]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[08]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[09]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[10]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[11]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[12]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[13]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[14]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[15]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                            /*[16]*/ [       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l",       "min~l" ],
                                                    ]
var sliderUnitsVolumeDoseTest =             /*[00]*/[[         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[01]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[02]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[03]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[04]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[05]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[06]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[07]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[08]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[09]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[10]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[11]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[12]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[13]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[14]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[15]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                            /*[16]*/ [         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-",         "-~-" ],
                                                    ]
var sliderUnitsTimeDoseTest =               /*[00]*/[[ "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg" ],
                                            /*[01]*/ [      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng" ],
                                            /*[02]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[03]*/ [ "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg" ],
                                            /*[04]*/ [ "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg", "min~\u03BCg" ],
                                            /*[05]*/ [      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng" ],
                                            /*[06]*/ [      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng",      "min~ng" ],
                                            /*[07]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[08]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[09]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[10]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[11]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[12]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[13]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[14]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[15]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                            /*[16]*/ [      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg",      "min~mg" ],
                                                    ]
//                                                       option1Id       option2Id      option3Id      option4Id    option4_1Id    option4_2Id      option5Id    option5_1Id    option5_2Id      option6Id    option6_1Id    option6_2Id    option6_3Id      option7Id
var conversionFactorBottleVolumeTest =      /*[00]*/[[          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[01]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[02]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[03]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[04]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[05]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[06]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[07]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[08]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[09]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[10]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[11]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[12]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[13]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[14]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[15]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[16]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                                     ]
var conversionFactorBloodVolumeTest =       /*[00]*/[[          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[01]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[02]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[03]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[04]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[05]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[06]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[07]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[08]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[09]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[10]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[11]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[12]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[13]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[14]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[15]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[16]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                                    ]
var conversionFactorO3Test =                /*[00]*/[[          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[01]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[02]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[03]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[04]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[05]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[06]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[07]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[08]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[09]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[10]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[11]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[12]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[13]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[14]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[15]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[16]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                                    ]
var conversionFactorFlowTest =              /*[00]*/[[          "1",            "1", /*fix*/   "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[01]*/ [         "24",           "24", /*fix*/   "1",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24" ],
                                            /*[02]*/ [   "0.016666",     "0.016666", /*fix*/   "1",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666" ],
                                            /*[03]*/ [          "1",            "1", /*fix*/   "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[04]*/ [          "1",            "1", /*fix*/   "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[05]*/ [         "24",           "24", /*fix*/   "1",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24" ],
                                            /*[06]*/ [         "24",           "24", /*fix*/   "1",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24",          "24" ],
                                            /*[07]*/ [   "0.016666",     "0.016666", /*fix*/   "1",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666" ],
                                            /*[08]*/ [   "0.016666",     "0.016666", /*fix*/   "1",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666" ],
                                            /*[09]*/ [   "0.016666",     "0.016666", /*fix*/   "1",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666" ],
                                            /*[10]*/ [   "0.016666",     "0.016666", /*fix*/   "1",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666",    "0.016666" ],
                                            /*[11]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[12]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[13]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[14]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[15]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[16]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                                     ]
var conversionFactorTimeTest =              /*[00]*/[[          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[01]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[02]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[03]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[04]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[05]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[06]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[07]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[08]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[09]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[10]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[11]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[12]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[13]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[14]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[15]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[16]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                                    ]
var conversionFactorTotalConcentrationTest =/*[00]*/[[          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[01]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[02]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[03]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[04]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[05]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[06]*/ [       "1000",         "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000",        "1000" ],
                                            /*[07]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[08]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[09]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[10]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[11]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[12]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[13]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[14]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[15]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                            /*[16]*/ [      "0.001",        "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001",       "0.001" ],
                                                    ]
var conversionFactorTherapyTimeTest =       /*[00]*/[[          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[01]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[02]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[03]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[04]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[05]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[06]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[07]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[08]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[09]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[10]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[11]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[12]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[13]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[14]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[15]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[16]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                                    ]
var conversionFactorVacuumTimeTest =        /*[00]*/[[          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[01]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[02]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[03]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[04]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[05]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[06]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[07]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[08]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[09]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[10]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[11]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[12]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[13]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[14]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[15]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                            /*[16]*/ [          "1",            "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1",           "1" ],
                                                    ]
var conversionFactorTimeVolumeTest =        /*[00]*/[[        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[01]*/ [     "1~1000",       "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000" ],
                                            /*[02]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[03]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[04]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[05]*/ [     "1~1000",       "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000" ],
                                            /*[06]*/ [     "1~1000",       "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000" ],
                                            /*[07]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[08]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[09]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[10]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[11]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[12]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[13]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[14]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[15]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[16]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                                    ]
var conversionFactorVolumeDoseTest =        /*[00]*/[[        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[01]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[02]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[03]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[04]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[05]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[06]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[07]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[08]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[09]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[10]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[11]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[12]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[13]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[14]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[15]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[16]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                                    ]
var conversionFactorTimeDoseTest =          /*[00]*/[[        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[01]*/ [     "1~1000",       "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000" ],
                                            /*[02]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[03]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[04]*/ [        "1~1",          "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1",         "1~1" ],
                                            /*[05]*/ [     "1~1000",       "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000" ],
                                            /*[06]*/ [     "1~1000",       "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000",      "1~1000" ],
                                            /*[07]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[08]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[09]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[10]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[11]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[12]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[13]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[14]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[15]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                            /*[16]*/ [    "1~0.001",      "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001",     "1~0.001" ],
                                                    ]
//                                                            dose        volume      pressure   temperature   weightToVolume
var parameterUnitsTest  =                   /*[00]*/[[    "\u03BCg",         "ml",       "mbar",       "cent",            "kg" ],
                                            /*[01]*/ [    "\u03BCg",         "ml",       "mbar",       "cent",            "kg" ],
                                            /*[02]*/ [    "\u03BCg",         "ml",       "mbar",       "cent",            "kg" ],
                                            /*[03]*/ [         "ng",         "nl",       "mbar",       "cent",            "kg" ],
                                            /*[04]*/ [         "mg",          "l",       "mbar",       "cent",            "kg" ],
                                            /*[05]*/ [         "ng",         "nl",       "mbar",       "cent",            "kg" ],
                                            /*[06]*/ [         "mg",          "l",       "mbar",       "cent",            "kg" ],
                                            /*[07]*/ [         "ng",         "nl",       "mbar",       "cent",            "kg" ],
                                            /*[08]*/ [         "mg",          "l",       "mbar",       "cent",            "kg" ],
                                            /*[09]*/ [         "mg",          "l",       "mbar",       "cent",             "g" ],
                                            /*[10]*/ [         "mg",          "l",       "mbar",       "cent",             "T" ],
                                            /*[11]*/ [         "mg",          "l",       "mbar",       "cent",            "Kg" ],
                                            /*[12]*/ [         "mg",          "l",       "mbar",       "cent",            " g" ],
                                            /*[13]*/ [         "mg",          "l",       "mbar",       "cent",            " T" ],
                                            /*[14]*/ [         "mg",          "l",       "mbar",       "cent",            "Kg" ],
                                            /*[15]*/ [         "mg",          "l",       "mbar",       "cent",             "g" ],
                                            /*[16]*/ [         "mg",          "l",       "mbar",       "cent",             "T" ],
                                                    ]
//                                                            dose        volume      pressure   temperature   weightToVolume
var parameterConversionFactorTest =         /*[00]*/[[          "1",          "1",          "1",          "1",             "1" ],
                                            /*[01]*/ [          "1",          "1",          "1",          "1",             "1" ],
                                            /*[02]*/ [          "1",          "1",          "1",          "1",             "1" ],
                                            /*[03]*/ [       "1000",       "1000",          "1",          "1",             "1" ],
                                            /*[04]*/ [      "0.001",      "0.001",          "1",          "1",             "1" ],
                                            /*[05]*/ [       "1000",       "1000",          "1",          "1",             "1" ],
                                            /*[06]*/ [      "0.001",      "0.001",          "1",          "1",             "1" ],
                                            /*[07]*/ [       "1000",       "1000",          "1",          "1",             "1" ],
                                            /*[08]*/ [      "0.001",      "0.001",          "1",          "1",             "1" ],
                                            /*[09]*/ [      "0.001",      "0.001",          "1",          "1",         "0.001" ],
                                            /*[10]*/ [      "0.001",      "0.001",          "1",          "1",          "1000" ],
                                            /*[11]*/ [      "0.001",      "0.001",          "1",          "1",             "1" ],
                                            /*[12]*/ [      "0.001",      "0.001",          "1",          "1",         "0.001" ],
                                            /*[13]*/ [      "0.001",      "0.001",          "1",          "1",          "1000" ],
                                            /*[14]*/ [      "0.001",      "0.001",          "1",          "1",             "1" ],
                                            /*[15]*/ [      "0.001",      "0.001",          "1",          "1",         "0.001" ],
                                            /*[16]*/ [      "0.001",      "0.001",          "1",          "1",          "1000" ],
                                                    ]


function setUpTest(testNumber){
    var therapieNum
    var parameterNum

    for (therapieNum = 0; therapieNum < 14; therapieNum++){

        //
        // Prepare test enviroment
        //
        sliderUnitsABottleVolume[therapieNum] =       sliderUnitsBottleVolume[therapieNum] =       sliderUnitsBottleVolumeTest[testNumber][therapieNum]
        sliderUnitsABloodVolume[therapieNum] =        sliderUnitsBloodVolume[therapieNum] =        sliderUnitsBloodVolumeTest[testNumber][therapieNum]
        sliderUnitsAO3[therapieNum] =                 sliderUnitsO3[therapieNum] =                 sliderUnitsO3Test[testNumber][therapieNum]
        sliderUnitsAFlow[therapieNum] =               sliderUnitsFlow[therapieNum] =               sliderUnitsFlowTest[testNumber][therapieNum]
        sliderUnitsATime[therapieNum] =               sliderUnitsTime[therapieNum] =               sliderUnitsTimeTest[testNumber][therapieNum]
        sliderUnitsATotalConcentration[therapieNum] = sliderUnitsTotalConcentration[therapieNum] = sliderUnitsTotalConcentrationTest[testNumber][therapieNum]
        sliderUnitsATherapyTime[therapieNum] =        sliderUnitsTherapyTime[therapieNum] =        sliderUnitsTherapyTimeTest[testNumber][therapieNum]
        sliderUnitsAVacuumTime[therapieNum] =         sliderUnitsVacuumTime[therapieNum] =         sliderUnitsVacuumTimeTest[testNumber][therapieNum]
        sliderUnitsATimeVolume[therapieNum] =         sliderUnitsTimeVolume[therapieNum] =         sliderUnitsTimeVolumeTest[testNumber][therapieNum]
        sliderUnitsAVolumeDose[therapieNum] =         sliderUnitsVolumeDose[therapieNum] =         sliderUnitsVolumeDoseTest[testNumber][therapieNum]
        sliderUnitsATimeDose[therapieNum] =           sliderUnitsTimeDose[therapieNum] =           sliderUnitsTimeDoseTest[testNumber][therapieNum]

        conversionFactorABottleVolume[therapieNum]       = conversionFactorBottleVolumeTest[testNumber][therapieNum]
        conversionFactorABloodVolume[therapieNum]        = conversionFactorBloodVolumeTest[testNumber][therapieNum]
        conversionFactorAO3[therapieNum]                 = conversionFactorO3Test[testNumber][therapieNum]
        conversionFactorAFlow[therapieNum]               = conversionFactorFlowTest[testNumber][therapieNum]
        conversionFactorATime[therapieNum]               = conversionFactorTimeTest[testNumber][therapieNum]
        conversionFactorATotalConcentration[therapieNum] = conversionFactorTotalConcentrationTest[testNumber][therapieNum]
        conversionFactorATherapyTime[therapieNum]        = conversionFactorTherapyTimeTest[testNumber][therapieNum]
        conversionFactorAVacuumTime[therapieNum]         = conversionFactorVacuumTimeTest[testNumber][therapieNum]
        conversionFactorATimeVolume[therapieNum]         = conversionFactorTimeVolumeTest[testNumber][therapieNum]
        conversionFactorAVolumeDose[therapieNum]         = conversionFactorVolumeDoseTest[testNumber][therapieNum]
        conversionFactorATimeDose[therapieNum]           = conversionFactorTimeDoseTest[testNumber][therapieNum]

        //
        // Save enviromnet in data base
        //
        Configurator.configureTherapy(optionId[therapieNum]) // just to create proper saveStamps

        Storage.setAppDB(magnitudeSelector.inputBottleVolume.saveStamp       + "_" + Constants.sliderUnitsId, sliderUnitsBottleVolume[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputBloodVolume.saveStamp        + "_" + Constants.sliderUnitsId, sliderUnitsBloodVolume[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputO3.saveStamp                 + "_" + Constants.sliderUnitsId, sliderUnitsO3[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputFlow.saveStamp               + "_" + Constants.sliderUnitsId, sliderUnitsFlow[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTime.saveStamp               + "_" + Constants.sliderUnitsId, sliderUnitsTime[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTotalConcentration.saveStamp + "_" + Constants.sliderUnitsId, sliderUnitsTotalConcentration[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTherapyTime.saveStamp        + "_" + Constants.sliderUnitsId, sliderUnitsTherapyTime[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputVacuumTime.saveStamp         + "_" + Constants.sliderUnitsId, sliderUnitsVacuumTime[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTimeVolume.saveStamp         + "_" + Constants.sliderUnitsId, sliderUnitsTimeVolume[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputVolumeDose.saveStamp         + "_" + Constants.sliderUnitsId, sliderUnitsVolumeDose[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTimeDose.saveStamp           + "_" + Constants.sliderUnitsId, sliderUnitsTimeDose[therapieNum])

        Storage.setAppDB(magnitudeSelector.inputBottleVolume.saveStamp       + "_" + Constants.sliderUnitsAId, sliderUnitsABottleVolume[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputBloodVolume.saveStamp        + "_" + Constants.sliderUnitsAId, sliderUnitsABloodVolume[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputO3.saveStamp                 + "_" + Constants.sliderUnitsAId, sliderUnitsAO3[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputFlow.saveStamp               + "_" + Constants.sliderUnitsAId, sliderUnitsAFlow[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTime.saveStamp               + "_" + Constants.sliderUnitsAId, sliderUnitsATime[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTotalConcentration.saveStamp + "_" + Constants.sliderUnitsAId, sliderUnitsATotalConcentration[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTherapyTime.saveStamp        + "_" + Constants.sliderUnitsAId, sliderUnitsATherapyTime[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputVacuumTime.saveStamp         + "_" + Constants.sliderUnitsAId, sliderUnitsAVacuumTime[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTimeVolume.saveStamp         + "_" + Constants.sliderUnitsAId, sliderUnitsATimeVolume[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputVolumeDose.saveStamp         + "_" + Constants.sliderUnitsAId, sliderUnitsAVolumeDose[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTimeDose.saveStamp           + "_" + Constants.sliderUnitsAId, sliderUnitsATimeDose[therapieNum])

        Storage.setAppDB(magnitudeSelector.inputBottleVolume.saveStamp       + "_" + Constants.unitsConversionFactorAId, conversionFactorABottleVolume[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputBloodVolume.saveStamp        + "_" + Constants.unitsConversionFactorAId, conversionFactorABloodVolume[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputO3.saveStamp                 + "_" + Constants.unitsConversionFactorAId, conversionFactorAO3[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputFlow.saveStamp               + "_" + Constants.unitsConversionFactorAId, conversionFactorAFlow[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTime.saveStamp               + "_" + Constants.unitsConversionFactorAId, conversionFactorATime[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTotalConcentration.saveStamp + "_" + Constants.unitsConversionFactorAId, conversionFactorATotalConcentration[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTherapyTime.saveStamp        + "_" + Constants.unitsConversionFactorAId, conversionFactorATherapyTime[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputVacuumTime.saveStamp         + "_" + Constants.unitsConversionFactorAId, conversionFactorAVacuumTime[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTimeVolume.saveStamp         + "_" + Constants.unitsConversionFactorAId, conversionFactorATimeVolume[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputVolumeDose.saveStamp         + "_" + Constants.unitsConversionFactorAId, conversionFactorAVolumeDose[therapieNum])
        Storage.setAppDB(magnitudeSelector.inputTimeDose.saveStamp           + "_" + Constants.unitsConversionFactorAId, conversionFactorATimeDose[therapieNum])
    }

    for (parameterNum = 0; parameterNum < 5; parameterNum++){
        parameterUnitsA[parameterNum] = parameterUnits[parameterNum] = parameterUnitsTest[testNumber][parameterNum]
        parameterConversionFactorA[parameterNum] = parameterConversionFactorTest[testNumber][parameterNum]
//      Storage.setAppDB(Constants.parameterId + "_" + Constants.parameterTypeId[parameterNum] + "_" + parameterUnitsId, parameterUnits[parameterNum])
//      Storage.setAppDB(Constants.parameterId + "_" + Constants.parameterTypeId[parameterNum] + "_" + parameterUnitsAId,  parameterUnitsA[parameterNum])
//      Storage.setAppDB(Constants.parameterId + "_" + Constants.parameterTypeId[parameterNum] + "_" + parameterConversionFactorAId , parameterConversionFactorA[parameterNum])
    }
    // Cumulated O3 parameter 0
    cumulatedBoard.cumulatedO3.unitsLabel.text = parameterUnitsTest[testNumber][0]
    cumulatedBoard.cumulatedO3.conversionFactor = parameterConversionFactorTest[testNumber][0]

    // Cumulated Volume parameter 1
    cumulatedBoard.cumulatedVolume.unitsLabel.text = parameterUnitsTest[testNumber][1]
    cumulatedBoard.cumulatedVolume.conversionFactor = parameterConversionFactorTest[testNumber][1]

    // Weight to volume conversion
//    bloodVolume.unitsLabel.text = parameterUnitsTest[testNumber][4]
//    bloodVolume.weightConversionFactor = parameterConversionFactorTest[testNumber][4]
    Storage.setAppDB(Constants.parameterId + "_" + Constants.parameterPersonWeightId + "_" + Constants.parameterUnitsId, parameterUnitsTest[testNumber][4])
    Storage.setAppDB(Constants.parameterId + "_" + Constants.parameterPersonWeightId + "_" + Constants.parameterUnitsAId, parameterUnitsTest[testNumber][4])
    Storage.setAppDB(Constants.parameterId + "_" + Constants.parameterPersonWeightId + "_" + Constants.parameterConversionFactorAId, parameterConversionFactorTest[testNumber][4])

    debug.log(DC.testConsoleLog, "set up test, ", Constants.parameterId + "_" + Constants.parameterPersonWeightId + "_" + Constants.parameterUnitsId + ": " + parameterUnitsTest[testNumber][4])
    debug.log(DC.testConsoleLog, "set up test, ", Constants.parameterId + "_" + Constants.parameterPersonWeightId + "_" + Constants.parameterUnitsAId + ": " + parameterUnitsTest[testNumber][4])
    debug.log(DC.testConsoleLog, "set up test, ", Constants.parameterId + "_" + Constants.parameterPersonWeightId + "_" + Constants.parameterConversionFactorAId + ": " + parameterConversionFactorTest[testNumber][4])

}

function createReference(){
    var therapieNum = 1
    var i, conv1, conv2

    for (therapieNum = 0; therapieNum < 14; therapieNum++){

        if((therapieNum !== 4) && (therapieNum !== 5) && (therapieNum !== 6) && (therapieNum !== 9)){

            testFile.write("Therapie number ", "Append")
            testFile.write(therapieNum, "Append")
            testFile.write(" (configuration)", "Append")

            // bottleVolume
            testFile.write(";" + sliderInitBottleVolume[therapieNum].toString().replace(/\./g,','), "Append")
            testFile.write(";" + sliderUnitsBottleVolume[therapieNum].toString().replace(/\./g,','), "Append")
            if(sliderUnitsBottleVolume[therapieNum] === sliderUnitsABottleVolume[therapieNum]){
                testFile.write(";" + conversionFactorABottleVolume[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else if(sliderUnitsBottleVolume[therapieNum] === sliderUnitsBBottleVolume[therapieNum]){
                testFile.write(";" + conversionFactorBBottleVolume[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else{
                testFile.write("; units error" , "Append")
            }

            // bloodVolume
            testFile.write(";" + sliderInitBloodVolume[therapieNum].toString().replace(/\./g,','), "Append")
            testFile.write(";" + sliderUnitsBloodVolume[therapieNum].toString().replace(/\./g,','), "Append")
            if(sliderUnitsBloodVolume[therapieNum] === sliderUnitsABloodVolume[therapieNum]){
                testFile.write(";" + conversionFactorABloodVolume[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else if(sliderUnitsBloodVolume[therapieNum] === sliderUnitsBBottleVolume[therapieNum]){
                testFile.write(";" + conversionFactorBBloodVolume[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else{
                testFile.write("; units error" , "Append")
            }

            // O3
            testFile.write(";" + sliderInitO3[therapieNum].toString().replace(/\./g,','), "Append")
            testFile.write(";" + sliderUnitsO3[therapieNum].toString().replace(/\./g,','), "Append")
            if(sliderUnitsO3[therapieNum] === sliderUnitsAO3[therapieNum]){
                testFile.write(";" + conversionFactorAO3[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else if(sliderUnitsO3[therapieNum] === sliderUnitsBO3[therapieNum]){
                testFile.write(";" + conversionFactorBO3[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else{
                testFile.write("; units error" , "Append")
            }

            // Flow
            testFile.write(";" + sliderInitFlow[therapieNum].toString().replace(/\./g,','), "Append")
            testFile.write(";" + sliderUnitsFlow[therapieNum].toString().replace(/\./g,','), "Append")
            if(sliderUnitsFlow[therapieNum] === sliderUnitsAFlow[therapieNum]){
                testFile.write(";" + conversionFactorAFlow[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else if(sliderUnitsFlow[therapieNum] === sliderUnitsBFlow[therapieNum]){
                testFile.write(";" + conversionFactorBFlow[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else{
                testFile.write("; units error" , "Append")
            }

            // Time
            testFile.write(";" + sliderInitTime[therapieNum].toString().replace(/\./g,','), "Append")
            testFile.write(";" + sliderUnitsTime[therapieNum].toString().replace(/\./g,','), "Append")
            if(sliderUnitsTime[therapieNum] === sliderUnitsATime[therapieNum]){
                testFile.write(";" + conversionFactorATime[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else if(sliderUnitsTime[therapieNum] === sliderUnitsBTime[therapieNum]){
                testFile.write(";" + conversionFactorBTime[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else{
                testFile.write("; units error" , "Append")
            }

            // Total concentration
            testFile.write(";" + sliderInitTotalConcentration[therapieNum].toString().replace(/\./g,','), "Append")
            testFile.write(";" + sliderUnitsTotalConcentration[therapieNum].toString().replace(/\./g,','), "Append")
            if(sliderUnitsTotalConcentration[therapieNum] === sliderUnitsATotalConcentration[therapieNum]){
                testFile.write(";" + conversionFactorATotalConcentration[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else if(sliderUnitsTotalConcentration[therapieNum] === sliderUnitsBTotalConcentration[therapieNum]){
                testFile.write(";" + conversionFactorBTotalConcentration[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else{
                testFile.write("; units error" , "Append")
            }

            // Therapy time
            testFile.write(";" + sliderInitTherapyTime[therapieNum].toString().replace(/\./g,','), "Append")
            testFile.write(";" + sliderUnitsTherapyTime[therapieNum].toString().replace(/\./g,','), "Append")
            if(sliderUnitsTherapyTime[therapieNum] === sliderUnitsATherapyTime[therapieNum]){
                testFile.write(";" + conversionFactorATherapyTime[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else if(sliderUnitsTherapyTime[therapieNum] === sliderUnitsBTherapyTime[therapieNum]){
                testFile.write(";" + conversionFactorBTherapyTime[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else{
                testFile.write("; units error" , "Append")
            }

            // Vacuum time
            testFile.write(";" + sliderInitVacuumTime[therapieNum].toString().replace(/\./g,','), "Append")
            testFile.write(";" + sliderUnitsVacuumTime[therapieNum].toString().replace(/\./g,','), "Append")
            if(sliderUnitsVacuumTime[therapieNum] === sliderUnitsAVacuumTime[therapieNum]){
                testFile.write(";" + conversionFactorAVacuumTime[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else if(sliderUnitsVacuumTime[therapieNum] === sliderUnitsBVacuumTime[therapieNum]){
                testFile.write(";" + conversionFactorBVacuumTime[therapieNum].toString().replace(/\./g,','), "Append")
            }
            else{
                testFile.write("; units error" , "Append")
            }

            // Time Volume
            testFile.write(";" + sliderInitTimeVolume[therapieNum].toString().replace(/\./g,','), "Append")
            i = sliderUnitsTimeVolume[therapieNum].search("~")
            testFile.write(";" + sliderUnitsTimeVolume[therapieNum].substring(i + 1).toString().replace(/\./g,','), "Append")

            if(sliderUnitsTimeVolume[therapieNum] === sliderUnitsATimeVolume[therapieNum]){
                i = conversionFactorATimeVolume[therapieNum].search("~")
                conv2 = conversionFactorATimeVolume[therapieNum].substring(0, i).toString().replace(/\./g,',')
                conv1 = conversionFactorATimeVolume[therapieNum].substring(i + 1).toString().replace(/\./g,',')
            }
            else if(sliderUnitsTimeVolume[therapieNum] === sliderUnitsBTimeVolume[therapieNum]){
                i = conversionFactorBTimeVolume[therapieNum].search("~")
                conv2 = conversionFactorBTimeVolume[therapieNum].substring(0, i).toString().replace(/\./g,',')
                conv1 = conversionFactorBTimeVolume[therapieNum].substring(i + 1).toString().replace(/\./g,',')
            }
            else{
                testFile.write("; units error" , "Append")
            }

            testFile.write(";" + conv1, "Append")
            testFile.write(";-" , "Append")
            i = sliderUnitsTimeVolume[therapieNum].search("~")
            testFile.write(";" + sliderUnitsTimeVolume[therapieNum].substring(0, i).toString().replace(/\./g,','), "Append")
            testFile.write(";" + conv2, "Append")

            // Volume Dose
            testFile.write(";" + sliderInitVolumeDose[therapieNum].toString().replace(/\./g,','), "Append")
            i = sliderUnitsVolumeDose[therapieNum].search("~")
            testFile.write(";" + sliderUnitsVolumeDose[therapieNum].substring(i + 1).toString().replace(/\./g,','), "Append")

            if(sliderUnitsVolumeDose[therapieNum] === sliderUnitsAVolumeDose[therapieNum]){
                i = conversionFactorAVolumeDose[therapieNum].search("~")
                conv2 = conversionFactorAVolumeDose[therapieNum].substring(0, i).toString().replace(/\./g,',')
                conv1 = conversionFactorAVolumeDose[therapieNum].substring(i + 1).toString().replace(/\./g,',')
            }
            else if(sliderUnitsVolumeDose[therapieNum] === sliderUnitsBVolumeDose[therapieNum]){
                i = conversionFactorBVolumeDose[therapieNum].search("~")
                conv2 = conversionFactorBVolumeDose[therapieNum].substring(0, i).toString().replace(/\./g,',')
                conv1 = conversionFactorBVolumeDose[therapieNum].substring(i + 1).toString().replace(/\./g,',')
            }
            else{
                testFile.write("; units error" , "Append")
            }

            testFile.write(";" + conv1, "Append")
            testFile.write(";-" , "Append")
            i = sliderUnitsVolumeDose[therapieNum].search("~")
            testFile.write(";" + sliderUnitsVolumeDose[therapieNum].substring(0, i).toString().replace(/\./g,','), "Append")
            testFile.write(";" + conv2, "Append")

            // Time Dose
            testFile.write(";" + sliderInitTimeDose[therapieNum].toString().replace(/\./g,','), "Append")
            i = sliderUnitsTimeDose[therapieNum].search("~")
            testFile.write(";" + sliderUnitsTimeDose[therapieNum].substring(i + 1).toString().replace(/\./g,','), "Append")

            if(sliderUnitsTimeDose[therapieNum] === sliderUnitsATimeDose[therapieNum]){
                i = conversionFactorATimeDose[therapieNum].search("~")
                conv2 = conversionFactorATimeDose[therapieNum].substring(0, i).toString().replace(/\./g,',')
                conv1 = conversionFactorATimeDose[therapieNum].substring(i + 1).toString().replace(/\./g,',')
            }
            else if(sliderUnitsTimeDose[therapieNum] === sliderUnitsBTimeDose[therapieNum]){
                i = conversionFactorBTimeDose[therapieNum].search("~")
                conv2 = conversionFactorBTimeDose[therapieNum].substring(0, i).toString().replace(/\./g,',')
                conv1 = conversionFactorBTimeDose[therapieNum].substring(i + 1).toString().replace(/\./g,',')
            }
            else{
                testFile.write("; units error" , "Append")
            }

            testFile.write(";" + conv1, "Append")
            testFile.write(";-" , "Append")
            i = sliderUnitsTimeDose[therapieNum].search("~")
            testFile.write(";" + sliderUnitsTimeDose[therapieNum].substring(0, i).toString().replace(/\./g,','), "Append")
            testFile.write(";" + conv2, "Append")

            // separator
            testFile.write("; ", "Append")

            // Cumulated O3 parameter 1
            testFile.write("; ", "Append")
            testFile.write(";" + cumulatedBoard.cumulatedO3.unitsLabel.text.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedO3.conversionFactor.toString().replace(/\./g,','), "Append")

            // Cumulated Volume parameter 2
            testFile.write("; ", "Append")
            testFile.write(";" + cumulatedBoard.cumulatedVolume.unitsLabel.text.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedVolume.conversionFactor.toString().replace(/\./g,','), "Append")

            // Cumulated Time Seconds parameter 3
            testFile.write("; ", "Append")
            testFile.write(";" + cumulatedBoard.cumulatedTimeSeconds.unitsLabel.text.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedTimeSeconds.conversionFactor.toString().replace(/\./g,','), "Append")

            // Cumulated Time parameter 4
            testFile.write("; ", "Append")
            testFile.write(";" + cumulatedBoard.cumulatedTime.unitsLabel.text.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedTime.conversionFactor.toString().replace(/\./g,','), "Append")

//            // Weight to volume conversion
//            Therapies.launchBloodVolume()
//            testFile.write("; ", "Append")
//            testFile.write(";" + bloodVolume.unitsLabel.text.toString().replace(/\./g,','), "Append")
//            testFile.write(";" + bloodVolume.weightConversionFactor.toString().replace(/\./g,','), "Append")
//            testFile.write(";" + bloodVolume.weightToBloodVolumeConversionFactor.toString().replace(/\./g,','), "Append")
//            testFile.write("\r\n", "Append")
//            debug.log(DC.testConsoleLog, "create reference, bloodVolume.unitsLabel.text: ", bloodVolume.unitsLabel.text)
//            debug.log(DC.testConsoleLog, "create reference, bloodVolume.weightConversionFactor: ", bloodVolume.weightConversionFactor)
//            debug.log(DC.testConsoleLog, "create reference, bloodVolume.weightToBloodVolumeConversionFactor: ",bloodVolume.weightToBloodVolumeConversionFactor)


            // Weight to volume conversion
            Therapies.launchBloodVolume()
            testFile.write("; ", "Append")
            testFile.write(";" + Storage.getAppDB(Constants.parameterId + "_" + Constants.parameterPersonWeightId + "_" + Constants.parameterUnitsId, "*"), "Append")
            testFile.write(";" + Storage.getAppDB(Constants.parameterId + "_" + Constants.parameterPersonWeightId + "_" + Constants.parameterConversionFactorAId, "1").toString().replace(/\./g,','), "Append")
            testFile.write(";" + bloodVolume.weightToBloodVolumeConversionFactor.toString().replace(/\./g,','), "Append")
            testFile.write("\r\n", "Append")
        }
    }
}

function test(){
    var therapyOption
    var therapieNum

    for (therapieNum = 0; therapieNum < 14; therapieNum++){

        if((therapieNum !== 4) && (therapieNum !== 5) && (therapieNum !== 6) && (therapieNum !== 9)){
            therapyOption = optionId[therapieNum]

            //    Configurator.configureTherapy(Constants.option2Id)
            Configurator.configureTherapy(therapyOption)
            Configurator.initTherapy()
            testFile.write("Magnitude values ", "Append")
            testFile.write(therapieNum, "Append")
            testFile.write(";" + magnitudeSelector.inputBottleVolume.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputBottleVolume.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputBottleVolume.conversionFactor, "Append")

            testFile.write(";" + magnitudeSelector.inputBloodVolume.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputBloodVolume.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputBloodVolume.conversionFactor, "Append")

            testFile.write(";" + magnitudeSelector.inputO3.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputO3.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputO3.conversionFactor, "Append")

            testFile.write(";" + magnitudeSelector.inputFlow.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputFlow.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputFlow.conversionFactor, "Append")

            testFile.write(";" + magnitudeSelector.inputTime.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTime.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTime.conversionFactor, "Append")

            testFile.write(";" + magnitudeSelector.inputTotalConcentration.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTotalConcentration.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTotalConcentration.conversionFactor, "Append")

            testFile.write(";" + magnitudeSelector.inputTherapyTime.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTherapyTime.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTherapyTime.conversionFactor, "Append")

            testFile.write(";" + magnitudeSelector.inputVacuumTime.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputVacuumTime.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputVacuumTime.conversionFactor, "Append")

            testFile.write(";" + magnitudeSelector.inputTimeVolume.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeVolume.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeVolume.conversionFactor, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeVolume.magnitudeLabel2.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeVolume.unitsLabel2.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeVolume.conversionFactorB, "Append")

            testFile.write(";" + magnitudeSelector.inputVolumeDose.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputVolumeDose.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputVolumeDose.conversionFactor, "Append")
            testFile.write(";" + magnitudeSelector.inputVolumeDose.magnitudeLabel2.text, "Append")
            testFile.write(";" + magnitudeSelector.inputVolumeDose.unitsLabel2.text, "Append")
            testFile.write(";" + magnitudeSelector.inputVolumeDose.conversionFactorB, "Append")

            testFile.write(";" + magnitudeSelector.inputTimeDose.magnitudeLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeDose.unitsLabel.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeDose.conversionFactor, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeDose.magnitudeLabel2.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeDose.unitsLabel2.text, "Append")
            testFile.write(";" + magnitudeSelector.inputTimeDose.conversionFactorB, "Append")

            tabBar.selectedOption = therapyOption
            Therapies.play()

            // Cumulated O3
            testFile.write(";" + cumulatedBoard.cumulatedO3.progressTool.maximumValue.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedO3.unitsLabel.text.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedO3.conversionFactor.toString().replace(/\./g,','), "Append")

            // Cumulated Volume
            testFile.write(";" + cumulatedBoard.cumulatedVolume.progressTool.maximumValue.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedVolume.unitsLabel.text.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedVolume.conversionFactor.toString().replace(/\./g,','), "Append")

            // Cumulated Time Seconds
            testFile.write(";" + cumulatedBoard.cumulatedTimeSeconds.progressTool.maximumValue.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedTimeSeconds.unitsLabel.text.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedTimeSeconds.conversionFactor.toString().replace(/\./g,','), "Append")

            // Cumulated Time
            testFile.write(";" + cumulatedBoard.cumulatedTime.progressTool.maximumValue.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedTime.unitsLabel.text.toString().replace(/\./g,','), "Append")
            testFile.write(";" + cumulatedBoard.cumulatedTime.conversionFactor.toString().replace(/\./g,','), "Append")

            // Weight to volume conversion
            Therapies.launchBloodVolume()
//          testFile.write(";" + bloodVolume.magnitudeLabel.text.replace(/\./g,','), "Append")
            testFile.write(";" + bloodVolume.magnitudeLabel.text.replace(/\./g,''), "Append")
            testFile.write(";" + bloodVolume.unitsLabel.text.toString().replace(/\./g,','), "Append")
            testFile.write(";" + bloodVolume.weightConversionFactor.toString().replace(/\./g,','), "Append")
            testFile.write(";" + bloodVolume.weightToBloodVolumeConversionFactor.toString().replace(/\./g,','), "Append")
            testFile.write("\r\n", "Append")

            debug.log(DC.testConsoleLog, "test, bloodVolume.magnitudeLabel.text: ", bloodVolume.magnitudeLabel.text)
            debug.log(DC.testConsoleLog, "test, bloodVolume.unitsLabel.text: ", bloodVolume.unitsLabel.text)
            debug.log(DC.testConsoleLog, "test, bloodVolume.weightConversionFactor: ", bloodVolume.weightConversionFactor)
            debug.log(DC.testConsoleLog, "test, bloodVolume.weightToBloodVolumeConversionFactor: ", bloodVolume.weightToBloodVolumeConversionFactor)

        }
    }
}

function execueteTest(){
    var testNumber = 0

    testFile.write("", "Truncate")
    for(testNumber = 0; testNumber < numberOfTests; testNumber++){
//  for(testNumber = (numberOfTests - 1); testNumber < numberOfTests; testNumber++){  // test just last test
        debug.log(DC.testConsoleLog, "Test " + testNumber)
        debug.log(DC.testConsoleLog, "Generating test reference.....")
        setUpTest(testNumber)
        testFile.write("Test " + testNumber + "\r\n\r\n", "Append")
        testFile.write("Reference\r\n", "Append")
        createReference()
        testFile.write("\r\n", "Append")
        testFile.write("Test results\r\n", "Append")
        debug.log(DC.testConsoleLog, "Generating test results.....")
        test()
        testFile.write("\r\n\r\n", "Append")
    }

    if(testReferenceFile.read() === testFile.read()){
        debug.log(DC.testConsoleLog, "Test OK!")
    }else{
        debug.log(DC.testConsoleLog, "Test fail...")
    }
}

