// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.
// This file is part of OM302DConsole.
// OM302DConsole is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>

class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)

public:
    explicit BackEnd(QObject *parent = nullptr);

    QString userName();
    void setUserName(const QString &userName);

signals:
    void userNameChanged();

private:
    QString m_userName;
};


#endif // BACKEND_H
