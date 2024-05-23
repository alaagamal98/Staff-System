#pragma once

#include <QObject>
#include <qqml.h>

namespace client::system
{
	// a login driver is the C++ part/driver of the qml login form
	// it manages the state and relays info to other drivers via its signals and slots
	class LoginDriver: public QObject
	{
		Q_OBJECT
		Q_PROPERTY(QString error READ error WRITE setError NOTIFY errorChanged)
		Q_PROPERTY(State state READ state NOTIFY stateChanged)
		Q_PROPERTY(QString username READ username NOTIFY usernameChanged)
		Q_PROPERTY(QByteArray avatar READ avatar NOTIFY avatarChanged)
		QML_ELEMENT
		QML_SINGLETON
	public:
		enum State
		{
			// we always start in logged out state
			StateLoggedOut,
			// we move to this state when we a user logs in, we have his name
			// and avatar url, etc...
			StateLoggedIn,
		};
		Q_ENUM(State);

		// returns a pointer to the singleton instance of this LoginDriver
		static LoginDriver* singleton();
		// QML API to provide the singleton instance to QML files
		static LoginDriver* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine);

		// called to perform login using normal username and password
		Q_INVOKABLE void login(QString username, QString password);

		// called to perform logout
		Q_INVOKABLE void logout();

		// Login error property
		QString error() { return mError; }

		// Set error property
		void setError(QString err) { mError = err; emit errorChanged(err); }

		// state property
		State state() const { return mState; }

		// username property
		QString username() const { return mUsername; }

		// avatar url property
		QByteArray avatar() const { return mAvatar; }

	public slots:
		// called whenever a login request has failed
		void loginFailed(QString reason);

		// called when a user logs in
		void loginSucceeded(QString username, QByteArray avatar);

		// called when a user fails to log out
		void logoutFailed(QString reason);

		// called when a user logs out
		void logoutSucceeded();

	signals:
		// sent whenever the user tries to login (clicks login button)
		void loginRequested(QString username, QString password);

		// sent whenever the user tries to logout (clicks logout button)
		void logoutRequested();

		// sent whenever we try a login/logout method and the error message changes
		void errorChanged(QString error);

		// sent whenever the login driver state changes
		void stateChanged(LoginDriver::State state);

		// sent whenever username changes
		void usernameChanged(QString username);

		// sent whenever avatar changes
		void avatarChanged(QByteArray avatar);

	private:
		LoginDriver(QObject* parent = nullptr);
		// helper function which changes the login driver state
		void setState(State nextState);
		// helper function to set user name
		void setUsername(QString username);
		// helper function to set avatar url
		void setAvatar(QByteArray avatar);

		// holds the error message of the last operation
		QString mError;
		State mState = StateLoggedOut;
		QString mUsername;
		QByteArray mAvatar;
	};
}
