#include "postmodel.h"

Post::Post(const QString &id,
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
           )
    : m_id(id),
      m_postText(postText),
      m_date(date),
      m_likes(likes),
      m_reposts(reposts),
      m_comments(comments),
      m_type(type),
      m_groupImage(groupImage),
      m_groupHeader(groupHeader),
      m_imgModel(imgModel),
      m_audModel(audModel),
      m_vidModel(vidModel)
{
}

QString Post::id() const
{
    return m_id;
}

QString Post::postText() const
{
    return m_postText;
}

QString Post::date() const
{
    return m_date;
}

QString Post::likes() const
{
    return m_likes;
}

QString Post::reposts() const
{
    return m_reposts;
}

QString Post::comments() const
{
    return m_comments;
}

QString Post::type() const
{
    return m_type;
}

QString Post::groupImage() const
{
    return m_groupImage;
}

QString Post::groupHeader() const
{
    return m_groupHeader;
}

QStringList Post::imgModel() const
{
    return m_imgModel;
}

QStringList Post::audModel() const
{
    return m_audModel;
}

QStringList Post::vidModel() const
{
    return m_vidModel;
}

PostModel::PostModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

void PostModel::addPost(const Post &post)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_posts << post;
    endInsertRows();
    emit dataChanged(QModelIndex(),QModelIndex());
}

int PostModel::rowCount(const QModelIndex & parent) const {
    return m_posts.count();
}

QVariant PostModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_posts.count())
        return QVariant();

    const Post &post = m_posts[index.row()];
    if (role == IdRole)
        return post.id();
    else if (role == PostTextRole)
        return post.postText();
    else if (role == DateRole)
        return post.date();
    else if (role == LikesRole)
        return post.likes();
    else if (role == RepostsRole)
        return post.reposts();
    else if (role == CommentsRole)
        return post.comments();
    else if (role == TypeRole)
        return post.type();
    else if (role == GroupImageRole)
        return post.groupImage();
    else if (role == GroupHeaderRole)
        return post.groupHeader();
    else if (role == ImgModelRole)
        return post.imgModel();
    else if (role == AudModelRole)
        return post.audModel();
    else if (role == VidModelRole)
        return post.vidModel();

    return QVariant();
}

QHash<int, QByteArray> PostModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[PostTextRole] = "postText";
    roles[DateRole] = "date";
    roles[LikesRole] = "likes";
    roles[RepostsRole] = "reposts";
    roles[CommentsRole] = "comments";
    roles[TypeRole] = "type";
    roles[GroupImageRole] = "groupImage";
    roles[GroupHeaderRole] = "groupHeader";
    roles[ImgModelRole] = "imgModel";
    roles[AudModelRole] = "audModel";
    roles[VidModelRole] = "vidModel";

    return roles;
}
