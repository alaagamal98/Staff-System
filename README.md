# Staff-System

This is a working desktop application using C++ and Qt for managing the staff (employees) within a small company.

Four types of users can access the system:
1- **admin:** Has full privilege in the system and can add/view/search/modify/delete HRs, Managers, Employees.
2- **HR:** Can add/view/search/modify/delete Managers, Employees.
3- **Manager:** Can only view/search Employees.
4- **Employee:** Can only view his own profile.

Employee profile can have the following data:

- First Name
- Last Name
- Employee Id
- E-mail
- Gender
- Age
- Photo
- Academic degrees
- Manager

**HR Functionalities:**

1. **Add a new manager**
1. **Display all managers**
1. **Add new employee under a certain manager**
1. **Display all employees**
1. **Display all employees under a certain manager**
1. **Display employee details in a separate pane**
1. **Update employee’s data**
1. **Delete employee** 
1. **Search/ Sort/ Filter employees**

**MANAGER Functionalities:**

1. **Display employee**s **(his employees only)**
1. **Search/Sort/Filter employees**

As a new user you need to login to your application using
**username: admin
password: admin**
and start creating new HR accounts, then each HR will login using his username and passwords and start adding/updating/deleting managers/employees

