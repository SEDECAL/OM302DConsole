// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.

Qt.include("DebugConstants.js")

var db
var memoryDB = LocalStorage.openDatabaseSync("MemoryDatabase", "0.1", "MemoryDatabase", 20000)
var settingsDB = LocalStorage.openDatabaseSync("SettingsDatabase", "0.1", "SettingsDatabase", 20000)
var languageDB = LocalStorage.openDatabaseSync("LanguageDatabase", "0.1", "LanguageDatabase", 20000)

function setMemDB(setting, value) {
    db = memoryDB
    return set(setting, value)
}
function getMemDB(setting, default_value) {
    db = memoryDB
    return get(setting, default_value)
}
function setAppDB(setting, value) {
    db = settingsDB
    return set(setting, value)
}
function getAppDB(setting, default_value) {
    db = settingsDB
    return get(setting, default_value)
}
function setLanguageDB(setting, value) {
    db = languageDB
    return set(setting, value)
}
function getLanguageDB(setting, default_value) {
    db = languageDB
    return get(setting, default_value)
}

// When a power off is done after setXxxDB action last data written is lost.
// This dummy write action acts as a save function.
function saveMemDB() {
    db = memoryDB
    return set("dummy_data", "-")
}
function saveAppDB() {
    db = settingsDB
    return set("dummy_data", "-")
}
function saveLanguageDB() {
    db = languageDB
    return set("dummy_data", "-")
}

function set(setting, value) {
    var res = ""

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)')
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value])
        if (rs.rowsAffected > 0) {
            res = "OK"
        } else {
            res = "Error"
            //DEB->debug.log(storageLog, "Set DB fail: " + setting)
        }
    }
    )
    return res
}

function get(setting, default_value) {
    var res = ""

    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting])
            if (rs.rows.length > 0) {
                res = rs.rows.item(0).value
            } else {
                res = default_value;
                //DEB->debug.log(storageLog, "Get DB fail: " + setting)
            }
        })
    } catch (err) {
        res = default_value
        //DEB->debug.log(storageLog, "Get DB fail (catch): " + err + " " + setting)
    }
    return res
}

