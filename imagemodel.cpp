#include "imagemodel.h"

Image::Image(const QString &picture, const QString &link, const QString &hdlink)
    :m_picture(picture), m_link(link), m_hdlink(hdlink)
{

}

QString Image::picture() const
{
    return m_picture;
}

QString Image::link() const
{
    return m_link;
}

QString Image::hdlink() const
{
    return m_hdlink;
}


ImageModel::ImageModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

void ImageModel::addImage(const Image &image)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_images << image;
    endInsertRows();
}

int ImageModel::rowCount(const QModelIndex & parent) const {
    return m_images.count();
}

QVariant ImageModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_images.count())
        return QVariant();

    const Image &image = m_images[index.row()];

    if (role == PictureRole)
        return image.picture();
    else if (role == LinkRole)
        return image.link();
    else if (role == HDLinkRole)
        return image.hdlink();
    return QVariant();
}

QHash<int, QByteArray> ImageModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[PictureRole] = "picture";
    roles[LinkRole] = "link";
    roles[HDLinkRole] = "hdlink";
    return roles;
}
