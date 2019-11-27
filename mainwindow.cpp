#include "mainwindow.h"
#include <QDebug>
#include <QWebView>
#include <QWebPage>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QUrlQuery>
#include <QWebFrame>
#include <QEventLoop>
#include <QTimer>
#include <QNetworkRequest>
#include <QMap>
#include <json.h>
#include <downloadwidget.h>
#include <QListWidget>
#include <wallview.h>
#include <QQmlContext>
#include <QHash>
#include <QByteArray>
#include <QAbstractListModel>
#include <QDate>
#include <imagemodel.h>
#include <QQmlProperty>
#include <QQmlNetworkAccessManagerFactory>
#include <QQmlEngine>
#include <QGLFormat>
#include <QOpenGLContext>

class MyNetworkAccessManagerFactory : public QQmlNetworkAccessManagerFactory
{
public:
    virtual QNetworkAccessManager *create(QObject *parent);
};

QNetworkAccessManager *MyNetworkAccessManagerFactory::create(QObject *parent)
{
    QNetworkAccessManager *nam = new QNetworkAccessManager(parent);
    QNetworkDiskCache* cache = new QNetworkDiskCache(parent);
    // 500 Mb
    cache->setMaximumCacheSize(500*1024*1024);
    cache->setCacheDirectory("cacheDir");
    nam->setCache(cache);

    return nam;
}

MainWindow::MainWindow(QWindow *parent)
    : QQuickView(parent)
{
    setSource(QUrl::fromLocalFile("H:/VK/main.qml").toString());

    photoSize = "130";


    // !!! SET QNAM AND CACHE
    manager = new QNetworkAccessManager(this);
    cache = new QNetworkDiskCache(this);
    // 500 Mb
    cache->setMaximumCacheSize(500*1024*1024);
    cache->setCacheDirectory("cacheDir");
    manager->setCache(cache);

    // SET CACHED NAM TO QMLENGINE TO
    MyNetworkAccessManagerFactory* namFactory = new MyNetworkAccessManagerFactory();
    QQmlEngine* eng =  engine();
    eng->setNetworkAccessManagerFactory(namFactory);


    QQmlProperty((QObject*)rootObject(), "color").write("#F5F5F5");
    QQmlProperty((QObject*)rootObject(), "height").write(height());


    wallObj = rootObject();
    //wallObj->setProperty("color", "#F5F5F5");
    //wallObj->setProperty("height",height());

    connect((QObject*)wallObj, SIGNAL(login()),this,SLOT(login()));
    connect((QObject*)wallObj, SIGNAL(getGroups()),this, SLOT(getGroups()));
    connect((QObject*)wallObj, SIGNAL(getWall(QString)),this, SLOT(getWall(QString)));
    connect((QObject*)wallObj, SIGNAL(morePosts()), this, SLOT(morePosts()));
    connect((QObject*)wallObj, SIGNAL(setPhotoSize(QString)), this, SLOT(setPhotoSize(QString)));


    LoadIni("H:/VK/config.ini");
    // do we have token
    if( settings->contains("token")){
        // its a unlimit token
        qDebug() << " HAVE TOKEN ";
        if(ReadConfig("expires").toInt()==0){
            Token = ReadConfig("token").toString();
        }
        // if no doesnt it token expire
        else if(ReadConfig("expDate").toDate()<=QDate::currentDate()){
            Token = ReadConfig("token").toString();
        }
    // if havent token login
    }else{
        login();
        qDebug() << " NEED LOGIN ";
    }
}



void MainWindow::getToken(QString token, QString expires)
{
    Token = token;
    Expires = expires;
    oauth->disconnect();
    oauth->hide();
    emit haveToken();
    WriteConfig("token",token);
    WriteConfig("expires",expires);
    WriteConfig("expDate",QDate::currentDate().addDays(1).toString());
}

