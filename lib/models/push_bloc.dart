import 'dart:async';

class PushBloc {
  final _push = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get onPush => _push.stream;

  void dispose() {
    _push.close();
  }

  pushReceived(Map<String, dynamic> push) async {
    _push.sink.add(push);
  }
}
