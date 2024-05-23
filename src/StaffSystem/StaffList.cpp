#include "StaffSystem/StaffList.h"

namespace client::system
{
	StaffList::StaffList(QObject* parent)
		: QAbstractListModel(parent)
	{
		connect(this, &QAbstractListModel::rowsInserted, this, &StaffList::countChanged);
		connect(this, &QAbstractListModel::rowsRemoved, this, &StaffList::countChanged);
		connect(this, &QAbstractListModel::modelReset, this, &StaffList::countChanged);
	}

	StaffList* StaffList::singleton()
	{
		static StaffList instance;
		return &instance;
	}

	int StaffList::rowCount(const QModelIndex& parent) const
	{
		if (parent.isValid())
			return 0;

		return mStaff.size();
	}

	QVariant StaffList::data(const QModelIndex& index, int role) const
	{
		if (index.isValid() == false)
			return QVariant();

		const auto& employee = mStaff[index.row()];
		switch (role)
		{
		case IDRole:
			return QVariant(employee->id);
		case UsernameRole:
			return QVariant(employee->username);
		case PasswordRole:
			return QVariant(employee->password);
		case FirstNameRole:
			return QVariant(employee->firstName);
		case LastNameRole:
			return QVariant(employee->lastName);
		case EmailRole:
			return QVariant(employee->email);
		case GenderRole:
			return QVariant(employee->gender);
		case AgeRole:
			return QVariant(employee->age);
		case PhotoRole:
			return QVariant(employee->photo);
		case AcademicDegreeRole:
			return QVariant(employee->academicDegree);
		case ManagerRole:
			return QVariant(employee->manager);
		case StaffTypeRole:
			return QVariant(employee->staffType);
		default:
			return QVariant();
		}
	}

	QHash<int, QByteArray> StaffList::roleNames() const
	{
		static QHash<int, QByteArray> mappings {
			{IDRole, "id"},
			{UsernameRole, "username"},
			{PasswordRole, "password"},
			{FirstNameRole, "firstName"},
			{LastNameRole, "lastName"},
			{EmailRole, "email"},
			{GenderRole, "gender"},
			{AgeRole, "age"},
			{PhotoRole, "photo"},
			{AcademicDegreeRole, "academicDegree"},
			{ManagerRole, "manager"},
			{StaffTypeRole, "staffType"},
		};
		return mappings;
	}

	void StaffList::addOrUpdateStaff(Staff* employee)
	{
		// if the given employee is already in the list we just update it
		for (size_t i = 0; i < mStaff.size(); ++i)
		{
			if (mStaff[i]->id != employee->id)
				continue;

			if (mStaff[i]->username != employee->username)
			{
				mStaff[i]->username = employee->username;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { UsernameRole });
			}
			if (mStaff[i]->password != employee->password)
			{
				mStaff[i]->password = employee->password;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { PasswordRole });
			}
			if (mStaff[i]->firstName != employee->firstName)
			{
				mStaff[i]->firstName = employee->firstName;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { FirstNameRole });
			}
			if (mStaff[i]->lastName != employee->lastName)
			{
				mStaff[i]->lastName = employee->lastName;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { LastNameRole });
			}
			if (mStaff[i]->email != employee->email)
			{
				mStaff[i]->email = employee->email;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { EmailRole });
			}
			if (mStaff[i]->gender != employee->gender)
			{
				mStaff[i]->gender = employee->gender;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { GenderRole });
			}
			if (mStaff[i]->age != employee->age)
			{
				mStaff[i]->age = employee->age;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { AgeRole });
			}
			if (mStaff[i]->photo != employee->photo)
			{
				mStaff[i]->photo = employee->photo;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { PhotoRole });
			}
			if (mStaff[i]->academicDegree != employee->academicDegree)
			{
				mStaff[i]->academicDegree = employee->academicDegree;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { AcademicDegreeRole });
			}
			if (mStaff[i]->manager != employee->manager)
			{
				mStaff[i]->manager = employee->manager;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { ManagerRole });
			}
			if (mStaff[i]->staffType != employee->staffType)
			{
				mStaff[i]->staffType = employee->staffType;
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { StaffTypeRole });
			}
			return;
		}

		// if the employee is not found in the list, then it's a new one that gets inserted
		beginInsertRows(QModelIndex(), mStaff.size(), mStaff.size());

		mStaff.append(employee);
		endInsertRows();
	}

	void StaffList::removeStaff(size_t id)
	{
		for (size_t i = 0; i < mStaff.size(); ++i)
		{
			if (mStaff[i]->id == id)
			{
				beginRemoveRows(QModelIndex(), i, i);
				mStaff.removeAt(i);
				endRemoveRows();
				return;
			}
		}
		Q_ASSERT_X(false, "removeStaff", "Staff list doesn't contain sent id");
	}

	void StaffList::clear()
	{
		beginResetModel();

		mStaff.clear();
		endResetModel();
	}

	Staff* StaffList::getStaff(size_t id)
	{
		for (auto employee: mStaff)
			if (employee->id == id)
				return employee;

		return nullptr;
	}

	Staff* StaffList::authenticateStaff(QString username, QString password)
	{
		for (auto employee: mStaff)
			if (employee->username == username && employee->password == password)
				return employee;

		return nullptr;
	}
}