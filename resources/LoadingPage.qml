import QtQuick
import QtQuick.Layouts

Item {
    id: root

    ColumnLayout {
        anchors.centerIn: parent

        spacing: 16

        Image {
            sourceSize.width: 512
            source: "qrc:/StaffSystem/icons/wide.svg"
            fillMode: Image.PreserveAspectFit
        }

        RowLayout {
            spacing: 8
        }
    }
}
