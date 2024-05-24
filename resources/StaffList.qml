import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Layouts
import StaffSystem

ColumnLayout {
    id: root

    property var tableHeaderInfo: ["Id", "Username", "First Name", "Last Name", "Email", "Gender", "Age", "Academic Degree", "Manager", "Role"]
    property var tableRows: StaffDriver.reportStaffList()
    property var rowCurrentIndex: 0

    property alias tableView: tableView
    property alias tableViewHeight: tableView.height
    property int itemsHeight: headerLbl.height + horizontalHeader.height

    Label {
        id: headerLbl
        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter
        Layout.fillWidth: true
        color: "#FFFFFF"
        font.pixelSize: 20
        font.bold: true
        Layout.bottomMargin: 50
        Layout.topMargin: 50
        objectName: "headerLbl"
        text: "Staff Database"
    }

    HorizontalHeaderView {
        id: horizontalHeader

        objectName: "horizontalHeader"
        Layout.fillWidth: true
        syncView: tableView
        clip: true
        Layout.preferredHeight: 50

        delegate: Rectangle {
            border.width: 1
            color: "#A9E0E6"
            Label {
                text: root.tableHeaderInfo[index]
                padding: 10
                color: "#292E5F"
                font.bold: true
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                anchors.centerIn: parent
            }
        }
    }

    TableView {
        id: tableView

        objectName: "tableView"
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        Layout.preferredHeight: 40
        Layout.fillWidth: true
        Layout.fillHeight: true

        model: TableModel {
            TableModelColumn {
                display: "Id"
            }
            TableModelColumn {
                display: "Username"
            }
            TableModelColumn {
                display: "First Name"
            }
            TableModelColumn {
                display: "Last Name"
            }
            TableModelColumn {
                display: "Email"
            }
            TableModelColumn {
                display: "Gender"
            }
            TableModelColumn {
                display: "Age"
            }
            TableModelColumn {
                display: "Academic Degree"
            }
            TableModelColumn {
                display: "Manager"
            }
            TableModelColumn {
                display: "Role"
            }
            rows: []
        }

        delegate: Item {
            implicitWidth: tableView.width / tableView.columns
            implicitHeight: childrenRect.height

            Rectangle {

                border.width: 1
                anchors.fill: parent

                color: "#A9E0E6"
            }

            Label {
                id: dataCell
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                color: "#292E5F"
                padding: 10
                width: parent.width
                wrapMode: Text.WordWrap
                text: model.display
            }
        }
    }

    Component.onCompleted: {
        while (rowCurrentIndex < tableRows.length) {
            tableView.model.appendRow(tableRows[rowCurrentIndex]);
            rowCurrentIndex++;
        }
    }

    Connections {
        target: StaffList

        function onCountChanged() {
            tableRows = StaffDriver.reportStaffList();
            if (rowCurrentIndex < tableRows.length) {
                tableView.model.appendRow(tableRows[rowCurrentIndex]);
                rowCurrentIndex++;
            }
        }
    }
}
