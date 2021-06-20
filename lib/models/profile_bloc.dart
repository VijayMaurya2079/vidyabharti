import 'dart:async';

import 'package:vidyabharti/models/profile.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/provider/db.dart';

class ProfileBloc {
  StreamController<ProfileView> _detailController =
      StreamController<ProfileView>.broadcast();
  Stream get getNewsList => _detailController.stream;

  void dispose() {
    _detailController.close();
  }

  list(id) async {
    Result result = await db.getUserDetail(id);
    final _news = ProfileView.fromJson(result.data);
    _detailController.sink.add(_news);
  }
}

final profileBloc = new ProfileBloc();
