import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Qt.labs.settings 1.0

Image {
    id: apodImage
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: units.gu(2)
    fillMode: Image.PreserveAspectFit
    source: network_api_information.image

}
