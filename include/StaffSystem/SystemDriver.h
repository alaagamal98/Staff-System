#pragma once

#include <QQmlEngine>
#include <QQuickWindow>

namespace client::system
{
	class SystemDriver : public QObject
	{
		Q_OBJECT
		QML_ELEMENT
		QML_SINGLETON

	public:
		SystemDriver(QObject* parent = nullptr);

		void setAppRef(QApplication* app) { mApp = app; }

	public slots:
		// used to handle the LoginDriver::loginRequested signal by
		// sending a login request to the server
		void onLoginRequested(const QString& username, const QString& password);

		// used to handle the LoginDriver::logoutRequested signal by
		// sending a logout request to the server
		void onLogoutRequested();

	signals:
		// emitted on successful login
		void loggedIn();

	private:
		QApplication* mApp;
	};
} // namespace client::system
