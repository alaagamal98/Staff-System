import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import StaffSystem
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

    ColumnLayout {
        id: content

        anchors.fill: parent
        spacing: 0

        RowLayout {
            id: titleBar

            Layout.fillWidth: true
            Layout.margins: 20
            Layout.alignment: Qt.AlignTop

            Text {
                id: employeeName
                Layout.fillWidth: true
                font.pixelSize: 30
                font.bold: true
                text: employee.firstName + " " + employee.lastName
                color: "#292E5F"
            }

            Button {
                id: closeBtn

                text: " Close"
                implicitWidth: 80
                implicitHeight: 25
                Layout.alignment: Qt.AlignRight
                icon.source: "qrc:/StaffSystem/icons/close.svg"

                onClicked: _root.close()
            }
        }
    }
}
