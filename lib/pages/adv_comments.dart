import 'package:flutter/material.dart';
import 'package:vidyabharti/models/news_activities_bloc.dart';
import 'package:vidyabharti/models/news_activity.dart';

class AdvComments extends StatefulWidget {
  final String id;
  AdvComments(this.id);

  _AdvCommentsState createState() => _AdvCommentsState();
}

class _AdvCommentsState extends State<AdvComments> {
  @override
  void initState() {
    super.initState();
    print("Adv ID :: ${widget.id}");
    newsActivitiesBloc.viewComment(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: newsActivitiesBloc.getNewsComments,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.0,
                  backgroundColor: Colors.deepOrange,
                ),
              ),
            );
          default:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return commentItem(snapshot.data[index]);
              },
            );
        }
      },
    );
  }

  commentItem(NewsActivity comment) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black26,
        radius: 25.0,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            image: comment.user_email,
            placeholder: "assets/user.jpg",
            width: 200,
            height: 200,
          ),
        ),
      ),
      title: Text(comment.news_comment),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.activity_date,
            style: TextStyle(fontSize: 11.0),
          ),
          Text(
            comment.user_name ?? "",
            style: TextStyle(fontSize: 11.0),
          ),
        ],
      ),
    );
  }
}
