import 'dart:async';

import 'package:vidyabharti/provider/utill.dart';

class UserBloc {
  final _isLogin = StreamController<bool>.broadcast();
  final _userid = StreamController<String>.broadcast();
  final _username = StreamController<String>.broadcast();
  Stream<bool> get isLogin => _isLogin.stream;
  Stream<String> get getUserID => _userid.stream;
  Stream<String> get getUserName => _username.stream;

  UserBloc() {
    setAppState();
  }
  void dispose() {
    _isLogin.close();
    _userid.close();
    _username.close();
  }

  setAppState() async {
    final id = await utill.getString("id");
    final name = await utill.getString("name");
    _userid.sink.add(id);
    _userid.sink.add(name);
    if (name.isEmpty) {
      _isLogin.sink.add(false);
    } else {
      _isLogin.sink.add(true);
    }
  }
}

final userBloc = new UserBloc();
