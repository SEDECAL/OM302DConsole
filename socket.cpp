// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.
// This file is part of OM302DConsole.
// OM302DConsole is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

#include "socket.h"

Socket::Socket(QObject *parent) : QObject(parent)
{
}

void Socket::Manage()
{
    socket = new QTcpSocket(this);
    connect(socket, SIGNAL(connected()), this, SLOT(connected()));
    connect(socket, SIGNAL(disconnected()), this, SLOT(disconnected()));
    connect(socket, SIGNAL(readyRead()), this, SLOT(readyRead()));
    connect(socket, SIGNAL(bytesWritten(qint64)), this, SLOT(bytesWritten(qint64)));

//  qDebug() << "Connecting socket...";
//  socket->connectToHost("localhost", 15557);
//  socket->connectToHost("bogotobogo.com", 80);

//  if(!socket->waitForDisconnected(1000))
//  {
//      qDebug() << "Error: " << socket->errorString();
//  }
}

void Socket::connected()
{
	qDebug() << "Socket connected!!";
    emit onConnected();
    socket->write("{GETDAT\r");
}

void Socket::disconnected()
{
//  qDebug() << "Socket unconnected!!";
    emit onDisconnected();
}

void Socket::bytesWritten(qint64 bytes)
{
//  qDebug() << "Socket written:-" << bytes << "btyes";
    emit onWritten(bytes);
}

void Socket::sendData(QString data)
{
//  qDebug() << "Socket write:-" + data;

	emit onWrite(data);
	socket->write(data.toLatin1());
}

void Socket::readyRead()
{
//  qDebug() << "Socket Read:-";
//	emit onRead(socket->readAll());

	dataReceived = socket->readAll();
	emit onRead(dataReceived);

}

void Socket::startConnection()
{
    qDebug() << "Connecting socket...";
    // Port used by the OM302D hardware control daemon (see protocol documentation in Documents/)
	socket->connectToHost("localhost", 15557);
}
