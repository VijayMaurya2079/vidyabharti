import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vidyabharti/models/newslist.dart';
import 'package:vidyabharti/models/newslist_block.dart';
import 'package:vidyabharti/pages/add_news.dart';
import 'package:vidyabharti/pages/auth.dart';
import 'package:vidyabharti/pages/my_news_detail.dart';
import 'package:vidyabharti/widgets/news_templete.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';

import 'package:vidyabharti/widgets/style.dart';

class MyNewsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyNewsListPageState();
}

class _MyNewsListPageState extends State<MyNewsListPage> {
  String _status = "Approved";
  initState() {
    super.initState();
    newsListBloc.mylist(_status == "Approved" ? "1" : "0");
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "My News",
      child: Container(
        decoration: appStyle.authBox(),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white70,
                padding: EdgeInsets.all(5.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white54,
                  ),
                  value: _status,
                  items: ["Approved", "Pending"].map((s) {
                    return DropdownMenuItem(
                      value: s,
                      child: Text(s),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value;
                      newsListBloc.mylist(_status == "Approved" ? "1" : "0");
                    });
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<List<NewsList>>(
                  stream: newsListBloc.getMyNewsList,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      default:
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MyNewsDetail(id: snapshot.data[index]),
                                  ),
                                );
                              },
                              child:
                                  NewsTemplete(newsList: snapshot.data[index]),
                            );
                          },
                        );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingChild: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: addNewNews,
      ),
    );
  }

  addNewNews() async {
    String userid = await utill.getString("id");
    if (userid == null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (contex) => AuthPage()),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (contex) => AddNews()),
      );
    }
  }
}
