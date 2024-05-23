#pragma once

#include <QtCore/QAbstractListModel>
#include <QtCore/QString>
#include <QtCore/QVector>
#include <QtGui/QColor>
#include <QtQml/qqml.h>

#include <chrono>

namespace client::system
{
	struct Staff
	{
		Q_GADGET
		Q_PROPERTY(size_t id MEMBER id)
		Q_PROPERTY(QString username MEMBER username)
		Q_PROPERTY(QString password MEMBER password)
		Q_PROPERTY(QString firstName MEMBER firstName)
		Q_PROPERTY(QString lastName MEMBER lastName)
		Q_PROPERTY(QString email MEMBER email)
		Q_PROPERTY(Gender gender MEMBER gender)
		Q_PROPERTY(size_t age MEMBER age)
		Q_PROPERTY(QByteArray photo MEMBER photo)
		Q_PROPERTY(QString academicDegree MEMBER academicDegree)
		Q_PROPERTY(QString manager MEMBER manager)
		Q_PROPERTY(StaffType staffType MEMBER staffType)
		QML_VALUE_TYPE(Staff)

	public:
		enum Gender
		{
			Male,
			Female,
		};
		Q_ENUM(Gender);

		enum StaffType
		{
			Admin,
			HR,
			Manager,
			Employee,
		};
		Q_ENUM(StaffType);

		size_t id;
		QString username;
		QString password;
		QString firstName;
		QString lastName;
		QString email;
		Gender gender;
		size_t age;
		QByteArray photo;
		QString academicDegree;
		QString manager;
		StaffType staffType;
	};

	class StaffList : public QAbstractListModel
	{
		Q_OBJECT
		QML_SINGLETON
		Q_PROPERTY(int count READ count NOTIFY countChanged) // To be bindable from qml

	public:
		explicit StaffList(QObject* parent = nullptr);

		enum
		{
			IDRole = Qt::UserRole,
			UsernameRole,
			PasswordRole,
			FirstNameRole,
			LastNameRole,
			EmailRole,
			GenderRole,
			AgeRole,
			PhotoRole,
			AcademicDegreeRole,
			ManagerRole,
			StaffTypeRole,
		};

		// returns a pointer to the singleton instance of this StaffList
		static StaffList* singleton();

		// QAbstractListModel overridden function
		int rowCount(const QModelIndex& parent = QModelIndex()) const override;
		QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
		QHash<int, QByteArray> roleNames() const override;

		void addOrUpdateStaff(Staff* employee);
		void removeStaff(size_t id);

		// empties the employee list
		void clear();

		// Getters
		Q_INVOKABLE QVector<Staff*> employees() const { return mStaff; }
		int count() const { return rowCount(QModelIndex{}); }

		// returns the employee associated with the given id, if there isn't one, it returns nullptr
		Q_INVOKABLE Staff* getStaff(size_t id);

		// returns the employee associated with the given username and password, if there isn't one, it returns nullptr
		Q_INVOKABLE Staff* authenticateStaff(QString username, QString password);

	private:
		QVector<Staff*> mStaff;

	signals:
		void countChanged();
	};
}
