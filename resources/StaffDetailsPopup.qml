import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import StaffSystem

Popup {
    id: _root

    property var employeeId
    property var employee: StaffDriver.staffList.getStaff(employeeId)

    objectName: "staffDetailsPopup"
    padding: 0
    closePolicy: Popup.NoAutoClose

    RowLayout {
        id: headerRow

        anchors {
            left: parent.left
            verticalCenter: closeBtn.verticalCenter
            leftMargin: 15
        }
        spacing: 10

        Label {
            id: name

            objectName: "cardNumber"
            text: employee.firstName + " " + employee.lastName
            color: "#616978"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Button {
        id: closeBtn

        anchors {
            top: parent.top
            right: parent.right
            topMargin: 15
            rightMargin: 15
        }
        text: "Close"
        implicitWidth: 20
        implicitHeight: 25
    	icon.source: "qrc:/StaffSystem/icons/close.svg"

        onClicked: _root.close()
    }

}
