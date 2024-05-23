import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material.impl as QQuickMaterial

import StaffSystem

Button {
    id: root

    property string buttonText: "Add"

    implicitWidth: contentItem.implicitWidth
    implicitHeight: contentItem.implicitHeight
    opacity: enabled ? 1 : 0.3

    contentItem: RowLayout {
        anchors.centerIn: root
        spacing: 4

        Text {
            Layout.leftMargin: 6
            Layout.bottomMargin: 2
            verticalAlignment : Text.AlignVCenter
            text: root.buttonText
            font.pixelSize: 14
            font.weight: Font.DemiBold
            color: "#4A75E8"
        }

        Image {
            Layout.alignment: Qt.AlignRight
            Layout.preferredHeight: 20
            Layout.preferredWidth: 20
            Layout.rightMargin: 6
            Layout.topMargin: 2
            Layout.bottomMargin: 2
            source: root.hovered ? "qrc:/StaffSystem/icons/plus-circle-on.svg" : "qrc:/StaffSystem/icons/plus-circle.svg"
            transform: Rotation {
                origin.x: 10
                origin.y: 10
                angle: root.hovered ? 90 : 0

                 Behavior on angle {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.Linear
                    }
                }
            }
        }
    }

    background: Rectangle {
        anchors.fill: root
        radius: 24
        color: root.hovered ? privates.backgroundHoveredColor : "transparent"

        QQuickMaterial.Ripple {
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            pressed: root.pressed
            anchor: root
            active: root.down || root.visualFocus || root.hovered
            color: root.pressed ? "#0C000000" : "transparent"
            clipRadius: parent.radius
            clip: true
        }
    }

    QtObject {
        id: privates

        readonly property color backgroundHoveredColor: "#292929"
    }
}
