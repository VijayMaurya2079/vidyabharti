import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_detail_view.dart';
import 'package:vidyabharti/models/news_detail_view_bloc.dart';
import 'package:vidyabharti/models/newslist.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/news_detail_templete.dart';
import 'package:vidyabharti/widgets/news_edit_buttons.dart';
import 'package:vidyabharti/widgets/no_news_templete.dart';

class NewsApprovalNewsDetailPage extends StatefulWidget {
  final NewsList id;
  NewsApprovalNewsDetailPage({this.id});

  @override
  _NewsApprovalNewsDetailPagelState createState() =>
      _NewsApprovalNewsDetailPagelState();
}

class _NewsApprovalNewsDetailPagelState
    extends State<NewsApprovalNewsDetailPage> {
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    newsBloc.list(widget.id.pk_new_news_id);
    super.initState();
  }

  @override
  void dispose() {
    utill.isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            StreamBuilder<NewsViewDetail>(
              stream: newsBloc.getNews,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return NoNews(newsId: widget.id.pk_new_news_id);
                  default:
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          NewsDetailTemplete(newsDetail: snapshot.data),
                          SizedBox(height: 10.0),
                          actionButtons(
                            snapshot.data.transaction_status,
                            snapshot.data,
                          ),
                        ],
                      );
                    } else {
                      return NoNews(newsId: widget.id.pk_new_news_id);
                    }
                }
              },
            ),
            AppBar(
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NewsEditButtons(widget.id.pk_new_news_id),
    );
  }

  actionButtons(String transaction_status, NewsViewDetail news) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          transaction_status == "0"
              ? RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.greenAccent,
                  colorBrightness: Brightness.light,
                  child: Text(
                    "Approve",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => approveNews(news),
                )
              : transaction_status == "1"
                  ? RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.redAccent,
                      colorBrightness: Brightness.light,
                      child: Text(
                        "Disapprove",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => disapproveNews(news),
                    )
                  : Container(),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.redAccent,
            colorBrightness: Brightness.light,
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => deletenews(news),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.blueAccent,
            colorBrightness: Brightness.light,
            child: Text(
              "Change Level",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => showLevelList(news.pk_new_news_id),
          ),
        ],
      ),
    );
  }

  approveNews(NewsViewDetail news) async {
    await newsBloc.approve(news.pk_new_news_id);
    db.sendPush(
      "Vidya Bharti Online News",
      news.news_title,
      news.pk_new_news_id,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("News Approved successfully"),
        );
      },
    );
  }

  disapproveNews(NewsViewDetail news) async {
    await newsBloc.disapprove(news.pk_new_news_id);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("News Disapproved successfully"),
        );
      },
    );
  }

  deletenews(NewsViewDetail news) async {
    await newsBloc.delete(news.pk_new_news_id);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("News deleted successfully"),
        );
      },
    );
  }

  showLevelList(id) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Select News Level",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Country"),
              onTap: () => chengeLevel(id, "Country"),
            ),
            ListTile(
              title: Text("Kshetra"),
              onTap: () => chengeLevel(id, "Kshetra"),
            ),
            ListTile(
              title: Text("Prant"),
              onTap: () => chengeLevel(id, "Prant"),
            ),
            ListTile(
              title: Text("Mahanagar"),
              onTap: () => chengeLevel(id, "Mahanagar"),
            ),
            ListTile(
              title: Text("Nagar"),
              onTap: () => chengeLevel(id, "Nagar"),
            ),
            ListTile(
              title: Text("School"),
              onTap: () => chengeLevel(id, "School"),
            ),
          ],
        );
      },
    );
  }

  chengeLevel(id, level) async {
    await newsBloc.changeLevel(id, level);
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("News level changed successfully"),
        );
      },
    );
  }
}
