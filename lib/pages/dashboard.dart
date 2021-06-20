import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vidyabharti/models/newslist.dart';
import 'package:vidyabharti/models/newslist_block.dart';
import 'package:vidyabharti/pages/add_news.dart';
import 'package:vidyabharti/pages/auth.dart';
import 'package:vidyabharti/pages/news_detail.dart';
import 'package:vidyabharti/pages/notice/NoticeBloc.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/news_templete.dart';

import 'package:vidyabharti/widgets/style.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  List<NewsList> list = [];
  ScrollController _controller;
  int page = 0;

  @override
  initState() {
    noticeBloc.count();

    page = 0;
    list = [];
    newsListBloc.list(page);
    _controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    //newsListBloc.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent - 10 &&
        !_controller.position.outOfRange) {
      setState(() {
        page += 1;
        print("Page Number $page");
      });
      newsListBloc.list(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      // title: newsListBloc.page.toString(),
      child: Container(
        decoration: appStyle.authBox(),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          semanticsLabel: "Loading News...",
          displacement: 20.0,
          onRefresh: reLoadNews,
          child: StreamBuilder<List<NewsList>>(
            stream: newsListBloc.getNewsList,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  //case ConnectionState.active:
                  print("API status waiting");
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                      ),
                    ),
                  );
                default:
                  return newsList(snapshot);
              }
            },
          ),
        ),
      ),
      floatingChild: FloatingActionButton(
        backgroundColor: Colors.red,
        //child: Text("$page"),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: addNewNews,
      ),
    );
  }

  newsList(snapshot) {
    list.addAll(snapshot.data);
    return ListView.builder(
      controller: _controller,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        NewsList nl = list[index];
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewsDetail(id: nl),
                ),
              );
            },
            child: NewsTemplete(newsList: nl));
      },
    );
  }

  addNewNews() async {
    String userid = await utill.getString("id");
    if (userid == null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (contex) => AuthPage()),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (contex) => AddNews()),
      );
    }
  }

  Future<Null> reLoadNews() async {
    await newsListBloc.list(0);
    return null;
  }
}
