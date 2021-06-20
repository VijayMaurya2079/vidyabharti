import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_activities_bloc.dart';
import 'package:vidyabharti/models/news_detail_view.dart';
import 'package:vidyabharti/models/news_detail_view_bloc.dart';
import 'package:vidyabharti/models/newslist.dart';
import 'package:vidyabharti/pages/dashboard.dart';
import 'package:vidyabharti/pages/news_comments.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/widgets/news_activity_counts.dart';
import 'package:vidyabharti/widgets/news_detail_templete.dart';
import 'package:vidyabharti/widgets/no_news_templete.dart';
import 'package:share/share.dart';

class NewsDetail extends StatefulWidget {
  final NewsList id;
  NewsDetail({this.id});

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  TextEditingController _commentController;
  FocusNode _commentFocus;
  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _commentFocus = FocusNode();
    newsBloc.list(widget.id.pk_new_news_id);
    newsActivitiesBloc.viewComment(widget.id.pk_new_news_id);
    _commentController.addListener(() {
      print(_commentController.text);
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                newsDetail(),
                NewsActivityCounts(id: widget.id.pk_new_news_id),
                commentBox(),
                Container(
                  height: 300,
                  child: NewsComments(id: widget.id.pk_new_news_id),
                )
              ],
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
                        builder: (context) => DashboardPage(),
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
        onPressed: () async {
          var data = await db.share();
          Share.share(
              "http://vidyabhartionline.org/school-news.php?id=${widget.id.pk_new_news_id} \n ${data}");
        },
        child: Icon(Icons.share),
      ),
    );
  }

  commentBox() {
    return TextField(
      controller: _commentController,
      focusNode: _commentFocus,
      autocorrect: true,
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
                widget.id.pk_new_news_id,
                _commentController.text,
              );
              _commentController.text = "";
              _commentFocus.unfocus();
              await newsActivitiesBloc.viewComment(widget.id.pk_new_news_id);
            },
          ),
        ),
      ),
    );
  }

  newsDetail() {
    return StreamBuilder<NewsViewDetail>(
      stream: newsBloc.getNews,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return NoNews(newsId: widget.id.pk_new_news_id);
          default:
            return NewsDetailTemplete(newsDetail: snapshot.data);
        }
      },
    );
  }
}
