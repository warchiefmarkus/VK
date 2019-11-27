#-------------------------------------------------
#
# Project created by QtCreator 2014-06-24T16:55:34
#
#-------------------------------------------------

QT       += core quick qml gui network widgets webkit webkitwidgets

TARGET = VKing
TEMPLATE = app

QMAKE_CXXFLAGS += -std=c++11

SOURCES += main.cpp\
        mainwindow.cpp \
#    reply.cpp \
#    json.cpp \
#    k8json/k8json.cpp \
#    client.cpp \
#    message.cpp \
#    attachment.cpp \
#    contact.cpp \
#    roster.cpp \
#    dynamicpropertydata.cpp \
#    utils.cpp \
#    friendrequest.cpp \
#    connection.cpp \
#    longpoll.cpp \
#    groupmanager.cpp \
#    oauthconnection.cpp
    oauthn.cpp \
    json.cpp \
    k8json/k8json.cpp \
    downloadwidget.cpp \
    downloadmanager.cpp \
    wallview.cpp \
    model.cpp \
    groupmodel.cpp \
    imagemodel.cpp \
    postmodel.cpp

HEADERS  += mainwindow.h \
#    reply.h \
#    reply_p.h \
#    json.h \
#    k8json/k8json.h \
#    client.h \
#    message.h \
#    attachment.h \
#    contact.h \
#    contact_p.h \
#    roster.h \
#    roster_p.h \
#    dynamicpropertydata_p.h \
#    utils.h \
#    utils_p.h \
#    client_p.h \
#    friendrequest.h \
#    connection.h \
#    connection_p.h \
#    longpoll.h \
#    longpoll_p.h \
#    groupmanager.h \
#    groupmanager_p.h \
#    oauthconnection.h
    oauthn.h \
    json.h \
    k8json/k8json.h \
    downloadmanager.h \
    downloadwidget.h \
    wallview.h \
    model.h \
    groupmodel.h \
    imagemodel.h \
    postmodel.h

FORMS +=

OTHER_FILES += \
    main.qml \
    ScrollBar.qml \
    GroupList.qml \
    PostFeed.qml \
    VMenu.qml \
    Scroll.qml


