import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import StaffSystem

Item {
    id: root
    implicitWidth: userRowContent.implicitWidth
    implicitHeight: userRowContent.implicitHeight

    RowLayout {
        id: userRowContent
        anchors.fill: parent

        Image {
            id: avatar
            source: "qrc:/StaffSystem/icons/account-circle.svg"
            width: 36
            height: 36
            sourceSize: Qt.size(width, height)
        }

        ColumnLayout {
            Text {
                text: StaffDriver.currentEmployee.username
                font.pixelSize: 12
                font.weight: 2
                font.family: "Roboto Light"
                color: "#333333"
                elide: Text.ElideMiddle
                Layout.fillWidth: true
            }
        }

        Button {
            icon.source: "qrc:/StaffSystem/icons/logout.svg"
            onClicked: LoginDriver.logout()
        }
    }
}
