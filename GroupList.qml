import QtQuick 2.2


// Group List
ListView {
    id: groupList
    anchors.fill: parent
    anchors.rightMargin: 10
    anchors.leftMargin: 10
    focus: true
    clip: true // CONTENT OUT OF WINDOW DONT RENDERING !!!

    //property alias groupModel

    signal groupClicked(int id) // show group by id

    Component {
        id: highlight
        Rectangle {
            width: groupList.parent.width-35; height: 70
            color: "lightsteelblue"; radius: 2
            y: groupList.currentItem.y
            Behavior on y {
                SpringAnimation {
                    spring: 3
                    damping: 0.2
                }
            }
        }
    }

    model: groupModel
    delegate: groupsDelegate
    highlight: highlight
    highlightFollowsCurrentItem: false

    Component {
        id: groupsDelegate
        // Item View
        Item{
            id: itemView
            width: groupList.parent.width-35
            height: 70

            MouseArea {
                      id: mArea
                      anchors.fill: parent
                      hoverEnabled: true
                      onClicked: {
                          console.log("clicked  ", " group id ", groupModel.count)
                          //groupList.groupClicked(id)
                          groupList.parent.parent.showWall( currentItem.link);

                      }
                      onEntered: {
                          groupList.currentIndex = index
                      }
                 }

            Rectangle {
                id: frame
                anchors.fill: parent
                radius: 3
                color: Qt.rgba(1,1,1,0.5)
                border.color: Qt.darker(frame.color,1.085)
                border.width: 2

                Row{
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                    spacing: 10
                    Image{
                        source: picture
                        width: 50
                        height: 50
                        fillMode: Image.Stretch
                        smooth: true
                        cache: true
                    }
                    Column{
                        spacing: 5
                        // Group Name
                        Text {
                            text: name
                            color: "#2B587A"
                            font.family:  "Tahoma"
                            font.weight: Font.Bold
                            font.pixelSize: 12
                        }
                        // Group Type
                        Text {
                            text: type
                            color: "#999"
                            font.family:  "Tahoma"
                            font.pixelSize: 12

                        }
                        // Group Members
                        Text {
                            text: members + " подписчиков " + " id " + link
                            color: "#999"
                            font.family:  "Tahoma"
                            font.pixelSize: 12
                        }


                    }
                }
            }



        }


    }
}
