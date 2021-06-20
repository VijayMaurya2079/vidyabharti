import 'dart:async';

import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/pages/magazine/model.dart';
import 'package:vidyabharti/provider/db.dart';

class MagazineBloc {
  final _magazineController = StreamController<List<Magazine>>.broadcast();

  Stream get getMagazineList => _magazineController.stream;

  void dispose() {
    _magazineController.close();
  }

  magazineList(magazine) async {
    Result result = await db.magazine(magazine);
    print("Magazine  List  :: ${result.toJson()}");
    final _news =result.data.map<Magazine>((i) => Magazine.fromJson(i)).toList();
    _magazineController.sink.add(_news);
  }
}

final magazineBloc = new MagazineBloc();
