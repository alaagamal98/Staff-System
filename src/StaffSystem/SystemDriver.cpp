#include "StaffSystem/SystemDriver.h"
#include "StaffSystem/LoginDriver.h"
#include "StaffSystem/StaffDriver.h"

#include <QCursor>
#include <QDesktopServices>
#include <QFileInfo>
#include <QGuiApplication>
#include <QtCore>

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
