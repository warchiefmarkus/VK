#ifndef POSTMODEL_H
#define POSTMODEL_H
#include <QAbstractListModel>
#include <QStringList>
#include <imagemodel.h>
#include <QList>
#include <QMetaType>



class Post
{
public:
    Post(const QString &id,
         const QString &postText,
         const QString &date,
         const QString &likes,
         const QString &reposts,
         const QString &comments,
         const QString &type,
         const QString &groupImage,
         const QString &groupHeader,
         const QStringList &imgModel,
         const QStringList &audModel,
         const QStringList &vidModel
         );

    QString id() const;
    QString postText() const;
    QString date() const;
    QString likes() const;
    QString reposts() const;
    QString comments() const;
    QString type() const;
    QString groupImage() const;
    QString groupHeader() const;
    QStringList imgModel() const;
    QStringList audModel() const;
    QStringList vidModel() const;

   // post_type
   // attachments -

private:
    QString m_id;
    QString m_postText;
    QString m_date;
    QString m_likes;
    QString m_reposts;
    QString m_comments;
    QString m_type;
    QString m_groupImage;
    QString m_groupHeader;
    QStringList m_imgModel;
    QStringList m_audModel;    
    QStringList m_vidModel;

};

class PostModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum PostRoles {
        IdRole = Qt::UserRole + 1,
        PostTextRole,
        DateRole,
        LikesRole,
        RepostsRole,
        CommentsRole,
        TypeRole,
        GroupImageRole,
        GroupHeaderRole,
        ImgModelRole,
        AudModelRole,
        VidModelRole
    };

    PostModel(QObject *parent = 0);


    void addPost(const Post &post);



     Q_INVOKABLE int count() const { return m_posts.size(); }

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<Post> m_posts;
};

#endif // POSTMODEL_H
