#pragma once

#include "StaffSystem/StaffList.h"

#include <QQmlEngine>

#include <sqlite3.h>

constexpr auto DATABASE_FILE_NAME = "../../../database.db";

namespace client::system
{
	class StaffDriver : public QObject
	{
		Q_OBJECT
		QML_ELEMENT
		QML_SINGLETON

		Q_PROPERTY(client::system::StaffList* staffList MEMBER mStaffList CONSTANT)

	public:
		StaffDriver(QObject* parent = nullptr);
		~StaffDriver() override;

		// returns a pointer to the singleton instance of this StaffDriver
		static StaffDriver* singleton();

		void setDBHandle(sqlite3* handle) { mHandle = handle; }

		void setStaffList(StaffList* staffList) { mStaffList = staffList; }

		void init();

		StaffList* staffList() const { return mStaffList; }

	private:
		StaffList* mStaffList;

		// per app sqlite handle to open a sqlite connection to the database.
		sqlite3* mHandle;
	};
} // namespace client::system
