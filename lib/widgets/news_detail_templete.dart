import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_detail_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:extended_image/extended_image.dart';

class NewsDetailTemplete extends StatefulWidget {
  final NewsViewDetail newsDetail;
  NewsDetailTemplete({Key key, this.newsDetail}) : super(key: key);

  _NewsDetailTempleteState createState() => _NewsDetailTempleteState();
}

class _NewsDetailTempleteState extends State<NewsDetailTemplete> {
  String main_image = "";
  YoutubePlayerController yctrl;
  @override
  void initState() {
    super.initState();

    main_image = widget.newsDetail.image_path == null
        ? ""
        : widget.newsDetail.image_path.replaceAll("/thumb", "");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            newsImage(widget.newsDetail),
            SizedBox(
              height: 2.0,
              child: Container(color: Colors.grey),
            ),
            otherNewsImages(widget.newsDetail),
            SizedBox(height: 10.0),
            newsDetail(widget.newsDetail),
            SizedBox(height: 10.0),
            showVideos(widget.newsDetail),
          ],
        ),
      ),
    );
  }

  noNews() {
    return Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: "primary_image" + widget.newsDetail.pk_new_news_id,
            child: Container(
              height: 220.0,
              color: Colors.black,
              child: Image.asset(
                "assets/default_image.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 250.0,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepOrange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  newsImage(data) {
    if (data.image_path == null) {
      return Hero(
        tag: "primary_image" + data.pk_new_news_id,
        child: Image.asset(
          "assets/default_image.png",
        ),
      );
    } else {
      return Hero(
        tag: "primary_image" + data.pk_new_news_id,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return ViewNewsImage(
                  id: "popup_image",
                  url: main_image,
                );
              },
            );
          },
          child: FadeInImage.assetNetwork(
            placeholder: "assets/default_image.png",
            image: main_image, //data.image_path,
          ),
        ),
      );
    }
  }

  otherNewsImages(data) {
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: data.images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: GestureDetector(
              child: Hero(
                tag: "popup_image" + index.toString(),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/default_image.png",
                  image: data.images[index].image_path,
                  height: 80.0,
                ),
              ),
              onTap: () {
                setState(() {
                  main_image = data.images[index].image_path
                      .toString()
                      .replaceAll("/thumb", "");
                });
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ViewNewsImage(
                      id: "popup_image" + index.toString(),
                      url: data.images[index].image_path,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  newsDetail(data) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.news_title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Text(
                "By ${data.user_name ?? '--'}",
                style: TextStyle(fontSize: 11.0),
              ),
              SizedBox(width: 10.0),
              Text(
                data.post_date,
                style: TextStyle(fontSize: 11.0),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(data.news_text),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }

  showVideos(data) {
    return Container(
      // height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: data.videos == null ? 0 : data.videos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId:
                    YoutubePlayer.convertUrlToId(data.videos[index].path),
              ),
              showVideoProgressIndicator: true,
            ),
          );
        },
      ),
    );
  }
}

class ViewNewsImage extends StatelessWidget {
  final String id;
  final String url;
  ViewNewsImage({Key key, this.id, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        child: ExtendedImage.network(
          getUrl(),
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: (state) {
            return GestureConfig(
                minScale: 0.9,
                animationMinScale: 0.7,
                maxScale: 3.0,
                animationMaxScale: 3.5,
                inertialSpeed: 100.0,
                speed: 1.0,
                initialScale: 1.0,
                inPageView: false);
          },
        ),
      ),
    );
  }

  getUrl() {
    return url.replaceAll("/thumb", "");
  }
}
