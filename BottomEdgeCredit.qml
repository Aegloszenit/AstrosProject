import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Qt.labs.settings 1.0

Page {
    id: creditsPage
    width: theBottomEdge.width
    height: theBottomEdge.height
    header: PageHeader {
        id: headerAppDescription
        title: "Astros App Description"
        extension: Sections {
            actions: [
                Action {
                    id: theAppDescription
                    text: "App"
                    onTriggered: {
                        creditsPage.state = "app"
                    }
                },
                Action {
                    id: theAppCredits
                    text: "Credits"
                    onTriggered: {
                        creditsPage.state = "credits"
                    }
                }

            ]
        }
    }

    state: "app"


    // App description Component

    Item {
        anchors.fill: parent

        Label {
            anchors.top:  headerAppDescription.bottom
            anchors.horizontalCenter: appDecriptionContainer.horizontalCenter
            text: "Astros"
        }

    }

}
