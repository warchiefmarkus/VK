#ifndef IMAGEMODEL_H
#define IMAGEMODEL_H
#include <QAbstractListModel>
#include <QStringList>

class Image
{
public:
    Image(const QString &Picture, const QString &link,const QString &hdlink);

    QString picture() const;
    QString link() const;
    QString hdlink() const;



private:
    QString m_picture;
    QString m_link;
    QString m_hdlink;

};

class ImageModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ImageRoles {
        PictureRole = Qt::UserRole + 1,
        LinkRole,
        HDLinkRole
    };

    ImageModel(QObject *parent = 0);

    Q_INVOKABLE int count() const { return m_images.size(); }

    void addImage(const Image &image);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<Image> m_images;
};

#endif // IMAGEMODEL_H
