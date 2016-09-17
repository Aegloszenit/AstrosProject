#ifndef JSONDATARECEIVER_H
#define JSONDATARECEIVER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>
#include <QGuiApplication>
#include <QJsonDocument>
#include <QCoreApplication>
#include <QVariant>
#include <QVariantMap>
#include <QVariantList>


class JsonDataReceiver : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString date READ date WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(QString image READ image WRITE setImage NOTIFY imageChanged)
    Q_PROPERTY(QString image_hd READ image_hd WRITE setImage_hd NOTIFY image_hdChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString explanation READ explanation WRITE setExplanation NOTIFY explanationChanged)
    Q_PROPERTY(QString media_type READ media_type WRITE setMedia_type NOTIFY media_typeChanged)
    Q_PROPERTY(QString curiosity_images READ curiosity_images WRITE setCuriosity_images NOTIFY curiosity_imagesChanged)
    Q_PROPERTY(QString search_older_photos READ search_older_photos WRITE setSearch_older_photos NOTIFY search_older_photosChanged)
    Q_PROPERTY(QList<QString> curiosity_photos READ curiosity_photos WRITE setCuriosity_photos NOTIFY curiosity_photosChanged)
    Q_PROPERTY(QList<QString> iss_people READ iss_people WRITE setIss_people NOTIFY iss_peopleChanged)

public:
    explicit JsonDataReceiver(QObject *parent = 0);

    QString date() const;
    void setDate(QString val);

    QString image() const;
    void setImage(QString val);

    QString image_hd() const;
    void setImage_hd(QString val);

    QString title() const;
    void setTitle(QString val);

    QString explanation() const;
    void setExplanation(QString val);

    QString media_type() const;
    void setMedia_type(QString val);

    QString curiosity_images() const;
    void setCuriosity_images(QString val);

    QString search_older_photos() const;

    QList<QString> curiosity_photos() const;
    void setCuriosity_photos(QList<QString> the_list);

    QList<QString> iss_people() const;
    void setIss_people(QList<QString> the_iss_gent);

signals:
    void dateChanged();
    void imageChanged();
    void image_hdChanged();
    void titleChanged();
    void explanationChanged();
    void media_typeChanged();
    void curiosity_imagesChanged();
    void search_older_photosChanged();
    void curiosity_photosChanged();
    void iss_peopleChanged();
public slots:
    void setSearch_older_photos(QString older_date);

private:
    QNetworkAccessManager access_apod;
    QString the_date;
    QString the_image;
    QString the_image_hd;
    QString the_title;
    QString the_explanation;
    QString the_media_type;
    QString the_curiosity_images;
    QString the_search_older_photos;
    QList<QString> the_curiosity_photos;
    QList<QString> the_iss_people;

};

#endif // JSONDATARECEIVER_H
