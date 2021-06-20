import 'dart:async';

import 'package:vidyabharti/models/notice_model.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';

class NoticeBloc {
  final _noticeController = StreamController<List<NoticeModel>>.broadcast();
  final _countController = StreamController<String>.broadcast();

  Stream get getNoticeList => _noticeController.stream;
  Stream get getCount => _countController.stream;

  void dispose() {
    _noticeController.close();
    _countController.close();
  }

  noticeList() async {
    Result result = await db.noticelist();
    print("${result.toJson()}");
    final _news =
        result.data.map<NoticeModel>((i) => NoticeModel.fromJson(i)).toList();
    _noticeController.sink.add(_news);
  }

  count() async {
    Result result = await db.noticecount();
    final _news = result.data.toString();
    _countController.sink.add(_news);
  }
}

final noticeBloc = new NoticeBloc();
