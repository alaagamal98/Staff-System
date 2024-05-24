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

    RowLayout {
        id: userRowContent
        Layout.alignment: Qt.AlignRight
        Layout.rightMargin: 20
        Layout.topMargin: 20

        Text {
            text: StaffDriver.currentEmployee.username
            font.pixelSize: 15
            font.weight: 5
            font.family: "Roboto Light"
            color: "#FFFFFF"
            elide: Text.ElideMiddle
            Layout.alignment: Qt.AlignRight
        }

        Image {
            id: avatar
            source: "qrc:/StaffSystem/icons/account-circle.svg"
            width: 36
            height: 36
            sourceSize: Qt.size(width, height)
        }
    }
}
