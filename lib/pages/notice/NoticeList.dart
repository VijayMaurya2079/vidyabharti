import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vidyabharti/pages/notice/NoticeBloc.dart';
import 'package:vidyabharti/pages/notice/NoticeDetail.dart';
import 'package:vidyabharti/pages/notice/NoticeEntryForm.dart';
import 'package:vidyabharti/widgets/style.dart';

class NoticeListPage extends StatefulWidget {
  @override
  _NoticeListPageListPageState createState() =>
      new _NoticeListPageListPageState();
}

class _NoticeListPageListPageState extends State<NoticeListPage> {
  @override
  void initState() {
    super.initState();
    noticeBloc.noticeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticeboard"),
        actions: <Widget>[
          FlatButton(
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add_comment),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoticeEntryForm(),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        decoration: appStyle.authBox(),
        child: StreamBuilder(
          stream: noticeBloc.getNoticeList,
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
                    return Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: snapshot.data[index].notice_status == "0"
                                ? Colors.lightBlue[100]
                                : Colors.white,
                            margin: EdgeInsets.only(bottom: 2.0),
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data[index].notice_title ?? '',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10.0),
                                Text(snapshot.data[index].notice_date ?? ''),
                                Text(
                                  snapshot.data[index].fk_mum_user_id ?? '',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NoticeDetailPage(snapshot.data[index]),
                              ),
                            );
                          },
                        ),
                      ],
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
