import 'dart:async';

class AuthMode {
  StreamController<String> _authModeController =
      StreamController<String>.broadcast();
  Stream get getMode => _authModeController.stream;

  void dispose() {
    _authModeController.close();
  }

  set(String mode) async {
    print("Current State Of Auth $mode");
    _authModeController.sink.add(mode);
  }
}

final authMode = AuthMode();
