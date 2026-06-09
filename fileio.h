// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.
// This file is part of OM302DConsole.
// OM302DConsole is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>

class FileIO : public QObject
{
	Q_OBJECT

public:
	Q_PROPERTY(QString source
			   READ source
			   WRITE setSource
			   NOTIFY sourceChanged)
	explicit FileIO(QObject *parent = 0);

	Q_INVOKABLE QString read();
//	Q_INVOKABLE bool write(const QString& data);
	Q_INVOKABLE bool write(const QString& data, QString mode);

	QString source() { return mSource; }

public slots:
	void setSource(const QString& source) { mSource = source; }

signals:
	void sourceChanged(const QString& source);
	void error(const QString& msg);

private:
	QString mSource;
};

#endif // FILEIO_H
