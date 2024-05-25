#include "StaffSystem/StaffDriver.h"
#include "StaffSystem/Parser.h"

namespace client::system
{
	StaffDriver::StaffDriver(QObject* parent) : QObject(parent)
	{
		mStaffList = StaffList::singleton();
		mCurrentEmployee = Staff::singleton();
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

	QVariantList StaffDriver::reportStaffList()
	{
		QVariantList staffList;

		auto employees = mStaffList->employees();

		std::sort(employees.begin(), employees.end(), [](Staff* a, Staff* b) -> bool {
			return a->id() < b->id();
		});

		for (auto employee : employees)
		{
			bool is_admin = mCurrentEmployee->staffType() == Staff::Admin;

			bool is_hr = mCurrentEmployee->staffType() == Staff::HR &&
				(employee->staffType() == Staff::Manager || employee->staffType() == Staff::Employee);

			bool is_manager = mCurrentEmployee->staffType() == Staff::Manager && employee->staffType() == Staff::Employee &&
				employee->manager() == mCurrentEmployee->username();

			if (is_admin || is_hr || is_manager)
			{
				auto gender = employee->gender() == Staff::Male ? "Male" : "Female";
				std::string role;
				if (employee->staffType() == Staff::Admin)
					role = "Admin";
				else if (employee->staffType() == Staff::HR)
					role = "HR";
				else if (employee->staffType() == Staff::Manager)
					role = "Manager";
				else
					role = "Employee";

				staffList.push_back(QVariantMap {
					{"Id", employee->id()},
					{"Username", employee->username()},
					{"First Name", employee->firstName()},
					{"Last Name", employee->lastName()},
					{"Gender", gender},
					{"Age", employee->age()},
					{"Academic Degree", employee->academicDegree()},
					{"Manager", employee->manager()},
					{"Role", role.c_str()},
					{"More Info", ""},
				});
			}
		}
		return staffList;
	}

	void StaffDriver::setCurrentEmployee(Staff* employee)
	{
		mCurrentEmployee->setId(employee->id());
		mCurrentEmployee->setUsername(employee->username());
		mCurrentEmployee->setPassword(employee->password());
		mCurrentEmployee->setFirstName(employee->firstName());
		mCurrentEmployee->setLastName(employee->lastName());
		mCurrentEmployee->setEmail(employee->email());
		mCurrentEmployee->setGender(employee->gender());
		mCurrentEmployee->setAge(employee->age());
		mCurrentEmployee->setPhoto(employee->photo());
		mCurrentEmployee->setAcademicDegree(employee->academicDegree());
		mCurrentEmployee->setManager(employee->manager());
		mCurrentEmployee->setStaffType(employee->staffType());
		currentEmployeeChanged(mCurrentEmployee);
	}
} // namespace client::system
