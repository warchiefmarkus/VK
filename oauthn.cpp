#include "oauthn.h"
#include <QEventLoop>
#include <QTimer>
#include <QUrlQuery>
#include <QWebFrame>
#include <QWebElement>

OAuthN::OAuthN(QWidget *parent) :
    QWebView(parent)
{
    // если в правах указать «offline», то токен будет бесконечным
    QUrl url = QUrl("http://oauth.vk.com/authorize?client_id=&scope=notify,friends,photos,audio,video,docs,notes,pages,status,offers,questions,wall,groups,messages,notifications,stats,ads,offline&redirect_uri=https://oauth.vk.com/blank.html&display=popup&v=5.4&response_type=token");
    setWindowTitle("WebView");
    Token = "";
    load(url);
    connect(this, SIGNAL(urlChanged(QUrl)), this, SLOT(newURL(QUrl)));
    connect(this,SIGNAL(loadFinished(bool)),this,SLOT(pageLoad()));
}

void OAuthN::newURL(QUrl subUrl)
{
    if (!subUrl.toString().contains("access_token")){
        return;
    }
    subUrl = subUrl.toString().replace("#","?");
    QUrlQuery * query = new QUrlQuery(subUrl.query());
    Token = query->queryItemValue("access_token");
    Expires = query->queryItemValue("expires_in");
    emit authSuccess(Token,Expires);
}

void OAuthN::pageLoad()
{
    QWebFrame *frame = this->page()->mainFrame();
    QWebElement element = frame->findFirstElement("input[name=email]");
    element.setAttribute("value", "");
    element = frame->findFirstElement("input[name=pass]");
    element.setAttribute("value", "");
    /*
    (!webPage->view()) {
                    QWebFrame *frame = webPage->mainFrame();

                    QWebElement element = frame->findFirstElement("input[name=email]");
                    element.setAttribute("value", login);
                    element = frame->findFirstElement("input[name=pass]");
                    element.setAttribute("value", password);
                    element = frame->findFirstElement("#login_enter");
                    element.setFocus();
                    handleAuthRequest(webPage.data());
                    */
    qDebug() << " Form Loaded ";
}
