import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vidyabharti/models/result.dart';
import 'package:vidyabharti/pages/magazine/bloc.dart';
import 'package:vidyabharti/pages/magazine/model.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/widgets/style.dart';

class MagazinePage extends StatefulWidget {
  @override
  _MagazinePageState createState() => new _MagazinePageState();
}

class _MagazinePageState extends State<MagazinePage> {
  List<Magazine> magazines = List<Magazine>();
  Magazine magazine = Magazine();
  @override
  void initState() {
    super.initState();
    getList();
    magazineBloc.magazineList(magazine);
  }

  getList() {
    db.magazineList().then((Result result) {
      final m = result.data.map<Magazine>((x) => Magazine.fromJson(x)).toList();
      setState(() {
        magazines = m;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Magazine & Periodical"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            selectType(),
            SizedBox(height: 10),
            StreamBuilder(
              stream: magazineBloc.getMagazineList,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Text("Waiting...");
                  default:
                    return getItems(snapshot.data);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  getItems(List<Magazine> l) {
    return Column(
      children: <Widget>[
        (l != null) ? l.map((x) => itemList(x)).toList() : SizedBox()
      ],
    );
  }

  Widget selectType() {
    return DropdownButtonFormField(
      value: magazine.pkMgzMnameId,
      items: magazines.map((value) {
        return DropdownMenuItem(
          value: value.pkMgzMnameId,
          child: Text(value.englishName),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => magazine.pkMgzMnameId = value);
        magazineBloc.magazineList(magazine);
      },
      decoration: appStyle.inputDecoration("Select Magazine or Periodical"),
    );
  }

  Widget itemList(Magazine x) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.assetNetwork(
              image:
                  "http://vidyabhartionline.org/bito_admin/${x.coverPageImage}",
              placeholder: "assets/default_image.png",
              width: MediaQuery.of(context).size.width,
              height: 180,
              fit: BoxFit.fitWidth,
            ),
            Container(
              child: Text(
                x.englishName.trim(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${x.insDate}"),
                GestureDetector(
                  onTap: () => launch(
                      "http://vidyabhartionline.org/bito_admin/${x.magazinePdf}"),
                  child: Chip(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Download"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
