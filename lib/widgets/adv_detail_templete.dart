import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:vidyabharti/models/ad_video.dart';
import 'package:vidyabharti/models/news_activities_bloc.dart';
import 'package:vidyabharti/pages/ad_video_list.dart';
import 'package:vidyabharti/pages/adv_comments.dart';
import 'package:vidyabharti/widgets/video_activity_count.dart';
import 'package:vidyabharti/widgets/youtube_videos.dart';

class AdvDetailPage extends StatefulWidget {
  final AdVideos video;
  AdvDetailPage(this.video);

  @override
  _AdvDetailPageState createState() => _AdvDetailPageState();
}

class _AdvDetailPageState extends State<AdvDetailPage> {
  TextEditingController _commentController;
  FocusNode _commentFocus;

  @override
  void initState() {
    super.initState();
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
                  YoutubeVideos(widget.video.path),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.video.act_date ?? "",
                              style: TextStyle(fontSize: 20),
                            ),
                            VideoActivityCounts(id: widget.video.id),
                          ],
                        ),
                        Text(
                          widget.video.title ?? "",
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
                      child: AdvComments(widget.video.id),
                    ),
                  )
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdVideoList(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Share.share("${widget.video.title} ${widget.video.path}");
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
                widget.video.id,
                _commentController.text,
              );
              _commentController.text = "";
              _commentFocus.unfocus();
              await newsActivitiesBloc.viewComment(widget.video.id);
            },
          ),
        ),
      ),
    );
  }
}