void MainWindow::getAudio()
{
    //QUrl current("https://api.vk.com/method/audio.get");
    QUrl current("https://api.vk.com/method/wall.getById");
    QUrlQuery query;
    query.addQueryItem("v","5.2");
    query.addQueryItem("access_token",Token);
    //query.addQueryItem("owner_id","-37376822"); // group id
    query.addQueryItem("posts","-37376822_247"); //
    query.addQueryItem("extended","1");
    current.setQuery(query);
    QByteArray answer = GET(current);
    qDebug() << answer;

    QVariantList List = JSON::parse(answer).toMap().value("response").toMap().value("items").toList(); // parse to list of objects Audio

    /*GET Audio
    QString du;
    for (int i=0; i<List.size(); i++)
    {
        QVariantMap current = List[i].toMap();
        du = current.value("url").toString();
        qDebug() << current.value("url").toString();
        qDebug() << current.value("id").toString();
        qDebug() << current.value("title").toString();
    }
    */

    QStringList links;

    for (int i=0; i<List.size(); i++)
    {
        QVariantMap current = List[i].toMap();

        qDebug() << current.value("id").toString();
        QVariantList attachments = current.value("attachments").toList();
        for (int k=0; k<attachments.size(); k++)
        {
            QVariantMap cur = attachments[k].toMap();
            if (cur.value("type").toString() == "audio")
            {
                qDebug() << "Audio";
                qDebug() << cur.value("audio").toMap().value("url").toString();
                links.append(cur.value("audio").toMap().value("url").toString());
            }
        }

    }

    //QListWidget * listView = new QListWidget(this);
    //listView->setGeometry(0, 50,700,500);
    //listView->addItems(links);
    //listView->show();
    //DownloadWidget wid(this);
    //wid.setGeometry(0,0,200,200);
    //wid.setParent(this);
    //wid.show();
    //wid.urlLineEdit->setText(du);
    //connect(wid.mManager, SIGNAL(progress(int)), this, SLOT(LOG(int)) );
    //wid.download();
}

void MainWindow::getGroups()
{
    qDebug() << " GET GROUPS FROM QML ";

    QUrl current("https://api.vk.com/method/groups.get");
    QUrlQuery query;
    query.addQueryItem("v","5.2");
    query.addQueryItem("access_token",Token);
    query.addQueryItem("user_id","138685584");
    query.addQueryItem("extended","1");
    query.addQueryItem("count","1000");
    query.addQueryItem("fields","members_count");

    current.setQuery(query);
    QByteArray answer = GET(current);

    QVariantList List = JSON::parse(answer).toMap().value("response").toMap().value("items").toList(); // parse to list of objects Audio

    /*GET Audio
    QString du;
    for (int i=0; i<List.size(); i++)
    {
        QVariantMap current = List[i].toMap();
        du = current.value("url").toString();
        qDebug() << current.value("url").toString();
        qDebug() << current.value("id").toString();
        qDebug() << current.value("title").toString();
    }
    */

    QQmlContext* context = rootContext();
    groupModel = new GroupModel();

    for (int i=0; i<List.size(); i++)
    {

        QVariantMap current = List[i].toMap();
        groupModel->addGroup(Group(current.value("name").toString(),current.value("type").toString(),current.value("photo_50").toString(),current.value("members_count").toString(),current.value("id").toString()));

        /*QVariantList attachments = current.value("attachments").toList();
        for (int k=0; k<attachments.size(); k++)
        {
            QVariantMap cur = attachments[k].toMap();
            if (cur.value("type").toString() == "audio")
            {
                qDebug() << "Audio";
                qDebug() << cur.value("audio").toMap().value("url").toString();
                links.append(cur.value("audio").toMap().value("url").toString());
            }
        }*/

    }

    context->setContextProperty("groupModel", groupModel);
    //if success loaded data
    if (1){
        wallObj = rootObject();
        QMetaObject::invokeMethod((QObject*)wallObj, "showGroupList");
    }
}

