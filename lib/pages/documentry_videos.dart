import 'package:flutter/material.dart';
import 'package:vidyabharti/models/ad_video.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/widgets/adv_detail_templete.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DocumentoryVideoList extends StatefulWidget {
  @override
  _DocumentoryVideoListState createState() => new _DocumentoryVideoListState();
}

class _DocumentoryVideoListState extends State<DocumentoryVideoList> {
  List<AdVideos> list = List<AdVideos>();
  bool loading = true;
  int page = 0;

  @override
  void initState() {
    super.initState();
    // db.documentryVideoList().then((Result result) {
    //   setState(() {
    //     list = result.data.map<AdVideos>((x) => AdVideos.fromJson(x)).toList();
    //   });
    // });
    getdata();
  }

  getdata() async {
    Result result = await db.documentryVideoListPageWise(page);
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
      title: "Documentry Videos",
      child: ListView(
        children: <Widget>[
          ...list.map((e) => videocard(e)),
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

  Widget videocard(video) {
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
