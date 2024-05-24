import QtQuick
import QtQuick.Layouts
import StaffSystem

RowLayout {
    id: homePage

    spacing: 0

    HomeSideBar {
        id: homeSideBar

        Layout.maximumWidth: 330
        Layout.preferredWidth: 330
        Layout.fillHeight: true
    }

    Loader {
        id: tableView

        source: LoginDriver.state === LoginDriver.StateLoggedIn ? "qrc:/StaffSystem/resources/StaffList.qml" : "qrc:/StaffSystem/resources/LoadingPage.qml"
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
    Rectangle {
        Layout.preferredWidth: 2
        Layout.fillHeight: true

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#080A21"
            }
            GradientStop {
                position: 1.0
                color: "#767995"
            }
        }
    }
}
