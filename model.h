#ifndef MAINWINDOW_H
#define MAINWINDOW_H
#include <QAbstractListModel>
#include <QStringList>

//![0]
class Animal 
{
public:
    Animal(const QString &type, const QString &size, const QString &Picture);
//![0]

    QString type() const;
    QString size() const;
    QString picture() const;

private:
    QString m_type;
    QString m_size;
    QString m_picture;
//![1]
};

class AnimalModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum AnimalRoles {
        TypeRole = Qt::UserRole + 1,
        SizeRole,
        PictureRole
    };

    AnimalModel(QObject *parent = 0);
//![1]

    void addAnimal(const Animal &animal);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<Animal> m_animals;
//![2]
};
//![2]

#endif // MAINWINDOW_H

