// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.
// This file is part of OM302DConsole.
// OM302DConsole is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

#ifndef SOCKET_H
#define SOCKET_H

#include <QObject>
#include <QDebug>
#include <QTcpSocket>
#include <QAbstractSocket>
#include <QString>

class Socket : public QObject
{
    Q_OBJECT

public:
    explicit Socket(QObject *parent = 0);
    void Manage();

signals:
    void onConnected();
    void onDisconnected();
    void onRead(QString data);
    void onWrite(QString data);
    void onWritten(qint64 bytes);

public slots:
    void connected();
    void disconnected();
    void bytesWritten(qint64 bytes);
    void readyRead();
    void sendData(QString data);

    void startConnection();

private:
    QTcpSocket *socket;

    QString dataReceived;

};

#if 0

class SocketTest : public QObject
{
    Q_OBJECT

public:
    explicit SocketTest(QObject *parent = 0);
    void Test();

signals:

public slots:

    void connected();
    void disconnected();
    void bytesWritten(qint64 bytes);
    void readyRead();

private:
    QTcpSocket *socket;

};

#endif
#endif // SOCKET_H
