import 'dart:async';

import 'package:vidyabharti/models/news_activities.dart';
import 'package:vidyabharti/models/news_activity.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';

class NewsActivitiesBloc {
  final _newsActivityController = StreamController<NewsActivities>.broadcast();

  final _newsCommentsController =
      StreamController<List<NewsActivity>>.broadcast();
  Stream get getNewsAtivities => _newsActivityController.stream;
  Stream get getNewsComments => _newsCommentsController.stream;

  void dispose() {
    _newsActivityController.close();
    _newsCommentsController.close();
  }

  get(id) async {
    Result result = await db.newsActivities(id);
    final _news = NewsActivities.fromJson(result.data);
    _newsActivityController.sink.add(_news);
  }

  hitLike(id) async {
    NewsActivity act = NewsActivity();
    act.fk_new_news_id = id;
    act.activity_source = "Mobile";
    act.activity_type = "Like";
    act.fk_mum_user_id = await utill.getString("id");
    Result result = await db.addNewsActivities(act);
    if (result.status) get(id);
  }

  hitDislike(id) async {
    NewsActivity act = NewsActivity();
    act.fk_new_news_id = id;
    act.activity_source = "Mobile";
    act.activity_type = "Dislike";
    act.fk_mum_user_id = await utill.getString("id");
    if (act.fk_mum_user_id.isEmpty) {
      return;
    }
    Result result = await db.addNewsActivities(act);
    if (result.status) get(id);
  }

  addComment(id, comment) async {
    NewsActivity act = NewsActivity();
    act.fk_new_news_id = id;
    act.activity_source = "Mobile";
    act.activity_type = "Comment";
    act.news_comment = comment;
    act.fk_mum_user_id = await utill.getString("id");
    Result result = await db.addNewsActivities(act);
    if (result.status) get(id);
  }

  viewComment(id) async {
    Result result = await db.newsComments(id);
    final comments =
        result.data.map<NewsActivity>((i) => NewsActivity.fromJson(i)).toList();
    _newsCommentsController.sink.add(comments);
  }
}

final newsActivitiesBloc = NewsActivitiesBloc();
