#ifndef OAUTHN_H
#define OAUTHN_H

#include <QWebPage>
#include <QWidget>
#include <QDebug>
#include <QWebView>
#include <QNetworkAccessManager>
#include <QUrlQuery>
#include <QWebFrame>

class OAuthN : public QWebView
{
    Q_OBJECT
public:
    explicit OAuthN(QWidget *parent = 0);
    QString Token;
    QString Expires;

signals:    
    void authSuccess(QString, QString);

public slots:
    void newURL(QUrl);
    void pageLoad();

private:

};

#endif // OAUTHN_H
