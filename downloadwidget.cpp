#include "downloadwidget.h"
#include <QProgressBar>
#include <QPushButton>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QTextEdit>
#include <QLabel>
#include <QLineEdit>

DownloadWidget::DownloadWidget(QWidget *parent) :
    QWidget(parent)
{
    mManager = new DownloadManager(this);
    connect(mManager,SIGNAL(downloadComplete()),this,SLOT(finished()));
    connect(mManager,SIGNAL(progress(int)),this,SLOT(progress(int)));

    setupUi();
    //to REMOVE the MINIMIZE and MAXIMIZE buttons
    setWindowFlags( windowFlags() & ~Qt::WindowCloseButtonHint );
    setWindowFlags( windowFlags() & ~Qt::WindowMinimizeButtonHint);

}

void DownloadWidget::setupUi()
{
    QVBoxLayout* mainLayout = new QVBoxLayout(this);


    urlLineEdit = new QLineEdit("Enter URL here");
    mainLayout->addWidget(urlLineEdit);

    mProgressBar = new QProgressBar(this);
    mainLayout->addWidget(mProgressBar);
    mProgressBar->hide();
    mainLayout->parentWidget();


    mDownloadBtn = new QPushButton("Download",this);
    mPauseBtn = new QPushButton("Pause",this);
    mPauseBtn->setEnabled(false);
    mResumeBtn = new QPushButton("Resume",this);
    mResumeBtn->setEnabled(false);

    QHBoxLayout* btnLayout = new QHBoxLayout;
    btnLayout->addWidget(mDownloadBtn);
    btnLayout->addWidget(mPauseBtn);
    btnLayout->addWidget(mResumeBtn);

    mainLayout->addLayout( btnLayout);

    connect(mDownloadBtn,SIGNAL(clicked()),this,SLOT(download()));
    connect(mPauseBtn,SIGNAL(clicked()),this,SLOT(pause()));
    connect(mResumeBtn,SIGNAL(clicked()),this,SLOT(resume()));
}

void DownloadWidget::download()
{
    url = urlLineEdit->text();
//mManager->download(QUrl("http://security.ubuntu.com/ubuntu/pool/main/g/glibc/libc6_2.7-10ubuntu8_amd64.deb"));

    mManager->download(QUrl(url));
    mDownloadBtn->setEnabled(false);
    mPauseBtn->setEnabled(true);
    urlLineEdit->hide();
    mProgressBar->show();
}

void DownloadWidget::pause()
{
    mManager->pause();
    mPauseBtn->setEnabled(false);
    mResumeBtn->setEnabled(true);
}

void DownloadWidget::resume()
{
    mManager->resume();
    mPauseBtn->setEnabled(true);
    mResumeBtn->setEnabled(false);
}


void DownloadWidget::finished()
{
    mDownloadBtn->setEnabled(true);
    mPauseBtn->setEnabled(false);
    mResumeBtn->setEnabled(false);

    urlLineEdit->show();
    urlLineEdit->setText("Enter Next URL here");
    mProgressBar->hide();
}

void DownloadWidget::progress(int percentage)
{
    mProgressBar->setValue( percentage);
}
