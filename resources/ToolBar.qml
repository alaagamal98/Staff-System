import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import StaffSystem

Rectangle {
    id: root

    readonly property var plan: null
    property bool hasUndoStep: plan?.hasUndoStep ?? false
    property bool hasRedoStep: plan?.hasRedoStep ?? false
    property alias homeButtonVisible: home.visible

    implicitHeight: 30
    z: Infinity

    ButtonGroup {
        id: buttonGroup
    }

    RowLayout {
        anchors {
            left: parent.left
            leftMargin: 8
            verticalCenter: parent.verticalCenter
        }
        spacing: 10

        // separator
        Rectangle {
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            Layout.bottomMargin: 2

            color: "#DBE2EE"
        }

            Rectangle {
                id: unsavedIndicator

                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: 6
                    rightMargin: 6
                }

                height: 6
                width: height
                radius: width * 0.5
                color: "#FFB71C1C"
                visible: false
            }

        // separator
        Rectangle {
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            Layout.bottomMargin: 2

            color: "#DBE2EE"
        }

        // separator
        Rectangle {
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            Layout.bottomMargin: 2

            color: "#DBE2EE"
        }
    }

    RowLayout {
        anchors {
            right: parent.right
            rightMargin: 8
            verticalCenter: parent.verticalCenter
        }
        spacing: 10

        // separator
        Rectangle {
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            Layout.bottomMargin: 2

            color: "#DBE2EE"
       }
    }

    Shortcut {
        sequence: "Ctrl+Z"
        enabled: root.hasUndoStep
        context: Qt.ApplicationShortcut
        autoRepeat: false

        // onActivated: SystemDriver.undo()
    }

    Shortcut {
        sequence: "Ctrl+Y"
        enabled: root.hasRedoStep
        context: Qt.ApplicationShortcut
        autoRepeat: false

        // onActivated: SystemDriver.redo()
    }

    SettingsPopup {
        id: settingsPopup
    }
}
