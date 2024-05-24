import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Layouts
import StaffSystem

ColumnLayout {
    id: root

    property var tableHeaderInfo: ["Id", "Username", "First Name", "Last Name", "Email", "Gender", "Age", "Photo", "Academic Degree", "Manager", "Role"]
    property var tableRows: StaffDriver.reportStaffList()
    property var rowCurrentIndex: 0

    property alias tableView: tableView
    property alias tableViewHeight: tableView.height
    property int itemsHeight: headerLbl.height + horizontalHeader.height + 50 // margins

    spacing: 20

    Label {
        id: headerLbl

        objectName: "headerLbl"
        Layout.fillWidth: true
        text: "Staff Database"
    }

    HorizontalHeaderView {
        id: horizontalHeader

        objectName: "horizontalHeader"
        Layout.fillWidth: true
        Layout.bottomMargin: -15
        syncView: tableView
        clip: true

        delegate: Label {
            text: root.tableHeaderInfo[index]
        }
    }

    TableView {
        id: tableView

        objectName: "tableView"
        Layout.fillWidth: true
        Layout.preferredHeight: Math.max(1, childrenRect.height)
        interactive: false

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
                display: "Photo"
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
                anchors {
                    top: rowSeparator.bottom
                }
                topPadding: 10
                bottomPadding: 10
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
			tableRows = StaffDriver.reportStaffList()

            if (rowCurrentIndex < tableRows.length) {
                tableView.model.appendRow(tableRows[rowCurrentIndex]);
                rowCurrentIndex++;
            }
        }
    }
}