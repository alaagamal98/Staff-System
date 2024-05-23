pragma Singleton

import QtQml
import QtQuick
import QtQuick.Dialogs

import StaffSystem

QtObject {
    id: root

    enum Page {
        Home,
        Plan
    }

    enum WindowState {
        Hidden,
        Minimized,
        Middle,
        Maximized
    }

    // Used as a parent for dynamically created dialogs
    property Window window: null
    readonly property int notificationLifeTime: 1000 * 6
    readonly property int maxInteger: 2 * 1000 * 1000 * 1000


    readonly property Component fileDialogComponent: FileDialog {
        // dummy signal for `dialogAsPromise` to connect to
        //
        // NOTE: the signal is not fired in order to to keep the dialog alive
        // in case it is needed (e.g., to access its `selectedFile`); you should
        // manually destroy the created dialog when you are done with it
        signal closed
    }

    signal pageChanged(int page)
    signal progressStarted(string message)
    signal progressUpdated(real percent)
    signal progressFinished()
    signal notificationSent(int messageType, string titleText, string bodyText)

    function goToPage(page) {
        pageChanged(page)
    }

    function startProgress(message) {
        progressStarted(message)
    }

    function finishProgress() {
        progressFinished()
    }

    function sendNotificationInfo(bodyText, titleText = "Info") {
        notificationSent(Notification.MessageType.Info, titleText, bodyText)
    }

    function sendNotificationTip(bodyText, titleText = "Tip") {
        notificationSent(Notification.MessageType.Tip, titleText, bodyText)
    }

    function sendNotificationNote(bodyText, titleText = "Note") {
        notificationSent(Notification.MessageType.Note, titleText, bodyText)
    }

    function sendNotificationWarning(bodyText, titleText = "Warning") {
        notificationSent(Notification.MessageType.Warning, titleText, bodyText)
    }

    function sendNotificationSuccess(bodyText, titleText = "Success") {
        notificationSent(Notification.MessageType.Success, titleText, bodyText)
    }

    function sendNotificationError(bodyText, titleText = "Error") {
        notificationSent(Notification.MessageType.Error, titleText, bodyText)
    }

    function savePlan(showProgress = true) {
    }

    function confirmUnsavedChanges() {
    }

    function closeRunningOperation() {
        if (ProgressDriver.hasRunningOperations()) {
            return dialogAsPromise(runningOperationDialogComponent)
        } else {
            return Promise.resolve()
        }
    }

    function closeActivePlan() {
        // TOOD(adas): close active plan, we now return resolved promise to be able to close
        return Promise.resolve()
    }

    // TODO: add error icon to the message as a visual distinction
    function showErrorDialog(error) {
        return dialogAsPromise(errorMessageDialogComponent, {"bodyText": error})
    }

    // Make a promise wrapper around cute::Progress
    function asPromise(progress) {
        return new Promise((resolve, reject) => {
            if (progress) {
                progress.percentChanged.connect(value => progressUpdated(value / 100.0))
                progress.success.connect(resolve)
                progress.failure.connect(reason => reject(reason))
            } else {
                reject("progress is null")
            }
        })
    }

    // Make a promise wrapper around a dynamically constructed dialog
    // NOTE: in case dialog rejection is possible, it will propagate as an error if you do not handle it
    function dialogAsPromise(component, properties = {}) {
        let dialog = component.createObject(root.window, properties)
        dialog.open()

        return new Promise((resolve, reject) => {
            dialog.accepted.connect(() => resolve(dialog))
            dialog.rejected.connect(() => reject(dialog))
            dialog.closed.connect(dialog.destroy)
        })
    }
}
