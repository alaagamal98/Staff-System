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

        delegate: Label {
            text: root.tableHeaderInfo[index]
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            color: "#FFFFFF"
            font.bold: true
            topPadding: 10
            bottomPadding: 10
        }
    }

    TableView {
        id: tableView

        objectName: "tableView"
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 50

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
                id: rowSeparator

                anchors {
                    top: parent.top
                    topMargin: 5
                }
                width: parent.width
                height: 2
                color: "#DBE2EE"
            }

            Label {
                id: dataCell
                anchors {
                    top: rowSeparator.bottom
                }
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                color: "#FFFFFF"
                padding: 10
                width: parent.width
                wrapMode: Text.WordWrap
                text: model.display
            }

            Rectangle {
                id: columnSeperator

                anchors {
                    left: dataCell.right
                    leftMargin: 5
                }
                height: parent.height
                width: 2
                color: "#DBE2EE"
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
