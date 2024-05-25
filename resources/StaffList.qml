import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Layouts
import StaffSystem

ColumnLayout {
    id: root

    property var tableHeaderInfo: ["Id", "Username", "First Name", "Last Name", "Gender", "Age", "Academic Degree", "Manager", "Role", "More Info"]
    property var tableRows: StaffDriver.reportStaffList()
    property var rowCurrentIndex: 0

    property alias tableView: tableView
    property alias tableViewHeight: tableView.height
    property int itemsHeight: headerLbl.height + horizontalHeader.height

    property var currentUserRole: StaffDriver.currentEmployee.staffType

    Label {
        id: headerLbl
        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter
        Layout.fillWidth: true
        color: "#FFFFFF"
        font.pixelSize: 40
        font.bold: true
        Layout.bottomMargin: 50
        Layout.topMargin: 50
        objectName: "headerLbl"
        text: "Staff Database"
    }

    Button {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        Layout.preferredWidth: 200
        Layout.topMargin: 5
        Layout.leftMargin: 15

        leftPadding: 8
        rightPadding: 8
        topPadding: 8
        bottomPadding: 8
        font.pixelSize: 18
        text: "Add New Employee"
        visible: currentUserRole == 0 || currentUserRole == 1

        onClicked: staffAddPopup.open()
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
            implicitHeight: parent.height
            implicitWidth: parent.width / tableHeaderInfo.size

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
            TableModelColumn {
                display: "More Info"
            }
            rows: []
        }
        delegate: DelegateChooser {

            DelegateChoice {
                column: 9

                delegate: Item {
                    implicitWidth: tableView.width / tableView.columns
                    implicitHeight: childrenRect.height

                    Rectangle {

                        border.width: 1
                        anchors.fill: parent

                        color: "#A9E0E6"
                    }

                    Button {

                        anchors.centerIn: parent
                        text: " Details"
                        icon.source: "qrc:/StaffSystem/icons/more.svg"
                        onClicked: {
                            staffDetailsPopup.employeeId = tableView.model.rows[row].Id;
                            staffDetailsPopup.open();
                        }
                    }
                }
            }

            DelegateChoice {

                delegate: Item {
                    implicitWidth: tableView.width / tableView.columns
                    implicitHeight: childrenRect.height
                    Rectangle {

                        border.width: 1
                        anchors.fill: parent

                        color: "#A9E0E6"
                    }

                    Text {
                        id: dataCell

                        color: "#292E5F"
                        padding: 10
                        width: parent.width
                        wrapMode: Text.WordWrap
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter
                        text: model.display
                    }
                }
            }
        }

        ScrollBar.vertical: ScrollBar {
            id: tableVerticalBar
            policy: ScrollBar.AlwaysOn
        }
    }

    Component.onCompleted: {
        while (rowCurrentIndex < tableRows.length) {
            tableView.model.appendRow(tableRows[rowCurrentIndex]);
            rowCurrentIndex++;
        }
    }

    Connections {
        target: StaffDriver.staffList

        function onCountChanged() {
            tableRows = StaffDriver.reportStaffList();
            if (rowCurrentIndex < tableRows.length) {
                tableView.model.appendRow(tableRows[rowCurrentIndex]);
                StaffDriver.InsertStaffToDB(tableView.model.getRow(rowCurrentIndex).Id);
                rowCurrentIndex++;
            }
        }
    }

    StaffDetailsPopup {
        id: staffDetailsPopup

        height: parent.height - 20
        width: parent.width - 20
        anchors.centerIn: parent
    }

    StaffAddPopup {
        id: staffAddPopup

        height: parent.height - 100
        width: parent.width - 100
        anchors.centerIn: parent
    }
}
