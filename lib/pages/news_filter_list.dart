import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/models/newslist.dart';
import 'package:vidyabharti/models/newslist_block.dart';
import 'package:vidyabharti/pages/add_news.dart';
import 'package:vidyabharti/pages/auth.dart';
import 'package:vidyabharti/pages/news_detail.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/news_templete.dart';

import 'package:vidyabharti/widgets/style.dart';

class NewsFilterListPage extends StatefulWidget {
  final NewsApprovalFilter user;
  NewsFilterListPage(this.user);

  @override
  State<StatefulWidget> createState() => _NewsFilterListPageState();
}

class _NewsFilterListPageState extends State<NewsFilterListPage> {
  initState() {
    newsListBloc.filterlist(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Filtered News",
      child: Container(
        decoration: appStyle.authBox(),
        child: StreamBuilder<List<NewsList>>(
          stream: newsListBloc.getFilterNewsList,
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
                  itemCount: snapshot.data.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsDetail(id: snapshot.data[index]),
                          ),
                        );
                      },
                      child: NewsTemplete(newsList: snapshot.data[index]),
                    );
                  },
                );
            }
          },
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
