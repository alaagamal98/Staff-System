import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform as Platform

import StaffSystem

ListView {
    id: root

    readonly property color itemSelectedColor: "#292929"

    focus: true
    clip: true
    currentIndex: -1
    interactive: false
    spacing: 5
    visible: count > 0
    implicitHeight: contentHeight
    model: StaffDriver.modelList

    highlight: Rectangle {
        radius: 4
        color: "#4A75E8"
        opacity: 0.3
    }

    delegate: Rectangle {
        readonly property bool delegateHovered: content.contentHovered

        width: root.width
        height: 32
        clip: true
        color: model.selected ? root.itemSelectedColor : "transparent"
        border.width: model.selected ? 1 : 0
        border.color: "#4A75E8"
        radius: 4

        onDelegateHoveredChanged: {
            if (delegateHovered)
                root.currentIndex = model.index
            else if (root.currentIndex === model.index)
                root.currentIndex = -1
        }

        RowLayout {
            id: content

            readonly property bool contentHovered: textMouseArea.containsMouse || visibilityBtn.hovered

            anchors.fill: parent
            spacing: 0

            Item {
                Layout.leftMargin: 8
                Layout.rightMargin: 8
                Layout.preferredHeight: parent.height
                Layout.fillWidth: true

                Rectangle {
                    id: colorIndicator

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                    }
                    width: 12
                    height: 12
                    radius: 4
                    color: model.color

                    Rectangle {
                        anchors.centerIn: parent
                        width: 4
                        height: 4
                    }
                }

                MouseArea {
                    id: textMouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked: function (mouse) {
                        if (mouse.button === Qt.RightButton) {
                            optionsMenu.x = mouse.x
                            optionsMenu.y = mouse.y
                            optionsMenu.popup()
                        } else if (mouse.button === Qt.LeftButton) {
                            // multi-selection
                            if (mouse.modifiers & Qt.ControlModifier) {
                                if (model.index < privates.topIndex)
                                    privates.topIndex = model.index
                                else
                                    privates.bottomIndex = model.index

                                // toggle selection
                                StaffDriver.setSelected(model.id, !model.selected)

                                // make the model visible if it is selected, note that the model can't
                                // be in a selected state AND invisible, so only one check suffices
                                if (model.visible === false)
                                    StaffDriver.setVisible(model.id, true)

                            // ranged-selection
                            } else if (mouse.modifiers & Qt.ShiftModifier) {
                                if (model.index < privates.topIndex)
                                    privates.topIndex = model.index
                                else
                                    privates.bottomIndex = model.index

                                // select all models between top and bottom index
                                StaffDriver.setMultipleSelected(privates.topIndex, privates.bottomIndex + 1, true)
                            // single-selection
                            } else {
                                privates.topIndex = model.index
                                privates.bottomIndex = model.index

                                if (!model.selected) {
                                    StaffDriver.setSelected(model.id, true)

                                    // make the model visible if it is selected
                                    if (model.visible === false)
                                        StaffDriver.setVisible(model.id, true)
                                }

                                // deselect all models except the selected one at model.index
                                StaffDriver.setMultipleSelected(0, model.index, false)
                                StaffDriver.setMultipleSelected(model.index + 1, count, false)
                            }
                        }
                    }
                    onDoubleClicked: function (mouse) {
                        nameTextField.forceActiveFocus()
                        nameTextField.selectAll()
                    }
                }
            }
        }
    }

    QtObject {
        id: privates

        // used in model list to indicate selection range
        property int topIndex: root.count - 1
        property int bottomIndex: 0
    }
}
