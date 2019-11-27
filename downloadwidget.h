#ifndef DOWNLOADWIDGET_H
#define DOWNLOADWIDGET_H

#include <QWidget>
#include <QLineEdit>
#include "downloadmanager.h"

class QProgressBar;
class QPushButton;
class QLabel;
class QTextEdit;

class DownloadWidget : public QWidget
{
    Q_OBJECT
public:
    explicit DownloadWidget(QWidget *parent = 0);

public slots:

    void download();

    void pause();

    void resume();

private slots:

    void finished();

    void progress(int percentage);

    void setupUi();

public:

    DownloadManager* mManager;
    QProgressBar *mProgressBar;
    QPushButton* mDownloadBtn;
    QPushButton* mPauseBtn;
    QPushButton* mResumeBtn;
    QLabel* mLabel;
    QUrl url;
    QLineEdit* urlLineEdit;
};

#endif // DOWNLOADWIDGET_H
