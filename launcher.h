// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.
// This file is part of OM302DConsole.
// OM302DConsole is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

#ifndef LAUNCHER_H
#define LAUNCHER_H

#include <QDebug>
#include <QObject>
#include <QProcess>

class Launcher : public QObject
{
	Q_OBJECT
public:
	explicit Launcher(QObject *parent = 0);
	Q_INVOKABLE QString launch(const QString &program);
	Q_INVOKABLE void stop(void);
	Q_INVOKABLE void write(const QByteArray &data);

signals:
	void processEnd(void);

public slots:
	void processFinished(void);

private:
	QProcess *m_process;
};

#endif // LAUNCHER_H
