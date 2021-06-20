import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/pages/sangathan/bloc.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => new _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  NewsApprovalFilter filter = NewsApprovalFilter();

  @override
  void initState() {
    super.initState();
    sangathanBloc.contactList(filter);
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Contact List",
      child: Container(
        decoration: appStyle.authBox(),
        child: StreamBuilder(
          stream: sangathanBloc.getContactList,
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
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data[index].person_name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:
                                  Text("${snapshot.data[index].profile_image??''}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  launch(
                                      "tel:${snapshot.data[index].mobile_no}");
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.phone, size: 15),
                                    Text(snapshot.data[index].mobile_no ?? ''),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                  onTap: () {
                                    launch(
                                        "mailto:${snapshot.data[index].email_id}");
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.email, size: 15),
                                      Text(snapshot.data[index].email_id ?? ''),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
      // floatingChild: FloatingActionButton(
      //   child: Icon(Icons.filter_list),
      //   onPressed: () {
      //     showBottomSheet(
      //       context: context,
      //       builder: (context) => SangathanFilterPage("contact"),
      //     );
      //   },
      // ),
    );
  }
}
