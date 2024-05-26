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
			bool is_admin = mCurrentEmployee->staffType() == Staff::Admin &&
				(employee->staffType() == Staff::HR || employee->staffType() == Staff::Manager || employee->staffType() == Staff::Employee);;

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

	QVariantList StaffDriver::searchStaff(QVariantMap filters)
	{
		QVariantList staffList;

		auto employees = mStaffList->employees();

		for (auto employee : employees)
		{
			bool is_admin = mCurrentEmployee->staffType() == Staff::Admin &&
				(employee->staffType() == Staff::HR || employee->staffType() == Staff::Manager || employee->staffType() == Staff::Employee);;

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

				auto userNameFilter = filters["Username"].toString();
				auto firstNameFilter = filters["FirstName"].toString();
				auto lastNameFilter = filters["LastName"].toString();
				auto genderFilter = filters["Gender"].toInt();
				auto ageFilter = filters["Age"].toUInt();
				auto academicDegreeFilter = filters["AcademicDegree"].toString();
				auto managerFilter = filters["Manager"].toString();
				auto roleFilter = filters["Role"].toInt();

				if ((userNameFilter == "" || userNameFilter == employee->username()) && (firstNameFilter == "" || firstNameFilter == employee->firstName()) &&
					(lastNameFilter == "" || lastNameFilter == employee->lastName()) && (genderFilter == 0 || Staff::Gender(genderFilter - 1) == employee->gender()) &&
					(ageFilter == 0 || ageFilter == employee->age()) && (academicDegreeFilter == "" || academicDegreeFilter == employee->academicDegree()) &&
					(managerFilter == "" || managerFilter == employee->manager()) && (roleFilter == 0 || Staff::StaffType(roleFilter) == employee->staffType()))
					{
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
		}
		return staffList;
	}

	QVariantList StaffDriver::sortStaff(QVariantList staffRows, QString columnSort)
	{
		std::sort(staffRows.begin(), staffRows.end(), [columnSort](QVariant a, QVariant b) -> bool {
		auto a_map = a.toMap();
		auto a_itr = a_map.cbegin();

		auto b_map = b.toMap();
		auto b_itr = b_map.cbegin();

		for(; a_itr != a_map.cend(); ++a_itr, ++b_itr)
		{
			auto columnName = a_itr.key();
			if (columnSort == "Id" && columnName == columnSort)
				return a_itr.value().toUInt() < b_itr.value().toUInt();
			else if (columnSort == "Username" && columnName == columnSort)
				return a_itr.value().toString() < b_itr.value().toString();
			else if (columnSort == "First Name" && columnName == columnSort)
				return a_itr.value().toString() < b_itr.value().toString();
			else if (columnSort == "Last Name" && columnName == columnSort)
				return a_itr.value().toString() < b_itr.value().toString();
			else if (columnSort == "Gender" && columnName == columnSort)
				return a_itr.value().toString() < b_itr.value().toString();
			else if (columnSort == "Age" && columnName == columnSort)
				return a_itr.value().toUInt() < b_itr.value().toUInt();
			else if (columnSort == "Academic Degree" && columnName == columnSort)
				return a_itr.value().toString() < b_itr.value().toString();
			else if (columnSort == "Manager" && columnName == columnSort)
				return a_itr.value().toString() < b_itr.value().toString();
			else if (columnSort == "Role" && columnName == columnSort)
				return a_itr.value().toString() < b_itr.value().toString();
		}
			return false;
		});

		return staffRows;
	}


	QVariantMap StaffDriver::getRow(size_t employee_id)
	{
		QVariantList staffList;

		auto employee = mStaffList->getStaff(employee_id);

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

		auto row = QVariantMap {
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
		};

		return row;
	}

	void StaffDriver::insertStaffToDB(size_t employee_id)
	{
		auto employee = mStaffList->getStaff(employee_id);

		auto staffType = employee->staffType();
		std::string role;
				if (staffType == Staff::Admin)
					role = "Admin";
				else if (staffType == Staff::HR)
					role = "HR";
				else if (staffType == Staff::Manager)
					role = "Manager";
				else
					role = "Employee";

		std::string query = "INSERT INTO Staff (Id, Username, Password, FirstName, LastName, Email, Gender, Age, Photo, AcademicDegree, Manager, Role) VALUES (";
		query.append(std::to_string(employee_id));
		query.append(", '");
		query.append(employee->username().toStdString());
		query.append("', '");
		query.append(employee->password().toStdString());
		query.append("', '");
		query.append(employee->firstName().toStdString());
		query.append("', '");
		query.append(employee->lastName().toStdString());
		query.append("', '");
		query.append(employee->email().toStdString());
		query.append("', '");
		query.append(employee->gender() == Staff::Male ? "Male" : "Female");
		query.append("', ");
		query.append(std::to_string(employee->age()));
		query.append(", '");
		query.append(employee->photo().toLocalFile().toStdString());
		query.append("', '");
		query.append(employee->academicDegree().toStdString());
		query.append("', '");
		query.append(employee->manager().toStdString());
		query.append("', '");
		query.append(role);
		query.append("')");

		char *err = nullptr;
		auto rc2 = sqlite3_exec(mHandle, query.c_str(), NULL, NULL, &err);
	}

	void StaffDriver::updateStaffToDB(size_t employee_id)
	{
		auto employee = mStaffList->getStaff(employee_id);

		auto staffType = employee->staffType();
		std::string role;
				if (staffType == Staff::Admin)
					role = "Admin";
				else if (staffType == Staff::HR)
					role = "HR";
				else if (staffType == Staff::Manager)
					role = "Manager";
				else
					role = "Employee";

		std::string query = "UPDATE Staff SET Username='";
		query.append(employee->username().toStdString());
		query.append("', Password='");
		query.append(employee->password().toStdString());
		query.append("', FirstName='");
		query.append(employee->firstName().toStdString());
		query.append("', LastName='");
		query.append(employee->lastName().toStdString());
		query.append("', Email='");
		query.append(employee->email().toStdString());
		query.append("', Gender='");
		query.append(employee->gender() == Staff::Male ? "Male" : "Female");
		query.append("', Age=");
		query.append(std::to_string(employee->age()));
		query.append(", Photo='");
		query.append(employee->photo().toLocalFile().toStdString());
		query.append("', AcademicDegree='");
		query.append(employee->academicDegree().toStdString());
		query.append("', Manager='");
		query.append(employee->manager().toStdString());
		query.append("', Role='");
		query.append(role);
		query.append("' WHERE Id=");
		query.append(std::to_string(employee_id));

		char *err = nullptr;
		auto rc2 = sqlite3_exec(mHandle, query.c_str(), NULL, NULL, &err);
	}

	void StaffDriver::removeStaffFromDB(size_t employee_id)
	{
		auto employee = mStaffList->getStaff(employee_id);

		std::string query = "DELETE FROM Staff WHERE ID=";
		query.append(std::to_string(employee_id));

		char *err = nullptr;
		auto rc2 = sqlite3_exec(mHandle, query.c_str(), NULL, NULL, &err);
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
