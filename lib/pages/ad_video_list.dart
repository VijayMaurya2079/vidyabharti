import 'package:flutter/material.dart';
import 'package:vidyabharti/models/ad_video.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/widgets/adv_detail_templete.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AdVideoList extends StatefulWidget {
  @override
  _AdVideoListState createState() => new _AdVideoListState();
}

class _AdVideoListState extends State<AdVideoList> {
  List<AdVideos> list = List<AdVideos>();
  bool loading = true;
  int page = 0;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    Result result = await db.adVideoListPageWise(page);
    setState(() {
      list.addAll(
          result.data.map<AdVideos>((x) => AdVideos.fromJson(x)).toList());
      print(list.length);
      page += result.data.length;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Videos",
      child: ListView(
        children: <Widget>[
          ...list.map((e) => videoCard(e)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              loading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : RaisedButton(
                      onPressed: () {
                        setState(() => loading = true);
                        getdata();
                      },
                      child: Text("Load More"),
                    )
            ],
          )
        ],
      ),
    );
  }

  Widget videoCard(video) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdvDetailPage(video),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.network(
                "https://i3.ytimg.com/vi/${YoutubePlayer.convertUrlToId(video.path)}/sddefault.jpg",
                fit: BoxFit.cover,
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        video.act_date ?? "",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Text(
                    video.title ?? "",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
