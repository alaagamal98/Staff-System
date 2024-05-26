import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import StaffSystem

ColumnLayout {
    id: user

    RowLayout {
        id: nameContent
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        Layout.leftMargin: 15

        Text {
            font.pixelSize: 20
            font.weight: Font.Bold
            color: "#FFFFFF"
            text: "Welcome, " + StaffDriver.currentEmployee.firstName + " " + StaffDriver.currentEmployee.lastName
        }
    }

    RowLayout {
        id: userRowContent
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter

        Image {
            id: avatar
            source: StaffDriver.currentEmployee.photo.toString() === "" ? "qrc:/StaffSystem/icons/account-circle.svg" : StaffDriver.currentEmployee.photo
            width: 200
            height: 200
            sourceSize: Qt.size(width, height)
        }
    }

    RowLayout {
        id: firstTextRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: firstNameText

            text: "First Name: "
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        Text {
            id: lastNameText

            text: "Last Name: "
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }
    }

    RowLayout {
        id: firstInputRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: firstNameInput
            text: StaffDriver.currentEmployee.firstName
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            color: "#FFFFFF"
        }

        Text {
            id: lastNameInput
            text: StaffDriver.currentEmployee.lastName
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            color: "#FFFFFF"
        }
    }


    RowLayout {
        id: secondTextRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: ageText

            text: "Age: "
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        Text {
            id: genderText

            text: "Gender: "
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }
    }

    RowLayout {
        id: secondInputRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: ageInput
            text: StaffDriver.currentEmployee.age
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            color: "#FFFFFF"
        }

        Text {
            id: genderInput
            text: StaffDriver.currentEmployee.gender == 0 ? "Male" : "Female"
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            color: "#FFFFFF"
        }
    }

    RowLayout {
        id: thirdTextRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: roleText

            text: "Role: "
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        Text {
            id: managerText

            text: "Manager: "
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }
    }

    RowLayout {
        id: thirdInputRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: roleInput
            text: {
                if (StaffDriver.currentEmployee.staffType == 0)
                    return "Admin";
                else if (StaffDriver.currentEmployee.staffType == 1)
                    return "HR";
                else if (StaffDriver.currentEmployee.staffType == 2)
                    return "Manager";
                else
                    return "Employee";
            }
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            color: "#FFFFFF"
        }

        Text {
            id: managrInput
            text: StaffDriver.currentEmployee.manager
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            color: "#FFFFFF"
        }

    }

    RowLayout {
        id: fourthTextRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: academicDegreeText

            text: "Academic Degree: "
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        Text {
            id: emailText

            text: "Email: "
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }
    }

    RowLayout {
        id: fourthInputRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: academicDegreeInput
            text: StaffDriver.currentEmployee.academicDegree
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            color: "#FFFFFF"
        }

        Text {
            id: emailInput
            text: StaffDriver.currentEmployee.email
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            color: "#FFFFFF"
        }
    }

	    RowLayout {
        id: fifthTextRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: usernameText

            text: "Username: "
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }
    }

	    RowLayout {
        id: fifthInputRow

        Layout.fillWidth: true
        Layout.margins: 5

        Text {
            id: usernameInput
            text: StaffDriver.currentEmployee.username
            font.pixelSize: 16
        	Layout.preferredWidth: 130
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            color: "#FFFFFF"
        }
    }

    RowLayout {
        id: logout
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.leftMargin: 15

        Button {
            Layout.alignment: Qt.AlignRight
            Layout.leftMargin: 20
            text: "Sign Out"

            icon.source: "qrc:/StaffSystem/icons/logout.svg"
            onClicked: LoginDriver.logout()
        }
    }

}
