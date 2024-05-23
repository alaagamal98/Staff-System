import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    id: root

    property alias titleText: titleText.text
    property alias titleColor: titleText.color
    property alias bodyText: bodyText.text

    property alias acceptText: acceptButton.text
    property alias rejectText: rejectButton.text
    property alias cancelText: cancelButton.text

    property alias acceptColor: acceptButton.outlinedColor
    property alias rejectColor: rejectButton.outlinedColor
    property alias cancelColor: cancelButton.outlinedColor

    property alias showAcceptButton: acceptButton.visible
    property alias showRejectButton: rejectButton.visible
    property alias showCancelButton: cancelButton.visible

    width: 384
    modal: true
    closePolicy: Popup.NoAutoClose

    anchors.centerIn: Overlay.overlay

    contentItem: ColumnLayout {
        anchors {
            topMargin: 8
            bottomMargin: 16
            leftMargin: 16
            rightMargin: 16
        }

        RowLayout {
            id: titleBar

            Layout.fillWidth: true
            Layout.preferredHeight: childrenRect.height
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom

            spacing: 2
        }
    }
}