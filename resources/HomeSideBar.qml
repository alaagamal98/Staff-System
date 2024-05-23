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

        anchors.fill: parent

        Connections {
            target: LoginDriver

            function onStateChanged(state) {
                if (state === LoginDriver.StateLoggedIn) {
                    loginView.source = "qrc:/StaffSystem/resources/UserItem.qml"
                } else if (state === LoginDriver.StateLoggedOut) {
                    loginView.source = "qrc:/StaffSystem/resources/LoginItem.qml"
                }
            }
        }

        Image {
            Layout.alignment: Qt.AlignTop
            sourceSize.width: 300
            fillMode: Image.PreserveAspectFit
            source: "qrc:/StaffSystem/icons/siemens.svg"
        }

        Loader {
            id: loginView

            source: LoginDriver.state === LoginDriver.StateLoggedIn ? "qrc:/StaffSystem/resources/UserItem.qml" : "qrc:/StaffSystem/resources/LoginItem.qml"

            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            Layout.leftMargin: 12
            Layout.rightMargin: 12
        }
    }
}
