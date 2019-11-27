#ifndef MODEL_H
#define MODEL_H
#include <QMainWindow>
#include <QWebPage>
#include <oauthn.h>
#include <QByteArray>
#include <QScrollArea>
#include <model.h>
#include <wallview.h>
#include <QGraphicsObject>
#include <groupmodel.h>
#include <QSettings>
#include <postmodel.h>
#include <QtNetwork>
#include <QList>
#include <QCheckBox>
#include <QGroupBox>
#include <QLabel>
#include <QComboBox>
#include <QQuickView>
#include <QWindow>

class MainWindow : public QQuickView
{
    Q_OBJECT
private:
     QQuickItem * wallObj;
     QSettings * settings;
public:
    MainWindow(QWindow *parent = 0);
    ~MainWindow();

    OAuthN *oauth;
    QString Token;
    QString Expires;
    QByteArray GET(QUrl);

    void LoadIni(QString path);
    void WriteConfig(QString name, QVariant value);
    QVariant ReadConfig(QString name);

    AnimalModel * model;
    GroupModel * groupModel;
    PostModel* postModel;

    wallView* viewer;

    //void mousePressEvent(QMouseEvent *);
    //void resizeEvent(QResizeEvent *);

    QNetworkAccessManager * manager; // GET NAM !!!
    QNetworkDiskCache *cache;


    QVariantMap curn;


    QString curWall;
    int curOffset;
    int getPostCount;

    //----------------GLOBAL SETTINGS
    QString photoSize;


signals:
    void haveToken();

public slots:
    void setPhotoSize(QString size) { photoSize = size; qDebug() << " Photo size " << size; }

    void getToken(QString, QString);
    void getAudio();
    void getGroups();

    void getWall(QString id);
    void morePosts();

    void loginSuccess(){ qDebug() << " Login Success ";}
    void LOG(int);

    void login(); // for qml slot
};

#endif // MODEL_H
