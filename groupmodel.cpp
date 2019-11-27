#include "groupmodel.h"

Group::Group(const QString &name, const QString &type, const QString &picture, const QString &members,const QString &link)
    : m_name(name), m_type(type), m_picture(picture), m_members(members), m_link(link)
{
}

QString Group::name() const
{
    return m_name;
}

QString Group::type() const
{
    return m_type;
}

QString Group::picture() const
{
    return m_picture;
}

QString Group::members() const
{
    return m_members;
}

QString Group::link() const
{
    return m_link;
}

GroupModel::GroupModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

void GroupModel::addGroup(const Group &group)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_groups << group;
    endInsertRows();
}

int GroupModel::rowCount(const QModelIndex & parent) const {
    return m_groups.count();
}

QVariant GroupModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_groups.count())
        return QVariant();

    const Group &group = m_groups[index.row()];
    if (role == NameRole)
        return group.name();
    else if (role == TypeRole)
        return group.type();
    else if (role == PictureRole)
        return group.picture();
    else if (role == MembersRole)
        return group.members();
    else if (role == LinkRole)
        return group.link();
    return QVariant();
}

QHash<int, QByteArray> GroupModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[TypeRole] = "type";
    roles[PictureRole] = "picture";
    roles[MembersRole] = "members";
    roles[LinkRole] = "link";
    return roles;
}
