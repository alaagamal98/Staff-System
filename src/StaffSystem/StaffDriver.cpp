#include "StaffSystem/StaffDriver.h"
#include "StaffSystem/Parser.h"

namespace client::system
{
	StaffDriver::StaffDriver(QObject* parent) : QObject(parent)
	{
		mStaffList = StaffList::singleton();
	}

	StaffDriver::~StaffDriver()
	{
		sqlite3_close_v2(mHandle);
	}

	StaffDriver* StaffDriver::singleton()
	{
		static StaffDriver instance;
		return &instance;
	}

	void StaffDriver::init()
	{
		sqlite3 *db = nullptr;
		auto rc1 = sqlite3_open_v2(DATABASE_FILE_NAME, &db, SQLITE_OPEN_READWRITE, NULL);
		setDBHandle(db);

		std::string query = "SELECT * FROM Staff";

		char *err = nullptr;
		auto rc2 = sqlite3_exec(db, query.c_str(), parseEmployee, mStaffList, &err);
	}
} // namespace client::system
