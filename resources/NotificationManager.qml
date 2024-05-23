import QtQuick
import QtQuick.Controls


ListView {
    id: root

    implicitWidth: 448
    boundsBehavior: Flickable.StopAtBounds
    clip: true
    verticalLayoutDirection: ListView.BottomToTop
    spacing: 4
    interactive: false
    model: ListModel {
        id: modelList
    }

    add: Transition {
        NumberAnimation {
            property: "x"
            from: 1000
            duration: 256
        }
    }

    displaced: Transition {
        NumberAnimation {
            property: "y"
            duration: 256
        }
    }

    remove: Transition {
        NumberAnimation {
            property: "x"
            to: 1000
            duration: 256
        }
    }

    delegate: Notification {
        required property var model

        messageType: model.messageType
        titleText: model.titleText
        bodyText: model.bodyText

        onCloseClicked: {
            modelList.remove(model.index)
        }

        onTimeout: {
            modelList.remove(model.index)
        }
    }

    function send(messageType, titleText, bodyText) {
        modelList.insert(0, {"titleText": titleText, "bodyText": bodyText, "messageType": messageType})
    }
}
