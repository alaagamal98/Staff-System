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

		Q_PROPERTY(StaffList* staffList MEMBER mStaffList CONSTANT)
		Q_PROPERTY(Staff* currentEmployee READ currentEmployee WRITE setCurrentEmployee NOTIFY currentEmployeeChanged)

	public:
		StaffDriver(QObject* parent = nullptr);
		~StaffDriver() override;

		// returns a pointer to the singleton instance of this StaffDriver
		static StaffDriver* singleton();

		void init();

		void setDBHandle(sqlite3* handle) { mHandle = handle; }

		void setCurrentEmployee(Staff* employee);

		Staff* currentEmployee() const { return mCurrentEmployee; }

		void setStaffList(StaffList* staffList) { mStaffList = staffList; }

		StaffList* staffList() const { return mStaffList; }

	signals:
	void currentEmployeeChanged(Staff* employee);

	private:
		Staff* mCurrentEmployee;
		StaffList* mStaffList;

		// per app sqlite handle to open a sqlite connection to the database.
		sqlite3* mHandle;
	};
} // namespace client::system
