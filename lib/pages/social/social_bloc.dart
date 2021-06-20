import 'dart:async';

import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/social_initiatives.dart';
import 'package:vidyabharti/provider/db.dart';

class SocialBloc {
  final _socialController =
      StreamController<List<SocialInitiatives>>.broadcast();
  final _dataController = StreamController<List<SocialMedia>>.broadcast();
  Stream get getSocialTypeList => _socialController.stream;
  Stream get getSocialDataList => _dataController.stream;

  void dispose() {
    _socialController.close();
    _dataController.close();
  }

  typeList() async {
    Result result = await db.socialTypes();
    final _news = result.data
        .map<SocialInitiatives>((i) => SocialInitiatives.fromJson(i))
        .toList();
    _socialController.sink.add(_news);
  }

  dataList(String type) async {
    Result result = await db.socialdata(type);
    final _news =
        result.data.map<SocialMedia>((i) => SocialMedia.fromJson(i)).toList();
    _dataController.sink.add(_news);
  }
}

final socialBloc = new SocialBloc();
