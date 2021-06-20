import 'dart:async';

import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/school_list._view.dart';
import 'package:vidyabharti/provider/db.dart';

class SchoolListBloc {
  final _schoolController = StreamController<List<SchoolListView>>.broadcast();
  Stream get getSchools => _schoolController.stream;

  void dispose() {
    _schoolController.close();
  }

  list(NewsApprovalFilter filter) async {
    print(filter.toJson());
    Result result = await db.searchSchool(filter);
    final _news = result.data
        .map<SchoolListView>((i) => SchoolListView.fromJson(i))
        .toList();
    _schoolController.sink.add(_news);
  }
}

final schoolListBloc = new SchoolListBloc();
