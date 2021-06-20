import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:vidyabharti/models/ad_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowAdVideo extends StatefulWidget {
  final AdVideos ad;
  ShowAdVideo(this.ad);

  @override
  _ShowAdVideoState createState() => _ShowAdVideoState();
}

class _ShowAdVideoState extends State<ShowAdVideo> {
  YoutubePlayerController yctrl;

  @override
  void initState() {
    super.initState();
    yctrl = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.ad.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${widget.ad.title}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              YoutubePlayer(
                controller: yctrl,
                showVideoProgressIndicator: true,
              ),
              FlatButton(
                child: Icon(Icons.close, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
