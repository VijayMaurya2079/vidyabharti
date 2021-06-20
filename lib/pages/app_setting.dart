import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/master_view.dart';
import 'package:vidyabharti/widgets/style.dart';

class AppSettingPage extends StatefulWidget {
  @override
  _AppSettingPageState createState() => new _AppSettingPageState();
}

class _AppSettingPageState extends State<AppSettingPage> {
  final fcm = FirebaseMessaging();
  bool isSwitched = true;
  String userid = "";
  @override
  void initState() {
    super.initState();
  }

  getData() async {
    final status = await utill.getString("notification");
    final id = await utill.getString("id");
    setState(() {
      isSwitched = status == "1" ? true : false;
      userid = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: "Notification Setting",
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: appStyle.authBox(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isSwitched ? "Turn Off Notifications" : "Turn On Notifications",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  if (isSwitched) {
                    fcm.subscribeToTopic("news");
                    fcm.subscribeToTopic("video");
                    fcm.subscribeToTopic(userid);
                  } else {
                    fcm.unsubscribeFromTopic("news");
                    fcm.unsubscribeFromTopic("video");
                    fcm.unsubscribeFromTopic(userid);
                  }
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
