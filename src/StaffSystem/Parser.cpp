#include "StaffSystem/Parser.h"

namespace client::system
{
	int
	parseEmployee(void *data, int col_count, char **col_content, char **col_name)
	{
		auto staff_list = (StaffList *)data;
		auto employee = new Staff{};

		for (int j = 0; j < col_count; ++j)
		{
			if (col_content[j] == nullptr)
				continue;

			auto column = std::string(col_name[j]);

			if (column == "Id")
			{
				char* end_ptr = (char*)col_content[j];
				employee->setId((size_t)std::strtol(col_content[j], &end_ptr, 10));
			}
			else if (column == "Username")
			{
				employee->setUsername(QString::fromStdString(col_content[j]));
			}
			else if (column == "Password")
			{
				employee->setPassword(QString::fromStdString(col_content[j]));
			}
			else if (column == "FirstName")
			{
				employee->setFirstName(QString::fromStdString(col_content[j]));
			}
			else if (column == "LastName")
			{
				employee->setLastName(QString::fromStdString(col_content[j]));
			}
			else if (column == "Email")
			{
				employee->setEmail(QString::fromStdString(col_content[j]));
			}
			else if (column == "Gender")
			{
				auto gender = std::string(col_content[j]);
				if (gender == "Male")
					employee->setGender(Staff::Male);
				else
					employee->setGender(Staff::Female);
			}
			else if (column == "Age")
			{
				char* end_ptr = (char*)col_content[j];
				employee->setAge((size_t)std::strtol(col_content[j], &end_ptr, 10));
			}
			else if (column == "Photo")
			{
				auto photo = std::string(col_content[j]);
				employee->setPhoto(QUrl::fromLocalFile(QString::fromStdString(photo)));
			}
			else if (column == "AcademicDegree")
			{
				employee->setAcademicDegree(QString::fromStdString(col_content[j]));
			}
			else if (column == "Manager")
			{
				employee->setManager(QString::fromStdString(col_content[j]));
			}
			else if (column == "Role")
			{
				auto role = std::string(col_content[j]);
				if (role == "Admin")
					employee->setStaffType(Staff::Admin);
				else if (role == "HR")
					employee->setStaffType(Staff::HR);
				else if (role == "Manager")
					employee->setStaffType(Staff::Manager);
				else
					employee->setStaffType(Staff::Employee);
			}
		}
		if (employee->id() > staff_list->lastIdx())
			staff_list->setLastIdx(employee->id());
		staff_list->addOrUpdateStaff(employee);

		return 0;
	}
} // namespace client::system
