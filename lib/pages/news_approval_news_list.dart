import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_approval_filter.dart';
import 'package:vidyabharti/models/newslist.dart';
import 'package:vidyabharti/models/newslist_block.dart';
import 'package:vidyabharti/pages/news_approcal_news_detail.dart';
import 'package:vidyabharti/widgets/news_templete.dart';
import 'package:vidyabharti/widgets/master_view.dart';

import 'package:vidyabharti/widgets/style.dart';

class NewsApprovalNewsListPage extends StatefulWidget {
  final NewsApprovalFilter user;
  NewsApprovalNewsListPage(this.user);

  @override
  State<StatefulWidget> createState() => _NewsApprovalNewsListPageState();
}

class _NewsApprovalNewsListPageState extends State<NewsApprovalNewsListPage> {
  String _status = "Pending";

  initState() {
    super.initState();
    widget.user.transaction_status = _status == "Approved" ? "1" : "0";
    newsListBloc.approvallist(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "News List",
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
                      widget.user.transaction_status =
                          _status == "Approved" ? "1" : "0";
                      newsListBloc.approvallist(widget.user);
                    });
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height-120,
                child: StreamBuilder<List<NewsList>>(
                  stream: newsListBloc.getApprovalNewsList,
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
                                        NewsApprovalNewsDetailPage(
                                            id: snapshot.data[index]),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