void MainWindow::morePosts(){
    qDebug() << " MORE POSTS in C++ emited " << curWall;

    QQmlContext* context = rootContext();
    //PostModel* tmpPostModel = new PostModel();

    QUrl current("https://api.vk.com/method/wall.get");
    QUrlQuery query;
    query.addQueryItem("v","5.2");
    query.addQueryItem("access_token",Token);
    query.addQueryItem("owner_id","-"+curWall);
    query.addQueryItem("offset",QString::number(curOffset));
    query.addQueryItem("count",QString::number(getPostCount));
    query.addQueryItem("filter","all");

    current.setQuery(query);
    QByteArray answer = GET(current);

    QVariantList List = JSON::parse(answer).toMap().value("response").toMap().value("items").toList(); // parse to list of objects Audio

    for (int i=0; i<List.size(); i++)
    {
        QVariantMap current = List[i].toMap();

        QDateTime date;
        QDateTime dateNew = date.fromTime_t(current.value("date").toInt());

        QStringList imgList;
        QStringList audList;
        QStringList vidList;

        QVariantList attachments = current.value("attachments").toList();

        if (attachments.size()>0){
        for (int k=0; k<attachments.size(); k++)
        {

            QVariantMap cur = attachments[k].toMap();
            if (cur.value("type").toString() == "audio")
            {
                qDebug() << "Audio" << cur.value("audio").toMap().value("title").toString();
                audList.append(cur.value("audio").toMap().value("title").toString());
            }
            if (cur.value("type").toString() == "photo")
            {
                qDebug() << "Photo" << cur.value("photo").toMap().value("photo_130").toString();

               imgList.append(cur.value("photo").toMap().value("photo_130").toString());


                //imgMod.addImage(Image(cur.value("photo").toMap().value("photo_130").toString(),cur.value("photo").toMap().value("id").toString(), cur.value("photo").toMap().value("photo_604").toString()));

            }
            if (cur.value("type").toString() == "video")
            {
                qDebug() << "Video" << cur.value("video").toMap().value("photo_130").toString();
                vidList.append(cur.value("video").toMap().value("photo_130").toString());
            }
        }

        }

        postModel->addPost(Post(
                                current.value("id").toString(),
                                current.value("text").toString(),
                                dateNew.toString(Qt::ISODate),
                                current.value("likes").toString(),
                                current.value("reposts").toString(),
                                current.value("comments").toString(),
                                current.value("type").toString(),
                                curn.value("photo_50").toString(),
                                curn.value("name").toString(),
                                imgList,
                                audList,
                                vidList

                                )
                           );



    }
    curOffset+= getPostCount;
}

