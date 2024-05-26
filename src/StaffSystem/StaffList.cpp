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
		case IdRole:
			return QVariant(employee->id());
		case UsernameRole:
			return QVariant(employee->username());
		case PasswordRole:
			return QVariant(employee->password());
		case FirstNameRole:
			return QVariant(employee->firstName());
		case LastNameRole:
			return QVariant(employee->lastName());
		case EmailRole:
			return QVariant(employee->email());
		case GenderRole:
			return QVariant(employee->gender());
		case AgeRole:
			return QVariant(employee->age());
		case PhotoRole:
			return QVariant(employee->photo());
		case AcademicDegreeRole:
			return QVariant(employee->academicDegree());
		case ManagerRole:
			return QVariant(employee->manager());
		case StaffTypeRole:
			return QVariant(employee->staffType());
		default:
			return QVariant();
		}
	}

	QHash<int, QByteArray> StaffList::roleNames() const
	{
		static QHash<int, QByteArray> mappings {
			{IdRole, "id"},
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
			if (mStaff[i]->id() != employee->id())
				continue;

			if (mStaff[i]->username() != employee->username())
			{
				mStaff[i]->setUsername(employee->username());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { UsernameRole });
			}
			if (mStaff[i]->password() != employee->password())
			{
				mStaff[i]->setPassword(employee->password());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { PasswordRole });
			}
			if (mStaff[i]->firstName() != employee->firstName())
			{
				mStaff[i]->setFirstName(employee->firstName());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { FirstNameRole });
			}
			if (mStaff[i]->lastName() != employee->lastName())
			{
				mStaff[i]->setLastName(employee->lastName());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { LastNameRole });
			}
			if (mStaff[i]->email() != employee->email())
			{
				mStaff[i]->setEmail(employee->email());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { EmailRole });
			}
			if (mStaff[i]->gender() != employee->gender())
			{
				mStaff[i]->setGender(employee->gender());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { GenderRole });
			}
			if (mStaff[i]->age() != employee->age())
			{
				mStaff[i]->setAge(employee->age());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { AgeRole });
			}
			if (mStaff[i]->photo() != employee->photo())
			{
				mStaff[i]->setPhoto(employee->photo());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { PhotoRole });
			}
			if (mStaff[i]->academicDegree() != employee->academicDegree())
			{
				mStaff[i]->setAcademicDegree(employee->academicDegree());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { AcademicDegreeRole });
			}
			if (mStaff[i]->manager() != employee->manager())
			{
				mStaff[i]->setManager(employee->manager());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { ManagerRole });
			}
			if (mStaff[i]->staffType() != employee->staffType())
			{
				mStaff[i]->setStaffType(employee->staffType());
				QModelIndex employeeIndex = createIndex(i, 0);
				emit dataChanged(employeeIndex, employeeIndex, { StaffTypeRole });
			}
			delete employee;
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
			if (mStaff[i]->id() == id)
			{
				beginRemoveRows(QModelIndex(), i, i);
				if (id == mLastIdx)
					mLastIdx--;
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
			if (employee->id() == id)
				return employee;

		return nullptr;
	}

	QVector<Staff*> StaffList::getManagers()
	{
		QVector<Staff*> managers;
		for (auto employee: mStaff)
			if (employee->staffType() == Staff::Manager)
				managers.append(employee);

		return managers;
	}

	void StaffList::addOrUpdateStaff(QVariantMap employee)
	{
		auto new_employee = new Staff{};

		auto idx = employee["Id"].toInt();
		if (idx == 0)
			idx = mLastIdx + 1;

		new_employee->setId(idx);
		new_employee->setUsername(employee["Username"].toString());
		new_employee->setPassword(employee["Password"].toString());
		new_employee->setFirstName(employee["FirstName"].toString());
		new_employee->setLastName(employee["LastName"].toString());
		new_employee->setEmail(employee["Email"].toString());
		new_employee->setGender(Staff::Gender(employee["Gender"].toInt()));
		new_employee->setAge(employee["Age"].toUInt());
		new_employee->setPhoto(employee["Photo"].toByteArray());
		new_employee->setAcademicDegree(employee["AcademicDegree"].toString());
		new_employee->setManager(employee["Manager"].toString());
		new_employee->setStaffType(Staff::StaffType(employee["Role"].toInt()));

		addOrUpdateStaff(new_employee);
	}

	Staff* StaffList::authenticateStaff(QString username, QString password)
	{
		for (auto employee: mStaff)
			if (employee->username() == username && employee->password() == password)
				return employee;

		return nullptr;
	}
}
