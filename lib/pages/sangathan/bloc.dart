import 'dart:async';

import 'package:vidyabharti/models/designation.dart';
import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/sangathan.dart';
import 'package:vidyabharti/provider/db.dart';

class SangathanBloc {
  final _sangathanController =
      StreamController<List<Designation>>.broadcast();
  final _sangathanListController =
      StreamController<List<SangathanModel>>.broadcast();
  final _contactListController =
      StreamController<List<SangathanModel>>.broadcast();

  Stream get getDesignationList => _sangathanController.stream;
  Stream get getSangathanList => _sangathanListController.stream;
  Stream get getContactList => _contactListController.stream;

  void dispose() {
    _sangathanController.close();
    _sangathanListController.close();
    _contactListController.close();
  }

  designationList() async {
    Result result = await db.sangathanTypes();
    final _news =
        result.data.map<Designation>((i) => Designation.fromJson(i)).toList();
    _sangathanController.sink.add(_news);
  }

  sangathanList(NewsApprovalFilter type) async {
    Result result = await db.sangathandata(type);
    print("Sangathan Data :${result.toJson()}");
    final _news = result.data
        .map<SangathanModel>((i) => SangathanModel.fromJson(i))
        .toList();
    _sangathanListController.sink.add(_news);
  }

  contactList(NewsApprovalFilter type) async {
    Result result = await db.contactdata(type);
    final _news = result.data
        .map<SangathanModel>((i) => SangathanModel.fromJson(i))
        .toList();
    _contactListController.sink.add(_news);
  }
}

final sangathanBloc = new SangathanBloc();
