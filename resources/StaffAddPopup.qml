import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import StaffSystem

Popup {
    id: _root

    property var currentUserRole: StaffDriver.currentEmployee.staffType
    property var currentManagers: StaffDriver.staffList.getManagers()

    objectName: "staffAddPopup"
    closePolicy: Popup.NoAutoClose

    function reset() {
        usernameInput.text = "";
        passwordInput.text = "";
        firstNameInput.text = "";
        lastNameInput.text = "";
        emailInput.text = "";
        genderInput.currentIndex = -1;
        ageInput.value = 0;
        avatar.source = "qrc:/StaffSystem/icons/account-circle.svg";
        academicDegreeInput.text = "";
        roleInput.currentIndex = -1;
        currentManagers = StaffDriver.staffList.getManagers();
        var managers = [];
        for (var i = 0; i < currentManagers.length; ++i) {
            managers.push(currentManagers[i].username);
        }
        managerInput.model = managers;
        managerInput.currentIndex = -1;
    }
    ColumnLayout {
        id: content

        anchors.fill: parent
        spacing: -200

        RowLayout {
            id: titleBar

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            Layout.leftMargin: 50
            Layout.topMargin: 10

            Label {
                id: label
                Layout.fillWidth: true
                font.pixelSize: 30
                font.bold: true
                text: "Add a New Staff Member"
                color: "#292E5F"
            }

            Button {
                id: closeBtn

                text: " Close"
                implicitWidth: 80
                implicitHeight: 25
                Layout.alignment: Qt.AlignRight
                icon.source: "qrc:/StaffSystem/icons/close.svg"

                onClicked: {
                    reset();
                    _root.close();
                }
            }
        }

        RowLayout {
            id: photoRow

            Layout.fillWidth: true
            Layout.margins: -50
            Layout.alignment: Qt.AlignHCenter

            Image {
                id: avatar
                source: "qrc:/StaffSystem/icons/account-circle.svg"
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

            TextField {
                id: firstNameInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                placeholderText: "First Name"
                font.pixelSize: 16
            }

            TextField {
                id: lastNameInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                placeholderText: "Last Name"
                font.pixelSize: 16
            }

            ComboBox {
                id: roleInput

                objectName: "roleInput"
                Layout.preferredWidth: 300
                Layout.preferredHeight: 45
                Layout.leftMargin: 15
                currentIndex: -1
                displayText: currentIndex === -1 ? "Select Role..." : currentText

                textRole: "text"
                valueRole: "value"
                model: {
                    if (currentUserRole == 0)
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
                    else if (currentUserRole == 1)
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
                }
            }

            TextField {
                id: emailInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                placeholderText: "Email"
                font.pixelSize: 16
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
                Layout.preferredWidth: 25
                verticalAlignment: Qt.AlignVCenter
                text: "Age: "
                font.pixelSize: 16
            }

            SpinBox {
                id: ageInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 260
                Layout.alignment: Qt.AlignVCenter
                from: 0
                to: 100
                editable: true
                font.pixelSize: 16
            }

            ComboBox {
                id: genderInput

                objectName: "genderInput"
                Layout.preferredWidth: 300
                Layout.preferredHeight: 45
                Layout.leftMargin: 15
                currentIndex: -1
                displayText: currentIndex === -1 ? "Select Gender..." : currentText

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
            }

            TextField {
                id: academicDegreeInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                placeholderText: "Academic Degree"
                font.pixelSize: 16
            }

            Button {
                id: photoInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignVCenter
                text: "Upload Photo"
                font.pixelSize: 16
                onClicked: fileDialog.open()
            }
        }

        RowLayout {
            id: thirdInputRow

            Layout.fillWidth: true
            Layout.margins: 10
            Layout.leftMargin: 50

            ComboBox {
                id: managerInput

                objectName: "managerInput"
                Layout.preferredWidth: 300
                Layout.preferredHeight: 45
                Layout.leftMargin: 15
                enabled: roleInput.currentValue == 3
                Component.onCompleted: {
                    var managers = [];
                    for (var i = 0; i < currentManagers.length; ++i) {
                        managers.push(currentManagers[i].username);
                    }
                    model = managers;
                    currentIndex = -1;
                }
                displayText: currentIndex === -1 ? "Select Manager..." : currentText
            }

            TextField {
                id: usernameInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                placeholderText: "Username"
                font.pixelSize: 16
                enabled: roleInput.currentValue == 1 || roleInput.currentValue == 2
            }

            TextField {
                id: passwordInput
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                verticalAlignment: Qt.AlignVCenter
                placeholderText: "Password"
                font.pixelSize: 16
                echoMode: TextInput.Password
                enabled: roleInput.currentValue == 1 || roleInput.currentValue == 2
            }
        }
        RowLayout {
            id: submetRow

            Layout.fillWidth: true
            Layout.margins: 10
            Layout.rightMargin: 50
            Layout.alignment: Qt.AlignRight

            Button {
                id: addButton
                Layout.leftMargin: 15
                Layout.preferredHeight: 45
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignVCenter
                text: "Add Staff Member"
                font.pixelSize: 16
                background: Rectangle {
                    color: "#A9E0E6"
                }
                onClicked: {
                    let new_employee = {
                        "Username": usernameInput.text,
                        "Password": passwordInput.text,
                        "FirstName": firstNameInput.text,
                        "LastName": lastNameInput.text,
                        "Email": emailInput.text,
                        "Gender": genderInput.currentValue,
                        "Age": ageInput.value,
                        "Photo": "",
                        "AcademicDegree": academicDegreeInput.text,
                        "Manager": managerInput.currentText,
                        "Role": roleInput.currentValue
                    };
                    StaffDriver.staffList.addStaff(new_employee);
                    reset();
                    _root.close();
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
