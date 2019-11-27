#include "mainwindow.h"
#include <QApplication>
#include <QGLFormat>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    a.setApplicationName("VKing");
    a.setOrganizationName("");
    a.setOrganizationDomain("");

    MainWindow w;
    w.show();

    return a.exec();
}
