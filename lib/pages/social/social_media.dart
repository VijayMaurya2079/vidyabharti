import 'package:flutter/material.dart';
import 'package:vidyabharti/models/social_initiatives.dart';
import 'package:vidyabharti/pages/social/detail.dart';
import 'package:vidyabharti/pages/social/social_bloc.dart';
import 'package:vidyabharti/widgets/style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SocialMediaPage extends StatefulWidget {
  final String social;
  SocialMediaPage(this.social);

  @override
  _SocialMediaPageState createState() => new _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  @override
  void initState() {
    super.initState();
    socialBloc.dataList(widget.social);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: appStyle.authBox(),
      child: StreamBuilder(
        stream: socialBloc.getSocialDataList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SocialDetailPage(snapshot.data[index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Material(
                        elevation: 2.0,
                        child: Material(
                          elevation: 2.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data[index].media_title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                child: Image.network(
                                  getImage(snapshot.data[index]),
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }

  getImage(SocialMedia data) {
    if (data.media_type == "Image") {
      return "https://i3.ytimg.com/vi/${YoutubePlayer.convertUrlToId(data.video_path)}/sddefault.jpg";
    } else if (data.media_type == "Video") {
      return "https://i3.ytimg.com/vi/${YoutubePlayer.convertUrlToId(data.video_path)}/sddefault.jpg";
    } else {
      return "";
    }
  }
}
