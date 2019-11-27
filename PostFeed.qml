import QtQuick 2.2


// Post Feed

ListView {
    id: postView
    anchors.fill: parent
    anchors.rightMargin: 10
    anchors.leftMargin: 10
    //clip: true // CONTENT OUT OF WINDOW DONT RENDERING !!!

    signal loadPosts;


    // set wallView height on change items
    //onAdd:{}

    // !!! HACK IF WE AT THE END OF FEED LOAD NEW CONTENT
    onFlickEnded: {
        console.log("At End of Feed", atYEnd)
        //loadPosts()
    }
    
    property string some: ""

    // Post View Delegat
    Component {
        id: myDelegate

        // post width must be original 540
        Item {
            //width: parent.width-15
            width: 400 // vk width
            // calc height as sum of all childs heights
            height: postHeader.height+pText.height+postImages.height+postVideos.height+postAudios.height+45
            // Post
            Rectangle{
                id: frame
                anchors.fill: parent
                radius: 3
                anchors.topMargin: 10
                color: "white"
                
                // COOL FEATURE !!!
                //border.color: Qt.lighter(color)
                border.color: Qt.darker(frame.color,1.085)
                border.width: 2
                
                // Content
                Item {
                    id: contentWraper
                    anchors.margins: 8
                    anchors.fill: parent
                    
                    // -----Post Header
                    Item{
                        id: postHeader
                        anchors.top: contentWraper.top
                        width: contentWraper.width
                        height: 50

                        // Image of Group
                        Image{
                            id: gImage
                            width: 50
                            height: 50
                            smooth: true
                            fillMode: Image.PreserveAspectFit  
                            source: groupImage
                        }
                        
                        // Text and Date
                        Item{
                            anchors.left: gImage.right
                            anchors.leftMargin: 5

                            // Header of Group
                            Text{
                                id: gHeader
                                anchors.top: parent.top
                                renderType: Text.NativeRendering

                                color: "#2B587A"
                                font.family:  "Lucida Sans"
                                font.weight: Font.Bold
                                font.pixelSize: 11
                                
                                text: groupHeader
                            }

                            // Time of Post
                            Text{
                                anchors.top: gHeader.bottom
                                renderType: Text.NativeRendering
                                anchors.topMargin: 5
                                id: postTime
                                color: "#999"
                                font.family:  "Tahoma"
                                font.pixelSize: 12
                                
                                text: date
                            }
                        }
                    }
                    
                    // -----Text of Post
                    Text{
                        id: pText
                        width: contentWraper.width
                        renderType: Text.NativeRendering
                        
                        anchors.topMargin: 5
                        anchors.top: postHeader.bottom
                        
                        color: "#000"
                        font.family:  "Tahoma"
                        font.pixelSize: 11
                        
                        // MEGA SUPER COOL FEATURE !!!
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        maximumLineCount: 5
                        
                        text: postText;

                    }
                    
                    // Images of Post
                    Grid {
                        GridView{
                            id: pImages
                            model: imgModel
                            visible: false

                            delegate: Image{
                                source: modelData
                            }
                        }

                        id: postImages
                        anchors.top: pText.bottom
                        anchors.topMargin: 5
                        columns: 5
                        spacing: 5
                        width: contentWraper.width

                        Component.onCompleted: {
                            // Set the VK images positioning model
                            // if 1 image

                            console.log("IAMGES COUNT ", pImages.count)

                            switch (pImages.count) {
                            case 1:{

                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  fillMode: Image.PreserveAspectFit; width: 340;  source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                break;
                            }
                            case 2:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[1]+'"; }',postImages, "dynamicIamge");

                                break;
                            }
                            case 3:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[1]+'"; }',postImages, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[2]+'"; }',postImages, "dynamicIamge");

                                break;
                            }
                            case 4:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[1]+'"; }',postImages, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[2]+'"; }',postImages, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[3]+'"; }',postImages, "dynamicIamge");

                                break;
                            }
                            case 5:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[1]+'"; }',postImages, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[2]+'"; }',postImages, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[3]+'"; }',postImages, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[4]+'"; }',postImages, "dynamicIamge");

                                break;
                            }
                            case 6:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[1]+'"; }',postImages, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[2]+'"; }',postImages, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[3]+'"; }',postImages, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[4]+'"; }',postImages, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[5]+'"; }',postImages, "dynamicIamge");

                                break;
                            }
                            case 7:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[1]+'"; }',postImages, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[2]+'"; }',postImages, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[3]+'"; }',postImages, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[4]+'"; }',postImages, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[5]+'"; }',postImages, "dynamicIamge");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[6]+'"; }',postImages, "dynamicIamge");

                                break;
                            }
                            case 8:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[1]+'"; }',postImages, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[2]+'"; }',postImages, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[3]+'"; }',postImages, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[4]+'"; }',postImages, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[5]+'"; }',postImages, "dynamicIamge");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[6]+'"; }',postImages, "dynamicIamge");
                                var newObject8 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[7]+'"; }',postImages, "dynamicIamge");

                                break;
                            }
                            case 9:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[1]+'"; }',postImages, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[2]+'"; }',postImages, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[3]+'"; }',postImages, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[4]+'"; }',postImages, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[5]+'"; }',postImages, "dynamicIamge");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[6]+'"; }',postImages, "dynamicIamge");
                                var newObject8 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[7]+'"; }',postImages, "dynamicIamge");
                                var newObject9 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[8]+'"; }',postImages, "dynamicIamge");

                                break;
                            }
                            case 10:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[0]+'"; }',postImages, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[1]+'"; }',postImages, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[2]+'"; }',postImages, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[3]+'"; }',postImages, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[4]+'"; }',postImages, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[5]+'"; }',postImages, "dynamicIamge");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[6]+'"; }',postImages, "dynamicIamge");
                                var newObject8 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[7]+'"; }',postImages, "dynamicIamge");
                                var newObject9 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[8]+'"; }',postImages, "dynamicIamge");
                                var newObject10 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+imgModel[9]+'"; }',postImages, "dynamicIamge");

                                break;
                            }

                            }
                        }

                        }




                    // Videos of Post
                    Grid {
                        GridView{
                            id: pVideos
                            model: vidModel
                            visible: false

                            delegate: Image{
                                source: modelData
                            }
                        }

                        id: postVideos
                        anchors.top: postImages.bottom
                        anchors.topMargin: 5
                        columns: 5
                        spacing: 5
                        width: contentWraper.width

                        Component.onCompleted: {
                            // Set the VK images positioning model
                            // if 1 image

                            console.log("Videos COUNT ", pVideos.count)

                            switch (pVideos.count) {
                            case 1:{

                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  fillMode: Image.PreserveAspectFit; width: 340;  source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                break;
                            }
                            case 2:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[1]+'"; }',postVideos, "dynamicIamge");

                                break;
                            }
                            case 3:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[1]+'"; }',postVideos, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[2]+'"; }',postVideos, "dynamicIamge");

                                break;
                            }
                            case 4:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[1]+'"; }',postVideos, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[2]+'"; }',postVideos, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[3]+'"; }',postVideos, "dynamicIamge");

                                break;
                            }
                            case 5:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[1]+'"; }',postVideos, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[2]+'"; }',postVideos, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[3]+'"; }',postVideos, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[4]+'"; }',postVideos, "dynamicIamge");

                                break;
                            }
                            case 6:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[1]+'"; }',postVideos, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[2]+'"; }',postVideos, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[3]+'"; }',postVideos, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[4]+'"; }',postVideos, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[5]+'"; }',postVideos, "dynamicIamge");

                                break;
                            }
                            case 7:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[1]+'"; }',postVideos, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[2]+'"; }',postVideos, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[3]+'"; }',postVideos, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[4]+'"; }',postVideos, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[5]+'"; }',postVideos, "dynamicIamge");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[6]+'"; }',postVideos, "dynamicIamge");

                                break;
                            }
                            case 8:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[1]+'"; }',postVideos, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[2]+'"; }',postVideos, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[3]+'"; }',postVideos, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[4]+'"; }',postVideos, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[5]+'"; }',postVideos, "dynamicIamge");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[6]+'"; }',postVideos, "dynamicIamge");
                                var newObject8 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[7]+'"; }',postVideos, "dynamicIamge");

                                break;
                            }
                            case 9:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[1]+'"; }',postVideos, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[2]+'"; }',postVideos, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[3]+'"; }',postVideos, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[4]+'"; }',postVideos, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[5]+'"; }',postVideos, "dynamicIamge");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[6]+'"; }',postVideos, "dynamicIamge");
                                var newObject8 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[7]+'"; }',postVideos, "dynamicIamge");
                                var newObject9 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[8]+'"; }',postVideos, "dynamicIamge");

                                break;
                            }
                            case 10:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[0]+'"; }',postVideos, "dynamicIamge");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[1]+'"; }',postVideos, "dynamicIamge");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[2]+'"; }',postVideos, "dynamicIamge");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[3]+'"; }',postVideos, "dynamicIamge");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[4]+'"; }',postVideos, "dynamicIamge");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[5]+'"; }',postVideos, "dynamicIamge");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[6]+'"; }',postVideos, "dynamicIamge");
                                var newObject8 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[7]+'"; }',postVideos, "dynamicIamge");
                                var newObject9 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[8]+'"; }',postVideos, "dynamicIamge");
                                var newObject10 = Qt.createQmlObject('import QtQuick 2.2;  Image {  width: 100; height: 100; source: "'+vidModel[9]+'"; }',postVideos, "dynamicIamge");

                                break;
                            }

                            }
                        }

                        }



                    
                    // Audios of Post

                    ListView{
                        id: pAudios
                        visible: false

                        //anchors.topMargin: 10
                        //anchors.top: postImages.bottom

                       // width: contentWraper.width


                        model: audModel

                        delegate: Text{
                            renderType: Text.NativeRendering
                            //width: 100
                            //height: 100
                            text: modelData
                        }
                    }

                    Column {


                        id: postAudios
                        anchors.top: postVideos.bottom
                        anchors.topMargin: 10
                        spacing: 5
                        width: contentWraper.width

                        Component.onCompleted: {
                            // Set the VK images positioning model
                            // if 1 image
                            console.log("AUDIO COUNT",pAudios.count)
                            switch (pAudios.count) {
                            case 1:{


                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;  horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                break;
                            }
                            case 2:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img2;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img2.verticalCenter;   text: "<b>'+audModel[1]+'</b> " }}',postAudios, "dynamicAudio");

                                break;
                            }
                            case 3:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering;  anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img2;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img2.verticalCenter;   text: "<b>'+audModel[1]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img3;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img3.verticalCenter;   text: "<b>'+audModel[2]+'</b> " }}',postAudios, "dynamicAudio");

                                break;
                            }
                            case 4:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img2;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img2.verticalCenter;   text: "<b>'+audModel[1]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img3;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img3.verticalCenter;   text: "<b>'+audModel[2]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img4;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img4.verticalCenter;   text: "<b>'+audModel[3]+'</b> " }}',postAudios, "dynamicAudio");

                                break;
                            }
                            case 5:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img2;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img2.verticalCenter;   text: "<b>'+audModel[1]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img3;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img3.verticalCenter;   text: "<b>'+audModel[2]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img4;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img4.verticalCenter;   text: "<b>'+audModel[3]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img5;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img5.verticalCenter;   text: "<b>'+audModel[4]+'</b> " }}',postAudios, "dynamicAudio");


                                break;
                            }
                            case 6:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img2;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img2.verticalCenter;   text: "<b>'+audModel[1]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img3;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img3.verticalCenter;   text: "<b>'+audModel[2]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img4;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img4.verticalCenter;   text: "<b>'+audModel[3]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img5;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img5.verticalCenter;   text: "<b>'+audModel[4]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img6;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img6.verticalCenter;   text: "<b>'+audModel[5]+'</b> " }}',postAudios, "dynamicAudio");

                                break;
                            }
                            case 7:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img2;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img2.verticalCenter;   text: "<b>'+audModel[1]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img3;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img3.verticalCenter;   text: "<b>'+audModel[2]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img4;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img4.verticalCenter;   text: "<b>'+audModel[3]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img5;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  anchors.verticalCenter: img5.verticalCenter;   text: "<b>'+audModel[4]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img6;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  anchors.verticalCenter: img6.verticalCenter;   text: "<b>'+audModel[5]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img7;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img7.verticalCenter;   text: "<b>'+audModel[6]+'</b> " }}',postAudios, "dynamicAudio");

                                break;
                            }
                            case 8:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img2;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img2.verticalCenter;   text: "<b>'+audModel[1]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img3;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img3.verticalCenter;   text: "<b>'+audModel[2]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img4;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img4.verticalCenter;   text: "<b>'+audModel[3]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img5;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img5.verticalCenter;   text: "<b>'+audModel[4]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img6;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img6.verticalCenter;   text: "<b>'+audModel[5]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img7;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img7.verticalCenter;   text: "<b>'+audModel[6]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject8 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img8;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img8.verticalCenter;   text: "<b>'+audModel[7]+'</b> " }}',postAudios, "dynamicAudio");

                                break;
                            }
                            case 9:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img2;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img2.verticalCenter;   text: "<b>'+audModel[1]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img3;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img3.verticalCenter;   text: "<b>'+audModel[2]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img4;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img4.verticalCenter;   text: "<b>'+audModel[3]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img5;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img5.verticalCenter;   text: "<b>'+audModel[4]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img6;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img6.verticalCenter;   text: "<b>'+audModel[5]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img7;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img7.verticalCenter;   text: "<b>'+audModel[6]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject8 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img8;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img8.verticalCenter;   text: "<b>'+audModel[7]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject9 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img9;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img9.verticalCenter;   text: "<b>'+audModel[8]+'</b> " }}',postAudios, "dynamicAudio");

                                break;
                            }
                            case 10:{
                                var newObject1 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img1;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img1.verticalCenter;   text: "<b>'+audModel[0]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject2 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img2;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img2.verticalCenter;   text: "<b>'+audModel[1]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject3 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img3;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img3.verticalCenter;   text: "<b>'+audModel[2]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject4 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img4;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img4.verticalCenter;   text: "<b>'+audModel[3]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject5 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img5;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img5.verticalCenter;   text: "<b>'+audModel[4]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject6 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img6;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img6.verticalCenter;   text: "<b>'+audModel[5]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject7 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img7;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img7.verticalCenter;   text: "<b>'+audModel[6]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject8 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img8;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img8.verticalCenter;   text: "<b>'+audModel[7]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject9 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img9;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img9.verticalCenter;   text: "<b>'+audModel[8]+'</b> " }}',postAudios, "dynamicAudio");
                                var newObject10 = Qt.createQmlObject('import QtQuick 2.2;  Row{ spacing: 5; Image { id: img10;   horizontalAlignment: Image.AlignLeft; verticalAlignment: Image.AlignTop;  fillMode: Image.Tile; width: 16; height: 16; source: "data/audio.png" }Text{  renderType: Text.NativeRendering; anchors.verticalCenter: img10.verticalCenter;   text: "<b>'+audModel[9]+'</b> " }}',postAudios, "dynamicAudio");

                                break;
                            }

                            }
                        }
                    }


                    
                }
            }
            
            
        }
    }
    
    model: postModel
    delegate: myDelegate
}


