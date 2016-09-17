import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Qt.labs.settings 1.0
import json.comunication 1.0

Page {

    header: PageHeader {
        id: marsHeaderPage
        title: "Curiosity, Opportunity, Spirit"
    }

    ListView {
        anchors.top: marsHeaderPage.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: units.gu(2)
        model: network_api_information.curiosity_photos.length
        delegate: Rectangle {
            width: parent.width
            height: units.gu(40)

            Image {
                anchors.fill: parent
                anchors.margins: units.gu(2)
                fillMode: Image.PreserveAspectFit
                source: network_api_information.curiosity_photos[index]
            }
        }
    }


}
