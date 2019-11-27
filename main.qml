import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

// Main Frame
Rectangle {
    id: wall
    width: 1000
    height: 500

    signal login
    signal getGroups
    signal getWall(string id)
    signal morePosts

    // ----- Global Settings signals
    signal setPhotoSize(string size)


    onMorePosts: {
        console.log("Load More Posts")
    }

    // emited after login signal slot was successed
    function showGroupList(){
        // if already have some feed
        if(wallFrame.children[0]!==undefined){
            wallFrame.children[0].destroy(); // COOL FEATURE!!!
            var component = Qt.createComponent("GroupList.qml"); // COOL FEATURE!!!
            var object = component.createObject(wallFrame); // COOL FEATURE!!!
        }
        else{
            var component = Qt.createComponent("GroupList.qml"); // COOL FEATURE!!!
            var object = component.createObject(wallFrame); // COOL FEATURE!!!

        }
    }

    // show wall with posts
    function showWall(){
        // if already have some feed
        if(wallFrame.children[0]!==undefined){
            wallFrame.children[0].destroy(); // COOL FEATURE!!!
            //getWall(id);
            var component = Qt.createComponent("PostFeed.qml"); // COOL FEATURE!!!
            var object = component.createObject(wallFrame); // COOL FEATURE!!!

            object.loadPosts.connect(morePosts) // !!! SUPER MEGA COOL FEATURE, signal emited from dynamicaly created object connect to sygnal of parent which connected in C++ to function

        }
        else{
            //getWall(id);
            var component = Qt.createComponent("PostFeed.qml"); // COOL FEATURE!!!
            var object = component.createObject(wallFrame); // COOL FEATURE!!!
            object.loadPosts.connect(morePosts)

            // Create Scroll Bar
            var comp = Qt.createComponent("Scroll.qml");
            var obj = comp.createObject(wall);
            obj.scrollArea = wallFrame.children[0]
            obj.height = wall.height
            obj.width= 8;
            obj.anchors.right = wall.right

        }

    }

    // Menu
    VMenu{
        id: menu
        smooth: true
        focus: true

        anchors.top: wall.top
        anchors.bottom: wall.bottom
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10
        anchors.left: wall.left


        // Groups Clicked
        onGroupsClicked: {
            console.log("groups clicked")
            wall.getGroups()
        }
        // Login clicked
        onIdClicked: {
            wall.login()
        }
        onNewsClicked: {
            console.log("News Clicked")
            //wall.getWall("80762928");
            wall.getWall("23165971");

        }
    }

    //-----GLOBAL SETTINGS
    // - Photo Size
    ComboBox{
        id: picSize
        width: 100
        height: 25
        anchors.top: wall.top
        anchors.right: wall.right

        model: ListModel {
                id: cbItems
                ListElement { text: "75";  }
                ListElement { text: "130";  }
                ListElement { text: "604";  }
                ListElement { text: "807";  }
            }
            currentIndex: 1
            onCurrentIndexChanged: {
                console.log(" CHOSED ", cbItems.get(currentIndex).text)
                setPhotoSize(cbItems.get(currentIndex).text)
            }
    }


    // Wall Frame
    Item{
        id: wallFrame
        anchors.left: menu.right
        anchors.right: wall.right
        anchors.top: wall.top
        anchors.bottom: wall.bottom
    }





    ScrollBar{
        id: verticalScrollBar
        width: 12;
        anchors.right: wall.right
        anchors.rightMargin: 3
        anchors.top: wall.top
        anchors.bottom: wall.bottom
        opacity: 0.78
        orientation: Qt.Vertical
        //position: wallFrame.children[0].visibleArea.yPosition
        //pageSize: wallFrame.children[0].visibleArea.heightRatio

    }

    //color: "blue"
    /*MouseArea {
        anchors.fill: parent
        onClicked: {
            //Qt.quit();
        }
    }*/


}
