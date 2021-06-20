import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:vidyabharti/models/news_activities_bloc.dart';
import 'package:vidyabharti/models/social_initiatives.dart';
import 'package:vidyabharti/pages/adv_comments.dart';
import 'package:vidyabharti/widgets/video_activity_count.dart';
import 'package:vidyabharti/widgets/youtube_videos.dart';

class SocialDetailPage extends StatefulWidget {
  final SocialMedia media;
  SocialDetailPage(this.media);

  @override
  _SocialDetailPageState createState() => new _SocialDetailPageState();
}

class _SocialDetailPageState extends State<SocialDetailPage> {
  TextEditingController _commentController;
  FocusNode _commentFocus;

  @override
  void initState() {
    super.initState();
    print(widget.media);
    _commentController = TextEditingController();
    _commentFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getMedia(widget.media),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.media.activity_date ?? "",
                              style: TextStyle(fontSize: 20),
                            ),
                            VideoActivityCounts(
                                id: widget.media.pk_soc_activitymedia_id),
                          ],
                        ),
                        Text(
                          widget.media.media_title ?? "",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: commentBox(),
                  ),
                  Container(
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AdvComments(widget.media.pk_soc_activitymedia_id),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Share.share("${widget.media.media_title} ${widget.media.image_path}");
        },
        child: Icon(Icons.share),
      ),
    );
  }

  commentBox() {
    return TextField(
      controller: _commentController,
      focusNode: _commentFocus,
      autocorrect: false,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      maxLines: null,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: "Write comment",
        suffix: Container(
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              print(_commentController.text);
              await newsActivitiesBloc.addComment(
                widget.media.pk_soc_activitymedia_id,
                _commentController.text,
              );
              _commentController.text = "";
              _commentFocus.unfocus();
              await newsActivitiesBloc
                  .viewComment(widget.media.pk_soc_activitymedia_id);
            },
          ),
        ),
      ),
    );
  }

  getMedia(SocialMedia data) {
    if (data.media_type == "Image") {
      return FadeInImage.assetNetwork(
        image: widget.media.image_path,
        placeholder: "assets/default_image.png",
      );
    } else if (data.media_type == "Video") {
      return YoutubeVideos(widget.media.video_path);
    } else {
      return "";
    }
  }
}
