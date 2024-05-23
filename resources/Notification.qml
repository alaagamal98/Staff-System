import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    enum MessageType {
        // Useful information that users should know, often non-critical
        Info,
        // Helpful advice for doing things better or more easily
        Tip,
        // Key information users need to know to achieve their goal
        Note,
        // Urgent info that needs immediate user attention to avoid problems
        Warning,
        // Indicates successful completion of an action or process
        Success,
        // Indicates an error or failure that occurred during an action or process
        Error
    }

    required property int messageType
    property int lifeTime: (messageType !== Notification.Error) ? Globals.notificationLifeTime : Globals.maxInteger
    property alias titleText: title.text
    property alias bodyText: body.text

    signal closeClicked
    signal timeout

    implicitWidth: 448
    implicitHeight: 96
    radius: 8

    color: {
        switch (root.messageType) {
        case Notification.Info:
            return "#E4ECFE"
        case Notification.Tip:
            return "#E7FFF2"
        case Notification.Note:
            return "#E5FCFF"
        case Notification.Success:
            return "#E5FFF1"
        case Notification.Warning:
            return "#FFF6E6"
        case Notification.Error:
            return "#FFE9E5"
        default:
            return "#E4ECFE"
        }
    }

    Image {
        id: icon

        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 16
        }

        fillMode: Image.PreserveAspectFit
        source: {
            switch (root.messageType) {
            case Notification.Info:
                return "qrc:/StaffSystem/icons/info.svg"
            case Notification.Tip:
                return "qrc:/StaffSystem/icons/tip.svg"
            case Notification.Note:
                return "qrc:/StaffSystem/icons/note.svg"
            case Notification.Success:
                return "qrc:/StaffSystem/icons/success.svg"
            case Notification.Warning:
                return "qrc:/StaffSystem/icons/warning.svg"
            case Notification.Error:
                return "qrc:/StaffSystem/icons/error.svg"
            default:
                return "qrc:/StaffSystem/icons/info.svg"
            }
        }
    }

    ColumnLayout {
        anchors {
            left: icon.right
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 16
        }

        Text {
            id: title

            Layout.fillWidth: true
            Layout.rightMargin: 16

            maximumLineCount: 1
            elide: Text.ElideRight
            font.pixelSize: 16
            font.bold: true

            color: {
                switch (root.messageType) {
                case Notification.Info:
                    return "#4A75E8"
                case Notification.Tip:
                    return "#00BFA5"
                case Notification.Note:
                    return "#00B8D4"
                case Notification.Success:
                    return "#009245"
                case Notification.Warning:
                    return "#E08E00"
                case Notification.Error:
                    return "#CF0009"
                default:
                    return "#4A75E8"
                }
            }
        }

        Text {
            id: body

            Layout.fillWidth: true
            Layout.rightMargin: 8

            maximumLineCount: 2
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            opacity: 0.8


            color: {
                switch (root.messageType) {
                case Notification.Info:
                    return "#4A75E8"
                case Notification.Tip:
                    return "#00BFA5"
                case Notification.Note:
                    return "#00B8D4"
                case Notification.Success:
                    return "#009245"
                case Notification.Warning:
                    return "#E08E00"
                case Notification.Error:
                    return "#CF0009"
                default:
                    return "#4A75E8"
                }
            }
        }
    }

    Timer {
        id: timer

        interval: root.lifeTime
        running: true

        onTriggered: root.timeout()
    }
}
