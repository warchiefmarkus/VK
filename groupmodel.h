#ifndef GROUPMODEL_H
#define GROUPMODEL_H
#include <QAbstractListModel>
#include <QStringList>

class Group
{
public:
    Group(const QString &name, const QString &type, const QString &Picture, const QString &members,const QString &link);
//![0]

    QString name() const;
    QString type() const;
    QString picture() const;
    QString members() const;
    QString link() const;

private:
    QString m_name;
    QString m_type;
    QString m_picture;
    QString m_members;
    QString m_link;
//![1]
};

class GroupModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum GroupRoles {
        NameRole = Qt::UserRole + 1,
        TypeRole,
        PictureRole,
        MembersRole,
        LinkRole
    };

    GroupModel(QObject *parent = 0);


    void addGroup(const Group &group);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<Group> m_groups;
};

#endif // GROUPMODEL_H
