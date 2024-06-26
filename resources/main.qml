import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Window
import StaffSystem

ApplicationWindow {
    id: root

    readonly property real aspectRatio: 16 / 9
    property int windowWidth: 1024
    property int windowHeight: windowWidth / aspectRatio

    title: `Siemens Staff System`
    visibility: Window.Maximized
    minimumWidth: 0.5 * Screen.width
    minimumHeight: minimumWidth / aspectRatio
    height: windowHeight
    width: windowWidth
    x: (Screen.width - windowWidth) / 2
    y: (Screen.height - windowHeight) / 2

    background: Rectangle {
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

    SwipeView {
        id: pageLayout

        anchors.fill: parent

        currentIndex: 0
        interactive: false

        HomePage {
            id: homePage
        }

        LoadingPage {
            id: loadingPage
        }
    }
}
