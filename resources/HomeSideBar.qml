import QtCore
import QtQuick
import QtQuick.Dialogs
import QtQuick.Layouts
import StaffSystem

Rectangle {
    id: root

    color: "#767995"

    ColumnLayout {
        id: homeSideBarLayout

        Layout.fillWidth: true

        Connections {
            target: LoginDriver

            function onStateChanged(state) {
                if (state === LoginDriver.StateLoggedIn) {
                    loginView.source = "qrc:/StaffSystem/resources/UserItem.qml";
                } else if (state === LoginDriver.StateLoggedOut) {
                    loginView.source = "qrc:/StaffSystem/resources/LoginItem.qml";
                }
            }
        }

        Loader {
            id: loginView

            source: LoginDriver.state === LoginDriver.StateLoggedIn ? "qrc:/StaffSystem/resources/UserItem.qml" : "qrc:/StaffSystem/resources/LoginItem.qml"

            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
            Layout.fillWidth: true
        }
    }
}
