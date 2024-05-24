#pragma once

#include "StaffSystem/StaffObject.h"

#include <QtCore/QAbstractListModel>
#include <QtCore/QString>
#include <QtCore/QVector>
#include <QtGui/QColor>
#include <QtQml/qqml.h>

namespace client::system
{
	class StaffList : public QAbstractListModel
	{
		Q_OBJECT
		QML_SINGLETON
		Q_PROPERTY(int count READ count NOTIFY countChanged) // To be bindable from qml

	public:
		StaffList(QObject* parent = nullptr);
		~StaffList() { clear(); };

		enum
		{
			IdRole = Qt::UserRole,
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
		int count() const {
			return rowCount(QModelIndex{});
		}

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
