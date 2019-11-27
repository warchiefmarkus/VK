import QtQuick 2.2


Item {
    id: menu
    width:150


    // COOL FEATURE !!!
    // export button properties
    //property alias text: label.text
    signal groupsClicked
    signal idClicked
    signal newsClicked

    property int ang: 0
    property int axisX: 0
    property int axisY: 0

    // 3D for ui
    transform: [
        //Scale {origin.x: 0; origin.y: 0; xScale: 1.5; yScale: 1.2},
        Rotation { origin.x:  menu.width/2; origin.y: menu.height/2; axis { x: axisX; y: axisY; z: 0 } angle: ang }
    ]



    MouseArea{
        id: menuMouse
        focus: true
        hoverEnabled: true
        anchors.fill: parent

        /*
        onMouseXChanged: {
            axisX = 0
            axisY = 1


            var centerPointX = menu.width/2;
            var posX = (mouseX-menu.x+10)/centerPointX;

            if (posX<1){
                console.log("ang ", menu.ang)
                menu.ang = 0-((posX-1)*(-1)*20)

            }else if (posX>1){
                console.log("ang", menu.ang)
                menu.ang = 0+((posX-1)*20)
            }



        }
        */

        onExited: PropertyAnimation { target: menu; property: "ang"; to: 0; duration: 600}




        /*
        onMouseYChanged: {

            axisX = 1
            var centerPointY = menu.height/2;
            var posY = (mouseY-menu.y+10)/centerPointY;


            if (posY<1){
                console.log("ang ", menu.ang)
                menu.ang = 0-((posY-1)*(-1)*15)

            }else if (posY>1){
                console.log("ang", menu.ang)
                menu.ang = 0+((posY-1)*15)
            }

        }*/

    }

    Column{
        anchors.fill: parent

        Rectangle{
            id: idItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering

                text: "Войти"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
            MouseArea{

                anchors.fill: parent
                onClicked: {
                    menu.idClicked()
                    console.log("Login Clicked")
                    }
            }
        }
        Rectangle{
            id: pageItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Страница"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }

        Rectangle{
            id: friendsItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Друзья"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
        Rectangle{
            id: photosItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Фотографии"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
        Rectangle{
            id: videosItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Видео"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
        Rectangle{
            id: audiosItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Аудио"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
        Rectangle{
            id: messagesItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Сообщения"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
        Rectangle{
            id: groupsItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Группы"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
            MouseArea{

                anchors.fill: parent
                onClicked: {
                    menu.groupsClicked()
                    }
            }
        }
        Rectangle{
            id: newsItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Новости"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
            MouseArea{

                anchors.fill: parent
                onClicked: {
                    menu.newsClicked()
                    }
            }
        }
        Rectangle{
            id: answersItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Ответы"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
        Rectangle{
            id: optionsItem
            anchors.left: parent.left
            anchors.right: parent.right
            border.color: Qt.darker(color,1.085)
            border.width: 2
            radius: 3
            height: 25

            Text{
                renderType: Text.NativeRendering
                text: "Настройки"
                color: "#2B587A"
                font.family:  "Tahoma"
                font.weight: Font.Bold
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }
    }
}

