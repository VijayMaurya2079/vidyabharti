import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_activities_bloc.dart';
import 'package:vidyabharti/pages/auth.dart';
import 'package:vidyabharti/pages/news_comments.dart';
import 'package:vidyabharti/provider/utill.dart';

class NewsActivityCounts extends StatefulWidget {
  final String id;

  NewsActivityCounts({Key key, this.id}) : super(key: key);

  _NewsActivityCountsState createState() => _NewsActivityCountsState();
}

class _NewsActivityCountsState extends State<NewsActivityCounts> {
  @override
  void initState() {
    super.initState();
    newsActivitiesBloc.get(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: newsActivitiesBloc.getNewsAtivities,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Container();
          default:
            return Container(
              padding: EdgeInsets.all(2.0),
              child: activityCounts(snapshot.data),
            );
        }
      },
    );
  }

  activityCounts(comment) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        iconActionButton(
            comment.comments,
            Icon(
              Icons.comment,
              color: Colors.blue,
            ), () async {
          String id = await utill.getString("id");
          print("id ${id}");
          if (id == null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AuthPage()));
          }
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return NewsComments(
                id: widget.id,
              );
            },
          );
        }),
        iconActionButton(
            comment.like,
            Icon(
              Icons.thumb_up,
              color: Colors.green,
            ), () async {
          String id = await utill.getString("id");
          if (id == null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AuthPage()));
          }
          newsActivitiesBloc.hitLike(widget.id);
        }),
        iconActionButton(
            comment.dislike,
            Icon(
              Icons.thumb_down,
              color: Colors.red,
            ), () async {
          String id = await utill.getString("id");
          if (id == null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AuthPage()));
          }
          newsActivitiesBloc.hitDislike(widget.id);
        }),
      ]),
    );
  }

  iconActionButton(int count, Icon icon, action) {
    return Stack(
      children: <Widget>[
        IconButton(icon: icon, onPressed: action),
        Positioned(
          right: 0.0,
          child: Container(
            constraints: BoxConstraints(
              minHeight: 20,
              minWidth: 20,
            ),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.orange,
            ),
            child: Text(
              count.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
