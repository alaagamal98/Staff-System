#include "StaffSystem/LoginDriver.h"

#include <QQmlEngine>

namespace client::system
{
	LoginDriver::LoginDriver(QObject* parent)
		:QObject(parent)
	{}

	LoginDriver* LoginDriver::singleton()
	{
		static LoginDriver instance;
		return &instance;
	}

	LoginDriver* LoginDriver::create(QQmlEngine *qmlEngine, QJSEngine *jsEngine)
	{
		Q_UNUSED(qmlEngine)
		Q_UNUSED(jsEngine)
		auto res = singleton();
		QQmlEngine::setObjectOwnership(res, QQmlEngine::CppOwnership);
		return res;
	}

	void LoginDriver::login(QString email, QString password)
	{
		emit loginRequested(email, password);
	}

	void LoginDriver::logout()
	{
		emit logoutRequested();
	}

	void LoginDriver::loginFailed(QString reason)
	{
		setState(StateLoggedOut);
		setError(reason);
	}

	void LoginDriver::loginSucceeded()
	{
		setState(StateLoggedIn);
	}

	void LoginDriver::logoutFailed(QString reason)
	{
		setError(reason);
	}

	void LoginDriver::logoutSucceeded()
	{
		setState(StateLoggedOut);
	}

	void LoginDriver::setState(State nextState)
	{
		if (mState == nextState)
			return;
		mState = nextState;
		emit stateChanged(mState);
	}
}
