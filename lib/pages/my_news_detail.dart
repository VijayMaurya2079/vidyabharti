import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_detail_view.dart';
import 'package:vidyabharti/models/news_detail_view_bloc.dart';
import 'package:vidyabharti/models/newslist.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/widgets/news_detail_templete.dart';
import 'package:vidyabharti/widgets/news_edit_buttons.dart';
import 'package:vidyabharti/widgets/no_news_templete.dart';
import 'package:vidyabharti/provider/db.dart';

class MyNewsDetail extends StatefulWidget {
  final NewsList id;
  MyNewsDetail({this.id});

  @override
  _MyNewsDetailState createState() => _MyNewsDetailState();
}

class _MyNewsDetailState extends State<MyNewsDetail> {
  NewsViewDetail _news;

  @override
  void initState() {
    newsBloc.list(widget.id.pk_new_news_id);
    super.initState();
  }

  Future<NewsViewDetail> getNews() async {
    Result result = await db.newsDetail(widget.id.pk_new_news_id);
    _news = result.data
        .map<NewsViewDetail>((i) => NewsViewDetail.fromJson(i))
        .toList()[0];
    return _news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    return Column(
                      children: <Widget>[
                        NewsDetailTemplete(newsDetail: snapshot.data),
                      ],
                    );
                }
              },
            ),
            AppBar(backgroundColor: Colors.transparent),
          ],
        ),
      ),
      bottomNavigationBar:NewsEditButtons( widget.id.pk_new_news_id)
          //widget.id.transaction_status == "0" ? _bottomButtons() : SizedBox(),
    );
  }

  // Widget _bottomButtons() {
  //   return Container(
  //     color: Colors.grey.withOpacity(0.2),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         Material(
  //           color: Colors.blueAccent,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(50.0),
  //           ),
  //           child: IconButton(
  //             icon: Icon(
  //               Icons.edit,
  //               color: Colors.white,
  //             ),
  //             onPressed: () => Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) =>
  //                         EditNewContent(widget.id.pk_new_news_id),
  //                   ),
  //                 ),
  //           ),
  //         ),
  //         Material(
  //           color: Colors.blueGrey,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(50.0),
  //           ),
  //           child: IconButton(
  //             icon: Icon(
  //               Icons.image,
  //               color: Colors.white,
  //             ),
  //             onPressed: () => Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => UploadNewsData(
  //                           widget.id.pk_new_news_id,
  //                           true,
  //                         ),
  //                   ),
  //                 ),
  //           ),
  //         ),
  //         Material(
  //           color: Colors.redAccent,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(50.0),
  //           ),
  //           child: IconButton(
  //             icon: Icon(
  //               Icons.delete_sweep,
  //               color: Colors.white,
  //             ),
  //             onPressed: () => Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) =>
  //                         EditNewsDeleteImages(id: widget.id.pk_new_news_id),
  //                   ),
  //                 ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
