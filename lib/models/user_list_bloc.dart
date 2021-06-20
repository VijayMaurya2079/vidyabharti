import 'dart:async';

import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/models/user_list.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';

class UserListBloc {
  final _listController = StreamController<List<UserListView>>.broadcast();

  Stream<List<UserListView>> get getUserList => _listController.stream;

  void dispose() {
    _listController.close();
  }

  getList(String status) async {
    String id = await utill.getString("id");
    Result result = await db.userList(id, status);
    final list =
        result.data.map<UserListView>((x) => UserListView.fromJson(x)).toList();
    _listController.sink.add(list);
  }
}

final userListBloc = new UserListBloc();
