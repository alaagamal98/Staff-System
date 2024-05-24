import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import StaffSystem

ColumnLayout {
    id: login

    Text {
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 20
        font.weight: Font.Bold
        color: "#FFFFFF"
        text: "Welcome"
    }

    Text {
        Layout.alignment: Qt.AlignHCenter
        Layout.topMargin: 10
        Layout.bottomMargin: 20
        font.pixelSize: 16
        font.weight: Font.Bold
        color: "#FFFFFF"
        text: "Login to your Siemens account"
    }

    TextField {
        id: usernameInput

        Layout.alignment: Qt.AlignHCenter
        Layout.preferredHeight: 45
        Layout.preferredWidth: 300
        verticalAlignment: Qt.AlignVCenter
        placeholderText: "Username"
        font.pixelSize: 16

        onTextEdited: LoginDriver.error = ""
    }

    TextField {
        id: passwordInput

        Layout.alignment: Qt.AlignHCenter
        Layout.preferredHeight: 45
        Layout.preferredWidth: 300
        verticalAlignment: Qt.AlignVCenter
        placeholderText: "Password"
        echoMode: TextInput.Password
        font.pixelSize: 16

        onTextEdited: LoginDriver.error = ""
    }

    Text {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        Layout.topMargin: 5
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 14
        wrapMode: Text.WordWrap
        color: "#DDB8B8"
        text: LoginDriver.error
    }

    Button {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.preferredWidth: 300
        Layout.topMargin: 5
        leftPadding: 8
        rightPadding: 8
        topPadding: 8
        bottomPadding: 8
        font.pixelSize: 18
        text: "Login"
        enabled: usernameInput.text.length !== 0 && passwordInput.text.length !== 0

        onClicked: LoginDriver.login(usernameInput.text.trim(), passwordInput.text.trim())
    }
}
