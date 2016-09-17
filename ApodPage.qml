
import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.DownloadManager 1.2
import Ubuntu.Components.Pickers 1.3
import json.comunication 1.0


Page {
    id: apodPage
    anchors.fill: parent

    header: PageHeader {
        id: apodHeader
        title: network_api_information.title

        trailingActionBar {
            actions: [
                Action {
                    id: theSearchction
                    iconName: "search"
                    onTriggered: {
                        PopupUtils.open(pickerDialog)
                    }
                },
                Action {
                    iconName: "document-save"
                    onTriggered: {
                        PopupUtils.open(dialog)
                        theProgressBar.visible = true

                    }
                }

            ]
        }
    }
    Item {
        width: units.gu(80)
        height: units.gu(80)
        Component {
            id: dialog
            Dialog {
                id: dialogue
                title: "Save file"
                text: "Are you sure that you want to save this file?"
                Button {
                    text: "cancel"
                    onClicked: {
                        theProgressBar.visible = false
                        PopupUtils.close(dialogue)
                    }
                }
                Button {
                    text: "Save normal quality photo"
                    color: UbuntuColors.orange
                    onClicked: {
                        singleDownload.download(network_api_information.image)
                        PopupUtils.close(dialogue)
                    }
                }
                Button {
                    text: "Save HD quality"
                    color: UbuntuColors.orange
                    onClicked: {
                        singleDownload.download(network_api_information.image_hd)
                        PopupUtils.close(dialogue)
                    }
                }
            }
        }
    }
    Item {
        width: units.gu(80)
        height: units.gu(80)
        Component {
            id: pickerDialog
            Dialog {
                id: pickerdialogue
                title: "Older APODs"
                text: "Find older astronomical pictures"
                DatePicker {
                    id: olderApodPhotos
                    minimum: {
                        return "1995-01-01";
                    }

                    maximum: {
                        var d = new Date();
                        return d;
                    }
                }

                Button {
                    text: "cancel"
                    onClicked: PopupUtils.close(pickerdialogue)
                }
                Button {
                    text: "Go to Date"
                    color: UbuntuColors.orange
                    onClicked: {

                        var change_date = Qt.formatDate(olderApodPhotos.date, "yyyy-MM-dd")
                        network_api_information.setSearch_older_photos(change_date)
                        PopupUtils.close(pickerdialogue)

                    }
                }
            }
        }
    }

    ProgressBar {
        id: theProgressBar
        visible: false

        width: parent.width
        minimumValue: 0
        maximumValue: 100
        value: singleDownload.progress
        z: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: units.gu(2)

    }

    SingleDownload {
        id: singleDownload
        metadata: Metadata {
            showInIndicator: true
            title: "APOD Download"
        }

        onFinished: {
            console.log("done " + path)
            theProgressBar.visible = false
        }
    }

    ListView {
        anchors {
            top: apodHeader.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
        clip: true
        //boundsBehavior: flickable.StopAtBounds
        model: 1
        delegate: Rectangle {
            width: parent.width
            height: childrenRect.height + units.gu(4)
            color: "transparent"
            state: network_api_information.media_type

            states: [
                State {
                    name: "image"
                    PropertyChanges {
                        target: apodElementLoader
                        source: "ImageMediaType.qml"

                    }
                },
                State {
                    name: "video"
                    PropertyChanges {
                        target: apodElementLoader
                        source: "VideoMediaType.qml"

                    }
                }
            ]
            Loader {
                id: apodElementLoader
                //source: "ImageMediaType.qml"
                source: "VideoMediaType.qml"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: units.gu(2)


            }
            Label {
                id: explanationText
                anchors.top: apodElementLoader.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: units.gu(3)
                text: network_api_information.explanation
                wrapMode: Text.WordWrap

            }
        }
    }










}
