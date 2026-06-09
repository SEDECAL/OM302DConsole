// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.
// This file is part of OM302DConsole.
// OM302DConsole is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

#include "fileio.h"
#include <QFile>
#include <QTextStream>

FileIO::FileIO(QObject *parent) :
	QObject(parent)
{

}

QString FileIO::read()
{
	if (mSource.isEmpty()){
		emit error("source is empty");
		return QString();
	}

	QFile file(mSource);
	QString fileContent;
	if ( file.open(QIODevice::ReadOnly) ) {
		QString line;
		QTextStream t( &file );
		do {
			line = t.readLine();
			fileContent += line;
		 } while (!line.isNull());

		file.close();
	} else {
		emit error("Unable to open the file");
		return QString();
	}
	return fileContent;
}

bool FileIO::write(const QString& data, QString mode)
{
	if (mSource.isEmpty())
		return false;

	QFile file(mSource);
//	if (!file.open(QFile::WriteOnly | QFile::Truncate))
//	if (!file.open(QFile::WriteOnly | QFile::Append))
	if (mode == "Truncate")
	{
		if (!file.open(QFile::WriteOnly | QFile::Truncate))
			return false;
	}
	else
	{
		if (!file.open(QFile::WriteOnly | QFile::Append))
			return false;
	}

	QTextStream out(&file);
	out << data;

	file.close();

	return true;
}
