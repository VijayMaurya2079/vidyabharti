import 'package:flutter/material.dart';
import 'package:vidyabharti/models/social_initiatives.dart';
import 'package:vidyabharti/pages/social/social_bloc.dart';
import 'package:vidyabharti/pages/social/social_media.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class SocialTypeListPage extends StatefulWidget {
  @override
  _SocialTypeListPageState createState() => new _SocialTypeListPageState();
}

class _SocialTypeListPageState extends State<SocialTypeListPage> {
  List<SocialInitiatives> list = [];

  @override
  void initState() {
    super.initState();
    socialBloc.typeList();
  }

  @override
  Widget build(BuildContext context) {
    String title = "Seva Prakalp";
    return AppBody(
      title: title,
      child: Container(
        decoration: appStyle.authBox(),
        child: StreamBuilder(
          stream: socialBloc.getSocialTypeList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
              case ConnectionState.waiting:
                return Center(
                  child: LinearProgressIndicator(),
                );
              default:
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 2.0),
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            title = snapshot.data[index].activity_name;
                          });
                          showBottomSheet(
                            context: context,
                            builder: (context) {
                              return SocialMediaPage(
                                snapshot.data[index].pk_soc_activity_id,
                              );
                            },
                          );
                        },
                        title: Text(snapshot.data[index].activity_name),
                        trailing: Icon(Icons.arrow_forward),
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
