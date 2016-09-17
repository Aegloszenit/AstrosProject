import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Qt.labs.settings 1.0
import json.comunication 1.0


/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "astros.aegloszenit"

    width: units.gu(100)
    height: units.gu(75)

    id: theRoot

    theme.name: settings.theme
    Component.onDestruction: {
        settings.theme = theRoot.theme.name
    }

    Settings {
        id: settings
        property string theme: "Ubuntu.Components.Themes.Ambiance"
    }
    ApodRequests {
        id: network_api_information
    }

    AdaptivePageLayout {
        id: layout
        anchors.fill: parent
        primaryPage: rootPage

        layouts: [
            // configure two columns
            PageColumnsLayout {
                when: layout.width > units.gu(80)
                PageColumn {
                    minimumWidth: units.gu(20)
                    maximumWidth: units.gu(60)
                    preferredWidth: units.gu(40)
                }
                PageColumn {
                    fillWidth: true
                }
            },
            // configure minimum size for single column
            PageColumnsLayout {
                when: true
                PageColumn {
                    minimumWidth: units.gu(20)
                    fillWidth: true
                }
            }
        ]

        MainPageDescription {
            id: rootPage
        }

        Page {
            id: leftPage
        }

        ApodPage {
            id: rightPage

        }
        MarsPage {
            id: marsPage

        }

        IssPage {
            id: sectionsPage
        }
    }
}