void MainWindow::getWall(QString id)
{
    curWall = id;
    curOffset = 0;
    getPostCount = 5;

    qDebug() << " GETWALL in C++ emited " << id;

    QQmlContext* context = rootContext();
    postModel = new PostModel();
    //postModel->addPost();

    // GET PHOTO OF GROUP
    QUrl cur("https://api.vk.com/method/groups.getById");
    QUrlQuery queryn;
    queryn.addQueryItem("v","5.2");
    queryn.addQueryItem("access_token",Token);
    queryn.addQueryItem("group_id",id);
    cur.setQuery(queryn);

    QByteArray answern = GET(cur);
    QVariantList Listn = JSON::parse(answern).toMap().first().toList();
    curn = Listn[0].toMap();



    QUrl current("https://api.vk.com/method/wall.get");
    QUrlQuery query;
    query.addQueryItem("v","5.2");
    query.addQueryItem("access_token",Token);
    query.addQueryItem("owner_id","-"+id);
    query.addQueryItem("offset",QString::number(curOffset));
    query.addQueryItem("count",QString::number(getPostCount));
    query.addQueryItem("filter","all");

    current.setQuery(query);
    QByteArray answer = GET(current);

    //qDebug() << answer << " GET " ;

    QVariantList List = JSON::parse(answer).toMap().value("response").toMap().value("items").toList(); // parse to list of objects Audio


    for (int i=0; i<List.size(); i++)
    {
        QVariantMap current = List[i].toMap();

        QDateTime date;
        QDateTime dateNew = date.fromTime_t(current.value("date").toInt());

        QStringList imgList;
        QStringList audList;
        QStringList vidList;


        QVariantList attachments = current.value("attachments").toList();
        //qDebug() << " ATTACH " << attachments[0].toMap().value("photo");

        if (attachments.size()>0){
        for (int k=0; k<attachments.size(); k++)
        {

            QVariantMap cur = attachments[k].toMap();
            if (cur.value("type").toString() == "audio")
            {
                qDebug() << "Audio" << cur.value("audio").toMap().value("title").toString();
                audList.append(cur.value("audio").toMap().value("title").toString());
            }
            if (cur.value("type").toString() == "photo")
            {
                qDebug() << "Photo" << cur.value("photo").toMap().value("photo_"+photoSize).toString();

               imgList.append(cur.value("photo").toMap().value("photo_"+photoSize).toString());


                //imgMod.addImage(Image(cur.value("photo").toMap().value("photo_130").toString(),cur.value("photo").toMap().value("id").toString(), cur.value("photo").toMap().value("photo_604").toString()));

            }
            if (cur.value("type").toString() == "video")
            {
                qDebug() << "Video" << cur.value("video").toMap().value("photo_"+photoSize).toString();
                vidList.append(cur.value("video").toMap().value("photo_"+photoSize).toString());
            }
        }

        }
        qDebug() << " VIDEO MODEL " << vidList;

        postModel->addPost(Post(
                                current.value("id").toString(),
                                current.value("text").toString(),
                                dateNew.toString(Qt::ISODate),
                                current.value("likes").toString(),
                                current.value("reposts").toString(),
                                current.value("comments").toString(),
                                current.value("type").toString(),
                                curn.value("photo_50").toString(),
                                curn.value("name").toString(),
                                imgList,
                                audList,
                                vidList

                                )
                           );


    }
    context->setContextProperty("postModel", postModel);
    //if success loaded data
    if (1){
        wallObj = rootObject();
        QMetaObject::invokeMethod((QObject*)wallObj, "showWall");
    }

    curOffset += 5;

    //qDebug() << " TEXT ROLE " << postModel->data(postModel->index(0,0),postModel->PostTextRole);
}

void MainWindow::LOG(int log)
{
    qDebug() << log;
}

void MainWindow::login()
{
    oauth = new OAuthN();
    oauth->setGeometry(100,0,500,400);
    //oauth->setParent(this);
    connect(oauth, SIGNAL(authSuccess(QString,QString)),this, SLOT(getToken(QString, QString)));
    connect(this,SIGNAL(haveToken()),this, SLOT(loginSuccess())); // FIXME : Change getGroups slot - to Login Succesfull slot acessuble from qml
    oauth->show();
}


MainWindow::~MainWindow()
{
}

QByteArray MainWindow::GET(QUrl r)
{ 
    QNetworkRequest request(r);

    request.setAttribute(QNetworkRequest::CacheLoadControlAttribute, QNetworkRequest::PreferNetwork);
    request.setAttribute(QNetworkRequest::CacheSaveControlAttribute, true);

    QNetworkReply * reply = manager->get(request);
    QEventLoop wait;
    connect(manager, SIGNAL(finished(QNetworkReply*)), &wait, SLOT(quit()));
    QTimer::singleShot(25000, &wait, SLOT(quit()));
    wait.exec();

    QByteArray answer = reply->readAll();
    reply->deleteLater();
    return answer;

}

void MainWindow::LoadIni(QString path)
{
    settings = new QSettings(path, QSettings::IniFormat);
}

void MainWindow::WriteConfig(QString name, QVariant value)
{
    settings->setValue(name, value);
}

QVariant MainWindow::ReadConfig(QString name)
{
    return settings->value(name);
}
