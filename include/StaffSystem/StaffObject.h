#pragma once

#include <QtCore/QAbstractListModel>
#include <QtCore/QString>
#include <QtCore/QVector>
#include <QtGui/QColor>
#include <QtQml/qqml.h>

namespace client::system
{
	class Staff : public QObject
	{
		Q_OBJECT
		Q_PROPERTY(size_t id READ id WRITE setId NOTIFY idChanged)
		Q_PROPERTY(QString username READ username WRITE setUsername NOTIFY usernameChanged)
		Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
		Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged)
		Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged)
		Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
		Q_PROPERTY(Gender gender READ gender WRITE setGender NOTIFY genderChanged)
		Q_PROPERTY(size_t age READ age WRITE setAge NOTIFY ageChanged)
		Q_PROPERTY(QByteArray photo READ photo WRITE setPhoto NOTIFY photoChanged)
		Q_PROPERTY(QString academicDegree READ academicDegree WRITE setAcademicDegree NOTIFY academicDegreeChanged)
		Q_PROPERTY(QString manager READ manager WRITE setManager NOTIFY managerChanged)
		Q_PROPERTY(StaffType staffType READ staffType WRITE setStaffType NOTIFY staffTypeChanged)
		QML_VALUE_TYPE(Staff)
		QML_ELEMENT

	public:
		Staff(QObject* parent = nullptr)
		: QObject(parent)
		{}

		// returns a pointer to the singleton instance of this Staff object
		static Staff* singleton()
		{
			static Staff instance;
			return &instance;
		}

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

		size_t id() const { return mId; }
		void setId(size_t value)
		{
			if (mId == value)
				return;
			mId = value;
			emit idChanged(mId);
		}

		QString username() const { return mUsername; }
		void setUsername(const QString& value)
		{
			if (mUsername == value)
				return;
			mUsername = value;
			emit usernameChanged(mUsername);
		}

		QString password() const { return mPassword; }
		void setPassword(const QString& value)
		{
			if (mPassword == value)
				return;
			mPassword = value;
			emit passwordChanged(mPassword);
		}

		QString firstName() const { return mFirstName; }
		void setFirstName(const QString& value)
		{
			if (mFirstName == value)
				return;
			mFirstName = value;
			emit firstNameChanged(mFirstName);
		}

		QString lastName() const { return mLastName; }
		void setLastName(const QString& value)
		{
			if (mLastName == value)
				return;
			mLastName = value;
			emit lastNameChanged(mLastName);
		}

		QString email() const { return mEmail; }
		void setEmail(const QString& value)
		{
			if (mEmail == value)
				return;
			mEmail = value;
			emit emailChanged(mEmail);
		}

		Gender gender() const { return mGender; }
		void setGender(Gender value)
		{
			if (mGender == value)
				return;
			mGender = value;
			emit genderChanged(mGender);
		}

		size_t age() const { return mAge; }
		void setAge(size_t value)
		{
			if (mAge == value)
				return;
			mAge = value;
			emit ageChanged(mAge);
		}

		QByteArray photo() const { return mPhoto; }
		void setPhoto(const QByteArray& value)
		{
			if (mPhoto == value)
				return;
			mPhoto = value;
			emit photoChanged(mPhoto);
		}

		QString academicDegree() const { return mAcademicDegree; }
		void setAcademicDegree(const QString& value)
		{
			if (mAcademicDegree == value)
				return;
			mAcademicDegree = value;
			emit academicDegreeChanged(mAcademicDegree);
		}

		QString manager() const { return mManager; }
		void setManager(const QString& value)
		{
			if (mManager == value)
				return;
			mManager = value;
			emit managerChanged(mManager);
		}

		StaffType staffType() const { return mStaffType; }
		void setStaffType(StaffType value)
		{
			if (mStaffType == value)
				return;
			mStaffType = value;
			emit staffTypeChanged(mStaffType);
		}

	signals:
		void idChanged(size_t id);
		void usernameChanged(const QString& username);
		void passwordChanged(const QString& password);
		void firstNameChanged(const QString& firstName);
		void lastNameChanged(const QString& lastName);
		void emailChanged(const QString& email);
		void genderChanged(Gender gender);
		void ageChanged(size_t age);
		void photoChanged(const QByteArray& photo);
		void academicDegreeChanged(const QString& academicDegree);
		void managerChanged(const QString& manager);
		void staffTypeChanged(StaffType staffType);

	private:
		size_t mId;
		QString mUsername;
		QString mPassword;
		QString mFirstName;
		QString mLastName;
		QString mEmail;
		Gender mGender;
		size_t mAge;
		QByteArray mPhoto;
		QString mAcademicDegree;
		QString mManager;
		StaffType mStaffType;
	};
}