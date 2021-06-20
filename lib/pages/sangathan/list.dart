import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/pages/sangathan/bloc.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class SangathanListPage extends StatefulWidget {
  @override
  _SangathanListPageState createState() => new _SangathanListPageState();
}

class _SangathanListPageState extends State<SangathanListPage> {
  NewsApprovalFilter filter = NewsApprovalFilter();

  @override
  void initState() {
    super.initState();
    // sangathanBloc.sangathanList(filter);
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Vidya Bharti Sangathan List",
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: appStyle.authBox(),
        child: StreamBuilder(
          stream: sangathanBloc.getSangathanList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(strokeWidth: 1.0),
                );
              default:
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 2.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: FadeInImage.assetNetwork(
                                image: snapshot.data[index].profile_image,
                                placeholder: "assets/default_image.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data[index].person_name
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                      "${snapshot.data[index].designation_name ?? ''}"),
                                  SizedBox(height: 5.0),
                                  Text(
                                      "Kendra :${snapshot.data[index].mahanagar_name ?? ''}"),
                                  Text(
                                      "Mobile :${snapshot.data[index].mobile_no ?? ''}"),
                                  Text(
                                      "Landline :${snapshot.data[index].alternate_no ?? ''}"),
                                  Text(
                                      "Email ID :${snapshot.data[index].email_id ?? ''}"),
                                  GestureDetector(
                                    onTap: () {
                                      launch(snapshot.data[index].profile_pdf);
                                    },
                                    child: Text(
                                      "View Profile",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
