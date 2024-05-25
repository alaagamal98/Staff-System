import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import StaffSystem

Popup {
    id: _root

    objectName: "staffAddPopup"
    padding: 0
    closePolicy: Popup.NoAutoClose

    RowLayout {
        id: headerRow

        anchors {
            left: parent.left
            verticalCenter: closeBtn.verticalCenter
            leftMargin: 15
        }
        spacing: 10

        Label {
            id: cardNumber

            objectName: "cardNumber"
            text: {
                if (!_root.opened)
                    return ""
            }
            color: "#616978"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
        }
    }

    Button {
        id: closeBtn

        anchors {
            top: parent.top
            right: parent.right
            topMargin: 15
            rightMargin: 15
        }
        text: "Close"
        implicitWidth: 20
        implicitHeight: 25
    	icon.source: "qrc:/StaffSystem/icons/close.svg"

        onClicked: _root.close()
    }

}
