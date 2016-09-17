import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import json.comunication 1.0
import "Images"
import Qt.labs.settings 1.0

Page {
    id: rootPage

    header: PageHeader {
        id: thePageHeader
        title: "Astros"

        StyleHints {
            //backgroundColor: "transparent"
            //foregroundColor: theRoot.theme.name == "Ubuntu.Components.Themes.SuruDark"? "yellow" : "red"
            //backgroundColor: "white"
            //dividerColor: theRoot.theme.name == "Ubuntu.Components.Themes.SuruDark"? "yellow" : "red"

        }
        Settings {
            property alias name: modeChanger.iconName
            property alias text: modeChanger.text
        }

        trailingActionBar {
            actions: [
                Action {
                    iconName: "info"
                    text: "App Info"
                    onTriggered: {
                        theBottomEdge.commit()
                    }
                },
                Action {
                    id: modeChanger
                    iconName: "night-mode"
                    text: "Night Mode"
                    onTriggered: {
                        if (theRoot.theme.name == "Ubuntu.Components.Themes.SuruDark") {
                            theRoot.theme.name = "Ubuntu.Components.Themes.Ambiance"
                            modeChanger.text = "Night Mode"
                            modeChanger.iconName = "night-mode"

                        }
                        else {
                            theRoot.theme.name = "Ubuntu.Components.Themes.SuruDark"
                            modeChanger.text = "Day Mode"
                            modeChanger.iconName = "torch-on"
                        }

                    }
                }


            ]
            numberOfSlots: 1
        }




    }
    BottomEdge {
        id: theBottomEdge
        height: parent.height
        hint.text: "About this App"

        state: "about"

        contentComponent: Page {
            id: bottompageRegion
            width: rootPage.width
            height: rootPage.height

            header: PageHeader {
                id: bottomheaderregion
                title: "About this App"

                extension: Sections {
                    actions: [
                        Action {
                            id: aboutCredit
                            text: "About"
                            onTriggered: {
                                theBottomEdge.state = "about"
                            }
                        },
                        Action {
                            id: creditCredit
                            text: "Credits"
                            onTriggered: {
                                theBottomEdge.state = "credits"
                            }
                        }

                    ]
                }

            }



            Label {
                id: nameOftheapp
                visible: theBottomEdge.state === "about" ? true : false
                anchors {
                    top: bottomheaderregion.bottom
                    horizontalCenter: bottompageRegion.horizontalCenter
                }
                font.pixelSize: units.gu(8)
                text: "Astros"
            }
            Label {
                id: versionOfTheApp
                visible: theBottomEdge.state === "about" ? true : false
                anchors {
                    top: nameOftheapp.bottom
                    topMargin: units.gu(8)
                    horizontalCenter: bottompageRegion.horizontalCenter
                }
                text: "version 0.5"

            }

            ListModel {
                id: modelCredits

                ListElement {
                    name: "Apod Webpage"
                    urlexternal: "http://apod.nasa.gov/apod/astropix.html"
                }
                ListElement {
                    name: "Code"
                    urlexternal: "https://github.com/Aegloszenit/AstrosProject/upload/master"
                }
            }

            ListView {
                model: modelCredits
                anchors {
                    top: bottomheaderregion.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                visible: theBottomEdge.state === "credits" ? true : false
                delegate: ListItem.Standard {
                    text: name
                    onClicked: {
                        Qt.openUrlExternally(urlexternal)
                    }
                }
            }
        }
    }

    Column {
        anchors {
            top: thePageHeader.bottom
            left: parent.left
            right: parent.right
        }
        spacing: units.gu(1)

        ListItem.MultiValue {


            iconSource: "Images/Astros_Icon.png"
            text: "APOD"
            values: ["Astronomical Picture of the day"]
            onClicked: layout.addPageToNextColumn(rootPage, rightPage)
        }

        ListItem.MultiValue {


            iconSource: "Images/Astros_Icon.png"
            text: "MARS"
            values: ["Opportunity", "Curiosity", "Spirit"]
            onClicked: layout.addPageToNextColumn(rootPage, marsPage)
        }

        ListItem.MultiValue {


            iconSource: "Images/ISS_Spaceship.jpg"
            text: "ISS"
            values: ["International Space Station"]
            onClicked: layout.addPageToNextColumn(rootPage, sectionsPage)
        }

    }

}
