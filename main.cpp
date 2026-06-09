// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.
// This file is part of OM302DConsole.
// OM302DConsole is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.


#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>
#include "backend.h"
#include "socket.h"

#include "process.h"

#include "fileio.h"

int main(int argc, char *argv[])
{
	qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

	qmlRegisterType<Process>("Process", 1, 0, "Process");
	qmlRegisterType<BackEnd>("socket", 1, 0, "Socket");
	qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");

    Socket consoleSocket;
    consoleSocket.Manage();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("consoleSocket", &consoleSocket);

	auto offlineStoragePath = QUrl::fromLocalFile(engine.offlineStoragePath());
	engine.rootContext()->setContextProperty("offlineStoragePath", offlineStoragePath);

	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

