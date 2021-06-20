import 'dart:async';

import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/models/newslist.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';

class NewsListBloc {
  final _newsController = StreamController<List<NewsList>>.broadcast();
  final _myNewsController = StreamController<List<NewsList>>.broadcast();
  final _approveNewsController = StreamController<List<NewsList>>.broadcast();
  final _filterNewsController = StreamController<List<NewsList>>.broadcast();
  final List<NewsList> _news = [];

  Stream get getNewsList => _newsController.stream;
  Stream get getMyNewsList => _myNewsController.stream;
  Stream get getApprovalNewsList => _approveNewsController.stream;
  Stream get getFilterNewsList => _filterNewsController.stream;

  void dispose() {
    _newsController.close();
    _myNewsController.close();
    _approveNewsController.close();
    _filterNewsController.close();
    //_news.clear();
  }

  list(int page) async {
    Result result = await db.newsList(page);
    print("Page No From Server ::: ${result.message}");
    if (result.data.length > 0) {
      final _news =
          result.data.map<NewsList>((i) => NewsList.fromJson(i)).toList();
      _newsController.sink.add(_news);
    }
  }

  mylist(String status) async {
    String id = await utill.getString("id");
    Result result = await db.myNewsList(id, status);
    final _list = result.data.map<NewsList>((i) => NewsList.fromJson(i)).toList();
    _myNewsController.sink.add(_list);
  }

  filterlist(NewsApprovalFilter filter) async {
    Result result = await db.filterNewsList(filter);
    final _news =
        result.data.map<NewsList>((i) => NewsList.fromJson(i)).toList();
    _filterNewsController.sink.add(_news);
  }

  approvallist(NewsApprovalFilter filter) async {
    Result result = await db.approveNewsList(filter);
    print("${result.toJson()}");
    final _news =
        result.data.map<NewsList>((i) => NewsList.fromJson(i)).toList();
    _approveNewsController.sink.add(_news);
  }
}

final newsListBloc = new NewsListBloc();
