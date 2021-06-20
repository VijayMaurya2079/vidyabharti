import 'dart:async';

import 'package:vidyabharti/models/news_detail_view.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';

class NewsDetailViewBloc {
  final _newsController = StreamController<NewsViewDetail>.broadcast();
  Stream get getNews => _newsController.stream;

  void dispose() {
    _newsController.close();
  }

  list(String id) async {
    Result result = await db.newsDetail(id);
    NewsViewDetail _news = result.data
        .map<NewsViewDetail>((i) => NewsViewDetail.fromJson(i))
        .toList()[0];
    _newsController.sink.add(_news);
  }

  approve(id) async {
    await db.approve(id);
    list(id);
  }

  disapprove(id) async {
    await db.disapprove(id);
    list(id);
  }

  delete(id) async {
    await db.deletenews(id);
    list(id);
  }

  changeLevel(id, level) async {
    await db.changeLevel(id, level);
    list(id);
  }
}

final newsBloc = new NewsDetailViewBloc();
