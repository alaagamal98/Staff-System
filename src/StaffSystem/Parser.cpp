#include "StaffSystem/Parser.h"

namespace client::system
{
	int
	parseEmployee(void *data, int col_count, char **col_content, char **col_name)
	{
		auto staff_list = (client::system::StaffList *)data;
		auto employee = new client::system::Staff{};

		for (int j = 0; j < col_count; ++j)
		{
			if (col_content[j] == nullptr)
				continue;

			auto column = std::string(col_name[j]);

			if (column == "ID")
			{
				char* end_ptr = (char*)col_content[j];
				employee->id = (size_t)std::strtol(col_content[j], &end_ptr, 10);
			}
			else if (column == "Username")
			{
				employee->username = QString::fromStdString(col_content[j]);
			}
			else if (column == "Password")
			{
				employee->password = QString::fromStdString(col_content[j]);
			}
			else if (column == "FirstName")
			{
				employee->firstName = QString::fromStdString(col_content[j]);
			}
			else if (column == "LastName")
			{
				employee->lastName = QString::fromStdString(col_content[j]);
			}
			else if (column == "Email")
			{
				employee->email = QString::fromStdString(col_content[j]);
			}
			else if (column == "Gender")
			{
				auto gender = std::string(col_content[j]);
				if (gender == "Male")
					employee->gender = client::system::Staff::Male;
				else
					employee->gender = client::system::Staff::Female;
			}
			else if (column == "Age")
			{
				char* end_ptr = (char*)col_content[j];
				employee->age = (size_t)std::strtol(col_content[j], &end_ptr, 10);
			}
			else if (column == "Photo")
			{
				auto photo = std::string(col_content[j]);
				employee->photo = QByteArray(photo.c_str(), photo.length());
			}
			else if (column == "AcademicDegree")
			{
				employee->academicDegree = QString::fromStdString(col_content[j]);
			}
			else if (column == "Manager")
			{
				employee->manager = QString::fromStdString(col_content[j]);
			}
			else if (column == "Role")
			{
				auto role = std::string(col_content[j]);
				if (role == "Admin")
					employee->staffType = client::system::Staff::Admin;
				else if (role == "HR")
					employee->staffType = client::system::Staff::HR;
				else if (role == "Manager")
					employee->staffType = client::system::Staff::Manager;
				else
					employee->staffType = client::system::Staff::Employee;
			}
		}
		staff_list->addOrUpdateStaff(employee);

		return 0;
	}
} // namespace client::system
