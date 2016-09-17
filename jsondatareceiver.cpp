#include "jsondatareceiver.h"

JsonDataReceiver::JsonDataReceiver(QObject *parent) : QObject(parent)
{
    /*
    QNetworkAccessManager nett;

    QUrl url("https://api.nasa.gov/planetary/apod?api_key=grby9Q3yUSBHLrcDHxmpvYjadTyJ9FFAQpxBbBHR");

    QNetworkRequest request;
    request.setUrl(url);
    QNetworkReply *reply = nett.get(request);

    */

    QEventLoop eventLoop;
    connect(&access_apod, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("https://api.nasa.gov/planetary/apod?api_key=grby9Q3yUSBHLrcDHxmpvYjadTyJ9FFAQpxBbBHR")));
    QNetworkReply *reply = access_apod.get(req);
    eventLoop.exec();

    if (reply->error() == QNetworkReply::NoError) {
        QString strReply = (QString) reply->readAll();


        QJsonDocument json_response = QJsonDocument::fromJson(strReply.toUtf8());
        QJsonObject json_obj = json_response.object();


        the_date = json_obj["date"].toString();
        the_image = json_obj["url"].toString();
        the_image_hd = json_obj["hdurl"].toString();
        the_title = json_obj["title"].toString();
        the_explanation = json_obj["explanation"].toString();
        the_media_type = json_obj["media_type"].toString();

    }

    //https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=grby9Q3yUSBHLrcDHxmpvYjadTyJ9FFAQpxBbBHR

    QEventLoop second_eventloop;
    connect(&access_apod, SIGNAL(finished(QNetworkReply*)), &second_eventloop, SLOT(quit()));
    QNetworkRequest curiosity_req(QUrl(QString("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=mast&api_key=grby9Q3yUSBHLrcDHxmpvYjadTyJ9FFAQpxBbBHR")));
    QNetworkReply *curiosity_reply = access_apod.get(curiosity_req);
    second_eventloop.exec();

    if (curiosity_reply->error() == QNetworkReply::NoError) {
        QString curiosity_str = (QString) curiosity_reply->readAll();
        QJsonDocument cur_json = QJsonDocument::fromJson((curiosity_str.toUtf8()));
        QJsonObject cur_object = cur_json.object();
        QJsonArray xx = cur_object["photos"].toArray();

        foreach (const QJsonValue & value, xx) {
            QJsonObject obj = value.toObject();

            the_curiosity_photos.append(obj["img_src"].toString());
        }

    }

    QEventLoop fourth_eventloop;
    connect(&access_apod, SIGNAL(finished(QNetworkReply*)), &fourth_eventloop, SLOT(quit()));
    QNetworkRequest iss_req(QUrl(QString("http://api.open-notify.org/astros.json")));
    QNetworkReply *iss_reply = access_apod.get(iss_req);
    fourth_eventloop.exec();

    if (iss_reply->error() == QNetworkReply::NoError) {
        QString iss_str = (QString) iss_reply->readAll();
        QJsonDocument iss_json = QJsonDocument::fromJson((iss_str.toUtf8()));
        QJsonObject iss_object = iss_json.object();
        QJsonArray iss_array = iss_object["people"].toArray();

        foreach (const QJsonValue & value, iss_array) {
            QJsonObject obj = value.toObject();

            the_iss_people.append(obj["name"].toString());
        }

    }

}


QString JsonDataReceiver::date() const
{
    return the_date;
}


void JsonDataReceiver::setDate(QString val)
{
    the_date = val;
    emit dateChanged();
}


QString JsonDataReceiver::image() const
{
    return the_image;
}


void JsonDataReceiver::setImage(QString val)
{
    the_image = val;
    emit imageChanged();
}


QString JsonDataReceiver::image_hd() const
{
    return the_image_hd;
}


void JsonDataReceiver::setImage_hd(QString val)
{
    the_image_hd = val;
    image_hdChanged();
}


QString JsonDataReceiver::title() const
{
    return the_title;
}


void JsonDataReceiver::setTitle(QString val)
{
    the_title = val;
    emit titleChanged();
}


QString JsonDataReceiver::explanation() const
{
    return the_explanation;
}


void JsonDataReceiver::setExplanation(QString val)
{
    the_explanation = val;
    emit explanationChanged();
}


QString JsonDataReceiver::media_type() const
{
    return the_media_type;
}


void JsonDataReceiver::setMedia_type(QString val)
{
    the_media_type = val;
    emit media_typeChanged();
}


QString JsonDataReceiver::curiosity_images() const
{
    return the_curiosity_images;
}


void JsonDataReceiver::setCuriosity_images(QString val)
{

}


QString JsonDataReceiver::search_older_photos() const
{
    return the_search_older_photos;
}


void JsonDataReceiver::setSearch_older_photos(QString older_date)
{
    QEventLoop eventLoop;
    connect(&access_apod, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    QNetworkRequest req(QUrl(QString("https://api.nasa.gov/planetary/apod?api_key=grby9Q3yUSBHLrcDHxmpvYjadTyJ9FFAQpxBbBHR&date=" + older_date)));
    QNetworkReply *reply = access_apod.get(req);
    eventLoop.exec();

    if (reply->error() == QNetworkReply::NoError) {
        QString strReply = (QString) reply->readAll();


        QJsonDocument json_response = QJsonDocument::fromJson(strReply.toUtf8());
        QJsonObject json_obj = json_response.object();
        setTitle(json_obj["title"].toString());
        setDate(json_obj["date"].toString());
        setImage(json_obj["url"].toString());
        setImage_hd(json_obj["hdurl"].toString());
        setExplanation(json_obj["explanation"].toString());
        setMedia_type(json_obj["media_type"].toString());



    }
}


QList<QString> JsonDataReceiver::curiosity_photos() const
{
    return the_curiosity_photos;
}


void JsonDataReceiver::setCuriosity_photos(QList<QString> the_list)
{

}


QList<QString> JsonDataReceiver::iss_people() const
{
    return the_iss_people;
}


void JsonDataReceiver::setIss_people(QList<QString> the_iss_gent)
{

}
