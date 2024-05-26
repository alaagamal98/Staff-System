import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import StaffSystem

ColumnLayout {
    id: user

    RowLayout {
        id: nameContent
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        Layout.fillWidth: true
        Layout.leftMargin: 15

        Text {
            font.pixelSize: 20
            font.weight: Font.Bold
            color: "#FFFFFF"
            text: "Welcome, " + StaffDriver.currentEmployee.firstName + " " + StaffDriver.currentEmployee.lastName
        }

        Button {
            Layout.alignment: Qt.AlignRight
            Layout.leftMargin: 20

            icon.source: "qrc:/StaffSystem/icons/logout.svg"
            onClicked: LoginDriver.logout()
        }
    }


       Text {
		text: StaffDriver.currentEmployee.username
		font.pixelSize: 15
		font.weight: 5
		font.family: "Roboto Light"
		color: "#FFFFFF"
		elide: Text.ElideMiddle
		Layout.alignment: Qt.AlignRight
	}

    RowLayout {
        id: userRowContent
        Layout.alignment: Qt.AlignHCenter

        Image {
            id: avatar
            source: StaffDriver.currentEmployee.photo.toString() === "" ?  "qrc:/StaffSystem/icons/account-circle.svg" : StaffDriver.currentEmployee.photo
            width: 300
            height: 300
            sourceSize: Qt.size(width, height)
        }
    }
}
