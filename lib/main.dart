import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vidyabharti/models/newslist.dart';
import 'package:vidyabharti/pages/news_detail.dart';
import 'package:vidyabharti/pages/welcome.dart';
import 'package:vidyabharti/provider/db.dart';
import 'package:vidyabharti/provider/utill.dart';
import 'package:vidyabharti/widgets/style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vidya Bharti',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.yellowAccent,
          brightness: Brightness.light),
      home: CheckStatus(),
    );
  }
}

class CheckStatus extends StatefulWidget {
  @override
  _CheckStatusState createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  final fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  dispose() {
    super.dispose();
  }

  checkStatus() async {
    db.securityCode = await db.token();
    String first = await utill.getString("notification");
    if (first == null) {
      fcm.subscribeToTopic("news");
      fcm.subscribeToTopic("video");
      utill.saveString("notification", "1");
    }
    fcm.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
    fcm.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print(" onLaunch called ${(msg)}");
        final news = NewsList(pk_new_news_id: msg["data"]["id"]);
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetail(id: news),
          ),
        );
      },
      onResume: (Map<String, dynamic> msg) {
        // final news = NewsList(pk_new_news_id: msg["data"]["id"]);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => NewsDetail(id: news)));
        print(" onResume called ${(msg)}");
        return;
      },
      onMessage: (Map<String, dynamic> msg) {
        print(" onMessage called ${(msg["notification"])}");
        // _push.pushReceived(msg);
        return;
      },
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WelcomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: appStyle.authBox(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icon.png",
                height: 150.0,
              ),
              Text(
                "Vidya Bharti",
                style: TextStyle(fontSize: 30.0, color: Colors.white54),
              ),
              SizedBox(
                height: 50.0,
              ),
              CircularProgressIndicator(
                strokeWidth: 1.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
