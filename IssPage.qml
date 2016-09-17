import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Qt.labs.settings 1.0
import json.comunication 1.0

Page {
    id: sectionsPage
    //title: i18n.tr("Page with sections")

    header: PageHeader {
        id: issBottomEdgeHeader
        title: "International Space Station"
        StyleHints {
            backgroundColor: "transparent"
        }
    }

    BottomEdge {
        height: parent.height
        hint.text: "People in Space"
        BottomEdgeRegion {
            contentComponent: Page {
                width: sectionsPage.width
                height: sectionsPage.height
                header: PageHeader {
                    title: "People in Space"
                }

                ListView {
                    anchors.fill: parent
                    model: network_api_information.iss_people.length
                    delegate: ListItem.MultiValue {
                        text: network_api_information.iss_people[index]
                        iconName: "search"
                    }
                }
            }
        }
    }

    Image {
        anchors.fill: parent
        source: "Images/ISS_Spaceship.jpg"
    }


}
