import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import StaffSystem

Popup {
    id: _root

    property var employee
    property var currentUserRole
    property var currentManagers
    property var popupOpened

    signal updateRow

    objectName: "staffDetailsPopup"
    padding: 0
    closePolicy: Popup.NoAutoClose

    function reset() {
        var managers = [];
        for (var i = 0; i < currentManagers.length; ++i) {
            managers.push(currentManagers[i].username);
        }
        managerInput.model = managers;
        managerInput.currentIndex = managerInput.find(employee.manager);
        popupOpened = false;
        error.text = "";
    }

    ColumnLayout {
        id: content

        anchors.fill: parent
        spacing: -200

        RowLayout {
            id: titleBar

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            Layout.topMargin: 10

            Label {
                id: label
                Layout.fillWidth: true
                Layout.leftMargin: 50
                font.pixelSize: 30
                font.bold: true
                text: popupOpened ? employee.firstName + " " + employee.lastName + "'s Details" : ""
                color: "#292E5F"
            }

            Button {
                id: closeBtn

                implicitWidth: 25
                implicitHeight: 25
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 10
                icon.source: "qrc:/StaffSystem/icons/close.svg"

                onClicked: _root.close()
            }
        }

        RowLayout {
            id: photoRow

            Layout.fillWidth: true
            Layout.margins: -40
            Layout.alignment: Qt.AlignHCenter

            Image {
                id: avatar
                source: employee.photo
                width: 200
                height: 200
                sourceSize: Qt.size(width, height)
            }
        }

        RowLayout {
            id: firstInputRow

            Layout.fillWidth: true
            Layout.margins: 10
            Layout.leftMargin: 50

            Text {
                id: firstNameText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "First Name: "
                font.pixelSize: 16
            }

            TextField {
                id: firstNameInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                text: popupOpened ? employee.firstName : ""
                font.pixelSize: 16
                enabled: currentUserRole !== 2
            }

            Text {
                id: lastNameText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "Last Name: "
                font.pixelSize: 16
            }

            TextField {
                id: lastNameInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                text: popupOpened ? employee.lastName : ""
                font.pixelSize: 16
                enabled: currentUserRole !== 2
            }

            Text {
                id: roleText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "Role: "
                font.pixelSize: 16
            }

            ComboBox {
                id: roleInput

                objectName: "roleInput"
                Layout.preferredWidth: 300
                Layout.preferredHeight: 45
                Layout.leftMargin: 15
                textRole: "text"
                valueRole: "value"
                model: {
                    if (currentUserRole === 0)
                        return [
                            {
                                "text": "HR",
                                "value": 1
                            },
                            {
                                "text": "Manager",
                                "value": 2
                            },
                            {
                                "text": "Employee",
                                "value": 3
                            }
                        ];
                    else if (currentUserRole === 1)
                        return [
                            {
                                "text": "Manager",
                                "value": 2
                            },
                            {
                                "text": "Employee",
                                "value": 3
                            }
                        ];
                    else if (currentUserRole === 2)
                        return [
                            {
                                "text": "Employee",
                                "value": 3
                            }
                        ];
                }
                currentIndex: {
                    if (popupOpened) {
                        if (currentUserRole === 0)
                            return employee.staffType - 1;
                        else if (currentUserRole === 1)
                            return employee.staffType - 2;
                        else if (currentUserRole === 2)
                            return employee.staffType - 3;
                    }
                    return -1;
                }
                enabled: currentUserRole !== 2
            }
        }

        RowLayout {
            id: secondInputRow

            Layout.fillWidth: true
            Layout.margins: 10
            Layout.leftMargin: 50

            Text {
                id: ageText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "Age: "
                font.pixelSize: 16
            }

            SpinBox {
                id: ageInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignVCenter
                from: 0
                to: 100
                value: popupOpened ? employee.age : 0
                editable: true
                font.pixelSize: 16
                enabled: currentUserRole !== 2
            }

            Text {
                id: genderText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "Gender: "
                font.pixelSize: 16
            }

            ComboBox {
                id: genderInput

                objectName: "genderInput"
                Layout.preferredWidth: 300
                Layout.preferredHeight: 45
                Layout.leftMargin: 15
                textRole: "text"
                valueRole: "value"
                model: [
                    {
                        "text": "Male",
                        "value": 0
                    },
                    {
                        "text": "Female",
                        "value": 1
                    }
                ]
                currentIndex: popupOpened ? employee.gender : -1
                enabled: currentUserRole !== 2
            }

            Text {
                id: academicDegreeText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "Academic Degree: "
                font.pixelSize: 16
            }

            TextField {
                id: academicDegreeInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                text: popupOpened ? employee.academicDegree : ""
                font.pixelSize: 16
                enabled: currentUserRole !== 2
            }
        }

        RowLayout {
            id: thirdInputRow

            Layout.fillWidth: true
            Layout.margins: 10
            Layout.leftMargin: 50

            Text {
                id: managerText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "Manager: "
                font.pixelSize: 16
            }

            ComboBox {
                id: managerInput

                objectName: "managerInput"
                Layout.preferredWidth: 300
                Layout.preferredHeight: 45
                Layout.leftMargin: 15
                enabled: roleInput.currentValue === 3 && currentUserRole !== 2

                Component.onCompleted: {
                    var managers = [];
                    for (var i = 0; i < currentManagers.length; ++i) {
                        managers.push(currentManagers[i].username);
                    }
                    model = managers;
                }
                currentIndex: -1
            }

            Text {
                id: usernameText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "Username: "
                font.pixelSize: 16
            }

            TextField {
                id: usernameInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                text: popupOpened ? employee.username : ""
                font.pixelSize: 16
                enabled: (roleInput.currentValue === 1 || roleInput.currentValue === 2) && currentUserRole !== 2
            }

            Text {
                id: passwordText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "Password: "
                font.pixelSize: 16
            }

            TextField {
                id: passwordInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                text: popupOpened ? employee.password : ""
                font.pixelSize: 16
                echoMode: TextInput.Password
                enabled: (roleInput.currentValue === 1 || roleInput.currentValue === 2) && currentUserRole !== 2
            }
        }

        RowLayout {
            id: fourthInputRow

            Layout.fillWidth: true
            Layout.margins: 10
            Layout.leftMargin: 50

            Text {
                id: emailText
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 120
                verticalAlignment: Qt.AlignVCenter
                text: "Email: "
                font.pixelSize: 16
            }

            TextField {
                id: emailInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                text: popupOpened ? employee.email : ""
                font.pixelSize: 16
                enabled: currentUserRole !== 2
            }

            Button {
                id: photoInput
                Layout.leftMargin: 150
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignVCenter
                text: "Upload Photo"
                font.pixelSize: 16
                onClicked: fileDialog.open()
                visible: currentUserRole !== 2
            }
        }

        RowLayout {
            id: submetRow

            Layout.fillWidth: true
            Layout.margins: 10
            Layout.rightMargin: 50
            Layout.alignment: Qt.AlignRight

            Text {
                id: error
                Layout.leftMargin: 15

                font.pixelSize: 14
                wrapMode: Text.WordWrap
                color: "#A53F3F"
                text: ""
            }
            Button {
                id: removeButton
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignVCenter
                text: "Remove"
                font.pixelSize: 16
                visible: currentUserRole !== 2
                background: Rectangle {
                    color: "#A53F3F"
                }
                onClicked: {
                    StaffDriver.staffList.removeStaff(employee.id);
                    _root.close();
                }
            }

            Button {
                id: updateButton
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignVCenter
                text: "Update"
                font.pixelSize: 16
                visible: currentUserRole !== 2
                background: Rectangle {
                    color: "#A9E0E6"
                }
                onClicked: {
                    var duplicate_username = false;
                    if (usernameInput.text !== "") {
                        var employees = StaffDriver.staffList.employees();
                        for (var i = 0; i < employees.length; ++i) {
                            if (employees[i].username === usernameInput.text && employees[i].id !== employee.id) {
                                duplicate_username = true;
                                break;
                            }
                        }
                    }
                    if (duplicate_username) {
                        error.text = "Username already used, Choose another one..";
                    } else {
                        let new_employee = {
                            "Id": employee.id,
                            "Username": usernameInput.text,
                            "Password": passwordInput.text,
                            "FirstName": firstNameInput.text,
                            "LastName": lastNameInput.text,
                            "Email": emailInput.text,
                            "Gender": genderInput.currentValue,
                            "Age": ageInput.value,
                            "Photo": avatar.source,
                            "AcademicDegree": academicDegreeInput.text,
                            "Manager": managerInput.currentText,
                            "Role": roleInput.currentValue
                        };
                        StaffDriver.staffList.addOrUpdateStaff(new_employee);
                        StaffDriver.updateStaffToDB(tableView.model.getRow(rowSelectedIndex).Id);
                        _root.updateRow();
                        _root.close();
                    }
                }
            }
        }
    }

    FileDialog {
        id: fileDialog

        title: "Choose Photo"
        fileMode: FileDialog.OpenFiles
        nameFilters: ["Case Files (*.png *.jpg)", "All Files (*)"]

        onAccepted: {
            avatar.source = selectedFile;
        }
    }
}
