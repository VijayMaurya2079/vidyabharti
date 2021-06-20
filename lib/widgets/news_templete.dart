import 'package:flutter/material.dart';
import 'package:vidyabharti/models/newslist.dart';

class NewsTemplete extends StatelessWidget {
  final NewsList newsList;
  final Widget redirect;
  const NewsTemplete({Key key, this.newsList, this.redirect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          newsDetail(newsList, MediaQuery.of(context).size.width * 0.70),
          showImage(newsList, MediaQuery.of(context).size.width * 0.23),
        ],
      ),
    );
  }

  newsDetail(NewsList newsList, double width) {
    return Container(
      padding: EdgeInsets.only(right: 5.0),
      width: width,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              newsList.news_title,
              overflow: TextOverflow.fade,
              maxLines: 3,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                //fontSize: 14.0,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 12.0,
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      newsList.user_name??"--",
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    color: Colors.grey,
                    size: 12.0,
                  ),
                  Text(
                    newsList.post_date,
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 11.0),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  showImage(NewsList newsList, double width) {
    if (newsList.image_path == null) {
      return Container(
        width: width,
        height: 100.0,
        child: Hero(
          tag: "primary_image" + newsList.pk_new_news_id,
          child: Image.asset(
            "assets/default_image.png",
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        width: width,
        height: 100.0,
        child: Hero(
          tag: "primary_image" + newsList.pk_new_news_id,
          child: FadeInImage.assetNetwork(
            placeholder: "assets/default_image.png",
            image: newsList.image_path,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
