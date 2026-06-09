// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2023 Sedecal S.A.
// This file is part of OM302DConsole.
// OM302DConsole is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

#include "launcher.h"

Launcher::Launcher(QObject *parent) :
	QObject(parent),
	m_process(new QProcess(this))
{
}

QString Launcher::launch(const QString &program)
{

	connect(m_process, SIGNAL(finished(int,QProcess::ExitStatus)), this, SLOT(processFinished()));

	m_process->start(program);	
//	m_process->waitForFinished(-1);
//	QByteArray bytes = m_process->readAllStandardOutput();
//	QString output = QString::fromLocal8Bit(bytes);
//	return output;
	 qDebug() << "process launched now!!";

	return 0;
}
void Launcher::stop(void)
{
	m_process->close();
//	m_process->kill();
//	m_process->terminate();
//	m_process->skip(4);
}
void Launcher::write(const QByteArray &data)
{
	m_process->write(data);
}

void Launcher::processFinished(void){
	qDebug() << "process finished detection!";
	emit processEnd();
}
