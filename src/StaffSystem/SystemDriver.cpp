#include "StaffSystem/SystemDriver.h"
#include "StaffSystem/LoginDriver.h"
#include "StaffSystem/StaffDriver.h"

#include <QCursor>
#include <QDesktopServices>
#include <QFileInfo>
#include <QGuiApplication>
#include <QtCore>

inline static int
_parse_employee(void *data, int col_count, char **col_content, char **col_name)
{
	auto staff_list = (client::system::StaffList *)data;
	auto employee = new client::system::Staff{};

	for (int j = 0; j < col_count; ++j)
	{
		if (col_content[j] == nullptr)
			continue;

		auto column = std::string(col_name[j]);

		if (column == "ID")
		{
			char* end_ptr = (char*)col_content[j];
			employee->id = (size_t)std::strtol(col_content[j], &end_ptr, 10);
		}
		else if (column == "Username")
		{
			employee->username = QString::fromStdString(col_content[j]);
		}
		else if (column == "Password")
		{
			employee->password = QString::fromStdString(col_content[j]);
		}
		else if (column == "FirstName")
		{
			employee->firstName = QString::fromStdString(col_content[j]);
		}
		else if (column == "LastName")
		{
			employee->lastName = QString::fromStdString(col_content[j]);
		}
		else if (column == "Email")
		{
			employee->email = QString::fromStdString(col_content[j]);
		}
		else if (column == "Gender")
		{
			auto gender = std::string(col_content[j]);
			if (gender == "Male")
				employee->gender = client::system::Staff::Male;
			else
				employee->gender = client::system::Staff::Female;
		}
		else if (column == "Age")
		{
			char* end_ptr = (char*)col_content[j];
			employee->age = (size_t)std::strtol(col_content[j], &end_ptr, 10);
		}
		else if (column == "Photo")
		{
			auto photo = std::string(col_content[j]);
			employee->photo = QByteArray(photo.c_str(), photo.length());
		}
		else if (column == "AcademicDegree")
		{
			employee->academicDegree = QString::fromStdString(col_content[j]);
		}
		else if (column == "Manager")
		{
			employee->manager = QString::fromStdString(col_content[j]);
		}
		else if (column == "Role")
		{
			auto role = std::string(col_content[j]);
			if (role == "Admin")
				employee->staffType = client::system::Staff::Admin;
			else if (role == "HR")
				employee->staffType = client::system::Staff::HR;
			else if (role == "Manager")
				employee->staffType = client::system::Staff::Manager;
			else
				employee->staffType = client::system::Staff::Employee;
		}
	}
	staff_list->addOrUpdateStaff(employee);

	return 0;
}

namespace client::system
{
	SystemDriver::SystemDriver(QObject* parent) : QObject(parent)
	{
		// Connect LoginDriver signals to SystemDriver slots
		auto loginDriver = LoginDriver::singleton();
		connect(loginDriver, &LoginDriver::loginRequested, this, &SystemDriver::onLoginRequested);
		connect(loginDriver, &LoginDriver::logoutRequested, this, &SystemDriver::onLogoutRequested);
	}

	void SystemDriver::onLoginRequested(const QString& username, const QString& password)
	{
		auto loginDriver = LoginDriver::singleton();
		auto staffDriver = StaffDriver::singleton();

		auto utf8Username = username.toUtf8();
		auto utf8Password = password.toUtf8();

		auto employee = staffDriver->staffList()->authenticateStaff(utf8Username, utf8Password);
		if (employee == nullptr)
			loginDriver->loginFailed("Username or Password Incorrect");
		else
			loginDriver->loginSucceeded(username, employee->photo);
	}

	void SystemDriver::onLogoutRequested()
	{
		auto loginDriver = LoginDriver::singleton();
		loginDriver->logoutSucceeded();
	}
} // namespace client::system
