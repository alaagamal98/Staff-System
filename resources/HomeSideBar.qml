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
                    loginView.source = "qrc:/StaffSystem/resources/UserItem.qml"
                } else if (state === LoginDriver.StateLoggedOut) {
                    loginView.source = "qrc:/StaffSystem/resources/LoginItem.qml"
                }
            }
        }

        Image {
            id: logo
            verticalAlignment: Qt.AlignTop
            horizontalAlignment: Qt.AlignHCenter
            sourceSize.width: 330
            fillMode: Image.PreserveAspectFit
            source: "qrc:/StaffSystem/icons/siemens.svg"
        }

        Rectangle {
            anchors {
                top: logo.bottom
                left: parent.left
                right: parent.right
                topMargin: 10
                leftMargin: 20
                rightMargin: 20
            }
            color: "#FFFFFF"
            height: 2
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
