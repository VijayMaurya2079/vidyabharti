import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideos extends StatefulWidget {
  final String path;
  YoutubeVideos(this.path);

  @override
  _YoutubeVideosState createState() => _YoutubeVideosState();
}

class _YoutubeVideosState extends State<YoutubeVideos> {
  YoutubePlayerController yctrl;

  @override
  void initState() {
    super.initState();
    print(widget.path);
    yctrl = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.path),
      flags: YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: yctrl,
      bufferIndicator: Text(
        "Loading...",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      showVideoProgressIndicator: true,
    );
  }
}
